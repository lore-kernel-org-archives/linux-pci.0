Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55536E479;
	Fri, 30 Jan 2026 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774135; cv=fail; b=Q3Gfxw91Mw85t/c+WwFTV1a0/sMMpnJ8jqYuKcHPg+qlw+vDwh1zbJxGd4FV6FK4c6ASKqyXCvlhTlDlcTYW+jDEsidfmiROnat6UHW7JmdkeSRcDVAYkA4kYtwnDvDQGjbdSFuiysmgTtBho7I8bh0AcQBVMx9HNjVTO29S63o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774135; c=relaxed/simple;
	bh=kewQh/AP5AA2ULKiUq9LNH59/IlFyPWuuw+zF2PLap0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1om0bRafb314X5LVfssfntk6ExkDYeqC16tHC919Z19YBz4rcjcoHcl14akq7UvJMtou7t2Jr9kmZ/ZrX+FTqFVjTSaptVCotoRAju0ToRSTtC+7vgjHAuKiAj1tnjg/c6l6IOz3yiULQ4L5BKd08DT0CjWNlPnfW9kDVQfGd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WnDBvEag; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WnDBvEag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7rK8G5moddWhgr3WtZVrJOQmxYj5laXXJZxFiCrXBgcoIGC96PdBpJkBpWcYuw5H07W3pYCJjzaw4Bkx28VFc5yyfAnf3UMjxFZinsYSoEta52Faz7rxvP+Ugb2o5XQhAjF3wSfoTTA6sIcKiVe2CN338qBtxQJP59sFIQ0JwUUtsCYC6tyr4CIbs87YzmmgV1RIcBdf6tXfCCejfVMSZO1zZnRux/Fj0c7CR2ab1VsOaGKD9z0relsxV7o3rqSH3vsWkdlWcm7dQCjPAkmEKo0EtnyiiDHua+YXLaowrJjKjvqRGUcV86vYxuhOESpb4dzjbm3fLnWew32e2CYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynrmTnhHEvOsBv7JJA1c8TJTgsCQOqlOi9WaBkHSXvI=;
 b=oWFUvMxtGSd2bJF7px0hlygKFIh2OFFZH+ocfxoMgrc1uDFP/P1qkCgTBJGHoqSMatGgo3jxcpt6Tz/uAuBDe+fPeEOxc4D0K1bKPidzrHwJnL47I4FpxAAKqErPFcY+jsUMEn7EvkDEgTDFc3iZiRltowKS+OmgPgoFappsdacW9T8KtyS5NcLgOO4izyQNqt9xhCPe+DSrRYYrS+iLVw8WLmrCR/eRo4DGb3yqgEPIByN+JWPsVsAr41zWstVMETOnKJwJk0fHqoZqE8/43xaMOlqWzQC3sMOUR34e+sZrMM7A9eL6bxiBiry3pGQ69Jxo88mokgZVpZFrhY97xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynrmTnhHEvOsBv7JJA1c8TJTgsCQOqlOi9WaBkHSXvI=;
 b=WnDBvEag4xbR+kkWIOs8/hZW2V6TKdjpi06fEh63codtDB65RehetUSgbeM2W6qkrgvGj0frHH/CBJQ2K5pwBwXNvYeHrOwnXmVLskgZB1dRCT7G4lKLyqOEBAKiaytdURpf/KD3x7CSJa8bYeFZymI8r7CKNPMaPSK6otHWvxI=
Received: from BYAPR08CA0045.namprd08.prod.outlook.com (2603:10b6:a03:117::22)
 by DS4PPFAE15A2261.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.9; Fri, 30 Jan
 2026 11:55:32 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::8d) by BYAPR08CA0045.outlook.office365.com
 (2603:10b6:a03:117::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 11:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:55:29 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:27 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:55:27 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UBtIu11665999;
	Fri, 30 Jan 2026 05:55:23 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <den@valinux.co.jp>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v5 1/3] PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
Date: Fri, 30 Jan 2026 17:25:14 +0530
Message-ID: <20260130115516.515082-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130115516.515082-1-a-garg7@ti.com>
References: <20260130115516.515082-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS4PPFAE15A2261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b33c3f8-a669-4a8b-e91e-08de5ff676f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6tuLG/v5Sx8EqfNDYiVBU/X7VEqzYVsmU86cgAs0IEb/NT7h6DgP2GheSbLN?=
 =?us-ascii?Q?qRSkdpQJAqeMUhKYzXif9xXIn8rmBxfRWqhJ+p4hSrhIb089272/RRUDZ8rh?=
 =?us-ascii?Q?JCCclTIaKVsy+SWBAsyo9e5PADAWjWei7GnDuEZp/kM8+gokUH1O8qG+g844?=
 =?us-ascii?Q?30MLoB1M4jQASQlzIQiImgu6Y62XWNQJ+4B6fDtB4cC5VcPxQXr7oeZHazbU?=
 =?us-ascii?Q?6K2T0rx6B13gfdfZIJP0McrcaLHKN9APPYnWrhorTrnDOyCnDm1yueAvCkQ4?=
 =?us-ascii?Q?Sxiq/P3lA+IofljJlTP7qogmSYXnR4z/oQSAAtFpD2/wEtUhMFoMybBLGEYJ?=
 =?us-ascii?Q?k2ESo6IxzekbyaM9sjISOJWvhsaekW2XdicLJikxiyWMVN46PeGuyFNYx1sW?=
 =?us-ascii?Q?Nha4pek3j7/MpItriHyP3oRP5HjqDibkMTEpV+HWCclNpey/UYL+eJwZ+tB7?=
 =?us-ascii?Q?unihEvfv33DA2vyuNToODbA7NFXWTjzzO5qhdDjcshE0bcntVbayTle+04r1?=
 =?us-ascii?Q?9pKKda7QWgGjanMvmlj3mw0nfakEHqLsg8+J/laNUh7gW8QPe1HAXrSliCxI?=
 =?us-ascii?Q?bFuv3+sEqQLP1g9hAcS27bgh118pWB/722mpo4uisG/p7o7m8jxDM9/5s9DP?=
 =?us-ascii?Q?X2JWn7GN7sSeHSS3jm7/sKT1fvklp4p3WG6tuRtCHqynutwD1047vPjTx6pT?=
 =?us-ascii?Q?e9yOfx09sqAY1HW5plBrkKO7kfZQz02M6AlmS5rr5/r4w/mP9l8uqdBNm/+b?=
 =?us-ascii?Q?cvwLoLAObAXycjkoMHvrOz+Rdumt8EiS1y/tCVxW/82ud2T7PDos4JBdA31M?=
 =?us-ascii?Q?Pg3WYlk51Bhb3KDXG7+z8swOOH5F10y4LDRwT0urZ1CUNAx4yo5rqT9iAv5A?=
 =?us-ascii?Q?g+Ey0NGxp3FWJ7yNTk6PJrOJnd4zNf1UK9vZ8QC47CEa7MMYGpbhxzo0v7i4?=
 =?us-ascii?Q?yUTCMbggzpbH0pudlfhHvPVHKFm18exjphxXbOtYTl+nwevWv7nidgPl+W+t?=
 =?us-ascii?Q?1ynCs4BZr0y24KTib4YfCUHpCeu7HCNfN9fjVPxQGpIbp5RhbDFTKkqRcI/0?=
 =?us-ascii?Q?AGzwF3rHmUB9DBoZkp8Mg1a6/Mo2cEsBBm2O+UUkNdPy++h+2eqj6xLgVptV?=
 =?us-ascii?Q?aJ0VoJXwzqlYzqNlAnbVLYhxUDEMkugdOgrl+eO55n4wvQoD8MkgcgqKB0M4?=
 =?us-ascii?Q?FNRxf4MkpIZJWuUPIsivB0SsLvKfKg18oZFGRC9dOBTxAbSquVONTbd9JHVY?=
 =?us-ascii?Q?Bt1hEg5zej3eD4gnq8N83sCLGryJw6q6oXZ4UlsxuU/LRSuXErFZeefMFbAh?=
 =?us-ascii?Q?uePHeia8h97H4q0uzA3Eq63DWTmqbCHve+t7gG7xViXKgOnCTOr9AfEvE6Ra?=
 =?us-ascii?Q?mWZU8ww+1RyytQaOcl3MtHQmbUBFDuJqtjGppH8IY9gaUZk3UvlAPWYXeJ2h?=
 =?us-ascii?Q?ey/S5LsJl/TsLf/BVutgaleTSa3cz/iDUiIRCGmoS3+RrC7ebHmRjUMOPbk5?=
 =?us-ascii?Q?9H2K4Fu9yPDyCvV6vGuHLvTcf6g/66kE5Ilx2Y42mkrN7O4SqicHZKqgNT7A?=
 =?us-ascii?Q?Gc6iupt8FdimyWyTsjCqsegkI/G83yRmN1esy6MCzq2NuXisk+UZNQ6vYrIz?=
 =?us-ascii?Q?sT9HhUlHutuJqAQ4Dnw/f5DhN2DIv21WKzpgG7mXoMUzo2Ej1b4QNKhaMKMn?=
 =?us-ascii?Q?DwLd5a2Oteq6g+gH4lkdYKxclUM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hTBJu+1/v4qHZsm/TULWXX2JdOB0X7biI3pIUsQ1P3Qey3soTGmYaOIYMPxzn40HeLkOwf04+GuMeLN6ZyTiPpbxfudfMfjXpQJxbzJ93yX+qOaIKKunXPV/eMMQvRGM6b3clPLUJ1RYN3W7mDdvykYhnOZ+6f1rwCCJ8adTM/PRKa+hI15Czjh57+clu5iv8QAFGyjR/+y+KejlqLK4D8+KDpJs6zq5m5kEyyt4X2wxaXhhxeWmhLmykW6UVrruNfb9O0XLQ6dpbpD2HDoUkH+NHbWkW8HSIX64krnrIKdgfMApQUb7PsZT5IxuVzva1z7B5XVrTSmZYLXVNdzrly2SSy6pt7tdLRpzrTw9+YR0aBNxtOynrMSagcrqV4ZPLghWoj5v5UVlojDE9NeAoyukyuTqfT759FqwFVfESeYC2rpHo1ctTJrFVhdIXSqb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:55:29.4437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b33c3f8-a669-4a8b-e91e-08de5ff676f8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAE15A2261

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

Changes from v4 to v5:
- None

Changes from v3 to v4:
- Rebased the patch, no functional change

Changes from v2 to v3:
- Changed function name from __dw_pcie_ep_init_non_sticky_registers()
  to dw_pcie_ep_init_rebar_registers()

Changes from v1 to v2:
- Fixed the suggested nit

v4: https://lore.kernel.org/all/20260129091753.490167-2-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260127085010.446116-2-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-2-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-2-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++-------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 855b2e58c338..1cc2985bab03 100644
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
 
@@ -1023,20 +1030,17 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
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
@@ -1057,16 +1061,28 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
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

