Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C77313E18;
	Mon, 26 Jan 2026 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413688; cv=fail; b=pdNbUMyDz0vbrfYd5UuLCL7e485GBwKOfHM6gNMvcWldfT3bj0NxP4k36TijLQ5GnqkOzfO6xQZmmZF1ZWZofTWIf/b9gGZBg3wGbcwpCHOyV7Gl6llitJftE0I6Iu8r9j9XQ3grRY0K/DZK7bW35D9ZqL2gE7ZMaacjoU2o99E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413688; c=relaxed/simple;
	bh=MIh3eSaRRBdWDIhBr6ycA+mCAPTXdSMfXaU/bVoh4f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oI5lfETlNjBpcs2gSBgXGLBUnzKQ1iU2Y9pMoQ1sXV54tD/1uXA9RXTsCNzNPAqRYHMXz8FSBI2bra17+RgBxv4ywQro7tBtD7MQnWnJY0/UCeUYvblJHq60QFVJM9nsQoonKrpO++nAVqvrTMnQIqTvu9LG9//OCXoV10Xw+nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1Tlp33Y; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q1Tlp33Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d70sY+YqOZ/WIpKCYG7H65pVHzo8rmi9j8pXDSXVkAM+Emz/9m+LC0UUpvgA8DvLbzz3WhVX9ah13en+6PeG78UBrexT+p9BhLNGCYr5fmU57gv3ox/eXaMUwDDTpY4BpcObqD5WqH4bozVxOMxhVOSwpcr0xf3TLsawg/gcr/r2k2f6WjxaerM4Er/NNA3v6EKBD+bRf9Gduu/6onv+9eeAZZZuwpozM3R/aqYS3blffLI6gbBcQzwJyIjkceYiktTrW78qOl79QHSYGRCGpNG4HzuhjxNm2ZFhi9QJqUp0DgciZwD4OlsYqiyOl/R99m6WZLlJpSR1Cy0v1xw0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deOaPg6CnXntCGXuwb5GRb2o4Ux30WqzTUYCKlnuoYY=;
 b=uT6dLtfTbtkhFVdMKWHpy3VKfncIGrK9A2MgKcdKYxw2yszd8H6YVffJ5em5kdWVjG8O9M3r0nwlal+mfnHQMLUmsDTzzV7QZXMk9iix/g2IHrhI7q9ixtTWHDibWSKtRwDHvGwfaLRvJTKcQTD5WhpKadg98R/1Xs1G+KiaTZ9stByFEIRotFNQf9Qh34v0eOEx9oGP5ISVAhmfl+ylUWrsy5eTOto3l71o9KR4kaHdRXb1VQ3j3542QSMYotyfN9zuIphn4D7aCg17WzkzMbJnkCOPPbT6Z97OizRXsJLh9xQwqjav0UkF98CwVHbVYkRPlyZs6WeMo50RWtuhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deOaPg6CnXntCGXuwb5GRb2o4Ux30WqzTUYCKlnuoYY=;
 b=Q1Tlp33YfEF4VBGDCLlDFC4185u3wl7Y5iQHYXD+2x7izLg/7cMiqLVDAh8HGLPt7xW2mVgdV3kdGHwNkELuZ+xbrUbWjeN+NGNd+7wmk4xpmiJ2sO2s1DycMRbd/z4294ci9DCcWY6xYidOx4r4AlS8EBoRzsQCHigcTZqzVrp6SANnY4cgmwN5P7P+FipX0fg9Tz3SlRz9NFwzohM3/Ym8Gh4vcVPomqi/TWCB0J9ueuiNQUI1nTcjRoOS625WaMbdKrYFb4kgUDxxUFb2iwc5aRY/eCnA9zt8BpItS+s9b8/c2IbR81fS71FppfFMbyhLnHDkKTbdWZEubj2mjA==
Received: from BYAPR07CA0090.namprd07.prod.outlook.com (2603:10b6:a03:12b::31)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 07:47:37 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::35) by BYAPR07CA0090.outlook.office365.com
 (2603:10b6:a03:12b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:48:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:54 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:48 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 21/22] PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
Date: Mon, 26 Jan 2026 13:15:18 +0530
Message-ID: <20260126074519.3426742-22-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8a42b7-cc05-4d9f-7508-08de5caf3cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7BZnD26ZWqA3vKBOIPJQ2pIIsDixj/ch6j2QSCMdARGhCBGpyyVhSKEvyChd?=
 =?us-ascii?Q?nsiXkYpJbxJu1Eea9N+3p5ruUsi+Pjbt4RZhUVD0Atvw//P0M71o4PYhnU/+?=
 =?us-ascii?Q?2WS61goaeYzTPTxBQhjEew/CaSlKCm4roHsXQvCWjqwAOQ/L0HxnVdy8gfQu?=
 =?us-ascii?Q?YDarXHz6yKaDH95uaJoCQrnd0kiUMspK4lhyW4FCoINrz96bFnNO9W1rG/X2?=
 =?us-ascii?Q?aH8QeNU/GXPId09FhPTa/Zz8ecXCm++9pZUrpzUKot9v8SFsSvRUh/7ZW+rI?=
 =?us-ascii?Q?iRIEmGVxrj651LuX7pmk3TIeDRm4s8w+fgGrtW5df5Wy6cF9YKQv+2TCPo9l?=
 =?us-ascii?Q?pFhoD3U/5dI44FYryMOVSlpJC59Ol9O4P83wLBGT/3QxiqNTDjUCayldLjVU?=
 =?us-ascii?Q?PVIFj1Xl6bIHy34dhNalgfhc5ba/K5JRhv1+f8Ls+xKfwS4vY4nijdMujPiD?=
 =?us-ascii?Q?T/Vf03WFn0FDJNy5Qz380XcAVPYv3ShpxFcSOF19p7JkHSRObHatWOyMa11l?=
 =?us-ascii?Q?Hix9kTXyeR99ubXxHfLC1lgvaD4HagDtp+kexIy9kKrX0L9yemKwGtBrf5fb?=
 =?us-ascii?Q?D/6xEX+lANzcg/HtVT0Zl2bdM9W2iL9805prp2z2+h8bVmqlQZji5KA10/0Z?=
 =?us-ascii?Q?oyokMv7IXrzTfY98egj6Naa497h3gJu59lgFiu4dLo8788aEnsyRNX+H8Q3s?=
 =?us-ascii?Q?eZkN4q+G3s+0LoVL6lSgsztLc4+1+dBG27EXCsUrjVfQNhwoJu6ubBKp+/EW?=
 =?us-ascii?Q?L92pxPsbuvXGX7onsBMEbO5dyG+QqKsBL3zoUJQdmBJUqFrx/kiaVK2Q8QKc?=
 =?us-ascii?Q?dD8HN0lqNMUP81Lv3r/tGjFCfVYlbcxHvM3saIC8OZZhQ3lbaZ06qn11K/zo?=
 =?us-ascii?Q?yW+Z1m0CUKIzGnnCc7CVbL1dASpfpxg1o9ypKrZDXfr8H+YTCSEiRKRHmNn2?=
 =?us-ascii?Q?IYRS63F5MyD/rtK1+Nzt3aM2UGTFDYTKazVbraQ/bnbYYuzHSSMxQo74LnKM?=
 =?us-ascii?Q?F0PL/nCwHGNhUqvZhm707+cfktA5OU9IVwDNHYigC8ugK0bfSxepxdxeUoKy?=
 =?us-ascii?Q?ecuBspqy5+uG1eRgj96dSCNuAOH+w+v2V3ycelxfvLoop3S2iX5x0vmuky/k?=
 =?us-ascii?Q?1Jn+oFBfoFKYa+XNDfWIGx4Fsgx9CS6XBSBTcTgfiuKS6kvvsWAmaAIVuim1?=
 =?us-ascii?Q?aQ9n4wTXBlk4HXFGOfOpC4Y0IbmlMztQmme921FfhMJTCWL/ysoBG9c9uN0a?=
 =?us-ascii?Q?BoK+h/vhj+53SHyTEuL2FbkkGO+FTI2L0atH3+1qh3l2LTBzuwPHMws2GH/L?=
 =?us-ascii?Q?IHg+aeDDxDUN/xYMRv4RbrAV6vJl2mVI3CJt32MDCKHdg9mE687kkYT4h/jR?=
 =?us-ascii?Q?aGU7Zhha/iONxur5vQS6VGS6uWsZTntQuf0O/6RWO98Zi+z4Niq+UgU6ZUS2?=
 =?us-ascii?Q?3q/Gv/KKM6P2ci/MIo0irx4tdLg3XwU4aUj1DGQC3bP+ULeQLXFvA752+Ija?=
 =?us-ascii?Q?WPMnrBSZhR4DJtUiu1PCImLnzAymavvaKB88xZwIXKM9OnQ/zAYW2XCsepar?=
 =?us-ascii?Q?VftBhabCZ2bu23sN0G8lsxoepeK4z7cgL0tiPJZOx7cHRMNufqqxmYvOHbNg?=
 =?us-ascii?Q?ez0bdjNuS+o7K/iw8ce3XmRGpTKIlwhmnrB/4EsTjHgUfcI+R+9ipSN6pb7Y?=
 =?us-ascii?Q?RNAl3tHoJA29Hz78l5t0iwIL6H0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:48:04.1722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8a42b7-cc05-4d9f-7508-08de5caf3cca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464

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
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 156918ba5ab4..b0964f57e8f2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1777,10 +1777,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_phy;
 	}
 
-	/* Perform cleanup that requires refclk */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
-
 	/* Clear any stale interrupt statuses */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
@@ -1853,6 +1849,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
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

