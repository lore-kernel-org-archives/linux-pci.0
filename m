Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1682836E;
	Thu, 29 Jan 2026 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678292; cv=fail; b=cdcT0AGb6Vv0S5RtxrVTZHpp87nld7O/YnWx30nTSnVN0vqvIYSzLJAW0vpqBSqkWyQR8rpWYl5JUHbQTeUBOjVqkJrhV8u9RFWNNdP8DJHTmrhxCQnE3V7CsjAoNo9XDjYUmQBMAK2lFt2aNN+YqarqfrujjOiPIAVdTUAzXE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678292; c=relaxed/simple;
	bh=lTkIZ1E23LiY++rKL65nu7vSGdppUWXUIP4YHKwfgEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeD8b4BZ3yyMWFBPsVWA6ese2DU5UeqnP/mgC+gQWo1LrVYmdxP/QXZ9KS40G9Oto7RUbuVpcd/9pXga8myAC5DPVdNAKqKCz1hWD3AG9A5QB5gt1/XMRteAcr5A1caOBbHPjYOIKZ9tK1O17Jrxxaja+KleHXqp8C9kb7fQeb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VkL/qODO; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VkL/qODO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFuY1x3X47I2MqqkgUcJ/ZR+HLKiOnpWnpY534ypaq4a6j+aBKeCcflLJl6mIiLEo9McXS4M8j+C4wRHKxqanzelzyw2gMtFJXpyGHEpd5MJMHlOsruXHctYtrJGcORA9DlrJSAXL9M/D9DRyvt/1yG3VkYDYMiaP5YZ9qky7EWKSS03qb/CadRWvAbAC6h00RAlx6JJdBaIWB0eG0/0s3hT0e2LFeYNUu6P97HQhSI4Af+ztKUpSRYCv8daGrsq35MS508d5UFN5oC2qJUqKLugieptZ8idVcmTlTJlg2/LUvnT6l8l8Y1bS2AXmsVJl0TC+6oi7mVnzu4LEbtRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrKsSrq6fMrwG5HRXBWkMT0KH758hj82xU9N9uIPKms=;
 b=TOxsB4p/ciOuRmLk4ZPYX9lpbnXqQTWcyxDVj1H3Qu6ebSPLoI7I6Bvy2G9i+mbQkNmi6CtZthP2SAwMO7gcO0GPANmvaL7z7QyDsy7ed1hbZpLuCzoMYwIBIBq3gHOsBfX+A8sOxGIqIfP0d7DnyGCDhFfvt2Io5YQnjm8HYghSOlSw+TK8Y7Wnz//lUWswnS5rmlRRWcMdo5MLEqLODBEy7djSrcuVzvmXcVIz4bZWmLotkgvJjb0Ur80kB1VOeoKA0THStV4b1/NEvcvvPpZcrbCNEwyyJs9vPr53oMHWAjqX1tao1jZf7ubnv8YEuNBCtBWxqMa0ejEWbIKrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrKsSrq6fMrwG5HRXBWkMT0KH758hj82xU9N9uIPKms=;
 b=VkL/qODOj+w7DBYzm9DlHbMAA+exbar0iNIMe1HV13V5NeHbJmfuxlDNsshky0dTSjplhxrimavZp4M4QbOs0Mv0Cep6a9OyIQYQVEoj0BsLiWjr0YJ3y3FbgiAD4xMgSwenRy/HeeJLgG4dOgiosRML28wLw6S+TN3vM0p/J+c=
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 09:18:08 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::93) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Thu,
 29 Jan 2026 09:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 09:18:07 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:04 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 03:18:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 03:18:04 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60T9Htko3499594;
	Thu, 29 Jan 2026 03:18:00 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v4 1/3] PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
Date: Thu, 29 Jan 2026 14:47:51 +0530
Message-ID: <20260129091753.490167-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129091753.490167-1-a-garg7@ti.com>
References: <20260129091753.490167-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CO1PR10MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 986e28c4-2eee-46b4-85a7-08de5f175090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v0RGkUmprxjBBe6Rk13OtyFYVG621uKATgqZQgpMhg67yvqMN3g0mU5UiS24?=
 =?us-ascii?Q?2jzvRl6jWVY/gcqhYxPjcg/Bu5S/dgs5RrXRM1sLrQ95T57Bx76nX2rL51IJ?=
 =?us-ascii?Q?/GJCE4kzgAGHUgGyb78OLjuW82dVN8J354biN93QilGN5AQfdnZLvVnoLbQQ?=
 =?us-ascii?Q?Brl+H25etA0IsIOA31QTgZBFf2a5UYS2Kn8FeUVOPXm1QaSCbbHBaF0tGq7e?=
 =?us-ascii?Q?ieb/QadcbW28hM5J7VNYrbfybHbHAp/Ww9GldMqkS6hJLxuxb+m6NxcYl9ni?=
 =?us-ascii?Q?L2fOqahMVriUGi+JNrOXN4uEzwz8777TA4atFn2F8aaVUx6sDd4oqTXF8ypC?=
 =?us-ascii?Q?LmjLYgeGtHwVjwx6oqgluFyuj9MYTGEEhrL1vDTB210aJzKNKjbNDliY3tyl?=
 =?us-ascii?Q?Q5tKKQ9F5xJE/ELgc9MgVJ1/JyR0TRv3jfueoVW/Hd6zkiH2M4s17YftIA/m?=
 =?us-ascii?Q?KKz59Xc6oY5jCwplfATg/uS+cJB8VOLFkJ140QtsHKTJWNps0e8cOQ5bqXu7?=
 =?us-ascii?Q?u540pp1K1Pbzo40ET5xZOno83RWcOC4MqQbwlU9oF1xJJ559vVwJm8RTFUVR?=
 =?us-ascii?Q?TGfDY15tpx56szzC/0h4Lh6i0RorQSc8T1/qfZNca4P0HW7SqBychtxxHq0g?=
 =?us-ascii?Q?iYXtFyDmvCdBt6JuBTA+r64FY9CtcEc1oUheCgr6cNcy2RqigIV0VnXX/erd?=
 =?us-ascii?Q?oLRJwVYZdMsCdPnd0UqLUGnEdpzpwHOhj5Wsi0ca+9jtEQqcXDXwidGabLZ7?=
 =?us-ascii?Q?T5G4D+0kPcZL9y55kxzUWXsFb7jrWIgMq9DdgniTPnxt2oMWl32OD645qW6W?=
 =?us-ascii?Q?VUho06cuMRrNWZqjKHzK74qAuIOV/s8gS7AHuINNLNtcFzGsFMkDzjpBi/vK?=
 =?us-ascii?Q?JYaP6aeGsEfD6D8f8yAJKMlU32s1LoWKstJawO7pafEnDdrBoeMZrNoiTRJI?=
 =?us-ascii?Q?IY4AFZkC6AS8MLD6lpmT0wRlxN8Ze0Cse2na1+rKYKRRWs3UcIu0sOk4+g8U?=
 =?us-ascii?Q?qLlMZncwNIBnQZcaGudSbdounixLyeWX13uGhvGL47bjFEJle+jh0WhcFU56?=
 =?us-ascii?Q?0Vwov7Mn2i9EpE4uSj9lWyBEtdDz+FqQDez03083nbo6pFXtPOVeh476iqbs?=
 =?us-ascii?Q?ZyUl8Uv+a7wW1kZEXlahlrTZhr0OEKkdUIpC6Rwmo93qFOfKJPbUoQp9TRVH?=
 =?us-ascii?Q?sTSJODwQzmLO+j33yI1vI+VGl/YN3YhWpxJP+3stcbkmvHF4oiXScw8sZZk+?=
 =?us-ascii?Q?SGYgeGwEgiTsgU5rnLVbXU0yylFcbKrjH4hnEwVif9OgsR9Q7/pbwJfqornD?=
 =?us-ascii?Q?E2+6ZQFDcXmykfAfNRYuLTY8hRib6uAGryaApJak9UFVofmMv+zlEp/3IiCl?=
 =?us-ascii?Q?QBSYGp42G23n/Yd9xsex4v8Ujd0JV2b123IcHCEZaw+alUpHKJJB7CyJ7glM?=
 =?us-ascii?Q?rqNC3L6XxU4R/J2o6cT88a1EzZWHdLae8SoECgSj6EGkyPeJOIJxdSOxDZ1f?=
 =?us-ascii?Q?hOlpiXfLp8Sr4Z94gL6U1NFksdXOzCOUGoGHSRGGsszxyGY0ZR5Fs/zuCbiC?=
 =?us-ascii?Q?iEOmsNWV7JbCiCvB6+LZXtB861II6wJhJS+A/y0FF6WeVq68EIHtSI2qZqa3?=
 =?us-ascii?Q?+SlIr+zAd+kgZSt6mCAADuVCMje0gyaE3l8YId7+wlDKNHfWalmbNiNAghJk?=
 =?us-ascii?Q?NIWXT8Wt+U6urXbyUgKFhhSWOFg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:18:07.2487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986e28c4-2eee-46b4-85a7-08de5f175090
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530

The resizable BAR support added by the commit 3a3d4cabe681
("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable
BARs") incorrectly configures the resizable BARs only for the first
Physical Function (PF0) in EP mode.

The resizable BAR configuration functions use generic dw_pcie_*_dbi
operations instead of physical function specific dw_pcie_ep_*_dbi
operations. This causes resizable BAR configuration to always target
PF0 regardless of the requested function number.

Additionally, dw_pcie_ep_init_non_sticky_registers() only initializes
resizable BAR registers for PF0, leaving other PFs unconfigured during
the execution of this function.

Fix this by using physical function specific configuration space access
operations throughout the resizable BAR code path and initializing
registers for all the physical functions that support resizable BARs.

Fixes: 3a3d4cabe681 ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable BARs")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes from v3 to v4:
- Rebased the patch, no functional change

Changes from v2 to v3:
- Changed function name from __dw_pcie_ep_init_non_sticky_registers()
  to dw_pcie_ep_init_rebar_registers()

Changes from v1 to v2:
- Fixed the suggested nit

v3: https://lore.kernel.org/all/20260127085010.446116-2-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-2-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-2-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++-------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de09cd786edc..1b3dd07e6004 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -75,6 +75,13 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 				 cap, NULL, ep, func_no);
 }
 
+static u16 dw_pcie_ep_find_ext_capability(struct dw_pcie_ep *ep,
+					  u8 func_no, u8 cap)
+{
+	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_ep_read_cfg, 0,
+				     cap, NULL, ep, func_no);
+}
+
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
@@ -350,22 +357,22 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	ep->epf_bar[bar] = NULL;
 }
 
-static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
+static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
 						enum pci_barno bar)
 {
 	u32 reg, bar_index;
 	unsigned int offset, nbars;
 	int i;
 
-	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
 	if (!offset)
 		return offset;
 
-	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+	reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
 
 	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
-		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 		bar_index = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, reg);
 		if (bar_index == bar)
 			return offset;
@@ -386,7 +393,7 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
 	u32 rebar_cap, rebar_ctrl;
 	int ret;
 
-	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
+	rebar_offset = dw_pcie_ep_get_rebar_offset(ep, func_no, bar);
 	if (!rebar_offset)
 		return -EINVAL;
 
@@ -416,16 +423,16 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
 	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
 	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
 	 */
-	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
+	rebar_ctrl = dw_pcie_ep_readl_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL);
 	rebar_ctrl &= ~GENMASK(31, 16);
-	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
+	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
 
 	/*
 	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
 	 * updated when writing PCI_REBAR_CAP, see "Figure 3-26 Resizable BAR
 	 * Example for 32-bit Memory BAR0" in DWC EP databook 5.96a.
 	 */
-	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CAP, rebar_cap);
+	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CAP, rebar_cap);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
@@ -1022,20 +1029,17 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
-static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
+static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
 {
-	struct dw_pcie_ep *ep = &pci->ep;
 	unsigned int offset;
 	unsigned int nbars;
 	enum pci_barno bar;
 	u32 reg, i, val;
 
-	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
-
-	dw_pcie_dbi_ro_wr_en(pci);
+	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
 
 	if (offset) {
-		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
 
 		/*
@@ -1056,16 +1060,28 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 			 * the controller when RESBAR_CAP_REG is written, which
 			 * is why RESBAR_CAP_REG is written here.
 			 */
-			val = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
 			if (ep->epf_bar[bar])
 				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
 			else
 				val = BIT(4);
 
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, val);
+			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_REBAR_CAP, val);
 		}
 	}
+}
+
+static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
+{
+	struct dw_pcie_ep *ep = &pci->ep;
+	u8 funcs = ep->epc->max_functions;
+	u8 func_no;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	for (func_no = 0; func_no < funcs; func_no++)
+		dw_pcie_ep_init_rebar_registers(ep, func_no);
 
 	dw_pcie_setup(pci);
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.34.1

