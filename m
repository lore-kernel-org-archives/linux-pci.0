Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C8383C90;
	Tue,  3 Mar 2026 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520972; cv=fail; b=e8mVoaZOJISINZsoF4LEicXWZLBzjVYDWeEPMu7MHzwDHvrx2T2AB/dK7omL6mbM2US45bNYFUkLHimaunQyfpkx6zl/8zl0rnV4omV5ASLbtoscHZ+jE+Fnt60BWscz8DDyj5z46D2g+GfVVhbW6oA+zIP56a3RBDzu2Y1XJYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520972; c=relaxed/simple;
	bh=koFySUYWEqbBcWMrbkqQIfi9DDjuB/pPHApTo0tobEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeT0bMW+rj+f8dsqZWYZ1ftAli5tV760Gir7xIrbBsOQ3hh0JjPwnu9a6IBqf3zKvSzlhSNCvi8F7b/zKRvGuivB/dYj23vkdy5ofd2BQzB4ajLqlMRUnNuMThKhnRCL5NE/OABvSHpBbirm31Fj/SbUCdiokfy/7biZuYhNc5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SYcB7Tt8; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SYcB7Tt8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLtg6Bgi3Hl0dCEP6CELJJPfdiO5F2YPwH48ytKcWxhEbkRuGHMg5fdvDKojfiNxk3AFsoSgMlfddD0RZxHnxefDEVfsLBNuiKwDGfsJpNUoNX7vYWXNvSbNzZQM8LINdWilhEaUAo+jbEjbOLHvu38g5re5jLfaEW2vGsVqVRb+8xO3x0AW2nb50wjE0ysVU0rxwArGbH0fkhv25o+Qnqv6dTt8ac5z9uO5Gwfx1jhygIgXq6OMxQYkkrI/6MKcSoN3riznUXBtF/fLaBW5bu7CRZ92rCbCxQvh0kkJgra+4g8ANIUMBjlvOUhr/jlIR0YRQjvMii/kZeQ3EsHswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U+iURCncUb3p3Qd8a10ypYwUGHM1knPktG6KwHdKkA=;
 b=UyqcK//xLKFZYL3Aa6v82tEaxYrKF9x87WMEw5Kwxlo/frEQivS5+dPDuYq8wmxP4nbwIiDOHRRo60QtUICIti8ztgx4ye8mZG/SNZbBKxp4qenYOuCjKGYhpVV80z+8EQ2LaDQVNvBIfmdiQ9fRlhBPK0FbVrXipI9Anvm0IKimzdH1Y+junEss0mbPpEMbtm4LL78HJl/PIncZEf9G6GbmDmhBrm8XjTIwy8xQLBpMjlcmCgMiWQ8reaaFzZPa0UwfRKwxTU0yMZnEB6BPRHW3pxt787bc1XTMz6Fj2/pO8JVpdN9khZ/TjEkBhHnamyrkAOh7pqS7SgEXv/AhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U+iURCncUb3p3Qd8a10ypYwUGHM1knPktG6KwHdKkA=;
 b=SYcB7Tt8/0n5XoekDKiK6PGLLeTcpgcAgx4oDntmzSmRmdzZWvPSUIJlBkXIzKeRk7YH9i/WTEMkRqienZ69+ObNcDBxWv3c2GMsSZy4rVTVcWq4JRC51ccGtgAvfQO9jHWKjbSpbR3SP85FemzV8chnIOc7lLV2gK0aIrpPhhS5J+/cOJ6bRAOqJdG5wQhRYwsklJR4sHac/gqysVmDTZFOWqE64uUGuE/DeC/Br1ainuANdRE38FFD8tJAQPVdi2v5VJJ+9q1kEnsHodAWi3XUb55Mo4cQdmQS8X08zh9K66RAVYIMUX8OKuyGm3OixM1owSXA4u9pEuLm9WyQJA==
Received: from BN9PR03CA0398.namprd03.prod.outlook.com (2603:10b6:408:111::13)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:56:05 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::5a) by BN9PR03CA0398.outlook.office365.com
 (2603:10b6:408:111::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:55:50 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:43 -0800
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
Subject: [PATCH v7 05/13] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date: Tue, 3 Mar 2026 12:24:40 +0530
Message-ID: <20260303065448.2361488-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 368c01b5-f72a-4b9e-cf75-08de78f1efd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	/f2b/oH+HblfwX0pMLUBjmAi/W1fVmrD2rT8bfGiHNIgQzLcUCOyjWSkCU0evzrjc3KpDAR/bR4lrCf4MSLu1Kc9SApNsilqzxsaiOBRCaaL5vtOI9tArESMboX6or4O0iKjAV55puiCBYKsoCD40GyDdzi2B/ngPptxlr1S89XG2WLm88UoZ9Tq46xxTK1hsX8j7YdOS+KgqcgsSX0m0hn02bxjRqdxJSkNG+saL5KUl7Xx7TWJMP8bnLWXsStN18gEeGyus7Pf2guDmvjSn4eMiyZ+HbwnY00Jg/P8peG9P8ZRR8bqnIvErRdOipabySSuSdv8aASeJ42f5OSZSHatXKs+sjfhr2z1kEYw/7l5JT4azqjRuRu6eKeEVmu2EXm/PXuV6SUvHXZbAbOdYutfaPHhOWwk1EFdMNn9cRcbl3lkqG+XWf6eWyep0B+vxYwlT9S0f/Fbpm34xj0f84FbfkjN8WVLZPyHnz7pblNqkYcSF+tuWV/KXFnD/Cj10/BMjDVniW0eU2uNEW7Hxd/qFuTZONDwmInYW/lRyTqkFEFxXExU8oKF0lziSo5nYVX5FuNsBXEI15H67TNXn6Fp28CyhUsxIpNo9awleEnJSffItBLMmxOVxWgUtkK1wU16k3ibvdmL6mLrUtPej674FdyLxhMk5Mz6Y4etcVRUwzmEgvwNoNQpusJnrjsPcTADzMRwbuSyaW9KO8bqitK7ckScpSUc1NdRq7+qywowztDcIdVDCJdUnWjR3Hp5LlmZyO6e2yAxyZIaMhrB6gQF/H83d6yKcP/ueDv1qGAAJCtsh22gj/EYbsFQk4XFv6w9oqZj4pP6SD9SNA+tsw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s0v4JH1xAvAhwnCv+sK3y03+qHYrNy9yu4x3MVpqnr0SL1jrmFMI+zAKxkMreSM7OChoSxRJLi/TO8NjM+nGK6y2sj1J3UUquyYaTigK6L3cNleC2IIV00i5jwgTrAdozFcABjzq7QWAOw8S6qVRwr3BG4rAGE3IPrMsMkI6IG9u+Wp7yvAoj6oFFrvVF/EBI0F4HVhka9DVRNC2fObf1zSXFyu5ByG13JByxjRMawR97Bu5kEDF81GboEiZ7cGdBaiHUMsphBPKFRALbQ1bOlNPv4njgmA8lCvk3hYOtyNasn0gzfw/s9UVH8aKT0Fko/wfLKsh2ssitD4+S7RwI9FGomPhDDkJoE66V6VOC+LHG5k+lT9jxYve9DjdBfQrT0CDf3M2dKdmUKnUWwNGhPFL09eDqxu8tDdMzsuuo+p91uaGYLsK+s4lMb1K6s3Q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:03.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 368c01b5-f72a-4b9e-cf75-08de78f1efd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903

From: Vidya Sagar <vidyas@nvidia.com>

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V7: None
Changes V4 -> V5: Added Fixes tag
Changes V1 -> V4: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index dd8b92fbd393..7dcf3e3596dd 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1167,9 +1167,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
-						    "nvidia,refclk-select",
-						    GPIOD_OUT_HIGH);
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
+							     "nvidia,refclk-select",
+							     GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
 		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
 		const char *level = KERN_ERR;
-- 
2.34.1

