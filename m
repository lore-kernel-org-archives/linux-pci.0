Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563316;
	b=HrrctwgAELmdcwjm4UpZLeAg2vHqIzpJl6UJqWc0Lu0MxofRyvuAmk9OIelHjfh5ZEWk
	 xNVqiP4kjS6grSnknhOOD2ml6l/mOZ+yfBDs+6hD0ppV0NGvihXFYWQPKDFuVc9Ohave8
	 AX9CCium4XML4eB3PELe/Phdd1KWCiP9VLmbw6Hxm+c8YLaXpVZ8ItumMJEsK5sF3lzor
	 TyUUWrdBBAFlN8mZxSh5b4u3Kkp8EHUvNtYK+h7fwvrpOIUsnQZjwOfztDoy3P8b+UI94
	 crZjeSNkhqomvkDuC6SOZ0hjJWvkSN1T8RhxIzqLcHhmjcKvZwH7uhwg++Jg0b0eEKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563316;
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
	bh=99eF7OoOCPvNXJ4LbFbcO1dHRR7kIzqZCOmFkDgb/3k=;
	b=kEyXRix12oQBJg77YQZfjgfB3IeBjN3bTrCu82pmWBrKr+pw7894rccokejwzto3tPhE
	 EMBmW5olrUx3uNle45uyjOcMU3KtJB55kGaQUECkOKq/j+HpVK8yts4zfxOnhZaFZzbW+
	 CMd5wJQ1bTV43X+OsOTVnYmEqd+tVRF3lIFGCXpcFtXmSPF6yI5HHPBZCQHvbN7h+nZvI
	 WH6jb3wfgeewsUMqm375EudiQAlISSWWBBQzXiXqr8j2qyauC6wScC6Yx9neXi09Oe/2f
	 Q1+2y0cbZWc4yP2e7+t62Ge7A/dJOq4NSfjy5MU9c5WJXTmRsXc5oRqa2YLNkUZLXeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=raFSBt5W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F50606A323;
	Wed, 21 Oct 2026 06:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F50606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=raFSBt5W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERDg1MH7tvHKrlmRJToynaOWaUsAqd0ehKf7F9pK0WHUq2d/qIqYvajgtH/sbWfW1+gT1mJ5EK6btpINkeWQo3+cUmnPdM4kAQ3TuAs0yvd8GqL1aQ2IDnNdE3n1NcXagYrJYKXno5+8WRettpaJKnQrjnHxmUWZmz7yLfbp54x4sR5VysQFBU50w/eVUJs8JnIXskwvb8Bre+Ii9O1a4MdeACtzcyouoWnJlIOcaQTVigo/lIDkjy6r4F4roHeq682RTIdtbcToskIf0t55H6WBx/95ccJKfVK2qfM+Z+dSfVgYza0tot0knzLfup7Pv59xgW1HJ+jxsQZY2DhlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99eF7OoOCPvNXJ4LbFbcO1dHRR7kIzqZCOmFkDgb/3k=;
 b=vEPaBC8Iznwv8MxUt/lnLabQPa5VKzGgo1dTpcABpvJwVBG5wsXEqkJcKZDSt9V2uI/YmWrRtaSvC3H25hBdNBdqkx1Ds6/bhavnMbLhBLLS5t4nFqhYVo0wgL9gN+Yf506aC/cLeG3OsoWwFEjsvinfdTcZXN9WX1kpe8f95TBtQKkkNQrBbMlUwTNL55U+Eka9vyVxoGuBNsZ7iAnp27coGA5tB+cHfMC/aG6N4hNEGnXFWssoFHh8V/8hudSug5guV67dRgPfOtQd/rCdsRgQ9G5CN9+wXhIBa2oEBLMJiXklKcAkWSHqc06aDdes0HPADUFLytd147ChkjF97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99eF7OoOCPvNXJ4LbFbcO1dHRR7kIzqZCOmFkDgb/3k=;
 b=raFSBt5W4ft2Kd746tqKA5dbIFUXsvs8S8GIwazvP4wnIHK41QQyMGgOnoFzlwsY8UxswKMiGInbSpbecBQS8LaKFnPeWf0KjpXjAZB/EfUEaqVvQOuOYqtzksZLXR8zlR6fV29WVLjJuqbjR2SKoXfvXVrZ+tzvIB7GsuVpInPzYspb6xGx66PqGi++wEgEzuCsF1PFjmXXqPj99ES8wDvamTNBlr86TMpydSGNnR3vYmwOd6WtZr7h6VvHHc0/PGmIag+321GUHtJXLLjHiC8gqbgevoWcQM1YxznQ0oqnfLrYGJLhfsaANPzriDemOy6V5SJjVCoVt7GSSlHpYw==
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:15:10 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::8b) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Wed,
 21 Oct 2026 06:15:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:15:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:47 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:42 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 07/10] PCI: tegra194: Always disable Tegra234 Endpoint L1.2
Date: Wed, 21 Oct 2026 11:43:46 +0530
Message-ID: <20261021061349.1265704-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: c018a57c-136f-44e8-21de-08df2f3aa94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pQaHHmvdxZTRxUD8QeLeprlW6cBJJai0EhqjcHVvLKdJII3QA4lZzVtFRzJssL5UNKkDs0Ca59KcyCGOVTXxkYLQsbGsbnzK0Bm99JMd1UD5S+O+Bo5H9z0F4JRMO3r1cFeGCH+u4iCrJdh3cOqnK/DUd8DGzGcV5qdzgJOvZ5Sl1LYxiNaJvdxM7Zfi3ZQLvJNhoxjGhoYLLtimdRkLtEi7C0v+fgV8dbtQkQ+JCFshNgfhKPzbFAjb9NWOiSUYjweNgebGA2xAZGh3xOubm7zZxXGxhsvt+QvjCFf09K4joubmHL0rK+tu/aavbNRQlxrfo4DnAwQsmIfnbc0UIdmnbAlAI/gxv5BzblcCyiGBCJvbNF+f6WsF7M5aRPuq2FHTJ7lgZOp5/+S2wo+MwiojyNe7Sf40NaEK0MSyagnAzrgdWqFmARgQ9ELTe18Tfz/o9OT7r+/XUb21Wqd63R2JzBaE0wXk9R3EKbm5HnYDzVvo1Z5QQAWiHEYKfkWE2pD++mDfTUJ2t8SiMT7pdBM6Y+90x+wwRiu4H+uFZVVBRE2WdNaioJ/t8ZGtor8O96ovJzg5RHFlv+Z1TagimkEMjF+BYB+LuSjX+o/sP/dDogDBD3bQTvgU9kStLekc75Ao/qyNjwUpadWojgfcpbj9p1zRx3rSMe22IORo3/+7sB/kNCREPKSrl0pbx8TdzD5A3lm95n97xVRmM6MbTA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XTCJ33VjkRPPBop6yhnV3EUSIL6trlLo0LHRqxvlDvnOJ3wN6XOVD2UstqjUG4jVFpSHo7hmXQuRpxxC5ydB4NRb0XoHJWrgehejZYRyvX9txfPgRss70VrZ7XtAvHFgyaC7tuJ8RBpCKXRQcBC9hd3gsrKq70jI7r0RiS8ohscWKU+W7HMMhfr3aaWJ5bKQYHA3ax1voFlmYFhoUovVQKMJZi6+gEAnG5IlIUOMAisVu6QBNQj0e7ZM7SNtpkulWj/5rrBZ+7sNWb8ycptwBdx2tXHq54hvr05Zy+PRXwxgPnQOdKYjTDONE7Ztlif6Q+Mr1a7Lkuq+538Q3pYkw76vlJKVkgR/rfZnWymd/42HcutaHAoL8MuLD/AFCQOGpAK5LqCZRXnFN9gPepTmRlW/OU+FWUvGpgSfXvUglSsXcQBaZ8I1zA/RbzHkXCEY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:15:10.3666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c018a57c-136f-44e8-21de-08df2f3aa94f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

Tegra234 Endpoint mode must not advertise L1.2 because exiting L1.2 can
bring the link down. That hardware workaround is required regardless of
whether the endpoint kernel is built with CONFIG_PCIEASPM.

Move the L1.2 capability masking out of init_host_aspm(), which is compiled
out when CONFIG_PCIEASPM is disabled, and apply it from the common
initialization paths.

Fixes: f59df1d9e6bd ("PCI: tegra194: Disable L1.2 capability of Tegra234 EP")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 47 +++++++++++++---------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7c349478556d..0e6224b6751d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -611,6 +611,33 @@ static struct pci_ops tegra_pci_ops = {
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
@@ -694,25 +721,6 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
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
@@ -1903,6 +1911,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	config_gen3_gen4_eq_presets(pcie);
 
 	init_host_aspm(pcie);
+	tegra_pcie_disable_ep_l1_2(pcie);
 
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
-- 
2.34.1

