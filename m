Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618908;
	b=JI7JRQQhhr9T8q1dflfOMCceLazmHwJsrQiBYNyUiwUwIfTfb+LZUp3hPrQnFHlpaG8l
	 1rTM2tMK32Fh/shw3g1BgVKdhpJ5m22Z9R7PbXoI8/xDYW6sM96g9zFLGBuhJDVH73IVB
	 7Oemv/Uuh4rw1Dt+vSIUsLxGLkA7bxqwLNcUFZtg2hhys9dY374It1QkIhooj2yQVKFUb
	 xwLeaCizCG9s75vqukE4xG/LpTZ43O716XfmOwOtk3ZGHu9PCOtrfDA31ss3gvAkMv3Vy
	 rTIUv2I7SUREidERgd9DWmBWUlj44FI2qr6nWugypV37J3qLk3+HB88Fx0uIxV3JzXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618908;
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
	bh=5UvgJnx1g3WxnrjcRxRKhgaM3Dpz7dx55IJm7gGXH1E=;
	b=ZyYgRe442+YakQ9jCWTXOVq21CXcZF5LwYDL4xdwjQbKecfXTcj7z3dY5UJ4EPwVadjy
	 Ce0zuGr2veckmRxG6CaGpGcTe0e4O9CRrS7xdufgcFL7FqIISYPhJrz+t+hMTm1SZ4J/F
	 BSF7R1fESffx3Q/Avf18hIkeoalCE7NbmvYqfSLsmopBVl+web7Oy4fWuEVCSRXy/w9ua
	 A9R5DXp1tTT7OTcMzDfLsl3rqoD12NvuKSBR2OepcWfRe/8gEjfv4wSbdTAa5t62AVFyG
	 kowTbqOXBk2dJPKpI8JPuWDMY/VGPVHs0M450B1fvi7/X2ueCpTR0V5rRNvuD027Xcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mG45urqq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.58
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F360A260F;
	Mon,  2 Nov 2026 11:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED3F360A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mG45urqq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhSGIj1y96MU8+0cK8A8H4q1CGxMC19kuDBIVJPonkFcMBFIV18/nbkAjzvX3reJliFMmaGgyzjoJzV54BKqi8ANf3R0NSHcowPHS0bnfoBwbhDPbaKQ1tM/RCpqCfr8q0MweTzIKdaloGz/dS+qKvJRbtM4dog2G+cZ2LmwLDckU/UcJlYZU7/xuMQXbjQE9LVtqMSO2sivCOqIFfIhXlAtN6V4PmBaLppf692V2OYIwdUDeISN0VI3eQ7WF4+hyJS/zG4ESIQIVAC7OL2HHLVtWeFOJb9gtoniSyEveha0vEIDCKgx9nZZGg/uC1wq5JDJH1fnO8fv5CFnG7KTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UvgJnx1g3WxnrjcRxRKhgaM3Dpz7dx55IJm7gGXH1E=;
 b=obBTvrRDuRS3uy2/YUd4n48h3315GDwvjg+1/4cNW3uqFwP+pGH8Qvrq47s2bEnPZ0dX6uibCMs/uzKZdGTAZyGph6k2g55RsXA3HaMbqNfu8/NaQNcfrcpZjo5oGj+8pBF3esYwP+kM6IawgWcxHZbryiyVrpRR9ZV+aFB+gtSEzHPtkz5e0qzaXkiC9rq7SXNJ4ax/VMogwHynita3jHsTV/blHxJCmvuSsw85KyrqwZda3hK747nPyVmpQ5Hv1Yvi7IRe5bkEgiIM1adZA5y+PJ1Nz5BmGiWCpl8Y+4gBANVEFcOpzzAGk8VX4DY249bxxhwO5s8pNVXS2vWOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UvgJnx1g3WxnrjcRxRKhgaM3Dpz7dx55IJm7gGXH1E=;
 b=mG45urqqxCcPrc2LzgeY2gR9DJfOOln1AdMuLlPrM2SywSpS+k3N7afRfmI4gjYcZxqlAhM+BgkqhMZVW0+s2I2cDcqdnXGIlbRiOd0/aLiKaMFf2Wd+yZUh8Ed0MovFDvxiFHn7jBgkVPaBigFI0ZQCZzyLjAXAm4u4rRTR63dxWWa81WmisFOoSFBK9LZ+bMLvUItGOE1Jj+Gk9sUdojLnCBTu/PUaBkEsiYcuzB2D7oDk88xLhlT8qOHiI13VjcOLWU1vTLCfKakiyrtgj5HY7/15SmcqynRPoA1VxWlkZvRKZcDd3L8HjqdPrzkHAwuoG+F4S5cmRIyAFMkTFA==
Received: from BN9PR03CA0169.namprd03.prod.outlook.com (2603:10b6:408:f4::24)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:21 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::2a) by BN9PR03CA0169.outlook.office365.com
 (2603:10b6:408:f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Mon, 2
 Nov 2026 11:28:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:28:06 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:28:00 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 05/10] PCI: tegra194: Check for 16 GT/s capability before programming
Date: Mon, 2 Nov 2026 16:57:14 +0530
Message-ID: <20261102112719.4022633-6-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f4790c-cb31-4868-92e0-08df38d4669b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HnWiutA3j2i7GnKSo/mdzHFLJMrbx0eTphcEjp1GSEfKjx9iqnAgSVumm5UDEIYufAgraJ7gS5mm4ywyJ9Xp06uFAyqHBgh87MF+zACqX+dcWwWFiGO4GgirwuWh6fLBN1h77SZ5hU1KMgbNBgbBJY5DD447zaE0s5DdHpy206taiAf4uLJudkD9QMVJlAOCblF/9HU5Ql8JVnk93ENpeqTjRT1h6ETuG0XhGw4sb6rF2BQ64XyNEUHDsS4h2ZznDQMJkXMdkvcI+tAdiIEJaZ3RQcNubIA3s9sp4GqlFBFNIkSPNYSp3ICGD0dtTSCb6WVwy2wiDIV9FzSL4f/UeHMa/n7CK5Yz7G2Dil/QR/oWg4HkU2zaJmMXmt/wYS2fJKePxyaY1mhoj529uupzNVEu0T3isFEDn5ijBqipgc9MtqjDte3DzieFqf2sHW1OADnfuiZStZdFRRkVSsvPitqe/IICJYC1dPozgr1aDotf/+JFAOuFP3jWp4RToV7R8UNnj4LL+rmlOBUdIav95PzRuBkbSWKvv6AgEukbU3n1ev3KMWrs+SkUzZoLWF6bYaStcWJlLzK4odxrWdaz1R/kUP/OGviC7OOOd1lyw/5ZGnsbYyhghHHLvuOVX6E3vcrUyF+PupvqH9X8nzm1KVDhf8j07CyrN8PhzbeNaaVoZmNNu6rqZ9E9Bh/QpYXQSHGEQs7m9R+1q2FhW9rDHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZMdRDFx0TskqO+5bBSfRrS6Ui418wmo9+M8GAvkmazt26aHf7NAC5iPkLlH6FZJR4M1z6tV5IFCZLDSBOBGEB5Fn7iGHxrYu1Xkg/voCuNQDf9r3RU5F4N0w4ocxwOgxwDWGJehhjcGM1rQxj8T2fEHZ8WuGbvw3EPbze7hF6LFzMJ4Wm+l8OdnX2aHQkdG57z3MhHMN5cCSV9Pdsl1EJxpalQnxPj30krynXtTr0UL61dCuMNUO4VGudry+zqo9hRn8tKMW7MZZ67BsZbIyXzZXLHOT3ZRPNwq7vEgga6RGxoRl72H4MyoG24DdSJe0x5YFkOABmWNQUXqqD4/joUFFe6CWHK7DMShiiqBU37wae/skil4O4FXS4Y4SKcU5f0MhXr7/aHwXu9u+0BbQ4XYXSTPaVVEDSSAT4Yd9lU5OO386RHFnSF6k7pgB2uaF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:21.3895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f4790c-cb31-4868-92e0-08df38d4669b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071

config_gen3_gen4_eq_presets() added PCI_PL_16GT_LE_CTRL to the result of
dw_pcie_find_ext_capability() without checking whether the 16 GT/s
capability exists. If the capability is absent, the code writes lane
presets at an unrelated configuration offset.

Look up the capability once before the lane loop and skip the 16 GT/s lane
equivalent control programming when it is absent.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0027c0adc7a1..4926fea2ee05 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -841,7 +841,11 @@ static void tegra_pcie_enable_interrupts(struct dw_pcie_rp *pp)
 static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
-	u32 val, offset, i;
+	u32 pl16g, val, i;
+
+	pl16g = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PL_16GT);
+	if (pl16g)
+		pl16g += PCI_PL_16GT_LE_CTRL;
 
 	/* Program init preset */
 	for (i = 0; i < pcie->num_lanes; i++) {
@@ -852,15 +856,15 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 			     GEN3_GEN4_EQ_PRESET_INIT);
 		dw_pcie_writew_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2), val);
 
-		offset = dw_pcie_find_ext_capability(pci,
-						     PCI_EXT_CAP_ID_PL_16GT) +
-				PCI_PL_16GT_LE_CTRL;
-		val = dw_pcie_readb_dbi(pci, offset + i);
+		if (!pl16g)
+			continue;
+
+		val = dw_pcie_readb_dbi(pci, pl16g + i);
 		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK, &val,
 			     GEN3_GEN4_EQ_PRESET_INIT);
 		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK, &val,
 			     GEN3_GEN4_EQ_PRESET_INIT);
-		dw_pcie_writeb_dbi(pci, offset + i, val);
+		dw_pcie_writeb_dbi(pci, pl16g + i, val);
 	}
 
 	val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
-- 
2.34.1

