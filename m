Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5468377ECA;
	Tue, 24 Mar 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315841; cv=fail; b=lSdxGHHwvZbiJrfEyT4A+YOhFr/lyq44+fIm946kG0pITKdfNucm2TTTg2FMdiyGTlXrPae3CnMiPdhfrFC8fV0mxc3EWPzxXgsGCchUp9Ft1iEgo7mtmK43PL7Ll9Y2GiGUo1L39IlfAUcadeuvJ+Gg8vHxFf715+4IdvC4jNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315841; c=relaxed/simple;
	bh=g9WXL7KFuRY2fA7MBv/iFR0IxFLNazRBX+5YYpvAiKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCjKHdgipem1xqBid/4zFE4utsBs2ep/3DMUkTT3BpwPI3nPsJE5cERXscCCMZUoIZ9VTLXtqwDpAJzrrMidpmSYLyTUxXg7g6xpo1NvHAsY0Ksm3vjsY4z2lZcPbf/Ggh1XUJJFC3lCF7xUoJsI7bFUaxTscRzGIAHUdNAvOQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DUs5LoWD; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DUs5LoWD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3GjdgyzWcz37vMKr25nh4kUn6IarnCR77YlSn6nMHn0BgOoLNlneiYFjmQXvf7sojxu5oYzoKpSKg0D6/e/Xg1ZufWd51lvWgyGmQqql0/tsqe8e2MpRG/KlzaWFP6knBrd29XLi55+Mpd8srhVf9aHxlpTVmbpMPhLCiamJn1/saSRh4zI5FfNLuOEYlQ2kyO41J1pe1O3RF9LNYTrdGpYJtyyonueSaS3kjmJkVXM+3WUcxqNlJxhqwPY7Uiywm3GlHxK6BnywjCRzSkqH/fw1OXjp4Q6SOIeGAiHWXbKOzzcH0VmNrMNA+Q31txFlUFYIkSEoyAeGct0hb1tKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuQLh5pLubrPMi5AySEr+GMTXrsEcUFRpizADzRdajI=;
 b=mzaLRT5TdcwaKDql9+kew4XXtyPjGNlv7yIlKdxtED28MbpdRKeOz7z37b/sb5n+pxeLKilgslJzDKyq6OHH7sob3rboxEXNbyZPqknal1a2coCa6VCc9KSiZO0B7sksI1hHscZYu34b+JPhZL2MIXahYU798mQ3Hnm8eT5U/ziRoYngUoXA1WFm6BhRGCSLaAiVFybbFcsh8PsiIMUOztAT2W6Wy/RYlot0bX+eiOA2WtdHVizGY6Jo3pA/isl8Jl60wpjZZw7z97qdf6sMQC6qLvTH4708n4iW+vsDimorNaKKA7N/A+1Q/C/BHVdCzm9GGj2YmB0sGt85stZD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuQLh5pLubrPMi5AySEr+GMTXrsEcUFRpizADzRdajI=;
 b=DUs5LoWDHCgJRXk/lmGzqpSDjrtRTjCODch7HZ70IEynn6IC69+5pTmxbE89a2E3at3YTl/OtRqlYW8ddubWWqT9Hhw/Rl+esPJtgEZu3Cq4UCUydS2SGxDz4R7jMPC4qx3uopFOEIx3kMbWKpLaVz357RHUNfWM7nKl+JimvEEUj49zeVF82xMz0tMbkZXf4vT7SRnkuZNRTaIWJetYv8wDJKs7xpLJtt4IkO+d60wDzrScIUV81VDtGCL1FEwPI6mDEWe6bpZ9FmUfCx8ayi2SFN7HwyhGQ+bjxrSbKUwuX9QZyTRbmBwcFqTxGFteQht9vSi2mxxPadElmq8IDA==
Received: from IA1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::15)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:30:31 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::87) by IA1P220CA0015.outlook.office365.com
 (2603:10b6:208:464::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:30:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:30:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:30:11 -0700
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 23 Mar 2026 18:30:10 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <will@kernel.org>, <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
	<ilkka@os.amperecomputing.com>, <jonathan.cameron@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<sdonthineni@nvidia.com>, <skelley@nvidia.com>, <mochs@nvidia.com>,
	<nirmoyd@nvidia.com>, <bhelgaas@google.com>, <wangyushan12@huawei.com>,
	<shiju.jose@huawei.com>, <linux-pci@vger.kernel.org>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v3 2/8] perf/arm_cspmu: nvidia: Add Tegra410 UCF PMU
Date: Tue, 24 Mar 2026 01:29:46 +0000
Message-ID: <20260324012952.1923296-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324012952.1923296-1-bwicaksono@nvidia.com>
References: <20260324012952.1923296-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 302dd1ff-b013-4aae-44dc-08de8944f00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rvVaXht5PG0wlu3vuZ0QfICmYFwCwHeGyrP2WxXRM0L82xQX16KTWfG/FbCkUdO8ra/kT1auAjXjWwj1UhS98gTbe5N1RvCKak1XyfM99AhpLKD3UkZfwDH5XXznCTtVZ9jlAiG2cCwIEZ2vDflewnRRSXsWdVnP7Cqp/18gMR32+5u+cQJKVwK7DObkslQ9w2F4ckSMgaPGbpu6hw6qb0KPp4xneo6E4e1UJAv3/6zQ5P4FKrgIwyX9s7mLnhtwl+ZFHITJOCrsn0fdZ1g2Aqo9fcmyQMpIIK1hZvg3U68xaK1eXUs9E/DFdIVV9giT1ZPXzGSETSf1GCVY23tQHxPwqeOWC7bbvrZy7RTa6QHNOYjw86aSSvUVrdbLg1KtXAH7LyJw9exVnwXv+O1xh2WZ/L2X8u2DeDC0nTvO/HyM91oqkJo2f8MD64rU5O7+X0BlvRH/M2A5IZEgYwnsagaKWNNoOFPtmiWjXCYKfOQv+PUtVO/UGsGLxtbm6M7nGBsYDomVebh4Q2O0OPK4X765zWlVWQLmVWfpHoVF5NT2hvXSNBDvHUj2ERNE6XexNtmPjrLWdgaVo/6HHryObnFNfPYPkZmrmxjD+QPeyNp3235sXgpcGcxljqWSvBf8pyzyM0TRTNzcwM4QJmFen3XKQTfi4q+30V8Fs4bkAqUO5kx1DAq9cGOw8KNhQC3VcksdZhjWvzBIG84vC4ABA65ZmIPdba9bMvx3XJJby4C/xsMp74wXmFvLmeETmZ09v3QW8I0S1zF3EcFrnFOULQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xq2LJpxjI/OfD0tVRs5NrnQe2z0mVFRa1zZXVjdrrASWj5c0i6VedH0xm773Idluimds2y6/AFxijs5PWyxO0My4h/2vnlqx0tMASd8qPKTdCSNJcLEKuQtHx24Vb089jc8AO0XJfVOw75SCLyFAN43GhaigoH8yayJvwDG0tj6RNVwmbbZrEVYA1C9vksLOHI8WyxYDaj1YBzkkFU1XSjBnBZwMaPTFxATyJ74N1n3LRJGS+HyNda5nM/wK6LUgMahjoNdYM0Ewl5ZM+GuOlIHmq0P8Rs8sreufMwyh+Q1EFAzr8up2wXaL6lEXhQQKBUQfSb5jjkvYN7YOmMWF4YZnpucCcD2mK+H0R3beqO1+o9nyAHypXarxooHy43zhGm7njzDcNKlt3dNcm23nkda5/NpwT3wElLlVtGMk/fwVIsT46rdPezGmTVkOYUnU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:30:30.9294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302dd1ff-b013-4aae-44dc-08de8944f00b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

The Unified Coherence Fabric (UCF) contains last level cache
and cache coherent interconnect in Tegra410 SOC. The PMU in
this device can be used to capture events related to access
to the last level cache and memory from different sources.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 Documentation/admin-guide/perf/index.rst      |   1 +
 .../admin-guide/perf/nvidia-tegra410-pmu.rst  | 106 ++++++++++++++++++
 drivers/perf/arm_cspmu/nvidia_cspmu.c         |  87 +++++++++++++-
 3 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index c407bb44b08e..aa12708ddb96 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -25,6 +25,7 @@ Performance monitor support
    alibaba_pmu
    dwc_pcie_pmu
    nvidia-tegra241-pmu
+   nvidia-tegra410-pmu
    meson-ddr-pmu
    cxl
    ampere_cspmu
diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
new file mode 100644
index 000000000000..7b7ba5700ca1
--- /dev/null
+++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
@@ -0,0 +1,106 @@
+=====================================================================
+NVIDIA Tegra410 SoC Uncore Performance Monitoring Unit (PMU)
+=====================================================================
+
+The NVIDIA Tegra410 SoC includes various system PMUs to measure key performance
+metrics like memory bandwidth, latency, and utilization:
+
+* Unified Coherence Fabric (UCF)
+
+PMU Driver
+----------
+
+The PMU driver describes the available events and configuration of each PMU in
+sysfs. Please see the sections below to get the sysfs path of each PMU. Like
+other uncore PMU drivers, the driver provides "cpumask" sysfs attribute to show
+the CPU id used to handle the PMU event. There is also "associated_cpus"
+sysfs attribute, which contains a list of CPUs associated with the PMU instance.
+
+UCF PMU
+-------
+
+The Unified Coherence Fabric (UCF) in the NVIDIA Tegra410 SoC serves as a
+distributed cache, last level for CPU Memory and CXL Memory, and cache coherent
+interconnect that supports hardware coherence across multiple coherently caching
+agents, including:
+
+  * CPU clusters
+  * GPU
+  * PCIe Ordering Controller Unit (OCU)
+  * Other IO-coherent requesters
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_source/devices/nvidia_ucf_pmu_<socket-id>.
+
+Some of the events available in this PMU can be used to measure bandwidth and
+utilization:
+
+  * slc_access_rd: count the number of read requests to SLC.
+  * slc_access_wr: count the number of write requests to SLC.
+  * slc_bytes_rd: count the number of bytes transferred by slc_access_rd.
+  * slc_bytes_wr: count the number of bytes transferred by slc_access_wr.
+  * mem_access_rd: count the number of read requests to local or remote memory.
+  * mem_access_wr: count the number of write requests to local or remote memory.
+  * mem_bytes_rd: count the number of bytes transferred by mem_access_rd.
+  * mem_bytes_wr: count the number of bytes transferred by mem_access_wr.
+  * cycles: counts the UCF cycles.
+
+The average bandwidth is calculated as::
+
+   AVG_SLC_READ_BANDWIDTH_IN_GBPS = SLC_BYTES_RD / ELAPSED_TIME_IN_NS
+   AVG_SLC_WRITE_BANDWIDTH_IN_GBPS = SLC_BYTES_WR / ELAPSED_TIME_IN_NS
+   AVG_MEM_READ_BANDWIDTH_IN_GBPS = MEM_BYTES_RD / ELAPSED_TIME_IN_NS
+   AVG_MEM_WRITE_BANDWIDTH_IN_GBPS = MEM_BYTES_WR / ELAPSED_TIME_IN_NS
+
+The average request rate is calculated as::
+
+   AVG_SLC_READ_REQUEST_RATE = SLC_ACCESS_RD / CYCLES
+   AVG_SLC_WRITE_REQUEST_RATE = SLC_ACCESS_WR / CYCLES
+   AVG_MEM_READ_REQUEST_RATE = MEM_ACCESS_RD / CYCLES
+   AVG_MEM_WRITE_REQUEST_RATE = MEM_ACCESS_WR / CYCLES
+
+More details about what other events are available can be found in Tegra410 SoC
+technical reference manual.
+
+The events can be filtered based on source or destination. The source filter
+indicates the traffic initiator to the SLC, e.g local CPU, non-CPU device, or
+remote socket. The destination filter specifies the destination memory type,
+e.g. local system memory (CMEM), local GPU memory (GMEM), or remote memory. The
+local/remote classification of the destination filter is based on the home
+socket of the address, not where the data actually resides. The available
+filters are described in
+/sys/bus/event_source/devices/nvidia_ucf_pmu_<socket-id>/format/.
+
+The list of UCF PMU event filters:
+
+* Source filter:
+
+  * src_loc_cpu: if set, count events from local CPU
+  * src_loc_noncpu: if set, count events from local non-CPU device
+  * src_rem: if set, count events from CPU, GPU, PCIE devices of remote socket
+
+* Destination filter:
+
+  * dst_loc_cmem: if set, count events to local system memory (CMEM) address
+  * dst_loc_gmem: if set, count events to local GPU memory (GMEM) address
+  * dst_loc_other: if set, count events to local CXL memory address
+  * dst_rem: if set, count events to CPU, GPU, and CXL memory address of remote socket
+
+If the source is not specified, the PMU will count events from all sources. If
+the destination is not specified, the PMU will count events to all destinations.
+
+Example usage:
+
+* Count event id 0x0 in socket 0 from all sources and to all destinations::
+
+    perf stat -a -e nvidia_ucf_pmu_0/event=0x0/
+
+* Count event id 0x0 in socket 0 with source filter = local CPU and destination
+  filter = local system memory (CMEM)::
+
+    perf stat -a -e nvidia_ucf_pmu_0/event=0x0,src_loc_cpu=0x1,dst_loc_cmem=0x1/
+
+* Count event id 0x0 in socket 1 with source filter = local non-CPU device and
+  destination filter = remote memory::
+
+    perf stat -a -e nvidia_ucf_pmu_1/event=0x0,src_loc_noncpu=0x1,dst_rem=0x1/
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index e06a06d3407b..8e37cbe3bae9 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
@@ -21,6 +21,13 @@
 #define NV_CNVL_PORT_COUNT           4ULL
 #define NV_CNVL_FILTER_ID_MASK       GENMASK_ULL(NV_CNVL_PORT_COUNT - 1, 0)
 
+#define NV_UCF_SRC_COUNT             3ULL
+#define NV_UCF_DST_COUNT             4ULL
+#define NV_UCF_FILTER_ID_MASK        GENMASK_ULL(11, 0)
+#define NV_UCF_FILTER_SRC            GENMASK_ULL(2, 0)
+#define NV_UCF_FILTER_DST            GENMASK_ULL(11, 8)
+#define NV_UCF_FILTER_DEFAULT        (NV_UCF_FILTER_SRC | NV_UCF_FILTER_DST)
+
 #define NV_GENERIC_FILTER_ID_MASK    GENMASK_ULL(31, 0)
 
 #define NV_PRODID_MASK	(PMIIDR_PRODUCTID | PMIIDR_VARIANT | PMIIDR_REVISION)
@@ -124,6 +131,36 @@ static struct attribute *mcf_pmu_event_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ucf_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(bus_cycles,            0x1D),
+
+	ARM_CSPMU_EVENT_ATTR(slc_allocate,          0xF0),
+	ARM_CSPMU_EVENT_ATTR(slc_wb,                0xF3),
+	ARM_CSPMU_EVENT_ATTR(slc_refill_rd,         0x109),
+	ARM_CSPMU_EVENT_ATTR(slc_refill_wr,         0x10A),
+	ARM_CSPMU_EVENT_ATTR(slc_hit_rd,            0x119),
+
+	ARM_CSPMU_EVENT_ATTR(slc_access_dataless,   0x183),
+	ARM_CSPMU_EVENT_ATTR(slc_access_atomic,     0x184),
+
+	ARM_CSPMU_EVENT_ATTR(slc_access_rd,         0x111),
+	ARM_CSPMU_EVENT_ATTR(slc_access_wr,         0x112),
+	ARM_CSPMU_EVENT_ATTR(slc_bytes_rd,          0x113),
+	ARM_CSPMU_EVENT_ATTR(slc_bytes_wr,          0x114),
+
+	ARM_CSPMU_EVENT_ATTR(mem_access_rd,         0x121),
+	ARM_CSPMU_EVENT_ATTR(mem_access_wr,         0x122),
+	ARM_CSPMU_EVENT_ATTR(mem_bytes_rd,          0x123),
+	ARM_CSPMU_EVENT_ATTR(mem_bytes_wr,          0x124),
+
+	ARM_CSPMU_EVENT_ATTR(local_snoop,           0x180),
+	ARM_CSPMU_EVENT_ATTR(ext_snp_access,        0x181),
+	ARM_CSPMU_EVENT_ATTR(ext_snp_evict,         0x182),
+
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL
+};
+
 static struct attribute *generic_pmu_event_attrs[] = {
 	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
 	NULL,
@@ -152,6 +189,18 @@ static struct attribute *cnvlink_pmu_format_attrs[] = {
 	NULL,
 };
 
+static struct attribute *ucf_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(src_loc_noncpu, "config1:0"),
+	ARM_CSPMU_FORMAT_ATTR(src_loc_cpu, "config1:1"),
+	ARM_CSPMU_FORMAT_ATTR(src_rem, "config1:2"),
+	ARM_CSPMU_FORMAT_ATTR(dst_loc_cmem, "config1:8"),
+	ARM_CSPMU_FORMAT_ATTR(dst_loc_gmem, "config1:9"),
+	ARM_CSPMU_FORMAT_ATTR(dst_loc_other, "config1:10"),
+	ARM_CSPMU_FORMAT_ATTR(dst_rem, "config1:11"),
+	NULL
+};
+
 static struct attribute *generic_pmu_format_attrs[] = {
 	ARM_CSPMU_FORMAT_EVENT_ATTR,
 	ARM_CSPMU_FORMAT_FILTER_ATTR,
@@ -236,6 +285,27 @@ static void nv_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
 	writel(filter, cspmu->base0 + PMCCFILTR);
 }
 
+static u32 ucf_pmu_event_filter(const struct perf_event *event)
+{
+	u32 ret, filter, src, dst;
+
+	filter = nv_cspmu_event_filter(event);
+
+	/* Monitor all sources if none is selected. */
+	src = FIELD_GET(NV_UCF_FILTER_SRC, filter);
+	if (src == 0)
+		src = GENMASK_ULL(NV_UCF_SRC_COUNT - 1, 0);
+
+	/* Monitor all destinations if none is selected. */
+	dst = FIELD_GET(NV_UCF_FILTER_DST, filter);
+	if (dst == 0)
+		dst = GENMASK_ULL(NV_UCF_DST_COUNT - 1, 0);
+
+	ret = FIELD_PREP(NV_UCF_FILTER_SRC, src);
+	ret |= FIELD_PREP(NV_UCF_FILTER_DST, dst);
+
+	return ret;
+}
 
 enum nv_cspmu_name_fmt {
 	NAME_FMT_GENERIC,
@@ -342,6 +412,21 @@ static const struct nv_cspmu_match nv_cspmu_match[] = {
 		.init_data = NULL
 	  },
 	},
+	{
+	  .prodid = 0x2CF20000,
+	  .prodid_mask = NV_PRODID_MASK,
+	  .name_pattern = "nvidia_ucf_pmu_%u",
+	  .name_fmt = NAME_FMT_SOCKET,
+	  .template_ctx = {
+		.event_attr = ucf_pmu_event_attrs,
+		.format_attr = ucf_pmu_format_attrs,
+		.filter_mask = NV_UCF_FILTER_ID_MASK,
+		.filter_default_val = NV_UCF_FILTER_DEFAULT,
+		.filter2_mask = 0x0,
+		.filter2_default_val = 0x0,
+		.get_filter = ucf_pmu_event_filter,
+	  },
+	},
 	{
 	  .prodid = 0,
 	  .prodid_mask = 0,
-- 
2.43.0

