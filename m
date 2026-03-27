Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE33BED26
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597045; cv=fail; b=GXS9jP/h0Kek0UCEBP2JotT9/126Z957B2SeLUU3HzuQ2iK8z8OJU14WXIKnP9tLsGUSOskj72/xUBoKTcJ03hLd1oz59V5w6kYPG+xdhwTmaQbd0VnWJHKuljuuMWcY39h7UzASErq5vGpeeEOofnEb7kZ79YEGwM8ZLL3t1K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597045; c=relaxed/simple;
	bh=6BPp6HxN3Kqj167eOlEiKeuEkOlwaAJ6d1ivvJIIcog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HrU0V2oqXvXFPeQD9GpnPJZU7eZOBMFbQ4ppaczSV4uGhBXOL6uFYouJ5DkXMZdPW6jizapYLO5GpoUp10KkSQU9hZmwxlTq2Y0bBqbaI/BqnO2Kxv2ZXjCo1qNIx6vAk/m91JaIrtnA8eB239F6gphCy+I8Oi6XMURrz0Vyg90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D4GwhPrM; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D4GwhPrM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFUXIlBlCIb6X9XKQi1rxR92hyU1HdfG4ZHIDORks7lSXx9nfJ0cWIovU1IrMrGfZ+Hhak7bB0Ev7/YKnCl6L6fZagxXeprisUrRMkU++yxW3ulu70e9CbGSDuJ09wuZV9arYoqjJggDrU7JxcdzVkAT1OQCJi04kHMG2T2ZbNBdpap4L60sKrDnISS/FEAWr7N+qgFfvtbTUxRen+5+7Bka6Wc1ZF9Kvt7lHTi2mZ/6nPdGuEjM3Loa0S40GHiuGOzLgrOH5qxk+FdUMjJ8h+1i2M9CsJlgrX6U7JXh9eUJd0nNAaOQBDrEIRZEwSrTuDCN7Y/1oUY9UUTaPHzQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYM9Ycz1bOS6zSa0Hz0ctO1Whbbo9SEifOTsETwTMvc=;
 b=SaGq0CW7xKN2FfvSQqAHI3pD2+zSGMl1JA15u9DgIyXg4a9i0rf3n78jQ9puVLn5DCpRoLKdWPzEV8sT3Jr0M7TeKL4eg6w9twMyO8BbWmodhCb2CagrDiLnsISW+IjbKJSLFBLVhoYGZkUFU+wa01mxhIuU4zlNIUT/XfpWj98UCsbwFESXTjdbHxHmZlehvkAPYuwJDMpTLtnRV8x2AKwrVy071Pu0YAAoj5hIsmWLWjpBJeihREYtt2QFm1iYpqVkjr32hrLYRnOrtlF/e7PCDML4VNdirZ+Xe8ZBRGUinN6z5p+guP37I/7VwxZJ1Tj1/z0FGSJDLotZM0GPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYM9Ycz1bOS6zSa0Hz0ctO1Whbbo9SEifOTsETwTMvc=;
 b=D4GwhPrM/CIo1YNDJxlAkvM6jb4wlzzVoEXSqI/LizTOuQiUcOrhxdJ7sd9tqP+FZigJAnocEmahe+ChQo8hmbhAaCUVPUOF/WKRdoIswjKpD84Fk2QCXqwoYGtsmpoEoPsbA89h3NoYeWbD5MhHTkaI7wgu0oRZwgEYUrXg0o8=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.10; Fri, 27 Mar 2026 07:37:14 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::80) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 07:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 07:37:14 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 02:37:13 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [PATCH] PCI: Skip devices with RRS Vendor ID(0x0001) on root bus
Date: Fri, 27 Mar 2026 15:36:59 +0800
Message-ID: <20260327073659.6160-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5d4aa4-42a6-4187-f7a8-08de8bd3aa70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bKhGQY/jE2i8HcsCNR34yayNL+nRHGP3u2vTBav652vgPu8offPMg9CS04BNuTSrIrPnZZtdUy+8DkQXROsrMC3RiBr3ayRNiw5xip+LAWV2FaM+uAmYMvMxC93f/X2fg5cFO0Dsm4LK2B3KxjnYwRZZ1u/TO3yweFFZAVD61/LQ2zbgmbVMJzWmv4JvV8ISO4J0uRVKDdLQLwhkaAGrloQX8wvNcHqMp4MG0+ilBapnzN/a3R75OoPxZc/aL2kKN3WkuiToNNZ5z1r7JuQ6XBtjBgN+FVTjmu6gp2eYtp/Ygb4XHjy0FVSmu+i/mmhU4HtPdTTX0NNFC/iWkkxhcVIIEFNmp2B+sr2LWUBybLKhmjoUDnV7yX604ZVobQQNA+YKtiTZLknSnjBqaPSHs5KzVa141RzAZwQ6gYIpsBCjPBHjuwrRGTkmGcvTf+5nYW/8VdvOCbWr+ArQ9v9IyGn1vv3fSyH7q9scNpNDxijecrA9njcLTCU5J88CswCprAEfWqscwabNOxKy/xD8+7k/icCckFYCqFG9IjOPhZFzhxjYqjQXrkKPshNnlQMoa5TYxjl7ERiZWJotbpAaUghU85A7cqmgHMeC2wpEfJ45HlMNfxrQWkezoQaHQ81m6QeV4WjNM68E8nQ4XCRIKJJN+hBPbbhhJEKYZ/UpBBzlXg2vKb3Dp+uur7+7Xf6PKdEdoXg3+HVO7NQhLv7p9yCs+hcJ2c2nq76b/rrIiSVccR9k7g86UDo7pEw/rq/rHS463b8B4O9IuxPpldfeOQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xpFmIZtwYDcVNExmJLMf3VptwioSmRHgyfypA/11HyhX180XnCEjalggeiRdQbLIOdTVPkN3QDoUhtq6f7snm0eIIHFkdA16EMB6KC7FL+36dH+qYrAOKTlKne1J6MQoEj3EouWvTyaFUn3PoWUidL/Bya6SDKk+9L66Pz/OIBoE7/S+1IktjqLx5UOIF85kF5qk0o4vKpFzLgi5JPuzIi916dt+B3S6LsE/Dn8d2f2Ldw2QSeJOZSSv6aoDsF2bNEHrzRfZX942jgHlUcVR5JCuVGYS216xItRtD3miF8fkSGMA6fI43Iz2Y+yZ2iO2lCXUIj/v3I89tT/+3S8fT1dMOYVko59oDaeBpduz/KSKcSNdXlyHhSqcLdBUzHv3D3ZPxIjSq16a85DnF+1SMDvXX2lcfShpQkUiolE6q2c7t/5DPAy2H2VXEAQ62N/L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:37:14.6321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5d4aa4-42a6-4187-f7a8-08de8bd3aa70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

PCIe Request Retry Status (RRS) is a link-layer mechanism where a
downstream device responds with RRS to indicate it is not ready.

With RRS Software Visibility enabled, the Root Port translates
RRS into Vendor ID 0x0001 (reserved by PCI SIG) for the driver.

Devices on the root bus, for example the root port itself,
have no upstream PCIe link and can never legitimately return RRS.

This patch skips any devices with RRS Vendor ID 0x0001
on the root bus instead of entering the RRS retry loop.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/pci/probe.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..2fad89ca594c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2578,8 +2578,27 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 	    *l == 0x0000ffff || *l == 0xffff0000)
 		return false;
 
-	if (pci_bus_rrs_vendor_id(*l))
+	if (pci_bus_rrs_vendor_id(*l)) {
+		/*
+		 * RRS (Request Retry Status) is a PCIe link-layer mechanism
+		 * where a downstream device sends a RRS completion status, and the
+		 * Root Port (with RRS Software Visibility enabled) translates
+		 * it to Vendor ID 0x0001 for the driver, indicating the
+		 * device is not ready.
+		 *
+		 * Therefore, RRS is a root port feature, and devices on the root bus,
+		 * for example the root port itself have no upstream PCIe link,
+		 * so they can never legitimately return RRS.
+		 */
+		if (pci_is_root_bus(bus)) {
+			pr_err("pci %04x:%02x:%02x.%d: invalid Vendor ID %04x (RRS, reserved by PCI SIG) on root bus, buggy device\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn),
+				*l & 0xffff);
+			return false;
+		}
 		return pci_bus_wait_rrs(bus, devfn, l, timeout);
+	}
 
 	return true;
 }
-- 
2.53.0

