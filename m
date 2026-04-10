Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896633F58B;
	Fri, 10 Apr 2026 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806456; cv=fail; b=MRuo0+8/wdZOje/HNI0rDZ4s68FPHLtW9jTax3FL/j4yikv24N+ptTk/Al1uEi0naK23KJ587KKxhehNGJNPFmfGg64KLoKJgB+mPA82ADWDABo1NNPZjFqSNKEs4F180zey1bN7OudUXnsVBYRmjUTorLjCMYfaSva54nfQQNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806456; c=relaxed/simple;
	bh=ZkS6xoDHQYM3AY9G+yC4gsmt+3WIC7/RXGyPYsMnDy8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KFwBtbdLolVLPBpSi36+1Y8WfED9AarDNl+/HrViVsXdugRU5VOZTqzFxvL/5HahI3CUP9PnrUSnaPaMWo6IhNnFNEftEd3fzOcQtVsnrMuh7Rdo3byB/RfO4OXGOImnxTHmo9cE8LMNc/TRF18ifjs+9xGaogv+v4NW626JYfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHe7hJji; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHe7hJji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnVeLBvcGeaTNBQQsp0QnIX/J723WJ8XY9MfJYtQxcE8NoQTx34vSpOtXCNnkc21moAOAOwxRtU3lebE/4aXNFWpsHHWC72ptZu/6oRJ/JgY/p6z7WktaHPhWRSXlQGNUGlxf+ej2Tcy6DRegGOcyMGVSmZSP1a8SWtRhEbXIsrTjTM1NiGzm45rQqUHj6os/NnSENhtK/jrbfuI6vZudpS6SW7aZrsukX7IlVn1i5lzKkXLbJyba4repb0nhjgr30pYFDWOHZHQmZiytZbec45kz7ylisJ33fzCldZX8lj6D9yeoK5wd0mgOJQfUMqkXCbrLyEilFHzRpTOV7Xrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTFUMNxpCPB184UTUYzFHBRNBVDCRByu2McDy3nRv6Q=;
 b=ax/LPR4CfFK7DS1m1o65E0SQh3CTBOLW5wZvkDb1600S7rVefsCwmmMyRcc7EgeE8TuvD05P1TPXXCc3HHDZ/oeK1JA91ki/lpTVB2/rVIe/ZSTVcOomqH7QrcUFUeLv3gozohx6J9EOzpQ1KSrSHzargI7ZAthv8CZxQr25za79MaJVmn3kfiCNaUb2Vqm3puHTQNxOhfF6t/uQ4yu/F63onW0bJqozRyGC2jqm229uMq0TrGXLQO4+PuApFa2L1jXEo9/bG84rha96VTihyRdqFJAFUyU8l68HYKSlnf5QOlD1/dYxrX2wS+vSMnIgp7k8Y+aAEB0jlD7vQ9vGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTFUMNxpCPB184UTUYzFHBRNBVDCRByu2McDy3nRv6Q=;
 b=fHe7hJjigAfOORFDjyBPz204e5rAy51H0zi84p7UQg9vKz0P39opTyC9QX5JfyMFOfF1hUsKMLO09mNL/fDj0VkqfPXmN74KY7ZcOAh0t9L7J0VBJhKScHu49HGqooYsZtmHkmKnFzd7XH5dK5N3gKH0GBbTTAzxE/cF5TLwjCSLS6XYG1uthcvD1o+Lc4A6YeGddhoePNKU8UeoFAc0R0R4p5euQPFZVeCYtnI4LrNoltrFyvYnO/iKd/lNKgLg12W7DG0Avz1JRHBGXUuvb0DRvCVLVwH2WqcKAMrnt2jlytjYiS/YsFeEHp6wDOHcDT9KoMRdPXkZ8DDtHxqJTA==
Received: from MN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:52d::23)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 07:34:09 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::cf) by MN0PR04CA0006.outlook.office365.com
 (2603:10b6:208:52d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 07:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 07:34:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 00:33:51 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 10 Apr 2026 00:33:45 -0700
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
Subject: [PATCH] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
Date: Fri, 10 Apr 2026 13:03:30 +0530
Message-ID: <20260410073330.837238-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 00854c47-7a9d-4ced-d26c-08de96d38da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|13003099007|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wm6Bx7elBUrWRRtvzFFj4M0odoiEVCV2X73iq7FhsFLKjFkVpIWfZN0e31VPUGGR0Wf5ip5I1HtvWmGSjkxJn2I7WnEzW8mUhbSSOz5nAL/J51M/SMyELsHjULKCUWvDUXJkJ8VtwPeaQ0zigMTOX9r3sYmCi3wLrrwMZvGJob2eKNh/yGJ4lZWgJUKTVkoD1W9kxdPmflUnByo2wLHzVJMgQr6HfKQXYSpPkII7ZDE5FTY96kh7VAjO7wOvKt3zcsLdSO9jDemPYvCd/deohp2KBA6Met/hYYMYVnBfERfDb4fg5aEu6TYrNZbBq7IRoO5X+FeNoG0yyGs1SFFEONGqVp4XeaCDW/UMLXn7XQf7CTAUkDysNKlPiTHvHAVBHD/BNzPGgK041ODSUQ8SJek+kACTyE+POnr+jAasQdnfQmqCAPEac4TB2Vsn/ITNmJ/opWJVDR5v5iIBAjaR/kR3xy/UD+ZMnFbLz9ocRGuY5yageyD9aEhzfW1plHet+CvIh6vK6TeOIfw57PB6JBNcnVIPl4DaPQ7CBBFC4zII9tIYh40Ww0/q3y4KzmRMnUI94JsrRWn/I5zMybspPFxV0kQiGAou+zbRBLLXWc1sJog+fwegA6B2pPJ9MLKjMa26FwBrrnj/KqRQ0WjCb7CLmBQsgVPIkTaIt+FwpeN+m2SMtVr5u97+4Wq56NONm/8mwI3wZcJqdVUKlVt+qMZq9w5KCx3SxB7rS0gl8eJING7rKJ9BIb/Osop6ocQOeLNx3gSy1BmBpMREkHyMfdNRIYEO5qZkhupNuV52WCLeTXlPV9m6QDNDIczOmIsw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(13003099007)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o4mH6/hXnlUY5kExWACRMWb3Agh/z8MI6BJbQ33QiWpzqYReA+RYwBF1wCvSerB+zY+CRu8KkZfJAYI2FLBl1q2jSbTnOd6gwRSNVnSBPSkpcbVoRlMGlbe5K9blm2YflwMo4UVmiRzDQgiCZyeqtX5a/PVn7RQ4UeVQP9srNz6gp8uuCom+um5PhhfxbGJ2zMoVj0OWx2b8KDeypw4qHLr4DOCcumM9JniZWS7uIxX9L3mekLIBh7z/f2DHhGbT9Bwl0L4HBw0e9ZX2TXHOT83h4SQ1s0imL/HXek7APap5rsZEYGw4Y2EOAKjpawsWZrXsI5xNKPD3Cd8tVfysbQrIr39+u+Vf5/lGVgkViX8HAxjnOHkfEFf1rdwYFj2Uy6fBn3+XSUnNn3hQt58eVbWpZYju1sW1Pjg+fSl4yOwZyqgB4hERFURJRsRWzY75
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 07:34:08.9975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00854c47-7a9d-4ced-d26c-08de96d38da3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172

Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
device tree property instead of of_data. Convert the value from nanoseconds
to the hardware encoding (log2(us) + 1, 3-bit field). If the property is
absent, default to 7 (maximum latency).

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20260324191000.1095768-10-mmaddireddy@nvidia.com
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 50c5ef12552b..f171f7e32b75 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -272,6 +273,7 @@ struct tegra_pcie_dw {
 	u32 aspm_cmrt;
 	u32 aspm_pwr_on_t;
 	u32 aspm_l0s_enter_lat;
+	u32 aspm_l1_enter_lat;
 
 	struct regulator *pex_ctl_supply;
 	struct regulator *slot_ctl_3v3;
@@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
 	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
+	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
 	val |= PORT_AFR_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
@@ -1110,6 +1114,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
+	u32 val;
 	int ret;
 
 	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -1136,6 +1141,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		dev_info(pcie->dev,
 			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
 
+	/* Default to max latency of 7. */
+	pcie->aspm_l1_enter_lat = 7;
+	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
+	if (!ret) {
+		u32 us = max(val / 1000, 1U);
+
+		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
 	if (ret < 0) {
 		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
-- 
2.34.1

