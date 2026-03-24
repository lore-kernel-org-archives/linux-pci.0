Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3293B6BF9;
	Tue, 24 Mar 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379418; cv=fail; b=meqDiLONJ6q53IzVA3hl1+RZarIN8mjlAs6N3AoU3hw3c7lEW5Pozc8qnzHTtcEmSRsQvEIaP7g4sx01tAGBuzwske/4vV9y1hN0lxj4LTgTbO9e1Qz7gllJgTiwByc9ipZAdwmg4n2bI5IasdadPVmCa+xin005YU8SeTSSvzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379418; c=relaxed/simple;
	bh=NnmrC4UkSD7uS+HGSliGZ8KF3B9konI65nTLL6C5XZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMPoO9I7psXnOMwAMJ6lKlCkE/kfzeJMKm957fvfO8qZoiTCKM7D7zi+s3Y1Ac5L0G0RjJRnn482WykXdRVDYmhdXn/wc7ImtN/ZucAq74AwpMU3QRqcXy/O+CvAVetPPUZBWu9+RUmoIYTCEuQri1Z2tEzI9U5Wi40eT2HwIrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sNm/xEan; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNm/xEan"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udll1VHtuUUfyuZoSYBBRdUfRCu8unOZAm4OBl37W48ALaL2AewZ9ACL1fPeJwgHFAzGmv2y4+tAiBExyB8lN/DUXN34u2rm4RiQQAQdR2FCxt3zeP7AHSLDPJpPSYxIEWEDUFUiW12tsUbORWjnla54E2uWV6egYyXVq9DjsVftgqZL/ayhf1UvR+skcgAA3RrmogmntNVitcf/xmcoy96wav4Dxt52wnV1Rb7vN4uP2P9BD0lmLp53mlbM/ztr245YzqEy1JwadvJ1pSfAcgyJAFXDqFid4GRs5mQzPJMCiUF1m+4oa3DcVnvvstjXanx5A/zAg0vq/ld/oRHTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viWGQCSZj1bnWKkmR4uZyMsefRWpFzLFEIGP/IPOFc8=;
 b=MFjDySkwqlaoboFWvQrq/sCXLwJ7sc1/nkMFBnPI2za5CTrXhzVr9dfEqEKqAiboWIeoW5pCnEkdDLOQu/MsYu+XqsDuQKRKRyZhlkLAdUxwOVCjOgZbC8Lr2p3NA0prCzRGPquXpQXGUOWAAtu8ovPO/y64LqgaAC7jDD6Z6KgFBC8IUowxicOmbDMUhpwL2gm/wcaS7Hfe+9L94Fw5nMGRXsi26npWvudS6W0SA7emJGb/v36SSBQg3DRMp2F3hE0Vclf4Ts8g/XNlLHMHFEBtAfJZ6K/uqIfOcobbMvxV2AGHtEYNXFWokM0hh4nl8orS0bQBy9qzVQuro88i4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viWGQCSZj1bnWKkmR4uZyMsefRWpFzLFEIGP/IPOFc8=;
 b=sNm/xEanDemWTXlWHw1d6OZyxe/Q++fdmTNsVsq3XaHBBjyIMa6hBRbPtnnWCmf2ZPbzXV/eL1eErYp5Kv3hlMP7+i0gY4Iht9E/+VvZvtclVTiLxf3/mJFB5ZnQ00Wh9wDfV8j+Z8fFn0QEB2GMil5Bj3HWkiTP9AQcmlz4OJH127NvGpmYtnFB1DehxFbHxsCww+lgg7h1vKS49aHz495HxWeTcJeYDEhgm6czuiiyVVrwaP0is9hdFS7RskjF52iTpwRz5z3P1YpVjEwbz63kVrL2nF10kYvW0kujQ7FmT53pdlNi7o6dHnWo0+8G4c1kgTVLudAskF5Ct1O1fg==
Received: from BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:10:08 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::a6) by BN9PR03CA0067.outlook.office365.com
 (2603:10b6:408:fc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:10:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:09:44 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:09:38 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v8 14/14] PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
Date: Wed, 25 Mar 2026 00:37:55 +0530
Message-ID: <20260324190755.1094879-15-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1298df4f-9df2-4eda-138e-08de89d8f6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hSjlS3IMvT12hF9TahsDl03H99YNVQ5GgkECcRVDemnqVd9pPIRPZSglIuUxeuDw5IIIG1J2XZ8RsdOsARfPlQBC3ijk6mtX+yZqkF63TcpHVkJsq+LxWri9oIxjku3R6vbK/cbnN5uMNzUwW/q2SlErPd6R6LMB50NE5ciMZvNEiaBucMiTRp7AYc5vCrr2CyV7VYvkS0keGQfCuqWV6dDRVyUzAbVYpkaHBijiwE6SqSwFA/Tu3WI2edQbIoIclYVEWNL6F409uPYx8ASABu9Qqjd6ecHNfHhjLk1YLSJ7R1fNcigxxcRO+++ppkvMzCLAmjDxUtfN5T8zlkuLqals24fPtj1q8TRvdooUx/VT9t+Qos2EbrN93s7A/KNzY2BFhabjxDzDPyZ/5sRVtwEgTcj6bcEdtCgy2beJFWRxBNWpmPMc/FuV+8XLhvTlNsE/OZwRYAM/FAwH/xpbWlCKkOltu3OK7Y0yfIWbwSNGrchw3fdPLs7Q0Lw6yDZQYcL6ZAMjX1fHwQ3KzMy6DKfoSEd8PqwTi0wa7PRj/o3L5Dkgc+wh5yzGlUG/HIoV72ETzMLpPVoyLjgrocU72PY3cWaV02Ye8865vScHEbZiBLkVcCaGiU3jYd32zIgJ7sIQ3T3R1Z2fpVly6CtwPJoNtVa+BARBzrNrLUtzE1yN7REC2tBTHCc7nDyz90GJZdqSS1T74DaCtPq8hA6OMVd5baP5i6ugPyBcIEqFJbw2oou6j4z32QhjL+LGHfhuIQ9e3j4TAsF2PRe8e1mUqxsjuEkWEiYxoRkLWVzqTf19BKVEN/D5VmE/+yed11LD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1lYO3P4+8MX1Ssp1JXBhd4BSv/6sVBx/QO4c6/D5aXxsSmcMN+5gaQ/A6+hTt1AMrLmUuben+lrJfF+45ml2TPM1ZELAAJcfTdhDCR+aJMknW45dGes032y+zF/hZ/G+H/zIEllPVo0PgoZYsXqusktP0pEgXh67MS54/wWIz8iZzMVLuE4VHeF4JOYiLcpQK/X58h/SIJkKUl7+dkxSPC+rNKz9iJ69opurbvUFKxBjL+PQFwg1ZBjzaaf8g/KJvt75bDUNSrHUgDPOUbMQAaKaBuEt3nskT0OiZHUaqCIgasJ6jHLOCToRqvUyIVENaIHDO2k+zGgdPDrqC363PAUjoGaOjDy+7YjjTQRyDPWkSc38tWJUp9NDYqDyu4hByxlI078nidiYQQwWzKx7plAO1b3LOhyx1216HXuXMnlHYqvKX50eWkjj08wAnuua
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:10:07.7604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1298df4f-9df2-4eda-138e-08de89d8f6c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

When PERST# is deasserted twice (assert -> deassert -> assert -> deassert),
a CBB (Control Backbone) timeout occurs at DBI register offset 0x8bc
(PCIE_MISC_CONTROL_1_OFF). This happens because pci_epc_deinit_notify()
and dw_pcie_ep_cleanup() are called before reset_control_deassert() powers
on the controller core.

The call chain that causes the timeout:
  pex_ep_event_pex_rst_deassert()
    pci_epc_deinit_notify()
      pci_epf_test_epc_deinit()
        pci_epf_test_clear_bar()
          pci_epc_clear_bar()
            dw_pcie_ep_clear_bar()
              __dw_pcie_ep_reset_bar()
                dw_pcie_dbi_ro_wr_en()  <- Accesses 0x8bc DBI register
    reset_control_deassert(pcie->core_rst)  <- Core powered on HERE

The DBI registers, including PCIE_MISC_CONTROL_1_OFF (0x8bc), are only
accessible after the controller core is powered on via
reset_control_deassert(pcie->core_rst). Accessing them before this point
results in a CBB timeout because the hardware is not yet operational.

Fix this by moving pci_epc_deinit_notify() and dw_pcie_ep_cleanup() to
after reset_control_deassert(pcie->core_rst), ensuring the controller is
fully powered on before any DBI register accesses occur.

Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V8: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c7cae3a004ec..b497b178bb7e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1749,10 +1749,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_phy;
 	}
 
-	/* Perform cleanup that requires refclk */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
-
 	/* Clear any stale interrupt statuses */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
@@ -1822,6 +1818,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	/* Perform cleanup that requires refclk and core reset deasserted */
+	pci_epc_deinit_notify(pcie->pci.ep.epc);
+	dw_pcie_ep_cleanup(&pcie->pci.ep);
+
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-- 
2.34.1

