Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618917;
	b=QDt57NyBeWeFPthYXlVDziminCQzUzkBLz/TZXFTfSsOVIR+UrdYJZzvgTnlx9znx2nW
	 7oZ8dXH8FJw69Evtj4NaCErB+Y76Lzua/w1p4XEvnWrOnk2mxvVVf3ZGCyFDUi+YWyhFA
	 QBqG0hZvsKOg0Ug6Qy1WTbNVVp3aMihozfEIpygb3qlbM0Mmf1sGcgg22FzHtbomGk0uE
	 yNLnRTjGxWqQO3B5yVjRRr9uUC/1K6aEVjyVP7MgtgKqTSQdzt1x+vgGlOtygPcn2DdaV
	 5gYRXj1DEcPSz7FXZBb4L+TcEhjI5a+kcdArqnw+TC1om+M7VXWcbP5K6tRvsSFYlHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618917;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qFsfJUC8Io8fbDJ/RvHeDzM1Iu4tAZ5ZkSTByHilyFw=;
	b=JPrYdQyh87Y6FJNwasg77TfnhkoPzfvkO7D6yvN16r1sL2zfjiPMBI7kCPKmIVO1KAHK
	 enSxTAYeWiOL3SyX2SKNxUrJLEpGkAIWyexqLAAS9xlrooaNJErBmvA/hu5OG1ZXZB/b0
	 gUPaAGIKDsFIdpKRu6dNzjqFlKw0Z+7mZRHGNSxKjNDWlMFssdiNjRDZD6jqz9PvlTKTX
	 2mfarRY5mlWSR2l2IzFOYF4tPv6loAPm4Ve7xve7sgZAYF+2ERxjanbrRnGBiMxJ3dUAg
	 bvIr4cW1Gd/nK6asr4kyNMePMvt5LcMbmALCUpv9P23YkHAsT2jEbKcg0SDRkULTWaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LfoAqVAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.59
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C560A6F46;
	Mon,  2 Nov 2026 11:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 752C560A6F46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LfoAqVAU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blok02MZq6Igef1cYgcF6FXB1drvKB2KwsNop2YHLgWN07aMeR56cVnFNDKfLJ+gnDAR7VwlvZj/+w7d9kyMr+rBM06qKaJC8VPl3WGfuN7wmOKoDbaK1eLm8M0v2/ufw6JF59zF4HcViyQww6/a4dmNeAvq7BeGNOKqAVm6NTRMrGDNJYC1Rm+8oLKNfakcPbJ3Xpz+SGGsNZEfMYiGx231DH6sk6gXvZZaleO8gHTYVo6Mdi5eOWze/5HbyVzqAq2K0uY+gG+mnhDohekFDiobF2PRDF80Z3vpa/5kyZefHKTpLCkW86+psmLzfyeJzVPYjNi5/o3QMnOY3+Y0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFsfJUC8Io8fbDJ/RvHeDzM1Iu4tAZ5ZkSTByHilyFw=;
 b=zHhqiHs2hdzvcD1D563hehB6qOM/uL2faPUVaP9DHDfBV3+nHw1pOmYoU6frPYcarsAlhZhDe1U9+MVYc5kTGycp3vDVcRbUfS1SklebpKC39ApjEtQGSR/Es3bmO+DFeHDZC0ioAngf5XZdVAGG+H6Qatj+ehhJqGcIhoXdNUcSE6aD4PpLshIVA8dnWWHm9TQ1/z8VRV1/nZQ9SzU+NTpfBXtCj/LnTnF6gmqw1BDjn2AQoNs6uvtIWYf3kHFRf+f3l3vQPxuczC5g/WdFk+x5xRjaWMnyB3UScRtZmCPf7FPquzIfDQF7aw0+ZJNcGFzavXPEc2KxM7hTJmVnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFsfJUC8Io8fbDJ/RvHeDzM1Iu4tAZ5ZkSTByHilyFw=;
 b=LfoAqVAUQKCi2sPKhjsUyhRHPG1nXnlH4XgVq4YEs+Y0IBcO2uDJ6cmUCXgjBFiuZRIcyXLOes2N62+QCNBGR8QiycowgU8Nl2HZAMafCtdao0gfzlY/dMiknQr+HpYAGQBC4WP1iqw38eV0C/JFT6PwBBuooPmn4xQNgZ8gKJsLAbERAv1jcw+d0J5+QMxbyEA8NQ5HRbczpSKm17HRhg7B80UOj4a0V4b//AbGcx6VbWOF68dVwj+g6DFhE7YWB+11T1H3dd0F/nklJnnyPs355P4TAbDqw69bZJ0307LNAI8Dylm+PtAxeF5Gf0snvx537RRZEg1sxQV2fTh+tg==
Received: from CH2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:610:58::13)
 by CC6PR12MB388577.namprd12.prod.outlook.com (2603:10b6:170:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:31 +0000
Received: from DS8PEPF000000DD.namprd05.prod.outlook.com
 (2603:10b6:610:58:cafe::3c) by CH2PR20CA0003.outlook.office365.com
 (2603:10b6:610:58::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:28:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS8PEPF000000DD.mail.protection.outlook.com (10.167.23.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:28:18 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:28:12 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 07/10] PCI: tegra194: Always disable Tegra234 Endpoint L1.2
Date: Mon, 2 Nov 2026 16:57:16 +0530
Message-ID: <20261102112719.4022633-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
References: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000DD:EE_|CC6PR12MB388577:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f63941f-636c-4e5f-4075-08df38d46c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	BDBfdwOxUau9i0iP7JGq2IPweqGdnJ9rdzKhuOoZanXikEhO7ZYsp0H6WTijINgVN80UDOfZ7f/Gd/3KMKkNu5xpVyifyrsmaWpoYtvMPXk+njmbhzxdVfERFbiEJ8/9mNqFTm1+mi+4iojTjLmazmkgFwKuCBJXVCw13NSkMR/g8hsqDpfjsVBJdk/dYlSJ5u3+pE27FC3F92h03xpiZDJYejzgs40UQY8Ycd965BmWKkzPhGV4ZJtqeMfAPdXRxUQhanQ23Kxf+TNHC5gZ5ai1sJgzOJS/VaG8k4CGYVkSVa/AGl6+PpYm0Uwma+IbOtlzsWWkpEqh+1HnfDRZRRvziuB/v1rmMpG7qDx5qGQfAYJlgGeZqCNB8LXEID2EIXuSYnvzO022+AVdVwc3mHLKZSzKVYfi5mY7h+r0asNIE4JRvjB6FKl5wcZR1sRFaLltSiWyX2ZSeLST1rH4H6OPHib0xihTY6IFoIjdHuOnguvqOg8k31TLq0azrJ46xYXg/HEqI9aR2V6kM8gqESxk8PMTZrl6WCs8HbubwK2BUf9uG9mYbGdc579TChCHy9tkq8dhLJuRwZI4zZqREerlsSA7IGcKtNi+UXdC9Uav8ysUyKMBrxLmXSXOBxtyxu+lOBGxsceuKLZXw4yQMEG+bSnwHUDN7Ch2UngXB0/iy3QscxPIdpuoSPI0e81c0HqoP0Z1azRyLtdEi/7n1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g2VJJ/FbqpZ9sKqhjq16hJtdQs/Jv926kYOFtADPWCkXf2QNjoSv/W2S0D7fAnjmoz+lnIaMs4atNexunjd/kTazY8S9Xp5XUuugdsUNy7uSyAigZ3Q1xsQAW6Rbs65qW46UFNm10uwxE0VxtTjvqL5tMQ7U3evE6Us3xI1sBKl06Mq9b+RWu2+IBI5I1zC8MOay7jYPguK248NXacz+BxL9Xm8y9LZC+s3rG4FcDsEw4+N8oamfA0vbxs0mjBgGVczHzGlvdSLXuhvB4+NxyIm8qLJbfTBNKgw+auKaYowOBus8iu3heMi+JGQool0kabumzWf5YLYP4bpuZ4k/lerH4hATCsL8twIuDVEzoUeCoS8lzdMwWfEiEEUK197LRROsZ1Xg94U5XsQ5i/SmC15gfsMW1SjsYRVwOdY99xQdTNl35svRahqXrz9FiS6j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:30.9156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f63941f-636c-4e5f-4075-08df38d46c44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000DD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR12MB388577

Tegra234 Endpoint mode must not advertise L1.2 because exiting L1.2 can
bring the link down. That hardware workaround is required regardless of
whether the endpoint kernel is built with CONFIG_PCIEASPM.

Move the L1.2 capability masking out of init_host_aspm(), which is compiled
out when CONFIG_PCIEASPM is disabled, and apply it from the common
initialization paths.

Fixes: f59df1d9e6bd ("PCI: tegra194: Disable L1.2 capability of Tegra234 EP")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 47 +++++++++++++---------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c1b666833754..0ae7adc16054 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -612,6 +612,33 @@ static struct pci_ops tegra_pci_ops = {
 	.write = tegra_pcie_dw_wr_own_conf,
 };
 
+/*
+ * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
+ * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
+ * powered up immediately without waiting for REFCLK to stabilize. This causes
+ * the PLL to fail to lock to the correct frequency, resulting in PCIe link
+ * loss. Since there is no hardware fix available, prevent the Endpoint from
+ * advertising L1.2 support so the host will not attempt to enter L1.2 with
+ * this Endpoint.
+ */
+static void tegra_pcie_disable_ep_l1_2(struct tegra_pcie_dw *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	u32 l1ss, val;
+
+	if (!pcie->of_data->disable_l1_2 ||
+	    pcie->of_data->mode != DW_PCIE_EP_TYPE)
+		return;
+
+	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss)
+		return;
+
+	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
+	val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
+	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
+}
+
 #if defined(CONFIG_PCIEASPM)
 static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 {
@@ -695,25 +722,6 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
 		if (pcie->supports_clkreq)
 			pci->l1ss_support = true;
-
-		/*
-		 * Disable L1.2 capability advertisement for Tegra234 Endpoint
-		 * mode. Tegra234 has a hardware bug where during L1.2 exit,
-		 * the UPHY PLL is powered up immediately without waiting for
-		 * REFCLK to stabilize. This causes the PLL to fail to lock to
-		 * the correct frequency, resulting in PCIe link loss. Since
-		 * there is no hardware fix available, prevent the Endpoint
-		 * from advertising L1.2 support by clearing the L1.2 bits in
-		 * the L1 PM Substates Capabilities register. This ensures the
-		 * host will not attempt to enter L1.2 with this Endpoint.
-		 */
-		if (pcie->of_data->disable_l1_2 &&
-		    pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-			val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
-			val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 |
-				 PCI_L1SS_CAP_ASPM_L1_2);
-			dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
-		}
 	}
 
 	/* Program L0s and L1 entrance latencies */
@@ -1904,6 +1912,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	config_gen3_gen4_eq_presets(pcie);
 
 	init_host_aspm(pcie);
+	tegra_pcie_disable_ep_l1_2(pcie);
 
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
-- 
2.34.1

