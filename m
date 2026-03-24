Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4B34D3B9;
	Tue, 24 Mar 2026 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315859; cv=fail; b=QFLS5JHq/CyD6AXJtCqkPJ7y4LKx0sMPeBEkqcLCJE4IMf+ngfLQE71gmBwgy1CgQFIcAMIUzPg9+ioKZvJzMoIduoREc6rWiIor5hYQlpr48gOU2rMsCm4chSzCRqZTYe2hqHa6a4cDH2kGMpgRuQoBgGUqZuGFMQayamZIsj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315859; c=relaxed/simple;
	bh=7ZGZYxhtHb4ljmxbJ4QnvSkkP+lKrBRYBnqZcHwW0l4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYiAsmC69/JZ2WJ7LaIF8uy3E6Oc5EVDcCYplgVUu/w8/LPZ+oQvaci8n5TynbUUSejgTUDZGpqmSQJwG7OQgoQkh6iUcppNJdXppPDyO9Z6DhnzotgM32mu4wv70rI7NUca48+/NLovxJSo0ykc1kpnv4joXnwL96hpUxDPalQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=db+rZG3G; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="db+rZG3G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF9beXMMtd86R/oeRcn0tClGopyQWAd0cZHlSSo5Go1pRTaykNR4OsCPfyjAX6d73T3XJaWKVWCASd4/rRKmS0cVbVVt8Q9fUVQnGHQVCnksOcho1XEfQTXDQPZG4/XGJfImg8uy+I3iwmP0F0Vid8FpuajJJSTKnXc8Wi9Lk6uw5VC2sZ8jwHFchcvGgZMIFcC8CXsA6PH6fYEx74hjE7AaHvOGQ+uBvUimQNkmkczR/cdnWYTRYhWJi6C3lkxhVzAhi7v5dfN5U6YRaTQgDk9CnOGkKQfZ6mFVeMxGIopffy4V9iM7Rfptxh6xyZ/LfyoWewvtOqvc2OvSGAx87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLjL8tH9pHzRbA/n1e0T57QScQBoLWmtA3czo9Q5NMc=;
 b=tzQgZSksNz1zn4HjKIlOXkPpZroHyhwDZp65+Ti1mtvAABk+lI9PpRNTc/M5292534/GG0zcg6NV48GUDCCA5724sANgzJNYU+G5AAspRBRREXJ1Ngt3Q0sKV2BeeXfkKXvQb0OtOKvQod+UBnGq0u/WM54254yD1OYtwdOrckdQYhSkJSCd2xYZ/a3FsC3R/Rh8VgJPSoBKHKx7mP8oq1A+ugST8G20yMkKUU40DiQlVXsvix0b+1QWgZmgLgXXW/D0tw3Tqp5OuIVCI+s+g8xiK+2dK6W7p5L3m8q9VVhkycGf0RV3NTyx6l6JFYWBH+LYwhfSy0iTApFGfRJvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLjL8tH9pHzRbA/n1e0T57QScQBoLWmtA3czo9Q5NMc=;
 b=db+rZG3GdexYCzNyolNcZCMRU1I8eTbuv15VvJ9f3P+k99eCJ8gNtKxoynIs47Bzg6+uVRjXOFUC5RzhCfKbMoM3Qfc9eTmMy5tgJ2o2eJIIQp/cbnsc4HQWLQkGfOsD5ymcgGhxaX/+icAhiaGtAdfW78Lx6w4ynQxuHheWxu8/stYjsSobPoxCJoVqMpywNFH2sJjcSCTIl29QTWUW9hVdSFbdrFSt6ENiO3aRvCQwEhLAR3l8WNwRVfTXGh92VZ09a8zvGjtSGfjgU8RDfuW6egK6O1oqlD0n+ncNSVKSkphE8UaytdAj+iwR48P8N98l+OXJ9K6IDcYHrZkhGQ==
Received: from MN2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:208:23b::16)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:30:45 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::9c) by MN2PR11CA0011.outlook.office365.com
 (2603:10b6:208:23b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:30:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:30:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:30:22 -0700
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 23 Mar 2026 18:30:22 -0700
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
Subject: [PATCH v3 7/8] perf: add NVIDIA Tegra410 C2C PMU
Date: Tue, 24 Mar 2026 01:29:51 +0000
Message-ID: <20260324012952.1923296-8-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1cb6be-1dac-43b9-d1f4-08de8944f8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+Fmf2fZZESqO+jEhv+3Gn7vusia+M+IIWXuUNzh8UBxgDXFnKbuJ7alStZRWdpkyOhnhac2EXERFZAYo4s8/9x4/MJ+tioWt1lltqRBrtj4SQj8LgVNnXCuRGb48O/RgJxkRTXGSyrXnDBjnF8vkCboBk+KHiSf/jM08TRu/kKBXbxK6vssTQyZbu+CLPjbtAptgA4eAfmzdFo37NvgJDofASYX3qZhCt/yW/ETJDx18pR8c5uXXFqDJMd/jf98N1uCuXB1L3Yrwwxz8lPfSjstzL9/vWpz5JPuUqhcbxUdLETJgLyJl8xMvxh42MAmkuRuauIABkA0HbyDBpefZLFx0QF3GN39R7mGhTTwP04icus/QWKAKzRHyBQcqBM1lGIbEdE0XrZu3U5DnO8L6s0qKepttGOoH1MR+jUVn86DyGIwyQU63Zn1mhxkFlovwxr3j/xx+0NADIvR6rgW69622KMrmJD2Dxalg/Hxj7gUYgGbPIt1KLov6BtgvXDhm51XBJqH1yOw/ztuf3W7NHWbZy1oH6g8n8Do6QcJUt/wTqLcCrlDUuS0xdT9hygUrF6IsmO79efAVr8x+xKfBpAP6QnTViJWtWHVTCftC8ktyO99M0peptcCgVEUDIbA89DTM7+0CDG/mgBYlu4WSACngOfzALGJyxaq4kCnORyJqdx0CdBnG2+I1O0/DoEZjdXUpvBnkj2dIi2M5K3TYGy+hCwnIexvlcluyoPzAkSPaRwogeEBITxsLkSNggePjyT90ftU1aUqQVNaun7gqkA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7kmxCKLZXJmC0Ft17KjuKx+zFrODt5IVOe4AkqoJXOoTUf/QX6dizdXLyCfndwMu3hg6UE0qiHHS3Qz4Co3Rm8hMfEfsKYpbMtLadWmVpWtf5hSb0GbGM7OTeDO4rUhjtLhP1Yz/EqPNVFjIAa2C2XKR/69NA8D/3YBfNb9dV8g/T5Ry70UVJ5biB8l8mEk/VoyakUUmLOQ0nSx6LQoRTt4hLazEeQZFGwsp48HGETRebk/VbobU4TN5PlQptQZLoJ1baTiDPkB6NlcOFISbken0O9Zxu27dLmZ0hTh8NE7Z9cjktKyilBH+4hXc0/u18dB+qj5+pRHGNMA6W56nh3Mtw7hO7Mw9sUyZhSSgjTGW1473MWmZuSAP+EscUIGxnzYhh9EIMVIVrj4XACtLAZZuelw63NeKvLuzBVf9muo4BIAxq3np77mBX4KMQIE4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:30:45.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1cb6be-1dac-43b9-d1f4-08de8944f8ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

Adds NVIDIA C2C PMU support in Tegra410 SOC. This PMU is
used to measure memory latency between the SOC and device
memory, e.g GPU Memory (GMEM), CXL Memory, or memory on
remote Tegra410 SOC.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../admin-guide/perf/nvidia-tegra410-pmu.rst  |  151 +++
 drivers/perf/Kconfig                          |    7 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/nvidia_t410_c2c_pmu.c            | 1051 +++++++++++++++++
 4 files changed, 1210 insertions(+)
 create mode 100644 drivers/perf/nvidia_t410_c2c_pmu.c

diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
index 9945c43f6a7a..0656223b61d4 100644
--- a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
+++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
@@ -9,6 +9,9 @@ metrics like memory bandwidth, latency, and utilization:
 * PCIE
 * PCIE-TGT
 * CPU Memory (CMEM) Latency
+* NVLink-C2C
+* NV-CLink
+* NV-DLink
 
 PMU Driver
 ----------
@@ -369,3 +372,151 @@ see /sys/bus/event_source/devices/nvidia_cmem_latency_pmu_<socket-id>.
 Example usage::
 
   perf stat -a -e '{nvidia_cmem_latency_pmu_0/rd_req/,nvidia_cmem_latency_pmu_0/rd_cum_outs/,nvidia_cmem_latency_pmu_0/cycles/}'
+
+NVLink-C2C PMU
+--------------
+
+This PMU monitors latency events of memory read/write requests that pass through
+the NVIDIA Chip-to-Chip (C2C) interface. Bandwidth events are not available
+in this PMU, unlike the C2C PMU in Grace (Tegra241 SoC).
+
+The events and configuration options of this PMU device are available in sysfs,
+see /sys/bus/event_source/devices/nvidia_nvlink_c2c_pmu_<socket-id>.
+
+The list of events:
+
+  * IN_RD_CUM_OUTS: accumulated outstanding request (in cycles) of incoming read requests.
+  * IN_RD_REQ: the number of incoming read requests.
+  * IN_WR_CUM_OUTS: accumulated outstanding request (in cycles) of incoming write requests.
+  * IN_WR_REQ: the number of incoming write requests.
+  * OUT_RD_CUM_OUTS: accumulated outstanding request (in cycles) of outgoing read requests.
+  * OUT_RD_REQ: the number of outgoing read requests.
+  * OUT_WR_CUM_OUTS: accumulated outstanding request (in cycles) of outgoing write requests.
+  * OUT_WR_REQ: the number of outgoing write requests.
+  * CYCLES: NVLink-C2C interface cycle counts.
+
+The incoming events count the reads/writes from remote device to the SoC.
+The outgoing events count the reads/writes from the SoC to remote device.
+
+The sysfs /sys/bus/event_source/devices/nvidia_nvlink_c2c_pmu_<socket-id>/peer
+contains the information about the connected device.
+
+When the C2C interface is connected to GPU(s), the user can use the
+"gpu_mask" parameter to filter traffic to/from specific GPU(s). Each bit represents the GPU
+index, e.g. "gpu_mask=0x1" corresponds to GPU 0 and "gpu_mask=0x3" is for GPU 0 and 1.
+The PMU will monitor all GPUs by default if not specified.
+
+When connected to another SoC, only the read events are available.
+
+The events can be used to calculate the average latency of the read/write requests::
+
+   C2C_FREQ_IN_GHZ = CYCLES / ELAPSED_TIME_IN_NS
+
+   IN_RD_AVG_LATENCY_IN_CYCLES = IN_RD_CUM_OUTS / IN_RD_REQ
+   IN_RD_AVG_LATENCY_IN_NS = IN_RD_AVG_LATENCY_IN_CYCLES / C2C_FREQ_IN_GHZ
+
+   IN_WR_AVG_LATENCY_IN_CYCLES = IN_WR_CUM_OUTS / IN_WR_REQ
+   IN_WR_AVG_LATENCY_IN_NS = IN_WR_AVG_LATENCY_IN_CYCLES / C2C_FREQ_IN_GHZ
+
+   OUT_RD_AVG_LATENCY_IN_CYCLES = OUT_RD_CUM_OUTS / OUT_RD_REQ
+   OUT_RD_AVG_LATENCY_IN_NS = OUT_RD_AVG_LATENCY_IN_CYCLES / C2C_FREQ_IN_GHZ
+
+   OUT_WR_AVG_LATENCY_IN_CYCLES = OUT_WR_CUM_OUTS / OUT_WR_REQ
+   OUT_WR_AVG_LATENCY_IN_NS = OUT_WR_AVG_LATENCY_IN_CYCLES / C2C_FREQ_IN_GHZ
+
+Example usage:
+
+  * Count incoming traffic from all GPUs connected via NVLink-C2C::
+
+      perf stat -a -e nvidia_nvlink_c2c_pmu_0/in_rd_req/
+
+  * Count incoming traffic from GPU 0 connected via NVLink-C2C::
+
+      perf stat -a -e nvidia_nvlink_c2c_pmu_0/in_rd_cum_outs,gpu_mask=0x1/
+
+  * Count incoming traffic from GPU 1 connected via NVLink-C2C::
+
+      perf stat -a -e nvidia_nvlink_c2c_pmu_0/in_rd_cum_outs,gpu_mask=0x2/
+
+  * Count outgoing traffic to all GPUs connected via NVLink-C2C::
+
+      perf stat -a -e nvidia_nvlink_c2c_pmu_0/out_rd_req/
+
+  * Count outgoing traffic to GPU 0 connected via NVLink-C2C::
+
+      perf stat -a -e nvidia_nvlink_c2c_pmu_0/out_rd_cum_outs,gpu_mask=0x1/
+
+  * Count outgoing traffic to GPU 1 connected via NVLink-C2C::
+
+      perf stat -a -e nvidia_nvlink_c2c_pmu_0/out_rd_cum_outs,gpu_mask=0x2/
+
+NV-CLink PMU
+------------
+
+This PMU monitors latency events of memory read requests that pass through
+the NV-CLINK interface. Bandwidth events are not available in this PMU.
+In Tegra410 SoC, the NV-CLink interface is used to connect to another Tegra410
+SoC and this PMU only counts read traffic.
+
+The events and configuration options of this PMU device are available in sysfs,
+see /sys/bus/event_source/devices/nvidia_nvclink_pmu_<socket-id>.
+
+The list of events:
+
+  * IN_RD_CUM_OUTS: accumulated outstanding request (in cycles) of incoming read requests.
+  * IN_RD_REQ: the number of incoming read requests.
+  * OUT_RD_CUM_OUTS: accumulated outstanding request (in cycles) of outgoing read requests.
+  * OUT_RD_REQ: the number of outgoing read requests.
+  * CYCLES: NV-CLINK interface cycle counts.
+
+The incoming events count the reads from remote device to the SoC.
+The outgoing events count the reads from the SoC to remote device.
+
+The events can be used to calculate the average latency of the read requests::
+
+   CLINK_FREQ_IN_GHZ = CYCLES / ELAPSED_TIME_IN_NS
+
+   IN_RD_AVG_LATENCY_IN_CYCLES = IN_RD_CUM_OUTS / IN_RD_REQ
+   IN_RD_AVG_LATENCY_IN_NS = IN_RD_AVG_LATENCY_IN_CYCLES / CLINK_FREQ_IN_GHZ
+
+   OUT_RD_AVG_LATENCY_IN_CYCLES = OUT_RD_CUM_OUTS / OUT_RD_REQ
+   OUT_RD_AVG_LATENCY_IN_NS = OUT_RD_AVG_LATENCY_IN_CYCLES / CLINK_FREQ_IN_GHZ
+
+Example usage:
+
+  * Count incoming read traffic from remote SoC connected via NV-CLINK::
+
+      perf stat -a -e nvidia_nvclink_pmu_0/in_rd_req/
+
+  * Count outgoing read traffic to remote SoC connected via NV-CLINK::
+
+      perf stat -a -e nvidia_nvclink_pmu_0/out_rd_req/
+
+NV-DLink PMU
+------------
+
+This PMU monitors latency events of memory read requests that pass through
+the NV-DLINK interface.  Bandwidth events are not available in this PMU.
+In Tegra410 SoC, this PMU only counts CXL memory read traffic.
+
+The events and configuration options of this PMU device are available in sysfs,
+see /sys/bus/event_source/devices/nvidia_nvdlink_pmu_<socket-id>.
+
+The list of events:
+
+  * IN_RD_CUM_OUTS: accumulated outstanding read requests (in cycles) to CXL memory.
+  * IN_RD_REQ: the number of read requests to CXL memory.
+  * CYCLES: NV-DLINK interface cycle counts.
+
+The events can be used to calculate the average latency of the read requests::
+
+   DLINK_FREQ_IN_GHZ = CYCLES / ELAPSED_TIME_IN_NS
+
+   IN_RD_AVG_LATENCY_IN_CYCLES = IN_RD_CUM_OUTS / IN_RD_REQ
+   IN_RD_AVG_LATENCY_IN_NS = IN_RD_AVG_LATENCY_IN_CYCLES / DLINK_FREQ_IN_GHZ
+
+Example usage:
+
+  * Count read events to CXL memory::
+
+      perf stat -a -e '{nvidia_nvdlink_pmu_0/in_rd_req/,nvidia_nvdlink_pmu_0/in_rd_cum_outs/}'
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 26e86067d8f9..ab90932fc2d0 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -318,4 +318,11 @@ config NVIDIA_TEGRA410_CMEM_LATENCY_PMU
 	  Enable perf support for CPU memory latency counters monitoring on
 	  NVIDIA Tegra410 SoC.
 
+config NVIDIA_TEGRA410_C2C_PMU
+	tristate "NVIDIA Tegra410 C2C PMU"
+	depends on ARM64 && ACPI
+	help
+	  Enable perf support for counters in NVIDIA C2C interface of NVIDIA
+	  Tegra410 SoC.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 4aa6aad393c2..eb8a022dad9a 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
 obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
 obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
 obj-$(CONFIG_NVIDIA_TEGRA410_CMEM_LATENCY_PMU) += nvidia_t410_cmem_latency_pmu.o
+obj-$(CONFIG_NVIDIA_TEGRA410_C2C_PMU) += nvidia_t410_c2c_pmu.o
diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
new file mode 100644
index 000000000000..411987153ff3
--- /dev/null
+++ b/drivers/perf/nvidia_t410_c2c_pmu.c
@@ -0,0 +1,1051 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra410 C2C PMU driver.
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
+#include <linux/property.h>
+
+/* The C2C interface types in Tegra410. */
+#define C2C_TYPE_NVLINK          0x0
+#define C2C_TYPE_NVCLINK         0x1
+#define C2C_TYPE_NVDLINK         0x2
+#define C2C_TYPE_COUNT           0x3
+
+/* The type of the peer device connected to the C2C interface. */
+#define C2C_PEER_TYPE_CPU        0x0
+#define C2C_PEER_TYPE_GPU        0x1
+#define C2C_PEER_TYPE_CXLMEM     0x2
+#define C2C_PEER_TYPE_COUNT      0x3
+
+/* The number of peer devices can be connected to the C2C interface. */
+#define C2C_NR_PEER_CPU          0x1
+#define C2C_NR_PEER_GPU          0x2
+#define C2C_NR_PEER_CXLMEM       0x1
+#define C2C_NR_PEER_MAX          0x2
+
+/* Number of instances on each interface. */
+#define C2C_NR_INST_NVLINK       14
+#define C2C_NR_INST_NVCLINK      12
+#define C2C_NR_INST_NVDLINK      16
+#define C2C_NR_INST_MAX          16
+
+/* Register offsets. */
+#define C2C_CTRL                    0x864
+#define C2C_IN_STATUS               0x868
+#define C2C_CYCLE_CNTR              0x86c
+#define C2C_IN_RD_CUM_OUTS_CNTR     0x874
+#define C2C_IN_RD_REQ_CNTR          0x87c
+#define C2C_IN_WR_CUM_OUTS_CNTR     0x884
+#define C2C_IN_WR_REQ_CNTR          0x88c
+#define C2C_OUT_STATUS              0x890
+#define C2C_OUT_RD_CUM_OUTS_CNTR    0x898
+#define C2C_OUT_RD_REQ_CNTR         0x8a0
+#define C2C_OUT_WR_CUM_OUTS_CNTR    0x8a8
+#define C2C_OUT_WR_REQ_CNTR         0x8b0
+
+/* C2C_IN_STATUS register field. */
+#define C2C_IN_STATUS_CYCLE_OVF             BIT(0)
+#define C2C_IN_STATUS_IN_RD_CUM_OUTS_OVF    BIT(1)
+#define C2C_IN_STATUS_IN_RD_REQ_OVF         BIT(2)
+#define C2C_IN_STATUS_IN_WR_CUM_OUTS_OVF    BIT(3)
+#define C2C_IN_STATUS_IN_WR_REQ_OVF         BIT(4)
+
+/* C2C_OUT_STATUS register field. */
+#define C2C_OUT_STATUS_OUT_RD_CUM_OUTS_OVF    BIT(0)
+#define C2C_OUT_STATUS_OUT_RD_REQ_OVF         BIT(1)
+#define C2C_OUT_STATUS_OUT_WR_CUM_OUTS_OVF    BIT(2)
+#define C2C_OUT_STATUS_OUT_WR_REQ_OVF         BIT(3)
+
+/* Events. */
+#define C2C_EVENT_CYCLES                0x0
+#define C2C_EVENT_IN_RD_CUM_OUTS        0x1
+#define C2C_EVENT_IN_RD_REQ             0x2
+#define C2C_EVENT_IN_WR_CUM_OUTS        0x3
+#define C2C_EVENT_IN_WR_REQ             0x4
+#define C2C_EVENT_OUT_RD_CUM_OUTS       0x5
+#define C2C_EVENT_OUT_RD_REQ            0x6
+#define C2C_EVENT_OUT_WR_CUM_OUTS       0x7
+#define C2C_EVENT_OUT_WR_REQ            0x8
+
+#define C2C_NUM_EVENTS           0x9
+#define C2C_MASK_EVENT           0xFF
+#define C2C_MAX_ACTIVE_EVENTS    32
+
+#define C2C_ACTIVE_CPU_MASK        0x0
+#define C2C_ASSOCIATED_CPU_MASK    0x1
+
+/*
+ * Maximum poll count for reading counter value using high-low-high sequence.
+ */
+#define HILOHI_MAX_POLL    1000
+
+static unsigned long nv_c2c_pmu_cpuhp_state;
+
+/* PMU descriptor. */
+
+/* C2C type information. */
+struct nv_c2c_pmu_data {
+	unsigned int c2c_type;
+	unsigned int nr_inst;
+	const char *name_fmt;
+};
+
+static const struct nv_c2c_pmu_data nv_c2c_pmu_data[] = {
+	[C2C_TYPE_NVLINK] = {
+		.c2c_type = C2C_TYPE_NVLINK,
+		.nr_inst = C2C_NR_INST_NVLINK,
+		.name_fmt = "nvidia_nvlink_c2c_pmu_%u",
+	},
+	[C2C_TYPE_NVCLINK] = {
+		.c2c_type = C2C_TYPE_NVCLINK,
+		.nr_inst = C2C_NR_INST_NVCLINK,
+		.name_fmt = "nvidia_nvclink_pmu_%u",
+	},
+	[C2C_TYPE_NVDLINK] = {
+		.c2c_type = C2C_TYPE_NVDLINK,
+		.nr_inst = C2C_NR_INST_NVDLINK,
+		.name_fmt = "nvidia_nvdlink_pmu_%u",
+	},
+};
+
+/* Tracks the events assigned to the PMU for a given logical index. */
+struct nv_c2c_pmu_hw_events {
+	/* The events that are active. */
+	struct perf_event *events[C2C_MAX_ACTIVE_EVENTS];
+
+	/*
+	 * Each bit indicates a logical counter is being used (or not) for an
+	 * event.
+	 */
+	DECLARE_BITMAP(used_ctrs, C2C_MAX_ACTIVE_EVENTS);
+};
+
+struct nv_c2c_pmu {
+	struct pmu pmu;
+	struct device *dev;
+	struct acpi_device *acpi_dev;
+
+	const char *name;
+	const char *identifier;
+
+	const struct nv_c2c_pmu_data *data;
+	unsigned int peer_type;
+	unsigned int socket;
+	unsigned int nr_peer;
+	unsigned long peer_insts[C2C_NR_PEER_MAX][BITS_TO_LONGS(C2C_NR_INST_MAX)];
+	u32 filter_default;
+
+	struct nv_c2c_pmu_hw_events hw_events;
+
+	cpumask_t associated_cpus;
+	cpumask_t active_cpu;
+
+	struct hlist_node cpuhp_node;
+
+	const struct attribute_group **attr_groups;
+
+	void __iomem *base_broadcast;
+	void __iomem *base[C2C_NR_INST_MAX];
+};
+
+#define to_c2c_pmu(p) (container_of(p, struct nv_c2c_pmu, pmu))
+
+/* Get event type from perf_event. */
+static inline u32 get_event_type(struct perf_event *event)
+{
+	return (event->attr.config) & C2C_MASK_EVENT;
+}
+
+static inline u32 get_filter_mask(struct perf_event *event)
+{
+	u32 filter;
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(event->pmu);
+
+	filter = ((u32)event->attr.config1) & c2c_pmu->filter_default;
+	if (filter == 0)
+		filter = c2c_pmu->filter_default;
+
+	return filter;
+}
+
+/* PMU operations. */
+
+static int nv_c2c_pmu_get_event_idx(struct nv_c2c_pmu_hw_events *hw_events,
+				    struct perf_event *event)
+{
+	u32 idx;
+
+	idx = find_first_zero_bit(hw_events->used_ctrs, C2C_MAX_ACTIVE_EVENTS);
+	if (idx >= C2C_MAX_ACTIVE_EVENTS)
+		return -EAGAIN;
+
+	set_bit(idx, hw_events->used_ctrs);
+
+	return idx;
+}
+
+static bool
+nv_c2c_pmu_validate_event(struct pmu *pmu,
+			  struct nv_c2c_pmu_hw_events *hw_events,
+			  struct perf_event *event)
+{
+	if (is_software_event(event))
+		return true;
+
+	/* Reject groups spanning multiple HW PMUs. */
+	if (event->pmu != pmu)
+		return false;
+
+	return nv_c2c_pmu_get_event_idx(hw_events, event) >= 0;
+}
+
+/*
+ * Make sure the group of events can be scheduled at once
+ * on the PMU.
+ */
+static bool nv_c2c_pmu_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct nv_c2c_pmu_hw_events fake_hw_events;
+
+	if (event->group_leader == event)
+		return true;
+
+	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
+
+	if (!nv_c2c_pmu_validate_event(event->pmu, &fake_hw_events, leader))
+		return false;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!nv_c2c_pmu_validate_event(event->pmu, &fake_hw_events,
+					       sibling))
+			return false;
+	}
+
+	return nv_c2c_pmu_validate_event(event->pmu, &fake_hw_events, event);
+}
+
+static int nv_c2c_pmu_event_init(struct perf_event *event)
+{
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 event_type = get_event_type(event);
+
+	if (event->attr.type != event->pmu->type ||
+	    event_type >= C2C_NUM_EVENTS)
+		return -ENOENT;
+
+	/*
+	 * Following other "uncore" PMUs, we do not support sampling mode or
+	 * attach to a task (per-process mode).
+	 */
+	if (is_sampling_event(event)) {
+		dev_dbg(c2c_pmu->pmu.dev, "Can't support sampling events\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
+		dev_dbg(c2c_pmu->pmu.dev, "Can't support per-task counters\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Make sure the CPU assignment is on one of the CPUs associated with
+	 * this PMU.
+	 */
+	if (!cpumask_test_cpu(event->cpu, &c2c_pmu->associated_cpus)) {
+		dev_dbg(c2c_pmu->pmu.dev,
+			"Requested cpu is not associated with the PMU\n");
+		return -EINVAL;
+	}
+
+	/* Enforce the current active CPU to handle the events in this PMU. */
+	event->cpu = cpumask_first(&c2c_pmu->active_cpu);
+	if (event->cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!nv_c2c_pmu_validate_group(event))
+		return -EINVAL;
+
+	hwc->idx = -1;
+	hwc->config = event_type;
+
+	return 0;
+}
+
+/*
+ * Read 64-bit register as a pair of 32-bit registers using hi-lo-hi sequence.
+ */
+static u64 read_reg64_hilohi(const void __iomem *addr, u32 max_poll_count)
+{
+	u32 val_lo, val_hi;
+	u64 val;
+
+	/* Use high-low-high sequence to avoid tearing */
+	do {
+		if (max_poll_count-- == 0) {
+			pr_err("NV C2C PMU: timeout hi-low-high sequence\n");
+			return 0;
+		}
+
+		val_hi = readl(addr + 4);
+		val_lo = readl(addr);
+	} while (val_hi != readl(addr + 4));
+
+	val = (((u64)val_hi << 32) | val_lo);
+
+	return val;
+}
+
+static void nv_c2c_pmu_check_status(struct nv_c2c_pmu *c2c_pmu, u32 instance)
+{
+	u32 in_status, out_status;
+
+	in_status = readl(c2c_pmu->base[instance] + C2C_IN_STATUS);
+	out_status = readl(c2c_pmu->base[instance] + C2C_OUT_STATUS);
+
+	if (in_status || out_status)
+		dev_warn(c2c_pmu->dev,
+			"C2C PMU overflow in: 0x%x, out: 0x%x\n",
+			in_status, out_status);
+}
+
+static u32 nv_c2c_ctr_offset[C2C_NUM_EVENTS] = {
+	[C2C_EVENT_CYCLES] = C2C_CYCLE_CNTR,
+	[C2C_EVENT_IN_RD_CUM_OUTS] = C2C_IN_RD_CUM_OUTS_CNTR,
+	[C2C_EVENT_IN_RD_REQ] = C2C_IN_RD_REQ_CNTR,
+	[C2C_EVENT_IN_WR_CUM_OUTS] = C2C_IN_WR_CUM_OUTS_CNTR,
+	[C2C_EVENT_IN_WR_REQ] = C2C_IN_WR_REQ_CNTR,
+	[C2C_EVENT_OUT_RD_CUM_OUTS] = C2C_OUT_RD_CUM_OUTS_CNTR,
+	[C2C_EVENT_OUT_RD_REQ] = C2C_OUT_RD_REQ_CNTR,
+	[C2C_EVENT_OUT_WR_CUM_OUTS] = C2C_OUT_WR_CUM_OUTS_CNTR,
+	[C2C_EVENT_OUT_WR_REQ] = C2C_OUT_WR_REQ_CNTR,
+};
+
+static u64 nv_c2c_pmu_read_counter(struct perf_event *event)
+{
+	u32 ctr_id, ctr_offset, filter_mask, filter_idx, inst_idx;
+	unsigned long *inst_mask;
+	DECLARE_BITMAP(filter_bitmap, C2C_NR_PEER_MAX);
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(event->pmu);
+	u64 val = 0;
+
+	filter_mask = get_filter_mask(event);
+	bitmap_from_arr32(filter_bitmap, &filter_mask, c2c_pmu->nr_peer);
+
+	ctr_id = event->hw.config;
+	ctr_offset = nv_c2c_ctr_offset[ctr_id];
+
+	for_each_set_bit(filter_idx, filter_bitmap, c2c_pmu->nr_peer) {
+		inst_mask = c2c_pmu->peer_insts[filter_idx];
+		for_each_set_bit(inst_idx, inst_mask, c2c_pmu->data->nr_inst) {
+			nv_c2c_pmu_check_status(c2c_pmu, inst_idx);
+
+			/*
+			 * Each instance share same clock and the driver always
+			 * enables all instances. So we can use the counts from
+			 * one instance for cycle counter.
+			 */
+			if (ctr_id == C2C_EVENT_CYCLES)
+				return read_reg64_hilohi(
+					c2c_pmu->base[inst_idx] + ctr_offset,
+					HILOHI_MAX_POLL);
+
+			/*
+			 * For other events, sum up the counts from all instances.
+			 */
+			val += read_reg64_hilohi(
+				c2c_pmu->base[inst_idx] + ctr_offset,
+				HILOHI_MAX_POLL);
+		}
+	}
+
+	return val;
+}
+
+static void nv_c2c_pmu_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, now;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		now = nv_c2c_pmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	local64_add(now - prev, &event->count);
+}
+
+static void nv_c2c_pmu_start(struct perf_event *event, int pmu_flags)
+{
+	event->hw.state = 0;
+}
+
+static void nv_c2c_pmu_stop(struct perf_event *event, int pmu_flags)
+{
+	event->hw.state |= PERF_HES_STOPPED;
+}
+
+static int nv_c2c_pmu_add(struct perf_event *event, int flags)
+{
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(event->pmu);
+	struct nv_c2c_pmu_hw_events *hw_events = &c2c_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
+					   &c2c_pmu->associated_cpus)))
+		return -ENOENT;
+
+	idx = nv_c2c_pmu_get_event_idx(hw_events, event);
+	if (idx < 0)
+		return idx;
+
+	hw_events->events[idx] = event;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		nv_c2c_pmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void nv_c2c_pmu_del(struct perf_event *event, int flags)
+{
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(event->pmu);
+	struct nv_c2c_pmu_hw_events *hw_events = &c2c_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	nv_c2c_pmu_stop(event, PERF_EF_UPDATE);
+
+	hw_events->events[idx] = NULL;
+
+	clear_bit(idx, hw_events->used_ctrs);
+
+	perf_event_update_userpage(event);
+}
+
+static void nv_c2c_pmu_read(struct perf_event *event)
+{
+	nv_c2c_pmu_event_update(event);
+}
+
+static void nv_c2c_pmu_enable(struct pmu *pmu)
+{
+	void __iomem *bcast;
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(pmu);
+
+	/* Check if any filter is enabled. */
+	if (bitmap_empty(c2c_pmu->hw_events.used_ctrs, C2C_MAX_ACTIVE_EVENTS))
+		return;
+
+	/* Enable all the counters. */
+	bcast = c2c_pmu->base_broadcast;
+	writel(0x1UL, bcast + C2C_CTRL);
+}
+
+static void nv_c2c_pmu_disable(struct pmu *pmu)
+{
+	unsigned int idx;
+	void __iomem *bcast;
+	struct perf_event *event;
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(pmu);
+
+	/* Disable all the counters. */
+	bcast = c2c_pmu->base_broadcast;
+	writel(0x0UL, bcast + C2C_CTRL);
+
+	/*
+	 * The counters will start from 0 again on restart.
+	 * Update the events immediately to avoid losing the counts.
+	 */
+	for_each_set_bit(idx, c2c_pmu->hw_events.used_ctrs,
+			 C2C_MAX_ACTIVE_EVENTS) {
+		event = c2c_pmu->hw_events.events[idx];
+
+		if (!event)
+			continue;
+
+		nv_c2c_pmu_event_update(event);
+
+		local64_set(&event->hw.prev_count, 0ULL);
+	}
+}
+
+/* PMU identifier attribute. */
+
+static ssize_t nv_c2c_pmu_identifier_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *page)
+{
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(page, "%s\n", c2c_pmu->identifier);
+}
+
+static struct device_attribute nv_c2c_pmu_identifier_attr =
+	__ATTR(identifier, 0444, nv_c2c_pmu_identifier_show, NULL);
+
+static struct attribute *nv_c2c_pmu_identifier_attrs[] = {
+	&nv_c2c_pmu_identifier_attr.attr,
+	NULL,
+};
+
+static struct attribute_group nv_c2c_pmu_identifier_attr_group = {
+	.attrs = nv_c2c_pmu_identifier_attrs,
+};
+
+/* Peer attribute. */
+
+static ssize_t nv_c2c_pmu_peer_show(struct device *dev,
+	struct device_attribute *attr,
+	char *page)
+{
+	const char *peer_type[C2C_PEER_TYPE_COUNT] = {
+		[C2C_PEER_TYPE_CPU] = "cpu",
+		[C2C_PEER_TYPE_GPU] = "gpu",
+		[C2C_PEER_TYPE_CXLMEM] = "cxlmem",
+	};
+
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(dev_get_drvdata(dev));
+	return sysfs_emit(page, "nr_%s=%u\n", peer_type[c2c_pmu->peer_type],
+		c2c_pmu->nr_peer);
+}
+
+static struct device_attribute nv_c2c_pmu_peer_attr =
+	__ATTR(peer, 0444, nv_c2c_pmu_peer_show, NULL);
+
+static struct attribute *nv_c2c_pmu_peer_attrs[] = {
+	&nv_c2c_pmu_peer_attr.attr,
+	NULL,
+};
+
+static struct attribute_group nv_c2c_pmu_peer_attr_group = {
+	.attrs = nv_c2c_pmu_peer_attrs,
+};
+
+/* Format attributes. */
+
+#define NV_C2C_PMU_EXT_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]){				\
+		{							\
+			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.var = (void *)_config				\
+		}							\
+	})[0].attr.attr)
+
+#define NV_C2C_PMU_FORMAT_ATTR(_name, _config) \
+	NV_C2C_PMU_EXT_ATTR(_name, device_show_string, _config)
+
+#define NV_C2C_PMU_FORMAT_EVENT_ATTR \
+	NV_C2C_PMU_FORMAT_ATTR(event, "config:0-3")
+
+static struct attribute *nv_c2c_pmu_gpu_formats[] = {
+	NV_C2C_PMU_FORMAT_EVENT_ATTR,
+	NV_C2C_PMU_FORMAT_ATTR(gpu_mask, "config1:0-1"),
+	NULL,
+};
+
+static const struct attribute_group nv_c2c_pmu_gpu_format_group = {
+	.name = "format",
+	.attrs = nv_c2c_pmu_gpu_formats,
+};
+
+static struct attribute *nv_c2c_pmu_formats[] = {
+	NV_C2C_PMU_FORMAT_EVENT_ATTR,
+	NULL,
+};
+
+static const struct attribute_group nv_c2c_pmu_format_group = {
+	.name = "format",
+	.attrs = nv_c2c_pmu_formats,
+};
+
+/* Event attributes. */
+
+static ssize_t nv_c2c_pmu_sysfs_event_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, typeof(*pmu_attr), attr);
+	return sysfs_emit(buf, "event=0x%llx\n", pmu_attr->id);
+}
+
+#define NV_C2C_PMU_EVENT_ATTR(_name, _config)	\
+	PMU_EVENT_ATTR_ID(_name, nv_c2c_pmu_sysfs_event_show, _config)
+
+static struct attribute *nv_c2c_pmu_gpu_events[] = {
+	NV_C2C_PMU_EVENT_ATTR(cycles, C2C_EVENT_CYCLES),
+	NV_C2C_PMU_EVENT_ATTR(in_rd_cum_outs, C2C_EVENT_IN_RD_CUM_OUTS),
+	NV_C2C_PMU_EVENT_ATTR(in_rd_req, C2C_EVENT_IN_RD_REQ),
+	NV_C2C_PMU_EVENT_ATTR(in_wr_cum_outs, C2C_EVENT_IN_WR_CUM_OUTS),
+	NV_C2C_PMU_EVENT_ATTR(in_wr_req, C2C_EVENT_IN_WR_REQ),
+	NV_C2C_PMU_EVENT_ATTR(out_rd_cum_outs, C2C_EVENT_OUT_RD_CUM_OUTS),
+	NV_C2C_PMU_EVENT_ATTR(out_rd_req, C2C_EVENT_OUT_RD_REQ),
+	NV_C2C_PMU_EVENT_ATTR(out_wr_cum_outs, C2C_EVENT_OUT_WR_CUM_OUTS),
+	NV_C2C_PMU_EVENT_ATTR(out_wr_req, C2C_EVENT_OUT_WR_REQ),
+	NULL
+};
+
+static const struct attribute_group nv_c2c_pmu_gpu_events_group = {
+	.name = "events",
+	.attrs = nv_c2c_pmu_gpu_events,
+};
+
+static struct attribute *nv_c2c_pmu_cpu_events[] = {
+	NV_C2C_PMU_EVENT_ATTR(cycles, C2C_EVENT_CYCLES),
+	NV_C2C_PMU_EVENT_ATTR(in_rd_cum_outs, C2C_EVENT_IN_RD_CUM_OUTS),
+	NV_C2C_PMU_EVENT_ATTR(in_rd_req, C2C_EVENT_IN_RD_REQ),
+	NV_C2C_PMU_EVENT_ATTR(out_rd_cum_outs, C2C_EVENT_OUT_RD_CUM_OUTS),
+	NV_C2C_PMU_EVENT_ATTR(out_rd_req, C2C_EVENT_OUT_RD_REQ),
+	NULL
+};
+
+static const struct attribute_group nv_c2c_pmu_cpu_events_group = {
+	.name = "events",
+	.attrs = nv_c2c_pmu_cpu_events,
+};
+
+static struct attribute *nv_c2c_pmu_cxlmem_events[] = {
+	NV_C2C_PMU_EVENT_ATTR(cycles, C2C_EVENT_CYCLES),
+	NV_C2C_PMU_EVENT_ATTR(in_rd_cum_outs, C2C_EVENT_IN_RD_CUM_OUTS),
+	NV_C2C_PMU_EVENT_ATTR(in_rd_req, C2C_EVENT_IN_RD_REQ),
+	NULL
+};
+
+static const struct attribute_group nv_c2c_pmu_cxlmem_events_group = {
+	.name = "events",
+	.attrs = nv_c2c_pmu_cxlmem_events,
+};
+
+/* Cpumask attributes. */
+
+static ssize_t nv_c2c_pmu_cpumask_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct nv_c2c_pmu *c2c_pmu = to_c2c_pmu(pmu);
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	unsigned long mask_id = (unsigned long)eattr->var;
+	const cpumask_t *cpumask;
+
+	switch (mask_id) {
+	case C2C_ACTIVE_CPU_MASK:
+		cpumask = &c2c_pmu->active_cpu;
+		break;
+	case C2C_ASSOCIATED_CPU_MASK:
+		cpumask = &c2c_pmu->associated_cpus;
+		break;
+	default:
+		return 0;
+	}
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
+}
+
+#define NV_C2C_PMU_CPUMASK_ATTR(_name, _config)			\
+	NV_C2C_PMU_EXT_ATTR(_name, nv_c2c_pmu_cpumask_show,	\
+				(unsigned long)_config)
+
+static struct attribute *nv_c2c_pmu_cpumask_attrs[] = {
+	NV_C2C_PMU_CPUMASK_ATTR(cpumask, C2C_ACTIVE_CPU_MASK),
+	NV_C2C_PMU_CPUMASK_ATTR(associated_cpus, C2C_ASSOCIATED_CPU_MASK),
+	NULL,
+};
+
+static const struct attribute_group nv_c2c_pmu_cpumask_attr_group = {
+	.attrs = nv_c2c_pmu_cpumask_attrs,
+};
+
+/* Attribute groups for C2C PMU connecting SoC and GPU */
+static const struct attribute_group *nv_c2c_pmu_gpu_attr_groups[] = {
+	&nv_c2c_pmu_gpu_format_group,
+	&nv_c2c_pmu_gpu_events_group,
+	&nv_c2c_pmu_cpumask_attr_group,
+	&nv_c2c_pmu_identifier_attr_group,
+	&nv_c2c_pmu_peer_attr_group,
+	NULL
+};
+
+/* Attribute groups for C2C PMU connecting multiple SoCs */
+static const struct attribute_group *nv_c2c_pmu_cpu_attr_groups[] = {
+	&nv_c2c_pmu_format_group,
+	&nv_c2c_pmu_cpu_events_group,
+	&nv_c2c_pmu_cpumask_attr_group,
+	&nv_c2c_pmu_identifier_attr_group,
+	&nv_c2c_pmu_peer_attr_group,
+	NULL
+};
+
+/* Attribute groups for C2C PMU connecting SoC and CXLMEM */
+static const struct attribute_group *nv_c2c_pmu_cxlmem_attr_groups[] = {
+	&nv_c2c_pmu_format_group,
+	&nv_c2c_pmu_cxlmem_events_group,
+	&nv_c2c_pmu_cpumask_attr_group,
+	&nv_c2c_pmu_identifier_attr_group,
+	&nv_c2c_pmu_peer_attr_group,
+	NULL
+};
+
+static int nv_c2c_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct nv_c2c_pmu *c2c_pmu =
+		hlist_entry_safe(node, struct nv_c2c_pmu, cpuhp_node);
+
+	if (!cpumask_test_cpu(cpu, &c2c_pmu->associated_cpus))
+		return 0;
+
+	/* If the PMU is already managed, there is nothing to do */
+	if (!cpumask_empty(&c2c_pmu->active_cpu))
+		return 0;
+
+	/* Use this CPU for event counting */
+	cpumask_set_cpu(cpu, &c2c_pmu->active_cpu);
+
+	return 0;
+}
+
+static int nv_c2c_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
+{
+	unsigned int dst;
+
+	struct nv_c2c_pmu *c2c_pmu =
+		hlist_entry_safe(node, struct nv_c2c_pmu, cpuhp_node);
+
+	/* Nothing to do if this CPU doesn't own the PMU */
+	if (!cpumask_test_and_clear_cpu(cpu, &c2c_pmu->active_cpu))
+		return 0;
+
+	/* Choose a new CPU to migrate ownership of the PMU to */
+	dst = cpumask_any_and_but(&c2c_pmu->associated_cpus,
+				  cpu_online_mask, cpu);
+	if (dst >= nr_cpu_ids)
+		return 0;
+
+	/* Use this CPU for event counting */
+	perf_pmu_migrate_context(&c2c_pmu->pmu, cpu, dst);
+	cpumask_set_cpu(dst, &c2c_pmu->active_cpu);
+
+	return 0;
+}
+
+static int nv_c2c_pmu_get_cpus(struct nv_c2c_pmu *c2c_pmu)
+{
+	int socket = c2c_pmu->socket, cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_to_node(cpu) == socket)
+			cpumask_set_cpu(cpu, &c2c_pmu->associated_cpus);
+	}
+
+	if (cpumask_empty(&c2c_pmu->associated_cpus)) {
+		dev_dbg(c2c_pmu->dev,
+			"No cpu associated with C2C PMU socket-%u\n", socket);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int nv_c2c_pmu_init_socket(struct nv_c2c_pmu *c2c_pmu)
+{
+	const char *uid_str;
+	int ret, socket;
+
+	uid_str = acpi_device_uid(c2c_pmu->acpi_dev);
+	if (!uid_str) {
+		dev_err(c2c_pmu->dev, "No ACPI device UID\n");
+		return -ENODEV;
+	}
+
+	ret = kstrtou32(uid_str, 0, &socket);
+	if (ret) {
+		dev_err(c2c_pmu->dev, "Failed to parse ACPI device UID\n");
+		return ret;
+	}
+
+	c2c_pmu->socket = socket;
+	return 0;
+}
+
+static int nv_c2c_pmu_init_id(struct nv_c2c_pmu *c2c_pmu)
+{
+	char *name;
+
+	name = devm_kasprintf(c2c_pmu->dev, GFP_KERNEL, c2c_pmu->data->name_fmt,
+				c2c_pmu->socket);
+	if (!name)
+		return -ENOMEM;
+
+	c2c_pmu->name = name;
+
+	c2c_pmu->identifier = acpi_device_hid(c2c_pmu->acpi_dev);
+
+	return 0;
+}
+
+static int nv_c2c_pmu_init_filter(struct nv_c2c_pmu *c2c_pmu)
+{
+	u32 cpu_en = 0;
+	struct device *dev = c2c_pmu->dev;
+	const struct nv_c2c_pmu_data *data = c2c_pmu->data;
+
+	if (data->c2c_type == C2C_TYPE_NVDLINK) {
+		c2c_pmu->peer_type = C2C_PEER_TYPE_CXLMEM;
+
+		c2c_pmu->peer_insts[0][0] = (1UL << data->nr_inst) - 1;
+
+		c2c_pmu->nr_peer = C2C_NR_PEER_CXLMEM;
+		c2c_pmu->filter_default = (1 << c2c_pmu->nr_peer) - 1;
+
+		c2c_pmu->attr_groups = nv_c2c_pmu_cxlmem_attr_groups;
+
+		return 0;
+	}
+
+	if (device_property_read_u32(dev, "cpu_en_mask", &cpu_en))
+		dev_dbg(dev, "no cpu_en_mask property\n");
+
+	if (cpu_en) {
+		c2c_pmu->peer_type = C2C_PEER_TYPE_CPU;
+
+		/* Fill peer_insts bitmap with instances connected to peer CPU. */
+		bitmap_from_arr32(c2c_pmu->peer_insts[0], &cpu_en, data->nr_inst);
+
+		c2c_pmu->nr_peer = 1;
+		c2c_pmu->attr_groups = nv_c2c_pmu_cpu_attr_groups;
+	} else {
+		u32 i;
+		const char *props[C2C_NR_PEER_MAX] = {
+			"gpu0_en_mask", "gpu1_en_mask"
+		};
+
+		for (i = 0; i < C2C_NR_PEER_MAX; i++) {
+			u32 gpu_en = 0;
+
+			if (device_property_read_u32(dev, props[i], &gpu_en))
+				dev_dbg(dev, "no %s property\n", props[i]);
+
+			if (gpu_en) {
+				/* Fill peer_insts bitmap with instances connected to peer GPU. */
+				bitmap_from_arr32(c2c_pmu->peer_insts[i], &gpu_en,
+						data->nr_inst);
+
+				c2c_pmu->nr_peer++;
+			}
+		}
+
+		if (c2c_pmu->nr_peer == 0) {
+			dev_err(dev, "No GPU is enabled\n");
+			return -EINVAL;
+		}
+
+		c2c_pmu->peer_type = C2C_PEER_TYPE_GPU;
+		c2c_pmu->attr_groups = nv_c2c_pmu_gpu_attr_groups;
+	}
+
+	c2c_pmu->filter_default = (1 << c2c_pmu->nr_peer) - 1;
+
+	return 0;
+}
+
+static void *nv_c2c_pmu_init_pmu(struct platform_device *pdev)
+{
+	int ret;
+	struct nv_c2c_pmu *c2c_pmu;
+	struct acpi_device *acpi_dev;
+	struct device *dev = &pdev->dev;
+
+	acpi_dev = ACPI_COMPANION(dev);
+	if (!acpi_dev)
+		return ERR_PTR(-ENODEV);
+
+	c2c_pmu = devm_kzalloc(dev, sizeof(*c2c_pmu), GFP_KERNEL);
+	if (!c2c_pmu)
+		return ERR_PTR(-ENOMEM);
+
+	c2c_pmu->dev = dev;
+	c2c_pmu->acpi_dev = acpi_dev;
+	c2c_pmu->data = (const struct nv_c2c_pmu_data *)device_get_match_data(dev);
+	if (!c2c_pmu->data)
+		return ERR_PTR(-EINVAL);
+
+	platform_set_drvdata(pdev, c2c_pmu);
+
+	ret = nv_c2c_pmu_init_socket(c2c_pmu);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = nv_c2c_pmu_init_id(c2c_pmu);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = nv_c2c_pmu_init_filter(c2c_pmu);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return c2c_pmu;
+}
+
+static int nv_c2c_pmu_init_mmio(struct nv_c2c_pmu *c2c_pmu)
+{
+	int i;
+	struct device *dev = c2c_pmu->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct nv_c2c_pmu_data *data = c2c_pmu->data;
+
+	/* Map the address of all the instances. */
+	for (i = 0; i < data->nr_inst; i++) {
+		c2c_pmu->base[i] = devm_platform_ioremap_resource(pdev, i);
+		if (IS_ERR(c2c_pmu->base[i])) {
+			dev_err(dev, "Failed map address for instance %d\n", i);
+			return PTR_ERR(c2c_pmu->base[i]);
+		}
+	}
+
+	/* Map broadcast address. */
+	c2c_pmu->base_broadcast = devm_platform_ioremap_resource(pdev,
+								 data->nr_inst);
+	if (IS_ERR(c2c_pmu->base_broadcast)) {
+		dev_err(dev, "Failed map broadcast address\n");
+		return PTR_ERR(c2c_pmu->base_broadcast);
+	}
+
+	return 0;
+}
+
+static int nv_c2c_pmu_register_pmu(struct nv_c2c_pmu *c2c_pmu)
+{
+	int ret;
+
+	ret = cpuhp_state_add_instance(nv_c2c_pmu_cpuhp_state,
+				       &c2c_pmu->cpuhp_node);
+	if (ret) {
+		dev_err(c2c_pmu->dev, "Error %d registering hotplug\n", ret);
+		return ret;
+	}
+
+	c2c_pmu->pmu = (struct pmu) {
+		.parent		= c2c_pmu->dev,
+		.task_ctx_nr	= perf_invalid_context,
+		.pmu_enable	= nv_c2c_pmu_enable,
+		.pmu_disable	= nv_c2c_pmu_disable,
+		.event_init	= nv_c2c_pmu_event_init,
+		.add		= nv_c2c_pmu_add,
+		.del		= nv_c2c_pmu_del,
+		.start		= nv_c2c_pmu_start,
+		.stop		= nv_c2c_pmu_stop,
+		.read		= nv_c2c_pmu_read,
+		.attr_groups	= c2c_pmu->attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+					PERF_PMU_CAP_NO_INTERRUPT,
+	};
+
+	ret = perf_pmu_register(&c2c_pmu->pmu, c2c_pmu->name, -1);
+	if (ret) {
+		dev_err(c2c_pmu->dev, "Failed to register C2C PMU: %d\n", ret);
+		cpuhp_state_remove_instance(nv_c2c_pmu_cpuhp_state,
+					  &c2c_pmu->cpuhp_node);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int nv_c2c_pmu_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct nv_c2c_pmu *c2c_pmu;
+
+	c2c_pmu = nv_c2c_pmu_init_pmu(pdev);
+	if (IS_ERR(c2c_pmu))
+		return PTR_ERR(c2c_pmu);
+
+	ret = nv_c2c_pmu_init_mmio(c2c_pmu);
+	if (ret)
+		return ret;
+
+	ret = nv_c2c_pmu_get_cpus(c2c_pmu);
+	if (ret)
+		return ret;
+
+	ret = nv_c2c_pmu_register_pmu(c2c_pmu);
+	if (ret)
+		return ret;
+
+	dev_dbg(c2c_pmu->dev, "Registered %s PMU\n", c2c_pmu->name);
+
+	return 0;
+}
+
+static void nv_c2c_pmu_device_remove(struct platform_device *pdev)
+{
+	struct nv_c2c_pmu *c2c_pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&c2c_pmu->pmu);
+	cpuhp_state_remove_instance(nv_c2c_pmu_cpuhp_state, &c2c_pmu->cpuhp_node);
+}
+
+static const struct acpi_device_id nv_c2c_pmu_acpi_match[] = {
+	{ "NVDA2023", (kernel_ulong_t)&nv_c2c_pmu_data[C2C_TYPE_NVLINK] },
+	{ "NVDA2022", (kernel_ulong_t)&nv_c2c_pmu_data[C2C_TYPE_NVCLINK] },
+	{ "NVDA2020", (kernel_ulong_t)&nv_c2c_pmu_data[C2C_TYPE_NVDLINK] },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, nv_c2c_pmu_acpi_match);
+
+static struct platform_driver nv_c2c_pmu_driver = {
+	.driver = {
+		.name = "nvidia-t410-c2c-pmu",
+		.acpi_match_table = nv_c2c_pmu_acpi_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = nv_c2c_pmu_probe,
+	.remove = nv_c2c_pmu_device_remove,
+};
+
+static int __init nv_c2c_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/nvidia/c2c:online",
+				      nv_c2c_pmu_online_cpu,
+				      nv_c2c_pmu_cpu_teardown);
+	if (ret < 0)
+		return ret;
+
+	nv_c2c_pmu_cpuhp_state = ret;
+	return platform_driver_register(&nv_c2c_pmu_driver);
+}
+
+static void __exit nv_c2c_pmu_exit(void)
+{
+	platform_driver_unregister(&nv_c2c_pmu_driver);
+	cpuhp_remove_multi_state(nv_c2c_pmu_cpuhp_state);
+}
+
+module_init(nv_c2c_pmu_init);
+module_exit(nv_c2c_pmu_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NVIDIA Tegra410 C2C PMU driver");
+MODULE_AUTHOR("Besar Wicaksono <bwicaksono@nvidia.com>");
-- 
2.43.0

