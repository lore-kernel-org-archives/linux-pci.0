Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36267 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754732AbdFNIZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2017 04:25:35 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so80807554pff.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Jun 2017 01:25:30 -0700 (PDT)
From: Guodong Xu <guodong.xu@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com,
        peter.griffin@linaro.org, puck.chen@hisilicon.com,
        lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com,
        arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Wang <jean.wangtao@linaro.org>
Subject: [PATCH v3 14/21] arm64: dts: hi3660: enable idle states
Date: Wed, 14 Jun 2017 16:23:31 +0800
Message-Id: <20170614082338.15673-15-guodong.xu@linaro.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Leo Yan <leo.yan@linaro.org>

On Hi3660 there have two clusters, one is CA53 cluster and another is
CA73 cluster. This two clusters have different idle states separately.
With Daniel Lezcano's patch (ARM: cpuidle: Support asymmetric idle
definition), now ARM idle driver can support different clusters with
different idle states.

Base on this, this patch is to bind two clusters idle states on Hi3660.
Except the "WFI" states are enabled by default for all CPUs, this patch
also binds below extra idle states:

- CA53 CPUs have two more states:
  CPU_SLEEP:       CPU power off state
  CLUSTER_SLEEP_0: Cluster power off state

- CA73 CPUs have three more states:
  CPU_NAP:         CPU retention state
  CPU_SLEEP:       CPU power off state
  CLUSTER_SLEEP_1: Cluster power off state

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Wang <jean.wangtao@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index e138973..4101bf5 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -58,6 +58,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +66,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu2: cpu@2 {
@@ -72,6 +74,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu3: cpu@3 {
@@ -79,6 +82,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu4: cpu@100 {
@@ -86,6 +90,11 @@
 			device_type = "cpu";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
 		};
 
 		cpu5: cpu@101 {
@@ -93,6 +102,11 @@
 			device_type = "cpu";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
 		};
 
 		cpu6: cpu@102 {
@@ -100,6 +114,11 @@
 			device_type = "cpu";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
 		};
 
 		cpu7: cpu@103 {
@@ -107,6 +126,50 @@
 			device_type = "cpu";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_NAP: cpu-nap {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0000001>;
+				entry-latency-us = <7>;
+				exit-latency-us = <2>;
+				min-residency-us = <15>;
+			};
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <40>;
+				exit-latency-us = <70>;
+				min-residency-us = <3000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <500>;
+				exit-latency-us = <5000>;
+				min-residency-us = <20000>;
+			};
+
+			CLUSTER_SLEEP_1: cluster-sleep-1 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <1000>;
+				exit-latency-us = <5000>;
+				min-residency-us = <20000>;
+			};
 		};
 	};
 
-- 
2.10.2
