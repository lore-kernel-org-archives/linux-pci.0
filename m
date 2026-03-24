Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77718239567;
	Tue, 24 Mar 2026 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315852; cv=fail; b=SE6tbvKqBCy4CKEGCqMhzlKixr1PnKV4E//ooDY0Mh/77LWUdO6qNcCuLxFmb7gey8G6n+neHVJMIsOP3Sja1FXLHpmatfiCtDDrdI5OqTc9pJg0TH2jVbpKZZh0gdJvjNEGtg49d5aW47U8BlGyZy8pX3JiYdAwm5kE+9ggIyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315852; c=relaxed/simple;
	bh=Es/4zZNnMxkRotgkfaeLrG0QgAVhCWfS2Kfs2jdN0cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDqVtFu3VkR58Hp3elVHEwtCHZRRi2oLJr5omP0RRJlee5fw1rCcmYail1Ck+TsU0eXS1bEErbRtgfb1UVm64OV6xmuf1WLygXoK9AZtSX/33b5hTBBVLdGDFgl46uX88tRin+z95JSaUw9jCQuS2MqE/AqWsQ2bCiK3+C5RPJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZ6Knq12; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZ6Knq12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FK+r1yvnhciGU/TDjBlIkLBV4FZLfFu+yyndZgrje2bRjZ2NnSLfVDSwi16QXwvrmrklYG7+RcPwbOmzzlHA7AWFqLd7uSKSUqo3Ax28EyktDJlSDZdGMEZ/neQasoCwJtbVoDy2ttow+DXDyTOEqpjeM2fhHswca8ki1TKycyRDTcnaYBofmcNKVXCM3p6yqDgiNbHhxwF0ke0+zgTNdkZZIDxv62fNur3kgLxL8D5ZQiJFh9DTxZw45Cm05Q20fkhZawAD1e7SvMQigvW4jm7Xww2rzoN7u68FQBA1HnOn7SNqdbDAfezZ8gaG5Q7bJPYl5De/04Kb/EmUwZBX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es83l2r4nDUrD2m5uzrgFlia0E01r+50Dvvc62h3UNg=;
 b=rj74VwyLmaTt/SRKDR56NkcztK1ZvbnIXn2X+vlLoKXvMS3ivxO5n2TXTmS84cmY1L+Aybs8SWSbRALipJTsokwEAelhPjhwMpUaUbGJQ6OqH5QWRGg3TKsYmMyMkdVPmLbV/FgQyH4+jRJAlXjWcaqBanJSFvRtu5wcPb7Kc84uzGryAyOrOrlAMgiWSRNODLFjmzyxDYEzCyoMNaNkbhnUoWaW++NdTXrg79/oSLKdJVhsV+ZOPoWYtsbN+R2IQ9RLyWRbAOdmxKHXK9ZJg+rwkL5cSM54BYKZxw2eCNsOOGWF/fODY5MqHIRcDuCXzeCMSBY8ov7bPiBwkBycjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es83l2r4nDUrD2m5uzrgFlia0E01r+50Dvvc62h3UNg=;
 b=JZ6Knq12UnVJgUoYuEpc4e1yt7zdyI+1MIKTpAV8ubUnf7XDHXZC+Zw3+fG4LctWThsRSwZHuB0bmlpus5ZZ2KOlELDZWcGDbTGLkCONrOssYjHVpB7rcmQ7rYI9euf7xImIiiYLidmlyRZJKLjlwIKNcnCLDxWu1xODh7WUUeeO4Fsl84nayzOHfEPGg95AV5jehH6rn5zXQVdWUTakV9/lvi9fWVFLn3QC/hJ2z72Ieji4Akfqlfyqg+EsI6c92ZqABaBo+FoyXto0e/O4fspJiNqXSDrncitW/eVxIHmtaEd11rqwOaDdZhXzIU1D2UiNC5DARiWGArkWYTWD6A==
Received: from BN9PR03CA0886.namprd03.prod.outlook.com (2603:10b6:408:13c::21)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:30:38 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::cf) by BN9PR03CA0886.outlook.office365.com
 (2603:10b6:408:13c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:30:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:30:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:30:20 -0700
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 23 Mar 2026 18:30:19 -0700
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
Subject: [PATCH v3 6/8] perf: add NVIDIA Tegra410 CPU Memory Latency PMU
Date: Tue, 24 Mar 2026 01:29:50 +0000
Message-ID: <20260324012952.1923296-7-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f50deb-3912-4bcf-6bf7-08de8944f45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iqpX6uwju+WisV9wLeJCuKFOOE/LOkO9KxA6XB+bu1q99pbv3uAknUyoWPAz4KspEax0IFTv4M78dqfGa8Zz0JiBCdbeMA9jRrswse1umYU8iZ4JbM7Da9ij9VacewevuAZjt28D48orLjA/JYbLl4N4F0gEZCH7ESvSjqK7zedeqV074yNaahv0WKq24SiujsD6i49fQSxrcjRbRSVAfW5rZ6OLAym2Jpdh9YL99P3ZT5aRTi1cv5pvHvZonm9ae+hWN32f4AuCwV2ZmRNcjmEqkRSAWg9nm9BBgygDeLc5UzCiwcFoARzQlt8ZtnNrJRxWPhnoacreRfreWx3Uv02dEquyAGUVu/zbFvKZunYe8Us00mHAo6oI0Xp9KnOMBYvQCm+dW2S9JoenKXhPX94XH8aC8QBqSUDKdjzyJh++PjqB51HvgPremioTOzIK8ep04iJmKxPveL4YhK9Bai8pZtIVvNB1dz7uPAbjNCLwCPIjY707hfQIEg4RYv4MZionbPeqXWbTrCWdgWBEMdfu+qwmxLe37ZzC2wizvF+ZBOs6vcQq2bvEZu63az0R8NDqdZURxLQ7zNNQ8LJRoxRNUJMnoTmxx6PP/t7pEDTzmaZqKRXC3pDRWfuNxFN4tRbuuSXR8W6W2EzgwfFe/OIKWhJyJC8aZmAVUZUgIZDgjZqYAL8+cmVws51GRAtSXa+U+w9pvTgm/5wiU6nkJw3YNo00I4hxgRuGA2s41u18fCgEGphyHdYhgDBPju+rjPd2DMb/PP/Iee6vS/8CTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t7/cb5teAz+KiPU14A/C9mknhwlBpLfXhkg2wu0BdkDvAuesPCkjRhKHvTdpBExwF011THx3mqiUewmhqsxEfE/recCNDfurggagDZcLTVZIEw+mv2S0Z0Q0im6ILeegle1p+UorqSymTgDx556GQsapT5xfi2NswOw9AZTAo/wPai6XfTC/5UX+1ZBZe9ZburRP47f0JqUbLDTChEcQ23yA0HEQrIaovHY2L4DvzxKyiKnS9IRy6zrl1hWNbVYw4TDRims0YKKs6RnUf23CsGZ2O6BEsmoD0IrNGjmUT1XpO9qmZYYaVqx68JmEJUCt/DS5v9mMbUWgJ1jVtBQyYiIuS9u7aRo0ALpWbbzmialTqbVGT4e/pXOh7ijy3mCJzJbI4dudCGgOVLsiRBigUyRurgTlVGbnH93ge+oD1szOstpWwQKbrZHwDF9KOcxj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:30:38.1976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f50deb-3912-4bcf-6bf7-08de8944f45e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018

Adds CPU Memory (CMEM) Latency PMU support in Tegra410 SOC.
The PMU is used to measure latency between the edge of the
Unified Coherence Fabric to the local system DRAM.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../admin-guide/perf/nvidia-tegra410-pmu.rst  |  25 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/nvidia_t410_cmem_latency_pmu.c   | 736 ++++++++++++++++++
 4 files changed, 769 insertions(+)
 create mode 100644 drivers/perf/nvidia_t410_cmem_latency_pmu.c

diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
index c065764d41fe..9945c43f6a7a 100644
--- a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
+++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
@@ -8,6 +8,7 @@ metrics like memory bandwidth, latency, and utilization:
 * Unified Coherence Fabric (UCF)
 * PCIE
 * PCIE-TGT
+* CPU Memory (CMEM) Latency
 
 PMU Driver
 ----------
@@ -344,3 +345,27 @@ Example usage:
   0x10000 to 0x100FF on socket 0's PCIE RC-1::
 
     perf stat -a -e nvidia_pcie_tgt_pmu_0_rc_1/event=0x1,dst_addr_base=0x10000,dst_addr_mask=0xFFF00,dst_addr_en=0x1/
+
+CPU Memory (CMEM) Latency PMU
+-----------------------------
+
+This PMU monitors latency events of memory read requests from the edge of the
+Unified Coherence Fabric (UCF) to local CPU DRAM:
+
+  * RD_REQ counters: count read requests (32B per request).
+  * RD_CUM_OUTS counters: accumulated outstanding request counter, which track
+    how many cycles the read requests are in flight.
+  * CYCLES counter: counts the number of elapsed cycles.
+
+The average latency is calculated as::
+
+   FREQ_IN_GHZ = CYCLES / ELAPSED_TIME_IN_NS
+   AVG_LATENCY_IN_CYCLES = RD_CUM_OUTS / RD_REQ
+   AVERAGE_LATENCY_IN_NS = AVG_LATENCY_IN_CYCLES / FREQ_IN_GHZ
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_source/devices/nvidia_cmem_latency_pmu_<socket-id>.
+
+Example usage::
+
+  perf stat -a -e '{nvidia_cmem_latency_pmu_0/rd_req/,nvidia_cmem_latency_pmu_0/rd_cum_outs/,nvidia_cmem_latency_pmu_0/cycles/}'
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 638321fc9800..26e86067d8f9 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -311,4 +311,11 @@ config MARVELL_PEM_PMU
 	  Enable support for PCIe Interface performance monitoring
 	  on Marvell platform.
 
+config NVIDIA_TEGRA410_CMEM_LATENCY_PMU
+	tristate "NVIDIA Tegra410 CPU Memory Latency PMU"
+	depends on ARM64 && ACPI
+	help
+	  Enable perf support for CPU memory latency counters monitoring on
+	  NVIDIA Tegra410 SoC.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index ea52711a87e3..4aa6aad393c2 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
 obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
 obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
+obj-$(CONFIG_NVIDIA_TEGRA410_CMEM_LATENCY_PMU) += nvidia_t410_cmem_latency_pmu.o
diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
new file mode 100644
index 000000000000..acb8f5571522
--- /dev/null
+++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
@@ -0,0 +1,736 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra410 CPU Memory (CMEM) Latency PMU driver.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+#define NUM_INSTANCES    14
+
+/* Register offsets. */
+#define CMEM_LAT_CG_CTRL         0x800
+#define CMEM_LAT_CTRL            0x808
+#define CMEM_LAT_STATUS          0x810
+#define CMEM_LAT_CYCLE_CNTR      0x818
+#define CMEM_LAT_MC0_REQ_CNTR    0x820
+#define CMEM_LAT_MC0_AOR_CNTR    0x830
+#define CMEM_LAT_MC1_REQ_CNTR    0x838
+#define CMEM_LAT_MC1_AOR_CNTR    0x848
+#define CMEM_LAT_MC2_REQ_CNTR    0x850
+#define CMEM_LAT_MC2_AOR_CNTR    0x860
+
+/* CMEM_LAT_CTRL values. */
+#define CMEM_LAT_CTRL_DISABLE    0x0ULL
+#define CMEM_LAT_CTRL_ENABLE     0x1ULL
+#define CMEM_LAT_CTRL_CLR        0x2ULL
+
+/* CMEM_LAT_CG_CTRL values. */
+#define CMEM_LAT_CG_CTRL_DISABLE    0x0ULL
+#define CMEM_LAT_CG_CTRL_ENABLE     0x1ULL
+
+/* CMEM_LAT_STATUS register field. */
+#define CMEM_LAT_STATUS_CYCLE_OVF      BIT(0)
+#define CMEM_LAT_STATUS_MC0_AOR_OVF    BIT(1)
+#define CMEM_LAT_STATUS_MC0_REQ_OVF    BIT(3)
+#define CMEM_LAT_STATUS_MC1_AOR_OVF    BIT(4)
+#define CMEM_LAT_STATUS_MC1_REQ_OVF    BIT(6)
+#define CMEM_LAT_STATUS_MC2_AOR_OVF    BIT(7)
+#define CMEM_LAT_STATUS_MC2_REQ_OVF    BIT(9)
+
+/* Events. */
+#define CMEM_LAT_EVENT_CYCLES    0x0
+#define CMEM_LAT_EVENT_REQ       0x1
+#define CMEM_LAT_EVENT_AOR       0x2
+
+#define CMEM_LAT_NUM_EVENTS           0x3
+#define CMEM_LAT_MASK_EVENT           0x3
+#define CMEM_LAT_MAX_ACTIVE_EVENTS    32
+
+#define CMEM_LAT_ACTIVE_CPU_MASK        0x0
+#define CMEM_LAT_ASSOCIATED_CPU_MASK    0x1
+
+static unsigned long cmem_lat_pmu_cpuhp_state;
+
+struct cmem_lat_pmu_hw_events {
+	struct perf_event *events[CMEM_LAT_MAX_ACTIVE_EVENTS];
+	DECLARE_BITMAP(used_ctrs, CMEM_LAT_MAX_ACTIVE_EVENTS);
+};
+
+struct cmem_lat_pmu {
+	struct pmu pmu;
+	struct device *dev;
+	const char *name;
+	const char *identifier;
+	void __iomem *base_broadcast;
+	void __iomem *base[NUM_INSTANCES];
+	cpumask_t associated_cpus;
+	cpumask_t active_cpu;
+	struct hlist_node node;
+	struct cmem_lat_pmu_hw_events hw_events;
+};
+
+#define to_cmem_lat_pmu(p) \
+	container_of(p, struct cmem_lat_pmu, pmu)
+
+
+/* Get event type from perf_event. */
+static inline u32 get_event_type(struct perf_event *event)
+{
+	return (event->attr.config) & CMEM_LAT_MASK_EVENT;
+}
+
+/* PMU operations. */
+static int cmem_lat_pmu_get_event_idx(struct cmem_lat_pmu_hw_events *hw_events,
+				struct perf_event *event)
+{
+	unsigned int idx;
+
+	idx = find_first_zero_bit(hw_events->used_ctrs, CMEM_LAT_MAX_ACTIVE_EVENTS);
+	if (idx >= CMEM_LAT_MAX_ACTIVE_EVENTS)
+		return -EAGAIN;
+
+	set_bit(idx, hw_events->used_ctrs);
+
+	return idx;
+}
+
+static bool cmem_lat_pmu_validate_event(struct pmu *pmu,
+				 struct cmem_lat_pmu_hw_events *hw_events,
+				 struct perf_event *event)
+{
+	int ret;
+
+	if (is_software_event(event))
+		return true;
+
+	/* Reject groups spanning multiple HW PMUs. */
+	if (event->pmu != pmu)
+		return false;
+
+	ret = cmem_lat_pmu_get_event_idx(hw_events, event);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
+
+/* Make sure the group of events can be scheduled at once on the PMU. */
+static bool cmem_lat_pmu_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct cmem_lat_pmu_hw_events fake_hw_events;
+
+	if (event->group_leader == event)
+		return true;
+
+	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
+
+	if (!cmem_lat_pmu_validate_event(event->pmu, &fake_hw_events, leader))
+		return false;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!cmem_lat_pmu_validate_event(event->pmu, &fake_hw_events, sibling))
+			return false;
+	}
+
+	return cmem_lat_pmu_validate_event(event->pmu, &fake_hw_events, event);
+}
+
+static int cmem_lat_pmu_event_init(struct perf_event *event)
+{
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 event_type = get_event_type(event);
+
+	if (event->attr.type != event->pmu->type ||
+	    event_type >= CMEM_LAT_NUM_EVENTS)
+		return -ENOENT;
+
+	/*
+	 * Sampling, per-process mode, and per-task counters are not supported
+	 * since this PMU is shared across all CPUs.
+	 */
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK) {
+		dev_dbg(cmem_lat_pmu->pmu.dev,
+				"Can't support sampling and per-process mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0) {
+		dev_dbg(cmem_lat_pmu->pmu.dev, "Can't support per-task counters\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Make sure the CPU assignment is on one of the CPUs associated with
+	 * this PMU.
+	 */
+	if (!cpumask_test_cpu(event->cpu, &cmem_lat_pmu->associated_cpus)) {
+		dev_dbg(cmem_lat_pmu->pmu.dev,
+				"Requested cpu is not associated with the PMU\n");
+		return -EINVAL;
+	}
+
+	/* Enforce the current active CPU to handle the events in this PMU. */
+	event->cpu = cpumask_first(&cmem_lat_pmu->active_cpu);
+	if (event->cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!cmem_lat_pmu_validate_group(event))
+		return -EINVAL;
+
+	hwc->idx = -1;
+	hwc->config = event_type;
+
+	return 0;
+}
+
+static u64 cmem_lat_pmu_read_status(struct cmem_lat_pmu *cmem_lat_pmu,
+				   unsigned int inst)
+{
+	return readq(cmem_lat_pmu->base[inst] + CMEM_LAT_STATUS);
+}
+
+static u64 cmem_lat_pmu_read_cycle_counter(struct perf_event *event)
+{
+	const unsigned int instance = 0;
+	u64 status;
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(event->pmu);
+	struct device *dev = cmem_lat_pmu->dev;
+
+	/*
+	 * Use the reading from first instance since all instances are
+	 * identical.
+	 */
+	status = cmem_lat_pmu_read_status(cmem_lat_pmu, instance);
+	if (status & CMEM_LAT_STATUS_CYCLE_OVF)
+		dev_warn(dev, "Cycle counter overflow\n");
+
+	return readq(cmem_lat_pmu->base[instance] + CMEM_LAT_CYCLE_CNTR);
+}
+
+static u64 cmem_lat_pmu_read_req_counter(struct perf_event *event)
+{
+	unsigned int i;
+	u64 status, val = 0;
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(event->pmu);
+	struct device *dev = cmem_lat_pmu->dev;
+
+	/* Sum up the counts from all instances. */
+	for (i = 0; i < NUM_INSTANCES; i++) {
+		status = cmem_lat_pmu_read_status(cmem_lat_pmu, i);
+		if (status & CMEM_LAT_STATUS_MC0_REQ_OVF)
+			dev_warn(dev, "MC0 request counter overflow\n");
+		if (status & CMEM_LAT_STATUS_MC1_REQ_OVF)
+			dev_warn(dev, "MC1 request counter overflow\n");
+		if (status & CMEM_LAT_STATUS_MC2_REQ_OVF)
+			dev_warn(dev, "MC2 request counter overflow\n");
+
+		val += readq(cmem_lat_pmu->base[i] + CMEM_LAT_MC0_REQ_CNTR);
+		val += readq(cmem_lat_pmu->base[i] + CMEM_LAT_MC1_REQ_CNTR);
+		val += readq(cmem_lat_pmu->base[i] + CMEM_LAT_MC2_REQ_CNTR);
+	}
+
+	return val;
+}
+
+static u64 cmem_lat_pmu_read_aor_counter(struct perf_event *event)
+{
+	unsigned int i;
+	u64 status, val = 0;
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(event->pmu);
+	struct device *dev = cmem_lat_pmu->dev;
+
+	/* Sum up the counts from all instances. */
+	for (i = 0; i < NUM_INSTANCES; i++) {
+		status = cmem_lat_pmu_read_status(cmem_lat_pmu, i);
+		if (status & CMEM_LAT_STATUS_MC0_AOR_OVF)
+			dev_warn(dev, "MC0 AOR counter overflow\n");
+		if (status & CMEM_LAT_STATUS_MC1_AOR_OVF)
+			dev_warn(dev, "MC1 AOR counter overflow\n");
+		if (status & CMEM_LAT_STATUS_MC2_AOR_OVF)
+			dev_warn(dev, "MC2 AOR counter overflow\n");
+
+		val += readq(cmem_lat_pmu->base[i] + CMEM_LAT_MC0_AOR_CNTR);
+		val += readq(cmem_lat_pmu->base[i] + CMEM_LAT_MC1_AOR_CNTR);
+		val += readq(cmem_lat_pmu->base[i] + CMEM_LAT_MC2_AOR_CNTR);
+	}
+
+	return val;
+}
+
+static u64 (*read_counter_fn[CMEM_LAT_NUM_EVENTS])(struct perf_event *) = {
+	[CMEM_LAT_EVENT_CYCLES] = cmem_lat_pmu_read_cycle_counter,
+	[CMEM_LAT_EVENT_REQ] = cmem_lat_pmu_read_req_counter,
+	[CMEM_LAT_EVENT_AOR] = cmem_lat_pmu_read_aor_counter,
+};
+
+static void cmem_lat_pmu_event_update(struct perf_event *event)
+{
+	u32 event_type;
+	u64 prev, now;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	event_type = hwc->config;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		now = read_counter_fn[event_type](event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	local64_add(now - prev, &event->count);
+
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+static void cmem_lat_pmu_start(struct perf_event *event, int pmu_flags)
+{
+	event->hw.state = 0;
+}
+
+static void cmem_lat_pmu_stop(struct perf_event *event, int pmu_flags)
+{
+	event->hw.state |= PERF_HES_STOPPED;
+}
+
+static int cmem_lat_pmu_add(struct perf_event *event, int flags)
+{
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(event->pmu);
+	struct cmem_lat_pmu_hw_events *hw_events = &cmem_lat_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
+					   &cmem_lat_pmu->associated_cpus)))
+		return -ENOENT;
+
+	idx = cmem_lat_pmu_get_event_idx(hw_events, event);
+	if (idx < 0)
+		return idx;
+
+	hw_events->events[idx] = event;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		cmem_lat_pmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void cmem_lat_pmu_del(struct perf_event *event, int flags)
+{
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(event->pmu);
+	struct cmem_lat_pmu_hw_events *hw_events = &cmem_lat_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	cmem_lat_pmu_stop(event, PERF_EF_UPDATE);
+
+	hw_events->events[idx] = NULL;
+
+	clear_bit(idx, hw_events->used_ctrs);
+
+	perf_event_update_userpage(event);
+}
+
+static void cmem_lat_pmu_read(struct perf_event *event)
+{
+	cmem_lat_pmu_event_update(event);
+}
+
+static inline void cmem_lat_pmu_cg_ctrl(struct cmem_lat_pmu *cmem_lat_pmu,
+										u64 val)
+{
+	writeq(val, cmem_lat_pmu->base_broadcast + CMEM_LAT_CG_CTRL);
+}
+
+static inline void cmem_lat_pmu_ctrl(struct cmem_lat_pmu *cmem_lat_pmu, u64 val)
+{
+	writeq(val, cmem_lat_pmu->base_broadcast + CMEM_LAT_CTRL);
+}
+
+static void cmem_lat_pmu_enable(struct pmu *pmu)
+{
+	bool disabled;
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(pmu);
+
+	disabled = bitmap_empty(cmem_lat_pmu->hw_events.used_ctrs,
+							CMEM_LAT_MAX_ACTIVE_EVENTS);
+
+	if (disabled)
+		return;
+
+	/* Enable all the counters. */
+	cmem_lat_pmu_cg_ctrl(cmem_lat_pmu, CMEM_LAT_CG_CTRL_ENABLE);
+	cmem_lat_pmu_ctrl(cmem_lat_pmu, CMEM_LAT_CTRL_ENABLE);
+}
+
+static void cmem_lat_pmu_disable(struct pmu *pmu)
+{
+	int idx;
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(pmu);
+
+	/* Disable all the counters. */
+	cmem_lat_pmu_ctrl(cmem_lat_pmu, CMEM_LAT_CTRL_DISABLE);
+
+	/*
+	 * The counters will start from 0 again on restart.
+	 * Update the events immediately to avoid losing the counts.
+	 */
+	for_each_set_bit(idx, cmem_lat_pmu->hw_events.used_ctrs,
+						CMEM_LAT_MAX_ACTIVE_EVENTS) {
+		struct perf_event *event = cmem_lat_pmu->hw_events.events[idx];
+
+		if (!event)
+			continue;
+
+		cmem_lat_pmu_event_update(event);
+
+		local64_set(&event->hw.prev_count, 0ULL);
+	}
+
+	cmem_lat_pmu_ctrl(cmem_lat_pmu, CMEM_LAT_CTRL_CLR);
+	cmem_lat_pmu_cg_ctrl(cmem_lat_pmu, CMEM_LAT_CG_CTRL_DISABLE);
+}
+
+/* PMU identifier attribute. */
+
+static ssize_t cmem_lat_pmu_identifier_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *page)
+{
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(page, "%s\n", cmem_lat_pmu->identifier);
+}
+
+static struct device_attribute cmem_lat_pmu_identifier_attr =
+	__ATTR(identifier, 0444, cmem_lat_pmu_identifier_show, NULL);
+
+static struct attribute *cmem_lat_pmu_identifier_attrs[] = {
+	&cmem_lat_pmu_identifier_attr.attr,
+	NULL
+};
+
+static struct attribute_group cmem_lat_pmu_identifier_attr_group = {
+	.attrs = cmem_lat_pmu_identifier_attrs,
+};
+
+/* Format attributes. */
+
+#define NV_PMU_EXT_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]){				\
+		{							\
+			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.var = (void *)_config				\
+		}							\
+	})[0].attr.attr)
+
+static struct attribute *cmem_lat_pmu_formats[] = {
+	NV_PMU_EXT_ATTR(event, device_show_string, "config:0-1"),
+	NULL
+};
+
+static const struct attribute_group cmem_lat_pmu_format_group = {
+	.name = "format",
+	.attrs = cmem_lat_pmu_formats,
+};
+
+/* Event attributes. */
+
+static ssize_t cmem_lat_pmu_sysfs_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, typeof(*pmu_attr), attr);
+	return sysfs_emit(buf, "event=0x%llx\n", pmu_attr->id);
+}
+
+#define NV_PMU_EVENT_ATTR(_name, _config)	\
+	PMU_EVENT_ATTR_ID(_name, cmem_lat_pmu_sysfs_event_show, _config)
+
+static struct attribute *cmem_lat_pmu_events[] = {
+	NV_PMU_EVENT_ATTR(cycles, CMEM_LAT_EVENT_CYCLES),
+	NV_PMU_EVENT_ATTR(rd_req, CMEM_LAT_EVENT_REQ),
+	NV_PMU_EVENT_ATTR(rd_cum_outs, CMEM_LAT_EVENT_AOR),
+	NULL
+};
+
+static const struct attribute_group cmem_lat_pmu_events_group = {
+	.name = "events",
+	.attrs = cmem_lat_pmu_events,
+};
+
+/* Cpumask attributes. */
+
+static ssize_t cmem_lat_pmu_cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct cmem_lat_pmu *cmem_lat_pmu = to_cmem_lat_pmu(pmu);
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	unsigned long mask_id = (unsigned long)eattr->var;
+	const cpumask_t *cpumask;
+
+	switch (mask_id) {
+	case CMEM_LAT_ACTIVE_CPU_MASK:
+		cpumask = &cmem_lat_pmu->active_cpu;
+		break;
+	case CMEM_LAT_ASSOCIATED_CPU_MASK:
+		cpumask = &cmem_lat_pmu->associated_cpus;
+		break;
+	default:
+		return 0;
+	}
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
+}
+
+#define NV_PMU_CPUMASK_ATTR(_name, _config)			\
+	NV_PMU_EXT_ATTR(_name, cmem_lat_pmu_cpumask_show,	\
+				(unsigned long)_config)
+
+static struct attribute *cmem_lat_pmu_cpumask_attrs[] = {
+	NV_PMU_CPUMASK_ATTR(cpumask, CMEM_LAT_ACTIVE_CPU_MASK),
+	NV_PMU_CPUMASK_ATTR(associated_cpus, CMEM_LAT_ASSOCIATED_CPU_MASK),
+	NULL
+};
+
+static const struct attribute_group cmem_lat_pmu_cpumask_attr_group = {
+	.attrs = cmem_lat_pmu_cpumask_attrs,
+};
+
+/* Per PMU device attribute groups. */
+
+static const struct attribute_group *cmem_lat_pmu_attr_groups[] = {
+	&cmem_lat_pmu_identifier_attr_group,
+	&cmem_lat_pmu_format_group,
+	&cmem_lat_pmu_events_group,
+	&cmem_lat_pmu_cpumask_attr_group,
+	NULL
+};
+
+static int cmem_lat_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct cmem_lat_pmu *cmem_lat_pmu =
+		hlist_entry_safe(node, struct cmem_lat_pmu, node);
+
+	if (!cpumask_test_cpu(cpu, &cmem_lat_pmu->associated_cpus))
+		return 0;
+
+	/* If the PMU is already managed, there is nothing to do */
+	if (!cpumask_empty(&cmem_lat_pmu->active_cpu))
+		return 0;
+
+	/* Use this CPU for event counting */
+	cpumask_set_cpu(cpu, &cmem_lat_pmu->active_cpu);
+
+	return 0;
+}
+
+static int cmem_lat_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
+{
+	unsigned int dst;
+
+	struct cmem_lat_pmu *cmem_lat_pmu =
+		hlist_entry_safe(node, struct cmem_lat_pmu, node);
+
+	/* Nothing to do if this CPU doesn't own the PMU */
+	if (!cpumask_test_and_clear_cpu(cpu, &cmem_lat_pmu->active_cpu))
+		return 0;
+
+	/* Choose a new CPU to migrate ownership of the PMU to */
+	dst = cpumask_any_and_but(&cmem_lat_pmu->associated_cpus,
+				  cpu_online_mask, cpu);
+	if (dst >= nr_cpu_ids)
+		return 0;
+
+	/* Use this CPU for event counting */
+	perf_pmu_migrate_context(&cmem_lat_pmu->pmu, cpu, dst);
+	cpumask_set_cpu(dst, &cmem_lat_pmu->active_cpu);
+
+	return 0;
+}
+
+static int cmem_lat_pmu_get_cpus(struct cmem_lat_pmu *cmem_lat_pmu,
+				unsigned int socket)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_to_node(cpu) == socket)
+			cpumask_set_cpu(cpu, &cmem_lat_pmu->associated_cpus);
+	}
+
+	if (cpumask_empty(&cmem_lat_pmu->associated_cpus)) {
+		dev_dbg(cmem_lat_pmu->dev,
+			"No cpu associated with PMU socket-%u\n", socket);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int cmem_lat_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_device *acpi_dev;
+	struct cmem_lat_pmu *cmem_lat_pmu;
+	char *name, *uid_str;
+	int ret, i;
+	u32 socket;
+
+	acpi_dev = ACPI_COMPANION(dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
+	uid_str = acpi_device_uid(acpi_dev);
+	if (!uid_str)
+		return -ENODEV;
+
+	ret = kstrtou32(uid_str, 0, &socket);
+	if (ret)
+		return ret;
+
+	cmem_lat_pmu = devm_kzalloc(dev, sizeof(*cmem_lat_pmu), GFP_KERNEL);
+	name = devm_kasprintf(dev, GFP_KERNEL, "nvidia_cmem_latency_pmu_%u", socket);
+	if (!cmem_lat_pmu || !name)
+		return -ENOMEM;
+
+	cmem_lat_pmu->dev = dev;
+	cmem_lat_pmu->name = name;
+	cmem_lat_pmu->identifier = acpi_device_hid(acpi_dev);
+	platform_set_drvdata(pdev, cmem_lat_pmu);
+
+	cmem_lat_pmu->pmu = (struct pmu) {
+		.parent		= &pdev->dev,
+		.task_ctx_nr	= perf_invalid_context,
+		.pmu_enable	= cmem_lat_pmu_enable,
+		.pmu_disable	= cmem_lat_pmu_disable,
+		.event_init	= cmem_lat_pmu_event_init,
+		.add		= cmem_lat_pmu_add,
+		.del		= cmem_lat_pmu_del,
+		.start		= cmem_lat_pmu_start,
+		.stop		= cmem_lat_pmu_stop,
+		.read		= cmem_lat_pmu_read,
+		.attr_groups	= cmem_lat_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+					PERF_PMU_CAP_NO_INTERRUPT,
+	};
+
+	/* Map the address of all the instances. */
+	for (i = 0; i < NUM_INSTANCES; i++) {
+		cmem_lat_pmu->base[i] = devm_platform_ioremap_resource(pdev, i);
+		if (IS_ERR(cmem_lat_pmu->base[i])) {
+			dev_err(dev, "Failed map address for instance %d\n", i);
+			return PTR_ERR(cmem_lat_pmu->base[i]);
+		}
+	}
+
+	/* Map broadcast address. */
+	cmem_lat_pmu->base_broadcast = devm_platform_ioremap_resource(pdev,
+										NUM_INSTANCES);
+	if (IS_ERR(cmem_lat_pmu->base_broadcast)) {
+		dev_err(dev, "Failed map broadcast address\n");
+		return PTR_ERR(cmem_lat_pmu->base_broadcast);
+	}
+
+	ret = cmem_lat_pmu_get_cpus(cmem_lat_pmu, socket);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_state_add_instance(cmem_lat_pmu_cpuhp_state,
+				       &cmem_lat_pmu->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
+		return ret;
+	}
+
+	cmem_lat_pmu_cg_ctrl(cmem_lat_pmu, CMEM_LAT_CG_CTRL_ENABLE);
+	cmem_lat_pmu_ctrl(cmem_lat_pmu, CMEM_LAT_CTRL_CLR);
+	cmem_lat_pmu_cg_ctrl(cmem_lat_pmu, CMEM_LAT_CG_CTRL_DISABLE);
+
+	ret = perf_pmu_register(&cmem_lat_pmu->pmu, name, -1);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register PMU: %d\n", ret);
+		cpuhp_state_remove_instance(cmem_lat_pmu_cpuhp_state,
+					    &cmem_lat_pmu->node);
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "Registered %s PMU\n", name);
+
+	return 0;
+}
+
+static void cmem_lat_pmu_device_remove(struct platform_device *pdev)
+{
+	struct cmem_lat_pmu *cmem_lat_pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&cmem_lat_pmu->pmu);
+	cpuhp_state_remove_instance(cmem_lat_pmu_cpuhp_state,
+				    &cmem_lat_pmu->node);
+}
+
+static const struct acpi_device_id cmem_lat_pmu_acpi_match[] = {
+	{ "NVDA2021" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cmem_lat_pmu_acpi_match);
+
+static struct platform_driver cmem_lat_pmu_driver = {
+	.driver = {
+		.name = "nvidia-t410-cmem-latency-pmu",
+		.acpi_match_table = ACPI_PTR(cmem_lat_pmu_acpi_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = cmem_lat_pmu_probe,
+	.remove = cmem_lat_pmu_device_remove,
+};
+
+static int __init cmem_lat_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/nvidia/cmem_latency:online",
+				      cmem_lat_pmu_cpu_online,
+				      cmem_lat_pmu_cpu_teardown);
+	if (ret < 0)
+		return ret;
+
+	cmem_lat_pmu_cpuhp_state = ret;
+
+	return platform_driver_register(&cmem_lat_pmu_driver);
+}
+
+static void __exit cmem_lat_pmu_exit(void)
+{
+	platform_driver_unregister(&cmem_lat_pmu_driver);
+	cpuhp_remove_multi_state(cmem_lat_pmu_cpuhp_state);
+}
+
+module_init(cmem_lat_pmu_init);
+module_exit(cmem_lat_pmu_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NVIDIA Tegra410 CPU Memory Latency PMU driver");
+MODULE_AUTHOR("Besar Wicaksono <bwicaksono@nvidia.com>");
-- 
2.43.0

