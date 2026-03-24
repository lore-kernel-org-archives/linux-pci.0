Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CD396D30;
	Tue, 24 Mar 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379381; cv=fail; b=TY1t+4e2qo6R0J3lOdmtsjBPyO0il3JtauXjmKKOMg/X0zxPla0QWyf2AtbLzyPNL0JY5oXgFwog92qHyCbLnf0pvTG1vwZkcu/ozQqMJbPb3C0BnAP8cnNBeefU0ytETykzM9LiJxJkIduieI9akZPDxLA2FTn3FgBgDwmVN/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379381; c=relaxed/simple;
	bh=42cvJMWsslbiGQ400nFWvVkC/Ti/i0gG4mAZUlaF6cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7ScBXcW0w6Q6pJ2LAOWgQjWMsbCLskqKsNVTD8DnzCT1T2BAR5F+ZPyXOWBE6Z5eocAKHJPvlXK4H0InVrrmDaIbhI5WdHDgx9lKp6ROpDaTjaR3j68Nnk0DqrYoEoY8/Jsx1ndiAYIfUaVmrtItCOZxSjVweTUuxBCqXy4Hdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lA9mf+XR; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lA9mf+XR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKb4Ufy58nKrsZOTHSG9Rmw+6wNsjnf3SrIe3nuD3Q2x5fWOfcgtomTFRojQYL1ozBm+21q2WivRnzmZUOLSwVvUF4M/SPQb+VNt4giQTiXHMPZE8UrqMDyXdL/0ftS+mdccIqP+UOOvy2+v3g0xu0IT9h6n0yHd9Et5RZ7bMWDnL+rhRjrt7ZMq/ez2Q2iQ77m5lXpvb2qBxEBDKOyMP5PXLR8P878za3VlaCRNRmGB9dGL05tyWVsWuO0M32kT+3l49xycYQ03u6D5ktcykbGR0Pk0sawxQIvGusmj9MHtbmvzbApGuhGlvX/pQ42NTt1yGKLzj+xA4UO7+XTeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07qSncn+4k1XpLnHxz+EkcNO1OPIZO1OoIXE83ontrY=;
 b=ekKpZsWNx81wFiYuKY3h7vFlr2GTdRoxU6wwCKjGVqoDBt+k+hUmRLlT9/BgvOsl6TFiWd+5nFN9Fyj/5mDpgGcAp6NVextzsn3ZuEk4jv/qrLtWzowew85zgiM4G0u2KXsqZpQjF7/MzRtVb5uvT02cQSqANV8noHy10RRUC0YhWgYxem9mu82Hi+MLbvIPXZXCVg9rf/lYxBNplnsss+I9jQA/ZdzBNLzbSoxMrHjscUu+RYyqOfdXQgDsWzORoMIcJR+gVEuqAvOD85uOnPY/U6vCJOBNvoFg9Ii79waCpJuVHpb/PpNKCNIuhj+gbtQjbxFtBswc2PpYlbZlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07qSncn+4k1XpLnHxz+EkcNO1OPIZO1OoIXE83ontrY=;
 b=lA9mf+XRea3YWQMLB8Zf7D9bjixfFy1M5dXYnKeA+7PZ8ak9M0FuXKTnLFYDFxxQecH43caSNhmePclfh2b7AGahnO3IDVHzcvuLzQEhN8kXfBsKW9YiLAWE6HPV1HYoLU2Oa5vI6W7qHDA+49oggQTYWJ2z1gcJjmyNiXFsojfzqKYNGK5UOjQ9W8GU0HwBXQ3oDjrgNXgnVEoedX6o1pkHhWIjLLuuoOoRNytPt+HjFpN2AScVkmFZUq9G5GWwHJN1351zZv+t5aNFm4GB4PgFTgwr4HuHwLKizPMYhYcw9tkBbLD1vRrxOfnFGpx3HfaK2Op0oT2RIbKDjmCkYg==
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 19:09:29 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::57) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:09:05 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:59 -0700
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
Subject: [PATCH v8 08/14] PCI: tegra194: Set LTR message request before PCIe link up
Date: Wed, 25 Mar 2026 00:37:49 +0530
Message-ID: <20260324190755.1094879-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c066fd8-322e-4e32-e0df-08de89d8df90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|376014|22082099003|56012099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	OVqUGE0IqlMe2oRnhwVW/R1TzTs1kIj3DN+RZEPglmBFNy1HfHHIondR+w3VpoD0EP2oBUM/mCThC5JpsMuDJihpGKI0zsPPHMwvg5oz639SA92GPHCchkpmPk9dUsFC4uAa7jZTeMVcEEwZykwnxWdKjl8vMPQt6fa2R2cHlaUnA1B7j5RcXCogouNogRXx9VCZQHzJ5NoTpPelArauFUjwbP6slvqt/+/Mvyr/sd8LR7RanH+sweJ3PL6tT/+BbQNNBYsOYWT9s6xxlE+YFPN/2N3ALZCelbixSHY8FBn7D8M7vceq9ZSOVcW7tIb5j0OaJGb6bWqHqP7OPPxpWCefRrNrSI2FQxdOinKXK6IYwG9Mw0eoScnpS501vsCZgn1lDL1Lgu0ykJsUS7Av0NhURgx0I2noBRAGsZhMbVHKu3St6r9veAO/ncPyJafc6XbRUTIygWXM0Pv861KXg0DNuKbw2BcVph71TPt9LuY/UJHG37LW73z/JynUj/rS/qAzsF6ZqgRNkEF14fu3h8VN1MxV478TiTGKN4+LMvm5qge/sYBSoBNcyPDYdwlbrX940XgxLzucbRtaQ4k/fLoMX6KssD31OV/hrXwQW3N2ehZCzr0zy0UQBVIPflLhr/nnJT7G6xNaEZrh0ynGD8TMaksC893dME9eVGjubl/OC78aOp7ZMd7h4l275xGCeI9N9LS+MVPZtOAtzcyo29/l/tbYWgVuVGbDN/RSgfnVYlNqDOqMp8UH7tkX4Ru+tGGw8f428juVbzHtzy/wjT7ic4AgmDDvQ4jc0ILXXIn1Qu7Mt/MH3nR2ppi4oIls
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yIh6zmz+iLTi8uK5iHQ9EfpuK/hL+bZYRSoXcLIHpxvfCusdUFK1gsWvVlhK/RO8gEnTi/y7SqO/Is9uFc8BrQMIhwXspAnVym8rE4o6520v66jff+nS+VnoIehwB0YXlfZ1MSLBCGWZvNMewW2eDYJIzrlwxNaStYUEb5Fhj6FIPlLBkPUMVMNCFztcIAQlfdflA/euGHMsYYuhScmMTnYjyWNNs2gL4tPYgxTIbDdWcjHofyeheDu+v6rrv11AF0VRYy9IXvNY2EE8DqoryXKO/qtpcD+bLMI8JGD7h68hWPPKjSophD0GVJp2IN4W+kVASrzUDJK8PLeQKC4sE4/caJuyVLOq9Ygh9IGO9t6/7WUvogq0am2/ch5EVLu7Xto4nLWSx3WKpoU2rY2xPo1VIzPYVEeCS17rqB2nkb9bPpaj+e1K1QqgyFKUUOuS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:28.8051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c066fd8-322e-4e32-e0df-08de89d8df90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

From: Vidya Sagar <vidyas@nvidia.com>

LTR message should be sent as soon as the Root Port enables LTR in the
Endpoint. Set snoop and no-snoop LTR timing and LTR message request before
the PCIe link comes up so that the LTR message is sent upstream as soon as
LTR is enabled.

This addresses the case where the host has not yet programmed Max Snoop/
No-Snoop latencies in config space. Without programming these values, the
Endpoint would send 0 latencies to the host. The hardware later compares
these requested values with the Max latencies configured by the host and
sends the appropriate values upstream once the host sets them.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Fix commit message
Changes V6 -> V7: Retain FIELD_PREP() usage
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0be701e58238..602ff8131887 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -485,15 +485,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 	if (val & PCI_COMMAND_MASTER) {
 		ktime_t timeout;
 
-		/* 110us for both snoop and no-snoop */
-		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
-		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
-		      LTR_MSG_REQ |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
-		      LTR_NOSNOOP_MSG_REQ;
-		appl_writel(pcie, val, APPL_LTR_MSG_1);
-
 		/* Send LTR upstream */
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
 		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
@@ -1803,6 +1794,15 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	/* 110us for both snoop and no-snoop */
+	val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
+	      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
+	      LTR_MSG_REQ |
+	      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
+	      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
+	      LTR_NOSNOOP_MSG_REQ;
+	appl_writel(pcie, val, APPL_LTR_MSG_1);
+
 	reset_control_deassert(pcie->core_rst);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

