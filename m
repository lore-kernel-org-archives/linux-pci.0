Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3944BC97;
	Wed, 23 Sep 2026 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148247; cv=fail; b=kBFXDu59NwehsmAossriCRo/2kK8gYs0mhCFsYF7u8mMpVw4Efl5G+VpZ+ySdGx/kGxY7KDR1hqMN4+P12FMaxNTtvRsFQY4o8Dd6J7xHf1D+xvWsdLHDZPo7f6hg1o5OKSEgPyxEJBbw4vrAClCSb0oHH4sBpJkoeTGZ5FCt4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148247; c=relaxed/simple;
	bh=Wrrn3UIWyVFX6RVpb8Esd32/LcjrJf4rcK0CXCjGT0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLB3fjpuhCr4TNYdORcjwwj0XM6Uv3MojQmVMB6DIX70sjSDTOkoeKEWXY0v+SwXwjxM5c2XiyTNE2FDiSs1VR1FDWEbD0xFsAt2Uk0Wy5E8zf09UhE/27A9iAqrFOYboUX7//4H2gXYnBniAER4QGQaDQKWBm2bEkbGqbi6wyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lmeW40rA; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lmeW40rA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scZDmPaME+U25dJeV27a9QlRfv18sUvG3qXOCgvpf1+2/1bs1Y5bjcOHyC3j9TfJWyKb5EiUhm5nhPHV61musIbSD+fQSB3SF3Mrgi9nly2ujvhN4wyLMjzOqYgb89TKXV/5dswMgGJOlsLv/+iuKzMk9YSh4FQfIOD9gkVEvC30uiD1K0eTle+jnpKSZ/2zIYN9SIgfBpSfUhquIZif/rKkMdKDguvWPhPuT9g+HR9zGIxNxPl4eDu53zr7pdmGLQwvI0rlrZN44zFTQOBlboGoRssCN0AIcS1uYFvOEuHk7XftC0uY3WlPm6Ib/KzuByWo2dag5KWoc0XfdzfGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSE9lPsaYUQXSCGx5RFafkkYIkdWDYB4XrNUQTB8aVI=;
 b=EY1RElW76WvTfrmeRwtQblEKFDvWt9Exa4Qelt4/h6PxVh+1D4VsTCTGrx3V37FANB8wr1Ko9qAsKwfwsJJf3H1Cha6MdNt5xDFzBHapWSWKd3cexunQMAtKq/bf1bjsC0jF1Q+QEs0d+5Rp/jsPpNB5dSGtfBLKKdymN9zlh1ZfmIn6GpaY1cX61pek2YFBdoHaJNRgXZ2in/cFWORY3lQh4QJteRCV4ANSoDuE+qGFX6xgZ5c+TS++HscfjyNcvIkV4j/PSv6vxbfkdqGgCwbp2baiMOUvMh/iKCIWCr3l73bgfEj3XmhPtm0REGc0nsS7hXEqu7ofZfXUCWjlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSE9lPsaYUQXSCGx5RFafkkYIkdWDYB4XrNUQTB8aVI=;
 b=lmeW40rAjgClBWKqfVuhXmC0SzLv9Tala4kYxumaelr0Pevwi8To56+OrGPhasQ/TOgN+pttOe5yXyofberEku0VjMMcxjZGr1NRDmxgIQm6nOeY9343nIIa/FSXlXIgxChWBR4QEsNRapJ0ZgHukjJGNiHe9oXpJPfjR5nJPtsw9jPJcEEz7Ze7vrkmTT6eZSrRD0M7JCaAQ50F1TTCaNu6vdXpEwvICSwZYKSXMZT0T5vkmjs01F+3WmOPsz+DnNx7EUZUFiIk2pG20SXXd70KNAYNcTiHVGuDrK1powf7nweawmYcb4ozRFMGewUTv/T/JGAECpNY/D1gxiyORA==
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:23:58 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:349:cafe::60) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 07:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:35 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:29 -0700
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
Subject: [PATCH 07/11] PCI: tegra194: Always disable Tegra234 Endpoint L1.2
Date: Wed, 23 Sep 2026 12:52:33 +0530
Message-ID: <20260923072237.1139013-8-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4bcafd-bb63-471f-76c9-08df1943a1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+yKhvO5JzQi2qjcvQYvHu/01l+wlYDiGe3IMkIbEho6EXyBkYL0WTx8ESs05iRf/ysLeO3JDDS1sST4xmGNkkGAbNgcG/hLhq/BN/SlvgnkLI08xNutCJ/n7O1pVlF4ZQFyKPARQn+OAkmVeZt9nysC+IDG2UqySHfmTvFX5jWkBq+RZ1t6DO7xIa3e1aeYutaDhRZHlI8uLwMzmrpBO/iCX95wCJUJLvBid8+0u5zb9MaTv+eAh8amloDZdy/pZ2D9HyZczDIYAPTgU5kl4zOtJimX9pz/jRRto2vJIrRepv/UUEBFRCReF1GyStbGg7yjw9t7Z5UlN4x+tiAKf+ltuen9QvynFK9GInOvxbxfYP4AR+tto2DOAHE9zFflpj9nsX3D04t2xbKvS3P+/FiXZQ28S9vb9MMm/E80FPSGpc5UgJg7rOpISawbrzKj+vDTiMX+SjANRqJx0QfZqDO70y7dbY1WpuYTBhaWpxHjE9VYpztgC1zo5SUOJ1u6zV+uiYvmnagoPgyQkfkl3ErzOW3uwfk468K7lrrjnjYcg3GlO3EVQ2Y4moYwR9FDiE3fnJ9ivQzJwDps/Z8XIYqx8HEPMqw20SIwA6O4lAWR21VKQWkh/ChXrRbiQZc2j6tqMOc0MOyTZ4jwK9fPiOi+WcYGP5Ij+x7enN2HbPbO/1bxICV5kxlab6uuyKp5WDnfZ84L5Lgp3rIC53VYnjg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FNXYkkubLi6XcZovGAsgJLraOmC2w7NXCmVCEyc6c3bbMxavCIHhVhFUdsL1HGjlFofT3sUF7krBSBVWFiHcmeSWc7tIrmirq+O87by100e3Cnsf3p/3EjSg98AVFvlxnE16Ug0mlbiK69mUqgbfr0N1Bou0uoAKjI4baK36IfmzzoM/lcF3KyycjeUPKKfsl8JeI6qikynfJsbaUaAnHd/B2s0LnWDzlWx8gnZEh8phxnbbg0L7Hobl07VX1X4FxCQ7m7jo9AChYe/PGmYdBNb2EYhrDomQ5evLbzhyo3P1aSXrQIeXsO7y1gb+WrTy3392yBqM+7EIydkYvcWBXkfAklrzga+28WCCIYJlJ7jraEhlQEfHICAJP0G97mrdWoWqUk7WIcdHdWwDqCrrT0Wpp4JA1E66oNslcKDs+eHDTybxe6L0YVBYKQsyUIWq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:57.6227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4bcafd-bb63-471f-76c9-08df1943a1c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834

Tegra234 Endpoint mode must not advertise L1.2 because exiting L1.2 can
bring the link down. That hardware workaround is required regardless of
whether the endpoint kernel is built with CONFIG_PCIEASPM.

Move the L1.2 capability masking out of init_host_aspm(), which is compiled
out when CONFIG_PCIEASPM is disabled, and apply it from the common
initialization paths.

Fixes: f59df1d9e6bd ("PCI: tegra194: Disable L1.2 capability of Tegra234 EP")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 47 +++++++++++++---------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b35d9456e9de..f8e39459db41 100644
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
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-- 
2.34.1

