Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA33E025D;
	Fri, 15 May 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828987; cv=fail; b=ZgIybLmrBsJHWPjjoalkjyZBEQhsCvoLZLLijIzVzrhW6V4Ap8RE05iUy0nbfVFLtzxfz7VBPMwsslPHeYBbGGT2NKx5ujhMq5gAGeMtZt/f3uW71mRqDbbjdQd6CXyBzH+bflMsMx77QLIJXZpc6Y2XxZs95bUpUBMOajIKWng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828987; c=relaxed/simple;
	bh=68U2Kqa+te7Ae8SRw88kMIDXb68bu6bYOZw6FXxnVIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNnt7LZdJJ5hOyrAyBp/gnA4h7Ib8oE9A0PVz5XMrDmRRkyYgXb7B1xVBAwmdp2Ck53QnC9wkIOrZEEhK7gWMQh93oHpfwIZ7Yfg7O3+aj2qD6G20BEfifhTeXyo8y69lNwzkHPI21r1tJVGqJRAvStqP+VzR/V1LcTO9mW4iDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uuSgKALS; arc=fail smtp.client-ip=40.107.200.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uuSgKALS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfqNB4in+huBiva6n0meKSaiouNxbB/Ndi+659iATNc6viu92Q+OP+Guf2LM7JQNNmOhEbgZVITxxxCcb3iW8sgE7tnnLttp8BiIq8JwbuSuz8XEGS+QhzamctMDFA8n5YIRufgm5d1dA8rlKadgLA2syn1N0cQonDfYfbNUUb9jkIhxhEarJivGGJbxTadSXJ5gCywmt5ZSbP88HeHG0SEd1pfiWn3yti20Uan50ml9rIS5b/a62IEJdR/mgeWmdlRlJPJdWP0VLtsk1Jqk3EV4UO3Bh5/5ELbDk0Oh9DKyUB3o+OUKbxL1+UR8himWLZLMxpPRTpVhUzNAQxXdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJtdrYPAtXaqRdCZtfAq/F3/atWN6XaO1vmvAFeyAGU=;
 b=XWYiOD+Mf8gQ4VRj1XtQgm+rJ4yoIQtBawomW0WNbLhhkuyfbPG5ZFGn6G6mfcUIfazLBpYQCKQILOQ44R2R3uJpr7IbmEQgsOk+3XqbnEfUVQzefExRv2HYWOEfr9O3IbA9//spOpEcimyzCKoHCAKEy/AILjQNR5bLiMZoF/tNoLvMXkng3fYxyvAxjB3n6BpwnuIQlmSrIzVKDaoOQJZOd31Vtb+RWJjEL6j/OkkhXdTVqDxH+vUIDTX/VTsfONdIEvpJiTjMFTd/c+YceWYfvuSXY5sYFy2rLHJoStWgeCTTls9Uha+hH4yIRTpqhNuLopOPtdbb3k6tnnbYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJtdrYPAtXaqRdCZtfAq/F3/atWN6XaO1vmvAFeyAGU=;
 b=uuSgKALS4tqdRp0kHGwUuq821KnZapySdVdIJpoSH656fPRFhXfj4opPNezROV/ZdngmB9KVUx0OVGFjLJuNVR+/rKReWp+C5ySfErAru6V35gEwL09yFJ7aLA+9/T/E/UR1kwmKp1ZNrJmydw7DwUByDweBFrlIp/mqFjTn1QytLwtPdVdLeDITKpuwo+gVIXr37/lbWORfeq5PRL54U91pvsaTaware/9xZYDL94sEMNRhS+Cxk5nYra2W1Ye5zpIP/MpWRq6FFDaZitnw70aQhsejk+ztoS3zsD+tMGdOztF3vqdvlgwHi69yHZi2DYqbOrSsFmmcqBhjGl8Vqg==
Received: from SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 07:09:39 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::66) by SJ0PR13CA0013.outlook.office365.com
 (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Fri, 15
 May 2026 07:09:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 07:09:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 00:08:24 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 00:08:17 -0700
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
Subject: [PATCH v3 1/2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
Date: Fri, 15 May 2026 12:37:52 +0530
Message-ID: <20260515070753.3852840-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515070753.3852840-1-mmaddireddy@nvidia.com>
References: <20260515070753.3852840-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 074afe4b-70ca-4b24-f3ea-08deb250edaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|56012099003|22082099003|18002099003|11063799003|921020;
X-Microsoft-Antispam-Message-Info:
	8AVR+UD9xTpcRxD2M9YnIhS12cysQEGatGyNHgIFxn/lvYpAxheWmOn8RVST4IjilY2hoFaVmCi5dReqWI5TCLnWWNOg6pgVXAeioYKWYPHpGdbJQtLF/OQkFlyikiaCoMKZi2j1sXSA1oSxM6cmsh84TLQFD68Dowrm5Nfw5maLOGkOKRaBkvHi2Py4VejHTjfWMA1BpeDWGHTU5g3tkBNq1VLbMxmxKvcmuldZQfLnyOnUhflXUWQEMGgxQ9Hj1DgVH8Vv0HOfpWaNFVHrj1dh2Cn+DYYHot787a2Pa1K4iMoVevX4L1qmFhgcf00xFIxVIVOKZAwW5GobyY2n+fpBL+mhuzQBXu2QwpJ8rxxa6nDIm/O/4mWJj8R7qkN1BQ3kiDtsvvnZOXaVQJaYBIQqRT9gbLJc3Y5gV39SqYsjPflT0J36fUHRBgGTkq6TTqWWfTievC7jWbeQeXrC5gaJK0uZOOLvFOYfvqY8RxGLlD0zZX5csw5k9+kxQ0OF2v6SmhgEq5tW7i5LkP/oMl7IehOqzQaVshoOMA+VHSA4Lb0wRd8ZtNwnYA8yVof+5Bm3SvWzSEmCYPx2S06ubYcMrG55qrN0heaRolKvNW4BybUDGAAd7XL5LKcqhA9oc4/o5sK0NgOc6OLR+xPakHoM1iAToRojud8Rp/BZezkcvO4zy1JMQdigj49R4gWYQXhnDSTNsqX6x9M0Kw3XqoN0Sy+sFMSlMQZCZ04pyJvo78wpdzUqSYABwqwQk1SZXIuEXsgsvpRqdkIcwabHXQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003)(11063799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fj8O/HBDIZ5ZgqRhzqzX50mvt+Iw4dBu42E+iVyHUm5JURmlyaWs8wpwWX2pmvr64bkF6GkixiPdlO54FS0X/rfgVs8oNnk/5dnAs/CDAt5EL8R2EIe4rEfcX3vxN5T/kdUHxMyuJ8bzQqFHMWAnVzYjYyuHxoqfIp/qSd/5FZeGWsPM2/w7hJPw9ykYnjWkUwdCOqvG/Y+jdKTa2jWuFJJcY05nMX2MfqRA4OniEkEctmEJcezPbol8kl81KMDXrIVVCyVtRT8TumWPRp3Iwa4nGV4vhVKep4qFF0ljSZco1Nv1j3hdlv2xtg6M4aa2ipefdVyFFO/yFoQOiGDWicvugHD291+I6FIyQdy+bkCSD93dCAt1iRQ4B47TvP4qWLiXEHgqmIvOMepwKXzPVEF1PNslfSnaOYTzvbl6pv4aNqiy18YEZqLXuB2rI3p3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 07:09:38.6329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074afe4b-70ca-4b24-f3ea-08deb250edaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

Program the Synopsys DesignWare PORT_AFR L1 entrance latency field from the
optional aspm-l1-entry-delay-ns device tree property (nanoseconds).

Convert delay to whole microseconds with ceiling division (DIV_ROUND_UP),
then derive the 3-bit hw encoding as the minimum of order_base_2(us) and 7.
If the property is not present or cannot be read, default to 7.

Hardware encoding (PORT_AFR L1 entrance latency, bits 27:29):

  +--------------------------+----------+
  | Advertised maximum       | Code     |
  +--------------------------+----------+
  | Maximum of 1 us          | 000b     |
  +--------------------------+----------+
  | Maximum of 2 us          | 001b     |
  +--------------------------+----------+
  | Maximum of 4 us          | 010b     |
  +--------------------------+----------+
  | Maximum of 8 us          | 011b     |
  +--------------------------+----------+
  | Maximum of 16 us         | 100b     |
  +--------------------------+----------+
  | Maximum of 32 us         | 101b     |
  +--------------------------+----------+
  | Maximum of 64 us         | 110b     |
  +--------------------------+----------+
  | Rest                     | 111b     |
  +--------------------------+----------+

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Fixed commit message as per review comments.
V3: Fixed encoding to handle all cases per above table.

 drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9dcfa194050e..5309a2f1356d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -272,6 +272,7 @@ struct tegra_pcie_dw {
 	u32 aspm_cmrt;
 	u32 aspm_pwr_on_t;
 	u32 aspm_l0s_enter_lat;
+	u32 aspm_l1_enter_lat;
 
 	struct regulator *pex_ctl_supply;
 	struct regulator *slot_ctl_3v3;
@@ -715,6 +716,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
 	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
+	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
 	val |= PORT_AFR_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
@@ -1115,6 +1118,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
+	u32 val;
 	int ret;
 
 	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -1141,6 +1145,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		dev_info(pcie->dev,
 			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
 
+	/* Default to max latency of 7. */
+	pcie->aspm_l1_enter_lat = 7;
+	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
+	if (!ret) {
+		u32 us = DIV_ROUND_UP(val, 1000);
+
+		pcie->aspm_l1_enter_lat = min_t(u32, order_base_2(us), 7);
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
 	if (ret < 0) {
 		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
-- 
2.34.1

