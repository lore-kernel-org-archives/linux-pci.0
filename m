Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3242368284;
	Mon, 23 Feb 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872251; cv=fail; b=iJk4zMTeXAEb1aG2UlRc77MbIKpHhjlvfzkzBuPz4EVpCVgGJgiSgt4UI7AKKat1M38d++NeCiUAIneJ4e307Nej0XjV+zkATL+qBDDb6GdYt2SEIATsHXg8ha/VTlxg2Zmr/tKO+pIA9Cdbuzra6SVVUR2yN0GYgwv+cp11678=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872251; c=relaxed/simple;
	bh=IOa5Cg62wYhMAZrb3lHPKiNZdtdR+DsqZFqv8UbnXBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrGxrtEqU+/lIcue4pdnIIrTUKf8JaW4lKiB6caTg10ob6mDQHwjrjeIQ0hfg/iuRtrpIDwnJJLh/++nAHLMoU16QHEgslMNAEKtKAm3P7EnU/clV+eq2/9sMslyVS6gp6ew+kWsrZJWQDrMWKHrlPnzYKslEhfgAVE/h0ezaX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUOr7uH9; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUOr7uH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrPDsay2w1GzRMGp5BO7cyegM8tIUN5hpP+l7N1Hz+F9OyX1XwktKGgEem+gTaMz9sFomWJp03v2swVqxaBpqCSXZoiV8OgTKjVkk6MWfw04AMjVX2YM8dgJs34lrO6sHPU/HF5mdUkNdLt3YwaYjG0yQTQy8NbV4rBQXIMdA0WyIppnD1X6B0QO/jOGBg8H5hf0+ljo24hZirnbdUFeWdM6olIVfTMbYbd6QdNPLW/bdAMFx2B6qJcZxciLSpWGVXkxOmFxhnsE89aptwu68cXLz8HzO/s5PioBNdk9aAh0dG1XelBxoAUu3qMlb/AlOHwcIkD+clz1d/rfBwknkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFGgpNc/nYPPxuxS+YTDLBWzhWlllxG6KwtwnrZnMeI=;
 b=iItVZ9tYl1qvT7KfesONei62Cf0RhScvbsBDHx/nYYFmb1FfYc71UILSY08XviBBAn4lY0bows3lUikfongMWSTqCqS9u1r7uc4w875Q7YrEFIPx5leVKxPzg75VJ2604vMcoKWF/8WOVPuPGg7jXEDPlQpfsWKe9KqJbvZ9hpELeeH7Ob9ofq94Q9/M4OuzZOxXJHKTXSi3NOt0IiUSYXpx9NwTJ/Ley2CS+Xb39I53uPgioMbiCYGUPRzeK8e2d7lWvPTjGXNe2fVvohONRFfQqvjxcvg/iD1eKCBTltvSxbITZGBOueXr/IgZbKEtp7KtJPNGbiKHlMWtEnMtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFGgpNc/nYPPxuxS+YTDLBWzhWlllxG6KwtwnrZnMeI=;
 b=AUOr7uH99iziKit/d9CUmZpAaJhkiFXNg0GyFeqjL9gleF2z79ON5miL+9NMkfmRTSJsfkTj9JS8P75rvCsi+R5fdclJeQGw3//URY0QIq5qDezP93L2FCfWqWiYQ1SDoLdU0uuHsNSTBRUT35LXj/Ul5ZS5wOCYPHbj9SE6Xc6yAM8sjrRiWNeACvtHMZtflNQp2znQEOZiQroHBRrBfx6Q40T9XMfTG5vNx5+malsBWcoTm2L0j5N4+YohEPZWPh2IJCEtJQkmEhwjHW68YojFIwXBinWE9HupujWCX4EuG+qAuaxtJoASB1FDbfY8nSqBkUlPfSAGmELywBh6zg==
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:44:03 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a8) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:44:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:43:37 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:43:31 -0800
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
Subject: [PATCH v6 12/13] PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
Date: Tue, 24 Feb 2026 00:11:50 +0530
Message-ID: <20260223184151.3083221-13-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c9080e-48ef-4da1-1f43-08de730b8390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CI8pYjvyvbem+uS1nGZ3493vqPaIjQ+sWfCft3194K7K8ldY28vqSjkXe5VP?=
 =?us-ascii?Q?it9NjmuWYviYVMk7ZR+iCL8juJb9lv+Pu8DuhL3XtKZdT+sEed7OAHwGAFPP?=
 =?us-ascii?Q?76+evGXxbNxawB6dlwAkwFlpf2aoWPFvAodebcFqvXBqM7svK2qVBqoQIdE5?=
 =?us-ascii?Q?eIZS9xm9OVK9wr+/udgOVyxvTtzLd1Y0SOrjs3cWpsUfiXv17J9zh0NJzsRk?=
 =?us-ascii?Q?pOUsNRUxg20cEa75DUcckUon2VAg3dI0vIiS3PopjEeq+EUJgPYU4eYff2Y4?=
 =?us-ascii?Q?JpSfuRzXa+skpZPPAriiPKrVN2TZK6azjl29utn8KVvUN8rQ1C8hv/iKIdxf?=
 =?us-ascii?Q?0alWaKWowD8S7/0XF013N2mjGo59ngxsp2HxUaQcvdcgBu/YMYV+ziAwi8EJ?=
 =?us-ascii?Q?3Q33SwhorB7zdZEObvYtJy8iYo7KVGT+H0Oec5okcXqo42crQpr6kcotuNXq?=
 =?us-ascii?Q?Gw0z3BiRoM/PMgjdEzpDNdAlu/vu5kHl42TLSf69CE8B+mo9pNbFQof5nfQ4?=
 =?us-ascii?Q?D8fRbPqaiUe9Ewx9O/3TxAs4ImWzmmYvZKTuR/qzmsa1bgJi3dIQ0eaf1ozC?=
 =?us-ascii?Q?f/hKqlafeh5oflqjgL/x2Ed7Aj117QAeApul+UBT/9bIK5VitxCYTJ40jnfh?=
 =?us-ascii?Q?fkun6+rRBchntHB8KAPkWZxNMH0lTB/Fi/k/hjmzhuMH6Oe4YYDaqiQchGUV?=
 =?us-ascii?Q?aW0gn5qM1ecIfMm7FNz51izUZuhpY46ZkBUzQvrWk5zjn1Uj/VhQ6dFD24Ub?=
 =?us-ascii?Q?MmVDyOveIbDcNa6KEFSlBJJHL3ioT1Wje4DVbpzshgArS4FsXZGfLTlfvzw5?=
 =?us-ascii?Q?iX8ll/LXeR8XguXB0kLlASA6YPO/iEZCTu8iO0bwi4QyGAizGZDsa8rW+st8?=
 =?us-ascii?Q?edZ/cWitzWxMFOCJi6YwSi6LYjHYQsJiCwZMkW4VYlgHs50rWt4iCwXqu0OF?=
 =?us-ascii?Q?pcXQw5bW8SN13g1j9I7LRLwXDFJZAKlQU6w0SB5+Q1acBU894TFTnPETe0bm?=
 =?us-ascii?Q?g6X3/aYM7deF6uZMyiDSk0he6ZKgyo1tC3mHKffyOxd5RSSIWIsjhFkEMZrS?=
 =?us-ascii?Q?FiHbK02pf84IdSd9e9Qq1C8liuKOgsGHQE3tsC0GVzUCVnnwxireyjxv6agp?=
 =?us-ascii?Q?j6jEqpJQdVuPOSf3TMDCidKERMOLXO259zWBAyV2OHy1eeBVGX+corQSGstR?=
 =?us-ascii?Q?Nc5NY0vN9qBOcL39P0JIWYCOuI7wnDL9+53lt7qJojvdvwcSmlaO9QAOYjb9?=
 =?us-ascii?Q?TrZJnbKSkIUPPESJCGAiwLvVA1NiaPTE/CtKdtlvXTigI+f/JIkRF7D4g+1M?=
 =?us-ascii?Q?omYqtIOmgtH0l4fI4nKe9ZGWXTuwTYPtsM8T6CGyO7qM1CeeULG7OGLSH4E/?=
 =?us-ascii?Q?gxwhoBF+A+llXZA9lyu/gLtlGH5WwgYbFrynV3XEkPlVXO2dbG/Hu8scC8mp?=
 =?us-ascii?Q?/PUxIhmrWF7sFU+NG5NWIE0vliNY58M8cjHF1L6cwjNnP4MRU0vAiIqylg/H?=
 =?us-ascii?Q?0tfGZSLhNj0/9zWYzOd8b1A6Q5CKE8iEdv33VstOr26TQzKroIRdVxmNqhlk?=
 =?us-ascii?Q?qRsDaRX8xk1vlfSFRr8YsFUApU+6afjROINVeaEBv6NCIwagwxb7808ijixp?=
 =?us-ascii?Q?8kG1czIbay63RNTkM384Wbw9VY2EK2IRd2rAIbhRqMdB4KDw01sU8pQ05nbT?=
 =?us-ascii?Q?mEtK158J0l1Pew3O+J47HO7gFr4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SI6BDsVCAJYN5N/Ya/Nj4aLd+jrW4MygYWWsJzvv1H9fj6yHU+mY4Bx1qNhh/kgrUOjHtganZlYj6apTJhvJHhw2du0A+8pHl6QMHqxUpV1UfyJROCMkOIiF9KQdJEEzQ4dOqwjJylEztUCbUaCSUpujf0Z4T7ZSZIDiVpJV05VCZZ3i3NVVU5Chqp/pFk4s3B+nxJV978QsHRqbhAX3mL0cFep/4rCFOSZGkcJG4rHpZAktUQ2r4hcagKd3Q8PHhRzArbCStTdhKv8U40513tXldzgKxw2vqnKb9cVelD14Pae3lc+X1eI4L8VKo4PTgiLqYMIlH8aJ503P5UusuqNqADN6SoDSmir6bRn7mQlT1kdlssQbyj3kP3t5JzDCi4/B51IKytEIRT/2TXEObpICQx7sKBlqaIY6M4n7IzNd49XMfYqEZXazjH3mTobw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:44:02.0840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c9080e-48ef-4da1-1f43-08de730b8390
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

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
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f107f2eb98fd..256a5d1eba16 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1729,10 +1729,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_phy;
 	}
 
-	/* Perform cleanup that requires refclk */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
-
 	/* Clear any stale interrupt statuses */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
@@ -1798,6 +1794,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
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

