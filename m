Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3D442B06;
	Wed, 23 Sep 2026 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148233; cv=fail; b=gIimqUrO+iuJzPBaXIgOHW4P32Y+6nxM7uEsQpF2MMAFI9LX+9Dxr686EC2yfPKR2iRxqlqCWTFfasdkP381+zBnLGA0U4Zh9Wj/Gmlv+lURh61mpaP5seqU8xCq7PvK+t1reOxjdjjJnDrQdlUskj8Gc4hYNnBXhu1o58nsaL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148233; c=relaxed/simple;
	bh=vINHzCcAdYYqth/HgLXfsxdUDdomlDQadrqgnf6DMq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnzkrK30myy5xpHOF3F87amc1C93rVATj2BJ6WZInvaQAjyEPGE3Mf03hTG8VatEDlP9+ObNnXQhehME8UcqYQqV/uuCtevHxPS2QsbfIsHfDuIMDwEusUptcb8D0Jwod2yKnNqypPiIaR58yLPG/aK6hcaxiusTby4gP0Y5gjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XdN/5Qk0; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XdN/5Qk0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szl5cIKrrYTH0QPB9TcWWpAlPIZB9LonfQWoFlf3iFcobJO+CPzpOkm/v6+VWEmHsO6P5HZ+X/ORyCyrSlUfTzuZfj8BCXm2/Yuojo0AM4TgaSoADGyZEtXNkOiMGhqyC0XXEYW0LabrR/c/BJzbp8Gw2i/ci/McelfDOYWPqeRHAph5Xb6iHcvBWj2vn3hJgrkeYgQz3gzhoHoIGjva56w55SZNWvfp39xNekwPCkoBF9VBGb2EpkAZ8kEauDYF1Wv5MpZRiAuqXexnOVIAR8rUN014x3NJL+xUfn1u3wtP2prnAM8M4Zfr9IItDnIoyyVk0RC0hkJJGg7WKxCPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTlfSv8tbR1YNPn4JIw3xCJ3017z80F8ttFnTh7MrwY=;
 b=aN7RovPHGsc7WQosvUIUNrYB9kAwU6Vooo/W2yZLWdslaaMuf5XNECPQZ4e786QBZqeKhM/2H3JLY0b89xXLoTzH9+Rq15m89naFIek3MCrm4RIDPNgBJ4be3DQMv/INFsLUnRoDUq/mW1SFU9xOdoEP6iaKU5i7/hdnzRk1eXDVnbWwMuzekVglD0m51B5gbKdG1RbDbF+6oUvRJJKURwp817aewx4iGMIwDeCJ76c9WQuPsaqpn2bDNexh8H5dDUV2/V3ndc2sSc86NQFhnJxRu0FU64JZXpDJzonRB4ywV9Zg4FUw7m2fKGb21thPmV3hgZqgE8Z+HmYa/LntFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTlfSv8tbR1YNPn4JIw3xCJ3017z80F8ttFnTh7MrwY=;
 b=XdN/5Qk04s0m3gkR/g2NwUBBLEO0X4S2bvSq6wUySBnSGojHQ7zbpZi/VqwLNcdzQyenx6XYZbtYC7RnmhyGfq9JqCcDvd43/P+0zzEkfdgESjTcNM8DwD/kY39EE06MrkErgvCrptO8aEAcyLhkUptYrWnaNnfolQO/tcaRfP+UlOxal0opbUCK2tnI9F2Ujl1JFG+RTGjQgw8FQ2OAcpp2hoj+E2rNq4gvZnAzVAu48NfLrQwtWx8xX58cuZD3kzig/9ETA6fQFnVjcrbUXsS9h/CBOZC9ge4YbYm4XqX93dRviU6HwmjgDUfLj1CnUSOLWAn0679c6SJw300ViA==
Received: from PH7P220CA0130.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::14)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 07:23:42 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:327:cafe::17) by PH7P220CA0130.outlook.office365.com
 (2603:10b6:510:327::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 07:23:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:24 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:18 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, Koichiro Den
	<den@valinux.co.jp>, Marco Crivellari <marco.crivellari@suse.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH 05/11] PCI: tegra194: Check for 16 GT/s capability before programming
Date: Wed, 23 Sep 2026 12:52:31 +0530
Message-ID: <20260923072237.1139013-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 1990208b-f461-41d4-b999-08df19439858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8p0NTiMQ7fsJKQPL+NppNONJWDJOBHAzC18JUyG/A/lc4tHjZagiu9LZvKg6rdqdm+mzXlECAz/Os8BDOHb0Jo7UDoqOSyBQKLjCpR5Vkb5so0gpfqOgi4IRubbZHEUFcowsrH1Tl97iZ6W6/wuFKcOHh+AYgPN+L7ZIx/0ApNUZLgNwFbMWoZbMR+AC1R/OK6yfRL884MixkTdlZev8k9UfXeAE6m5yI+6v4nOpzjbgt3XDCAiXp1ZtKS28u0qOGLg+OOvifGVu6851D+kfi1vYhQxUulU0UANaBpC6RnTxDykIP/Epdu9paWXAGbWneHcZUvHv37JmCJWdqfqvyI33/DIEhovXiuUxdDq3hx0D+O+0US/4tOXvKY5QAnXGnwYf/lV9sNZmOWFfqDF0YT/yrERKvdkiC9/GN8NLL1Mp1Lk1jkC959xtb3YejiFVe8x08BMhFyN+Uv5Rioq3ZkfMVdwNOZIUiq6+5NoeenJvdc95TZlfwxDjXyclylMwkM8ADoL88/j5Sf34kTe8lNA1D8fOFHTDqmoMrqtDEklJ1CD13b239naoIsSHvsnRFBQiK7tNI35l+MI0hY3CukAkDVUeyEl3XUxlDedOc75tSTvxgOrW8HtRUsML6u5Y8+KeTctwgNA6vracZcmKyUbMR5lYZ814CCb/IVoS39IScgNV4n0yQG2eJQB7zjjLKFU7cw6E/1QlWewAsw0V9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RLAiE7KbkXI8TRbZ+W3OiUJMUBi8VnJO0dphcXYHmg2VP2igWSPDzMpMSafW4IpMCY31Uwk+DyksXNQrXdSDEs3xNOOtUkiWA4wzegTBH1+oBGmYTSBer0mbgvyRc/KStoq3IKqRuEyEo/nzWt+2ohZaYtt1Uopber0Gc6DfiXdvGIuI8v9uuJjthw3jzDhWVup+G6ZlWkQbqtGAX0Sipw2hXXeMhuUhQ4D1s0q6n7mgz/Oi6dQpsf8CpbkICtMEddoAeiMAc/HOm0lYH9yJ/zQWueXkfg4hUAo36X/oNY2tZkM98mj8KpcXxkIICgbD5R83tHPSFw2i7ceak5hhxwVycBaHg8h/2veWnRX2fN9lV0nZXGTYxCO5G4AOFh8k3kebdMAKz+e/EWVuPAZmU4mT0csKW+7g3l414bC1fO/mssngOfJyFhIq5ifX79Mj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:41.7983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1990208b-f461-41d4-b999-08df19439858
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

config_gen3_gen4_eq_presets() added PCI_PL_16GT_LE_CTRL to the result of
dw_pcie_find_ext_capability() without checking whether the 16 GT/s
capability exists. If the capability is absent, the code writes lane
presets at an unrelated configuration offset.

Look up the capability once before the lane loop and skip the 16 GT/s lane
equivalent control programming when it is absent.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index aa47052a37cf..358156c63da0 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -840,7 +840,11 @@ static void tegra_pcie_enable_interrupts(struct dw_pcie_rp *pp)
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
@@ -851,15 +855,15 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
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
 
 	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-- 
2.34.1

