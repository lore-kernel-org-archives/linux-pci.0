Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104921CC58;
	Tue, 24 Mar 2026 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315852; cv=fail; b=dzSqPI5nOgDUeKSxfbyY0whFsDNEjsCmC1/Qk9RLpezNdrSlRDXWg/M6SNySaFMQODJ+jdvBswnagUwUa9N7jq6SPVuplxi9nq0r9ubVqfP6kWA7EqdL1J7kgIP9CRqYNUmvxVNiF0RLZoATkeeKI86aElhDlaHd1VWH1FUe+CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315852; c=relaxed/simple;
	bh=gul9uVclujkVyo86GcG+TAaA17VqcHaPHjlxIBy5YFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMdx08qzfBlwjGh1W4fO8E4d9EWi1LiFEaWhfFFfpn8S6tBw/YPZwRrGrsjgoKbyij1n7Zlvx5yKFS22DaMvhkHggDDyE20LraDtuCaEEML1OQ46K+Hduy2RctVa9Il6fy55AvK41NSDzWdR0XDTHa17Z6DRRR4ogsKl3tkN1Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QrACZ9Z6; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QrACZ9Z6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGJLrftOB1neZUmFHuW7iQ8KoE8Z+995bGkXIqf6zM/8aloMKoahH0k0Px/qgZQ6YGwsh/c4Q1V0xy7zNeYKb3u6fQLUQW3DPmSSYd4M499lUnQMtmuewMeELJyEfcF0wfyJ7lqNFG4xzuBACubUqjNVJyPL5rrN/rQ0X3hPf86xTddf4r+wTD9Q4nlBhDRGE4NMvQ69CSp2dnDBI/Yp4aQ3FgqsXrvZ4n9l5/Q+wJXDgQ5Tlkt0+2EeE+JmFITmy66XM7F7bTrUnlHgP3rGGdV+FASBGadBoRPDKn1cv4ceel8fk4dtl/w5XkR6l1kCFMEjs4YhDeFIIlZ3MiWVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZOOkppL1ziIdW00NoMwt+w9lNpDFTZASROKYukwCy4=;
 b=NQ+hZlC9P1b/u99St0STXjlWD7U3dZ0T9SY3i+0Guf41WJB0i7wfNk0eN2d8uzGmgV6orWi2nWiwN9nqiuifybLQDLZqL60d9HKbX4uB3iFyMSudT/MfP9arZuWtItkioFRAk/BfpFKUtVB5N+atU4e/7dnT3Gmn1Pkvf1vPL+koeckjHdM2xn1lLzKl1WOvX4sEL4YRyw2KB4kcV1nDAm6ZPuKT5ZBeoZHG3E//VAlsYaTu0Gr9Tl+OeZokbiONGH3iwwJVXzaNIiR8Z2GrXdsXpZvWLRJ2/l3hSfntmsk1+haWMPckKDtdE6P30KQ8cgoqKfY9JtViOasFrt1Aqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZOOkppL1ziIdW00NoMwt+w9lNpDFTZASROKYukwCy4=;
 b=QrACZ9Z6pPOeUwqElFOfUMOvfYEZCkgZlL++odUmEu2JJfyDtGW8N41bLpoGaoO3KNXyGSrLy7hieXxVw8co6ErrAiTdOBbcjLsRa4mCIO+r3NCKR9tUgmUS1y2Gm7Dzfzt0S6S277tUNDSPMxUp+738XP832SC2KBd/4BSbaEOqaFFOdBaawsYVc1A5YuJ3+N+oEaJCYjdQ1a/zFtmEU3AIgmQQJxZlzH2We6B2ZO3jyd2Ug8xWNkk52x2DxtXQ8R26ZQLV8taC4ql4TmOLpNQeJxTyOtQQoi/z9FqQli3lr+wGSNOxYC/TQLqXSWe5u+gWCr80/PnTGrcaeeBsiA==
Received: from BL1PR13CA0441.namprd13.prod.outlook.com (2603:10b6:208:2c3::26)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:30:40 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::5) by BL1PR13CA0441.outlook.office365.com
 (2603:10b6:208:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:30:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:30:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:30:18 -0700
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 23 Mar 2026 18:30:17 -0700
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
Subject: [PATCH v3 5/8] perf/arm_cspmu: nvidia: Add Tegra410 PCIE-TGT PMU
Date: Tue, 24 Mar 2026 01:29:49 +0000
Message-ID: <20260324012952.1923296-6-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: d74ae709-4626-409c-3048-08de8944f5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DXk92KBY11dsCIibrmdFE+Jl17P2z85iWD7lSNqqSi/PSI3zTaESUx0VeMvB+2d9oR/09C3BBTwsSYtaDOtaWT2XMW/RcyG4Qd3iD30PdM9JQS+bNR0VbJBej2wAQr7umuFw3q32J0038R7J8YHpAiNGogKz5B4TOQMV+JmG/J7mezT8+SOa0QO8BeUitwTDRnJ5vc178MRQoCZz1QXnBgG2LuZ3j5UkM9IIROFeQBkLw4FaBN0COhd0F1OhmrG0x24d23uj9EAggy0g9dYra+hwGtWpZO6iwMaqqwJlUN35wRk41wuwCBmHezpWdtYHJXKmas/gl8Jvjd+CHC6BLOKrY7JDEfkNmuL2yAFOTG4hRpK795GM+q7lhk7PfwH4DRv9U4838N5hnNQxXj4zDg4ySLpMeg5yDNI9yvtEv4uvktTLQzw2jmGJ907aZFCjKqeZOVy6VQ8qwGxa4bH5Hyp/AqvRnBNRYfX2XKalvtq33UIsku2ge/Q2Hs1jNWsH+FpQONXZ2ROuz7/4OGEsz2JMad53FjgpKBPWb038TgPwLpeGKQ5EmkoJYBleSh1eEXb5rIW2QlstjyQatRHJ4q6+3sqdkzNGokmmk0VIxxc++zGeQsP1rb07G21ysLySMC/6cu2st+l3nFY93FYnS2AtvepT1CYEZoy817dMpWOodJU/F/i4tH0yEYyx8UEYX6kjq8/4WmJrVhmfHgDtq3CqfgB4fD3cquOTLZKHpyXFwDh7W79RWl7MusnyhfmnQdDi8mkjI0kL7qOZypNDIw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3/Fj1ZmCMlPK6PXaurdWybLXzvutnZJgSQtcuUNd517bi255Az6aBbjwlZHE/mmFaX5cOOO/Wzp79X4wdEMEtNS+dsJzWQBv71wtoYukGCt2V7MWz7wKGsmzUsLBIvB5VZAY9WkESjBN53vBffbQBCmaP4uXxbX5cKQYbGG/HCbve31OQIYkKfmetYhh0yFYwwgKTf418vTFeO135J55fIZI6o4DN73Y96SVWHEcWjhT6fBDsTrROeUev4MXOjkSXONbcyC0VPGH2QqI0xRNt5EsLEFYrgZfORHrY5ZsEtKN/vZY/VnZODXNuQtM0EoM2IYjaB+Sf45HOvLSbnhBtGLc+gdtOj0pkgn2L/v3VIFeCgTMAteovmvYO1yeKnK+hpCECICgRIfcznaZmlMgMnTPS28DrW/S2WqnV9s1IgSUwzseo12bWjIXWesgS6NJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:30:40.4729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74ae709-4626-409c-3048-08de8944f5b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

Adds PCIE-TGT PMU support in Tegra410 SOC. This PMU is
instanced in each root complex in the SOC and it captures
traffic originating from any source towards PCIE BAR and CXL
HDM range. The traffic can be filtered based on the
destination root port or target address range.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../admin-guide/perf/nvidia-tegra410-pmu.rst  |  77 +++++
 drivers/perf/arm_cspmu/nvidia_cspmu.c         | 321 ++++++++++++++++++
 2 files changed, 398 insertions(+)

diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
index b8cfbb80be1c..c065764d41fe 100644
--- a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
+++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
@@ -7,6 +7,7 @@ metrics like memory bandwidth, latency, and utilization:
 
 * Unified Coherence Fabric (UCF)
 * PCIE
+* PCIE-TGT
 
 PMU Driver
 ----------
@@ -212,6 +213,11 @@ Example usage:
 
     perf stat -a -e nvidia_pcie_pmu_0_rc_4/event=0x4,src_bdf=0x0180,src_bdf_en=0x1/
 
+.. _NVIDIA_T410_PCIE_PMU_RC_Mapping_Section:
+
+Mapping the RC# to lspci segment number
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 Mapping the RC# to lspci segment number can be non-trivial; hence a new NVIDIA
 Designated Vendor Specific Capability (DVSEC) register is added into the PCIE config space
 for each RP. This DVSEC has vendor id "10de" and DVSEC id of "0x4". The DVSEC register
@@ -267,3 +273,74 @@ Example output::
   000d:40:00.0: Bus=40, Segment=0d, RP=01, RC=04, Socket=01
   000d:c0:00.0: Bus=c0, Segment=0d, RP=02, RC=04, Socket=01
   000e:00:00.0: Bus=00, Segment=0e, RP=00, RC=05, Socket=01
+
+PCIE-TGT PMU
+------------
+
+This PMU is located in the SOC fabric connecting the PCIE root complex (RC) and
+the memory subsystem. It monitors traffic targeting PCIE BAR and CXL HDM ranges.
+There is one PCIE-TGT PMU per PCIE RC in the SoC. Each RC in Tegra410 SoC can
+have up to 16 lanes that can be bifurcated into up to 8 root ports (RP). The PMU
+provides RP filter to count PCIE BAR traffic to each RP and address filter to
+count access to PCIE BAR or CXL HDM ranges. The details of the filters are
+described in the following sections.
+
+Mapping the RC# to lspci segment number is similar to the PCIE PMU. Please see
+:ref:`NVIDIA_T410_PCIE_PMU_RC_Mapping_Section` for more info.
+
+The events and configuration options of this PMU device are available in sysfs,
+see /sys/bus/event_source/devices/nvidia_pcie_tgt_pmu_<socket-id>_rc_<pcie-rc-id>.
+
+The events in this PMU can be used to measure bandwidth and utilization:
+
+  * rd_req: count the number of read requests to PCIE.
+  * wr_req: count the number of write requests to PCIE.
+  * rd_bytes: count the number of bytes transferred by rd_req.
+  * wr_bytes: count the number of bytes transferred by wr_req.
+  * cycles: count the clock cycles of SOC fabric connected to the PCIE interface.
+
+The average bandwidth is calculated as::
+
+   AVG_RD_BANDWIDTH_IN_GBPS = RD_BYTES / ELAPSED_TIME_IN_NS
+   AVG_WR_BANDWIDTH_IN_GBPS = WR_BYTES / ELAPSED_TIME_IN_NS
+
+The average request rate is calculated as::
+
+   AVG_RD_REQUEST_RATE = RD_REQ / CYCLES
+   AVG_WR_REQUEST_RATE = WR_REQ / CYCLES
+
+The PMU events can be filtered based on the destination root port or target
+address range. Filtering based on RP is only available for PCIE BAR traffic.
+Address filter works for both PCIE BAR and CXL HDM ranges. These filters can be
+found in sysfs, see
+/sys/bus/event_source/devices/nvidia_pcie_tgt_pmu_<socket-id>_rc_<pcie-rc-id>/format/.
+
+Destination filter settings:
+
+* dst_rp_mask: bitmask to select the root port(s) to monitor. E.g. "dst_rp_mask=0xFF"
+  corresponds to all root ports (from 0 to 7) in the PCIE RC. Note that this filter is
+  only available for PCIE BAR traffic.
+* dst_addr_base: BAR or CXL HDM filter base address.
+* dst_addr_mask: BAR or CXL HDM filter address mask.
+* dst_addr_en: enable BAR or CXL HDM address range filter. If this is set, the
+  address range specified by "dst_addr_base" and "dst_addr_mask" will be used to filter
+  the PCIE BAR and CXL HDM traffic address. The PMU uses the following comparison
+  to determine if the traffic destination address falls within the filter range::
+
+    (txn's addr & dst_addr_mask) == (dst_addr_base & dst_addr_mask)
+
+  If the comparison succeeds, then the event will be counted.
+
+If the destination filter is not specified, the RP filter will be configured by default
+to count PCIE BAR traffic to all root ports.
+
+Example usage:
+
+* Count event id 0x0 to root port 0 and 1 of PCIE RC-0 on socket 0::
+
+    perf stat -a -e nvidia_pcie_tgt_pmu_0_rc_0/event=0x0,dst_rp_mask=0x3/
+
+* Count event id 0x1 for accesses to PCIE BAR or CXL HDM address range
+  0x10000 to 0x100FF on socket 0's PCIE RC-1::
+
+    perf stat -a -e nvidia_pcie_tgt_pmu_0_rc_1/event=0x1,dst_addr_base=0x10000,dst_addr_mask=0xFFF00,dst_addr_en=0x1/
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 61fde84ea343..bac83e424d6d 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -42,6 +42,24 @@
 #define NV_PCIE_V2_FILTER2_DST       GENMASK_ULL(NV_PCIE_V2_DST_COUNT - 1, 0)
 #define NV_PCIE_V2_FILTER2_DEFAULT   NV_PCIE_V2_FILTER2_DST
 
+#define NV_PCIE_TGT_PORT_COUNT       8ULL
+#define NV_PCIE_TGT_EV_TYPE_CC       0x4
+#define NV_PCIE_TGT_EV_TYPE_COUNT    3ULL
+#define NV_PCIE_TGT_EV_TYPE_MASK     GENMASK_ULL(NV_PCIE_TGT_EV_TYPE_COUNT - 1, 0)
+#define NV_PCIE_TGT_FILTER2_MASK     GENMASK_ULL(NV_PCIE_TGT_PORT_COUNT, 0)
+#define NV_PCIE_TGT_FILTER2_PORT     GENMASK_ULL(NV_PCIE_TGT_PORT_COUNT - 1, 0)
+#define NV_PCIE_TGT_FILTER2_ADDR_EN  BIT(NV_PCIE_TGT_PORT_COUNT)
+#define NV_PCIE_TGT_FILTER2_ADDR     GENMASK_ULL(15, NV_PCIE_TGT_PORT_COUNT)
+#define NV_PCIE_TGT_FILTER2_DEFAULT  NV_PCIE_TGT_FILTER2_PORT
+
+#define NV_PCIE_TGT_ADDR_COUNT       8ULL
+#define NV_PCIE_TGT_ADDR_STRIDE      20
+#define NV_PCIE_TGT_ADDR_CTRL        0xD38
+#define NV_PCIE_TGT_ADDR_BASE_LO     0xD3C
+#define NV_PCIE_TGT_ADDR_BASE_HI     0xD40
+#define NV_PCIE_TGT_ADDR_MASK_LO     0xD44
+#define NV_PCIE_TGT_ADDR_MASK_HI     0xD48
+
 #define NV_GENERIC_FILTER_ID_MASK    GENMASK_ULL(31, 0)
 
 #define NV_PRODID_MASK	(PMIIDR_PRODUCTID | PMIIDR_VARIANT | PMIIDR_REVISION)
@@ -185,6 +203,15 @@ static struct attribute *pcie_v2_pmu_event_attrs[] = {
 	NULL
 };
 
+static struct attribute *pcie_tgt_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(rd_bytes,		0x0),
+	ARM_CSPMU_EVENT_ATTR(wr_bytes,		0x1),
+	ARM_CSPMU_EVENT_ATTR(rd_req,		0x2),
+	ARM_CSPMU_EVENT_ATTR(wr_req,		0x3),
+	ARM_CSPMU_EVENT_ATTR(cycles, NV_PCIE_TGT_EV_TYPE_CC),
+	NULL
+};
+
 static struct attribute *generic_pmu_event_attrs[] = {
 	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
 	NULL,
@@ -238,6 +265,15 @@ static struct attribute *pcie_v2_pmu_format_attrs[] = {
 	NULL
 };
 
+static struct attribute *pcie_tgt_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_ATTR(event, "config:0-2"),
+	ARM_CSPMU_FORMAT_ATTR(dst_rp_mask, "config:3-10"),
+	ARM_CSPMU_FORMAT_ATTR(dst_addr_en, "config:11"),
+	ARM_CSPMU_FORMAT_ATTR(dst_addr_base, "config1:0-63"),
+	ARM_CSPMU_FORMAT_ATTR(dst_addr_mask, "config2:0-63"),
+	NULL
+};
+
 static struct attribute *generic_pmu_format_attrs[] = {
 	ARM_CSPMU_FORMAT_EVENT_ATTR,
 	ARM_CSPMU_FORMAT_FILTER_ATTR,
@@ -477,6 +513,267 @@ static int pcie_v2_pmu_validate_event(struct arm_cspmu *cspmu,
 	return 0;
 }
 
+struct pcie_tgt_addr_filter {
+	u32 refcount;
+	u64 base;
+	u64 mask;
+};
+
+struct pcie_tgt_data {
+	struct pcie_tgt_addr_filter addr_filter[NV_PCIE_TGT_ADDR_COUNT];
+	void __iomem *addr_filter_reg;
+};
+
+#if defined(CONFIG_ACPI) && defined(CONFIG_ARM64)
+static int pcie_tgt_init_data(struct arm_cspmu *cspmu)
+{
+	int ret;
+	struct acpi_device *adev;
+	struct pcie_tgt_data *data;
+	struct list_head resource_list;
+	struct resource_entry *rentry;
+	struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+	struct device *dev = cspmu->dev;
+
+	data = devm_kzalloc(dev, sizeof(struct pcie_tgt_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	adev = arm_cspmu_acpi_dev_get(cspmu);
+	if (!adev) {
+		dev_err(dev, "failed to get associated PCIE-TGT device\n");
+		return -ENODEV;
+	}
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_memory_resources(adev, &resource_list);
+	if (ret < 0) {
+		dev_err(dev, "failed to get PCIE-TGT device memory resources\n");
+		acpi_dev_put(adev);
+		return ret;
+	}
+
+	rentry = list_first_entry_or_null(
+		&resource_list, struct resource_entry, node);
+	if (rentry) {
+		data->addr_filter_reg = devm_ioremap_resource(dev, rentry->res);
+		ret = 0;
+	}
+
+	if (IS_ERR(data->addr_filter_reg)) {
+		dev_err(dev, "failed to get address filter resource\n");
+		ret = PTR_ERR(data->addr_filter_reg);
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+	acpi_dev_put(adev);
+
+	ctx->data = data;
+
+	return ret;
+}
+#else
+static int pcie_tgt_init_data(struct arm_cspmu *cspmu)
+{
+	return -ENODEV;
+}
+#endif
+
+static struct pcie_tgt_data *pcie_tgt_get_data(struct arm_cspmu *cspmu)
+{
+	struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+
+	return ctx->data;
+}
+
+/* Find the first available address filter slot. */
+static int pcie_tgt_find_addr_idx(struct arm_cspmu *cspmu, u64 base, u64 mask,
+	bool is_reset)
+{
+	int i;
+	struct pcie_tgt_data *data = pcie_tgt_get_data(cspmu);
+
+	for (i = 0; i < NV_PCIE_TGT_ADDR_COUNT; i++) {
+		if (!is_reset && data->addr_filter[i].refcount == 0)
+			return i;
+
+		if (data->addr_filter[i].base == base &&
+			data->addr_filter[i].mask == mask)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static u32 pcie_tgt_pmu_event_filter(const struct perf_event *event)
+{
+	u32 filter;
+
+	filter = (event->attr.config >> NV_PCIE_TGT_EV_TYPE_COUNT) &
+		NV_PCIE_TGT_FILTER2_MASK;
+
+	return filter;
+}
+
+static bool pcie_tgt_pmu_addr_en(const struct perf_event *event)
+{
+	u32 filter = pcie_tgt_pmu_event_filter(event);
+
+	return FIELD_GET(NV_PCIE_TGT_FILTER2_ADDR_EN, filter) != 0;
+}
+
+static u32 pcie_tgt_pmu_port_filter(const struct perf_event *event)
+{
+	u32 filter = pcie_tgt_pmu_event_filter(event);
+
+	return FIELD_GET(NV_PCIE_TGT_FILTER2_PORT, filter);
+}
+
+static u64 pcie_tgt_pmu_dst_addr_base(const struct perf_event *event)
+{
+	return event->attr.config1;
+}
+
+static u64 pcie_tgt_pmu_dst_addr_mask(const struct perf_event *event)
+{
+	return event->attr.config2;
+}
+
+static int pcie_tgt_pmu_validate_event(struct arm_cspmu *cspmu,
+				   struct perf_event *new_ev)
+{
+	u64 base, mask;
+	int idx;
+
+	if (!pcie_tgt_pmu_addr_en(new_ev))
+		return 0;
+
+	/* Make sure there is a slot available for the address filter. */
+	base = pcie_tgt_pmu_dst_addr_base(new_ev);
+	mask = pcie_tgt_pmu_dst_addr_mask(new_ev);
+	idx = pcie_tgt_find_addr_idx(cspmu, base, mask, false);
+	if (idx < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void pcie_tgt_pmu_config_addr_filter(struct arm_cspmu *cspmu,
+	bool en, u64 base, u64 mask, int idx)
+{
+	struct pcie_tgt_data *data;
+	struct pcie_tgt_addr_filter *filter;
+	void __iomem *filter_reg;
+
+	data = pcie_tgt_get_data(cspmu);
+	filter = &data->addr_filter[idx];
+	filter_reg = data->addr_filter_reg + (idx * NV_PCIE_TGT_ADDR_STRIDE);
+
+	if (en) {
+		filter->refcount++;
+		if (filter->refcount == 1) {
+			filter->base = base;
+			filter->mask = mask;
+
+			writel(lower_32_bits(base), filter_reg + NV_PCIE_TGT_ADDR_BASE_LO);
+			writel(upper_32_bits(base), filter_reg + NV_PCIE_TGT_ADDR_BASE_HI);
+			writel(lower_32_bits(mask), filter_reg + NV_PCIE_TGT_ADDR_MASK_LO);
+			writel(upper_32_bits(mask), filter_reg + NV_PCIE_TGT_ADDR_MASK_HI);
+			writel(1, filter_reg + NV_PCIE_TGT_ADDR_CTRL);
+		}
+	} else {
+		filter->refcount--;
+		if (filter->refcount == 0) {
+			writel(0, filter_reg + NV_PCIE_TGT_ADDR_CTRL);
+			writel(0, filter_reg + NV_PCIE_TGT_ADDR_BASE_LO);
+			writel(0, filter_reg + NV_PCIE_TGT_ADDR_BASE_HI);
+			writel(0, filter_reg + NV_PCIE_TGT_ADDR_MASK_LO);
+			writel(0, filter_reg + NV_PCIE_TGT_ADDR_MASK_HI);
+
+			filter->base = 0;
+			filter->mask = 0;
+		}
+	}
+}
+
+static void pcie_tgt_pmu_set_ev_filter(struct arm_cspmu *cspmu,
+				const struct perf_event *event)
+{
+	bool addr_filter_en;
+	int idx;
+	u32 filter2_val, filter2_offset, port_filter;
+	u64 base, mask;
+
+	filter2_val = 0;
+	filter2_offset = PMEVFILT2R + (4 * event->hw.idx);
+
+	addr_filter_en = pcie_tgt_pmu_addr_en(event);
+	if (addr_filter_en) {
+		base = pcie_tgt_pmu_dst_addr_base(event);
+		mask = pcie_tgt_pmu_dst_addr_mask(event);
+		idx = pcie_tgt_find_addr_idx(cspmu, base, mask, false);
+
+		if (idx < 0) {
+			dev_err(cspmu->dev,
+				"Unable to find a slot for address filtering\n");
+			writel(0, cspmu->base0 + filter2_offset);
+			return;
+		}
+
+		/* Configure address range filter registers.*/
+		pcie_tgt_pmu_config_addr_filter(cspmu, true, base, mask, idx);
+
+		/* Config the counter to use the selected address filter slot. */
+		filter2_val |= FIELD_PREP(NV_PCIE_TGT_FILTER2_ADDR, 1U << idx);
+	}
+
+	port_filter = pcie_tgt_pmu_port_filter(event);
+
+	/* Monitor all ports if no filter is selected. */
+	if (!addr_filter_en && port_filter == 0)
+		port_filter = NV_PCIE_TGT_FILTER2_PORT;
+
+	filter2_val |= FIELD_PREP(NV_PCIE_TGT_FILTER2_PORT, port_filter);
+
+	writel(filter2_val, cspmu->base0 + filter2_offset);
+}
+
+static void pcie_tgt_pmu_reset_ev_filter(struct arm_cspmu *cspmu,
+				     const struct perf_event *event)
+{
+	bool addr_filter_en;
+	u64 base, mask;
+	int idx;
+
+	addr_filter_en = pcie_tgt_pmu_addr_en(event);
+	if (!addr_filter_en)
+		return;
+
+	base = pcie_tgt_pmu_dst_addr_base(event);
+	mask = pcie_tgt_pmu_dst_addr_mask(event);
+	idx = pcie_tgt_find_addr_idx(cspmu, base, mask, true);
+
+	if (idx < 0) {
+		dev_err(cspmu->dev,
+			"Unable to find the address filter slot to reset\n");
+		return;
+	}
+
+	pcie_tgt_pmu_config_addr_filter(cspmu, false, base, mask, idx);
+}
+
+static u32 pcie_tgt_pmu_event_type(const struct perf_event *event)
+{
+	return event->attr.config & NV_PCIE_TGT_EV_TYPE_MASK;
+}
+
+static bool pcie_tgt_pmu_is_cycle_counter_event(const struct perf_event *event)
+{
+	u32 event_type = pcie_tgt_pmu_event_type(event);
+
+	return event_type == NV_PCIE_TGT_EV_TYPE_CC;
+}
+
 enum nv_cspmu_name_fmt {
 	NAME_FMT_GENERIC,
 	NAME_FMT_SOCKET,
@@ -618,6 +915,28 @@ static const struct nv_cspmu_match nv_cspmu_match[] = {
 		.reset_ev_filter = nv_cspmu_reset_ev_filter,
 	  }
 	},
+	{
+	  .prodid = 0x10700000,
+	  .prodid_mask = NV_PRODID_MASK,
+	  .name_pattern = "nvidia_pcie_tgt_pmu_%u_rc_%u",
+	  .name_fmt = NAME_FMT_SOCKET_INST,
+	  .template_ctx = {
+		.event_attr = pcie_tgt_pmu_event_attrs,
+		.format_attr = pcie_tgt_pmu_format_attrs,
+		.filter_mask = 0x0,
+		.filter_default_val = 0x0,
+		.filter2_mask = NV_PCIE_TGT_FILTER2_MASK,
+		.filter2_default_val = NV_PCIE_TGT_FILTER2_DEFAULT,
+		.init_data = pcie_tgt_init_data
+	  },
+	  .ops = {
+		.is_cycle_counter_event = pcie_tgt_pmu_is_cycle_counter_event,
+		.event_type = pcie_tgt_pmu_event_type,
+		.validate_event = pcie_tgt_pmu_validate_event,
+		.set_ev_filter = pcie_tgt_pmu_set_ev_filter,
+		.reset_ev_filter = pcie_tgt_pmu_reset_ev_filter,
+	  }
+	},
 	{
 	  .prodid = 0,
 	  .prodid_mask = 0,
@@ -710,6 +1029,8 @@ static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 
 	/* NVIDIA specific callbacks. */
 	SET_OP(validate_event, impl_ops, match, NULL);
+	SET_OP(event_type, impl_ops, match, NULL);
+	SET_OP(is_cycle_counter_event, impl_ops, match, NULL);
 	SET_OP(set_cc_filter, impl_ops, match, nv_cspmu_set_cc_filter);
 	SET_OP(set_ev_filter, impl_ops, match, nv_cspmu_set_ev_filter);
 	SET_OP(reset_ev_filter, impl_ops, match, NULL);
-- 
2.43.0

