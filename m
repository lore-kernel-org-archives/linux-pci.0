Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881A38642B;
	Tue,  3 Mar 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521162; cv=fail; b=lf0vmTXc3kz0g02GNSXahU54Bgxb1cuiEnyHVU8LOTbqhX6O2eNMyxp3eYbrOhq9WRdwWlqCdl2TeWSlK6aC8ju1E3xFoF6RQ2LgHqHrId/vjCsOjqfBk6OPoBOn7OWBn/RKs67ujooCztbfLjoww/n8nuyBkt30YdCBac+2DzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521162; c=relaxed/simple;
	bh=SNlv8mAHCUs4k3Vy7oEfwE2TAg16S0OEeTi0Duma7k8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgKjSuPhBJFyxMGp2qNNauqllSSU6f6ek7oI7GDhWH5bEM31cTB1iSFcvQbPWlNJf8I8Zx+Oq3FqCQ1SVxcw+aa7p2AjIE/X6hbeE++yEb+XfJ3xOukChXzOqIFEQhfun8NpUbiFV3q2fbT//R+wTV3I8e/nYws+10uAY6lnmT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U/wwgeNU; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U/wwgeNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oaey0jXXrZt1ZicdgsWZWcfqb8zJO4hJcGPKeXZqypGKBUpKucN5xjdstfaoxYz12/O7OwXhSTH/ZWfW9j3H1LItU2uBMxKmZ0AdtFXGC4RJ1eW3j1/gN4CqgoqEGwRNiv97qUOxVyKxb0VZrFL4d7nUxIRSo9pvICljNnuQGot9WCxDyakXDytXPAxYhulig9vgaRrJipqRgI57BdBbaAj/iQBPahIf9aNve6q3CAv+83jAkrUuNmmooapW1sjysx76JZ3yypmrpLVqJkopgjh3IjC4odD0sVXKV2N4It+CmRddS+KRpANzYn7dX7moT/v1uGoQUsxSukjP20lS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9hd36+h8SW6jMvIEVc+ta2p8bFkLwOAZolDuZPv2k4=;
 b=qgycWy1gyp0KoYih7YUC5hozyCzRDIj7kMtDMzmlSf7zL45uC9n07CKx/1lJoUx9Po+YcKmQDVWJnPF1lzJahQ/bIdnb0xSBY7XjMulxcai9vH0jb6Z0RNt+LRQNZkRLbBFh36Sr1Zb0lq88iBpKRvT3gQze0+Nu6n+2VOwxXLRl4dKAavX2+nA4r1/AAjvlX7UPauwrppjwd43CyE3sTEBX+XqB3j63rtjcHd3ckiaptOTrhc10XbBt/a7FW9krkz4JrWvnqZ8zMlgygkb7GoSEEXNhREUGGzs/ZXSvWW6ErCrSGXA4/o+5KrU8NSgoGgUZTKWt9fqCLZpDiziswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9hd36+h8SW6jMvIEVc+ta2p8bFkLwOAZolDuZPv2k4=;
 b=U/wwgeNUDdXq/7hpfdTwMJHd6RGkhSV4mA3SdV6N2uN4rtbuaG0BIn5EoeJroDa5HS0iGHDmAdkf669CEr531mFIfXExlI1Ep7vAI7Yf6uus4CdbJBpfuunZ4TExeVt1skTaXFQ9EwCH9XWZ+aIWxoLZFI8+GLUEONk19XgaqAhWi4WymTiFvzk8eKYGm7DyTI/X56eBUoNgSBBRMW+RW5l3oLrWX7w1usfK49BSpNu5ubrLTILtutFrMxmi5drUnLE2KloDCd5/+eRuAvH+YMtQcJimTYtPf6Qm2gSytrfTSak6PFC7M+hS1efrRpo7rZNPml77uFs+BJsIG+dQ+Q==
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 06:59:11 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::b1) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 06:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:59:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:58:58 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:51 -0800
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
Subject: [PATCH v7 6/9] PCI: tegra194: Disable L1.2 capability of Tegra234 EP
Date: Tue, 3 Mar 2026 12:27:55 +0530
Message-ID: <20260303065758.2364340-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6cfde1-dfcf-4f08-ad77-08de78f25f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	3ILQsehwLxs+04xNSq10rmjdUoKaLSAJZVLHiPSGO+jTC8BCO3D91tXbZgBHtA2AuWR13CHapTwvaeip2Gp05sjSSPbFr/rjyd/7KBz6cuaVg+m5xgt41zCdnySKStGkQLAA5KfazP2K6w2gKPIDRl/Ww8+QCaL/7QG9V17YxTjet1IctH3UsC2NM8xFSelGmBv+wG0JmWeFTlNfTMRk9vL1m4ya1wOR1lm1ILqQVfOx0nyOk5JJA0QiTxoGOj7ySO/plyTDWtlikvL8WY8aLDHP7V+uP8rbfL/I2yUYOsNjAPEMXgsefxyWlXJAjlPCZ0EEolMTgwPKsa+9BxtF9/OLmrR97YeX5GCWjJpLMqJX8Zwf4B23/XM1uu8IPV1J2PQ3Y1V5kD6yy2NXomz8TpHCHDzFyLPEQuKFxFzqwiPjZ55Vey8xOWLeHpaUU1pFUL4fl1yaubpyxeLGryB9ISsLYYvNkltmaxhcF2Qoxpxs8IEngpmo8Fx/Jnb5IqbhmY3CrAnECQ/BhUAkX7+qtaNVkIIE7cKzHk8lryvXotw3nuNyJ6PA+PaltdapWM/ikXzfBCn1pQ3BzdOjUKPq/dooZy26V9ED9Yc7kUaiBqFt1biFkitSeyesh2GZXW5AE4ZsoZZOUjrt/XPKJxJUZMad7cLn4jccwIpQQK+k/0U+r2PkV0939BUGspLFgVYYOYb0uuoIVBD5pGNhM/T0Gs80hgetzdoyh6MnWV6wKYUpQgE6nglcIEIgP84he23+hhdrBZpvQJvnHOIoONyEXqYj61vnCqpOLT/kN7jG297daNGGWxLAyxF2lkeWqqt7PdmEVUwySGTuP5a9tUNGaIvkf/0dkskhkHaWabn1WpI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FVJu5/MSXm++WvK/gm3FRWZ+KBE98n6qtPVgoowUnu91Yf933EYk5uKofrk1JddklCclNgFsyc/IBMTuXqkMgSx9+ia2EgsK6XlNZ+HuCAfFoXePGh323SalqFZefVvMerARkZLOtwM6fN6lgKCX74GxaePZTu6XUDWUVNsnQ+z3AmRXb0mIEbIFOnX9Djsf3nJ40PyWZkHzBSmmwWmGtCXoG5E/xHAd71n1HordaThGJ2C8HVDSalLItnvsY05TmCoMwKGkSMCNxkP1v1NeP7ZFC+e0dZ33VnmiAIs8T6xN6m2U5QYxErDb2pMFln6HVTLhuH64vNik4ibkiE2jwUdZNigEkPzaPQjiJSZjxX0Vnqdycv5ZrX/WqtVC565ykKmjabXHk9GXx1TGERu6bYeY1yzCQMIIf6Wcb7dw3l/x+ujqS4MQGSgHgpE6hMfV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:59:10.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6cfde1-dfcf-4f08-ad77-08de78f25f35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

From: Vidya Sagar <vidyas@nvidia.com>

When Tegra234 is operating in the Endpoint mode with L1.2 enabled, PCIe
link goes down during L1.2 exit. This is because Tegra234 is powering up
UPHY PLL immediately without making sure that the REFCLK is stable.
This is causing UPHY PLL to not lock to the correct frequency and leading
to link going down. There is no hardware fix for this, hence do not
advertise the L1.2 capability in the Endpoint mode.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 8f95910e99bc..070eb7f4058d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -236,6 +236,7 @@ struct tegra_pcie_dw_of_data {
 	bool has_sbr_reset_fix;
 	bool has_l1ss_exit_fix;
 	bool has_ltr_req_fix;
+	bool disable_l1_2;
 	u32 cdm_chk_int_en_bit;
 	u32 gen4_preset_vec;
 	u8 n_fts[2];
@@ -688,6 +689,22 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	if (pcie->supports_clkreq)
 		pci->l1ss_support = true;
 
+	/*
+	 * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
+	 * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
+	 * powered up immediately without waiting for REFCLK to stabilize. This
+	 * causes the PLL to fail to lock to the correct frequency, resulting in
+	 * PCIe link loss. Since there is no hardware fix available, we prevent
+	 * the Endpoint from advertising L1.2 support by clearing the L1.2 bits
+	 * in the L1 PM Substates Capabilities register. This ensures the host
+	 * will not attempt to enter L1.2 state with this Endpoint.
+	 */
+	if (pcie->of_data->disable_l1_2 && pcie->of_data->mode == DW_PCIE_EP_TYPE) {
+		val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
+		val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
+		dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
+	}
+
 	/* Program L0s and L1 entrance latencies */
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
@@ -2465,6 +2482,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 	.has_l1ss_exit_fix = true,
 	.has_ltr_req_fix = true,
+	.disable_l1_2 = true,
 	.cdm_chk_int_en_bit = BIT(18),
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
-- 
2.34.1

