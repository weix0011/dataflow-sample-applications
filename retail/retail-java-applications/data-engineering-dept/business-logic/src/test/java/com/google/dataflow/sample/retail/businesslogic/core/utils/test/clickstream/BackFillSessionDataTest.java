/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.google.dataflow.sample.retail.businesslogic.core.utils.test.clickstream;

import com.google.dataflow.sample.retail.businesslogic.core.transforms.clickstream.BackFillSessionData;
import com.google.dataflow.sample.retail.businesslogic.core.transforms.clickstream.ClickStreamSessions;
import java.util.Objects;
import org.apache.beam.sdk.schemas.transforms.Convert;
import org.apache.beam.sdk.schemas.transforms.Select;
import org.apache.beam.sdk.testing.PAssert;
import org.apache.beam.sdk.testing.TestPipeline;
import org.apache.beam.sdk.transforms.Create;
import org.apache.beam.sdk.transforms.DoFn;
import org.apache.beam.sdk.transforms.ParDo;
import org.apache.beam.sdk.values.PCollection;
import org.apache.beam.sdk.values.Row;
import org.apache.beam.sdk.values.TimestampedValue;
import org.apache.beam.vendor.grpc.v1p26p0.com.google.common.collect.ImmutableList;
import org.joda.time.Duration;
import org.junit.Rule;
import org.junit.Test;

public class BackFillSessionDataTest {

  @Rule public transient TestPipeline pipeline = TestPipeline.create();

  @Test
  /**
   * This test provides values from time 0 to time 2 with no agent, time 3 has a agent and time 4 is
   * again null
   */
  public void testBackFillSessionization() throws Exception {

    Duration windowDuration = Duration.standardMinutes(5);

    // Remove user ID from first few message.

    PCollection<Long> sessions =
        pipeline
            .apply(
                Create.timestamped(
                    TimestampedValue.of(
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_0_MINS
                            .getValue()
                            .toBuilder()
                            .setAgent(null)
                            .build(),
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_0_MINS.getTimestamp()),
                    TimestampedValue.of(
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_1_MINS
                            .getValue()
                            .toBuilder()
                            .setAgent(null)
                            .build(),
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_1_MINS.getTimestamp()),
                    TimestampedValue.of(
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_2_MINS
                            .getValue()
                            .toBuilder()
                            .setAgent(null)
                            .build(),
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_2_MINS.getTimestamp()),
                    ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_3_MINS,
                    TimestampedValue.of(
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_4_MINS
                            .getValue()
                            .toBuilder()
                            .setAgent(null)
                            .build(),
                        ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_4_MINS.getTimestamp()),
                    ClickStreamSessionTestUtil.CLICK_STREAM_EVENT_10_MINS))
            .apply(Convert.toRows())
            .apply(ClickStreamSessions.create(windowDuration))
            .apply(BackFillSessionData.create(ImmutableList.of("agent")))
            .apply(Select.fieldNames("value.agent"))
            .apply(ParDo.of(new ExtractUserIDCountFromRow()));

    PAssert.that(sessions).containsInAnyOrder(4L, 1L);

    pipeline.run();
  }

  static class ExtractUserIDCountFromRow extends DoFn<Row, Long> {
    @ProcessElement
    public void process(ProcessContext pc) {
      long count = pc.element().getArray("agent").stream().filter(Objects::nonNull).count();
      System.out.println(count);
      pc.output(count);
    }
  }
}
