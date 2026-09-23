Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96E413782;
	Wed, 23 Sep 2026 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148218; cv=fail; b=i1c2TYr9KAdMRe6W2w1uV2oVE53AN5dhuq+bUpl0L8uJoGS9hPWWPc2Iq2bwhCqZCV5sTuc+ejAB3Vaao6CQpiCAh2EEod5J5PdlkzDIsyIBk3R1bB1pjp3W98gIL6VbBYAs7gH0EKcjdPdPWwK+VBtrifZPB6zjrKCyoeGSDbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148218; c=relaxed/simple;
	bh=brNg+NiO40oPuvAeQtw2zI6RsnmRn3LL8DWsBXA+Sa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFk3nV5UImHnnEtbtYxnI6JWJ+YDJnS0AGY/PgexuRM6cbYiVIPWbg7h7Mts36DHDokDeGfj8SyinuVBSXV3hXKI63zdVI02yT8M2WgX9LD9/lBSGPD5om65LqZEucreFPZcprSfGl6KPksu2BGFwgzWFblj3Z6t52cy2JtmUbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMVqCZlQ; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMVqCZlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8RyiYsk/33JdRAMSjzPE9ZufmnJ8FwcrgAO1jQyYmqzR5Uu608K2gaYA0EYUlGbfWGY3zuYgzk+q+dq/9kt8n8dPbY8G04u8CGL0A2cpgh9T1QEIShdDBz6rlPLgash6zCn/zZhL8PdiKyiy84Gc7YRxlCPtcSRzTDaliBRkvErj9mCy0eCPP2qjD/Aebq5Ma7lAMnXWIdU+doP3rRX/jrclYOHPxDFaeWe64t+zzTJm2zG/VgSFNjheIizNq+Uo8HeNuIaHoB2PbPq8IfTVfKrsC1sNwfKdnQHftTOtuM+MaTyhYwPCLanaqo+ll4LOJf0hkXbNZVIRXouxGQcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt4aZ3iv/fJyyZ0wFjZUm9L8JUksjrvOkW6n7nQ58Q0=;
 b=T1Eszj/ylSndo+G47tf/Bc4ozC1lYoDUsBR93wILoHjFqJuuRVPeMVhovbu2zueFiCcha6T+p2Mfgaso0cbufancrcBonAUzxKi3UnjdK4Wtet50BCAT/cU9JcV7cE5tQ+UVqera+nGPY00ZhpAzK/i0uiVOgoU20C0XfYWPdC4vXqstE4KD3u+v/u1UjBAKQF74cbcJpVLS1qr1M8rtsov9PttDokKRguuwbE7hYyo202wL+n2ni9sphXHwCw8U+jZ3QoKFZrInbaDXXaNnT+9sGO+0uJ7NVusuD5Z/FQB0hDvVvQj9vWbre2bUS3CLv03HoZUF665REH4nJxcjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt4aZ3iv/fJyyZ0wFjZUm9L8JUksjrvOkW6n7nQ58Q0=;
 b=YMVqCZlQqwtB8kn199WYOzMMPdWIDV8m10bXsoI3kWkEkPcvFfEi5B7FjsbMynu+au3g1EzZRKE44YN87iAOTXpQPffUBNEebb99mMyvUMxD4TOmnQZw4p2z5uIOjoMuH8RzXgPDl5NoqFhiUospWoTtNJ61UdbtgtxhIuhfQIZiToP3KLa66PrmUG7GoR5+UPLc/Se0YtSAozUEsOO+Sbr9rH4oWF1ehf83qo8BOcneyN+I0gNCulLfCzGsS2eln6dWyMZgEMSfc/ixFUujNn/FCqJfZca6wPiWPtOngqdGGBihZdYH7lG775qAGGoJ7sGJ7TzqLcVm9/OUdcFg8A==
Received: from PH8PR02CA0035.namprd02.prod.outlook.com (2603:10b6:510:2da::30)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:23:23 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::54) by PH8PR02CA0035.outlook.office365.com
 (2603:10b6:510:2da::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:23:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:07 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:02 -0700
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
Subject: [PATCH 02/11] PCI: tegra194: Check core reset deassertion
Date: Wed, 23 Sep 2026 12:52:28 +0530
Message-ID: <20260923072237.1139013-3-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3763568b-54cc-4bbd-2d3a-08df19438d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3tIjMdS974stE+uXKBkL87RsEUlF+YnF7Krcp8hEk0rH7rtnX6DpQq9f+5TPQhC0/7aYppV3ekAOMYrSp3EwNjvtdgAji9v7YX2MBvs9JwNgmWNiqEyA2YOAzPIDhEA7+FmQsXd/Veunw/oU/jeUReJ67cun5NkDDFFeF6vV2qc/Tndqr32Ce+uodIqj8p25VVqpIMpw7CL4sf/zZLn1EHvHBN8r2ZkUyneuPIqtWNvHSzc6lKbLwDJ7en9EU2bjaszAER6WffP4lTYuq/PoLhCBR4z1X7J5wLkt4SvPhL3hGddAPOnLNG7RLSS8+yK3wVc7F8RhrhKQ19Nh4Kq9xHfIaoCkRRkh2mjp3pjeQ9e2o5hOalFKoDOqAVmofiCMKwKtE/N07uCDdEu6eZUt15bmfTtfopIK4bD/2VA5UWRH9wR17WgnZytDmzH03SsdDazBZ+LEf2hw/h+nzTrCgyLaWsW+s2jnvm9gpxFIG72yfnurIUOc4rCEPT3HGNi6eC1qvMnuo/CWdC4/yMgMnjNxSrSAkBymkICdhVvObgokeue2qf9JtSTzAv82oei9ohqa81NNw1Gclr/eV6zswXSPWBg0CS+3FtwuqXKkZmJ2XiRBtvDQAt+tm1WPA1CanzfwzDKtP8/tMFwhsDy+0zNVso9Vq1UDJnL0wBXfWzSjDFSjRHm08DcDrdUjTAcc+RSLc2GeIZSlbjiBrYwgtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NaMpSSpl64fkTdaOV1EYtTm2elW4M2kSer84HlaauaUKv8mK7W4itWXUGNF6DFhb8KuMuxr+jcam2xkxEIIg644NLRGHm+Yg+C2mbaPFym9hzeea1prHecqllzHVFGYWkWxbUDl+UyKUBHt0TAxcQ7IzfYFkneu3UxRkD5FiIqr2hUddnLra8FodzMaml12cunelGhi7X8aeT1Hd4wQmgU5/ZsjbZQ987EAQSWF3P5hshxS9Jvx2m95H3kwzOsb7uwxX2bpH25TXwrzOHqGlW37upZ8qHss4tF5/mK1PvZhTZqACnGGMHuk4i2EinVeNBWi1rb16puvmCeObz1IionX1UqGBzns9o3IGsPuabVBtbtph4XyoJDgp5OgIRDbAYn0tIXbuyxfejOgjMKZzMLf7yokfXmGA/PmSotYuqfpKs96LZzgQZUrb9tRujd+h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:23.5625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3763568b-54cc-4bbd-2d3a-08df19438d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

Several paths access DBI registers after deasserting the controller core
reset. If reset_control_deassert() fails, those DBI accesses can trigger a
CBB timeout, or setup can return success with the core still in reset.

Check core reset deassertion in Root Port setup, the DLF retry path and the
Endpoint PERST# deassert path. Unwind before DBI access when deassertion
fails.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f2b75bf49a12..810695d8e5c8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -954,6 +954,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	struct dw_pcie_rp *pp = &pci->pp;
 	u32 val, offset, tmp;
+	int ret;
 	bool retry = true;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
@@ -1009,7 +1010,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		appl_writel(pcie, val, APPL_CTRL);
 
 		reset_control_assert(pcie->core_rst);
-		reset_control_deassert(pcie->core_rst);
+		ret = reset_control_deassert(pcie->core_rst);
+		if (ret) {
+			dev_err(pci->dev, "Failed to deassert core reset: %d\n",
+				ret);
+			return ret;
+		}
 
 		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
 		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
@@ -1455,10 +1461,16 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		    pcie->atu_dma_res->start & APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
 		    APPL_CFG_IATU_DMA_BASE_ADDR);
 
-	reset_control_deassert(pcie->core_rst);
+	ret = reset_control_deassert(pcie->core_rst);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to deassert core reset: %d\n", ret);
+		goto fail_core_rst;
+	}
 
 	return ret;
 
+fail_core_rst:
+	tegra_pcie_disable_phy(pcie);
 fail_phy:
 	reset_control_assert(pcie->core_apb_rst);
 fail_core_apb_rst:
@@ -1853,7 +1865,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	      LTR_NOSNOOP_MSG_REQ;
 	appl_writel(pcie, val, APPL_LTR_MSG_1);
 
-	reset_control_deassert(pcie->core_rst);
+	ret = reset_control_deassert(pcie->core_rst);
+	if (ret) {
+		dev_err(dev, "Failed to deassert core reset: %d\n", ret);
+		goto fail_core_rst;
+	}
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
 	pci_epc_deinit_notify(pcie->pci.ep.epc);
@@ -1927,6 +1943,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 fail_init_complete:
 	reset_control_assert(pcie->core_rst);
+fail_core_rst:
 	tegra_pcie_disable_phy(pcie);
 fail_phy:
 	reset_control_assert(pcie->core_apb_rst);
-- 
2.34.1

