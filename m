Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563328;
	b=ZbpLbNv5pnnhaQq31F2VZelG8+RFJz/HlqINfvMvSoOs+oNTvrdySJDo2qIzv4LmMR+a
	 ch7x2nOZjQ/Maxcl8U6vuAzMvBDrvoL78IAjIgUKBNc8BhZ8Xqku1IH8cj2iCMkIbZTDN
	 RONlD+sB5TfSwTPydRDieCSD5FQ4gf6NOJSVUC4FwB8sRl1+dW6wyjyrJCppBn0EKO51B
	 A5vr0J630g5VCymfB8GsBw7Yq/sIZz6wMMtayTVP6ChS2WgK7W3tW6MWhibtlGraWr7ZQ
	 415Anc9Lc2ftIb1D2b6ST1YVGirrlQLeODLZSpwgUZv/e76Wt8BbWqrDRtiw83aKKtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563328;
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
	bh=q4uoYp7iebUpoeCR9I0ryRFEWbubLaTWKvE9tskfluI=;
	b=chQtq0eoelb67aFVrJb8AASEfvHoByfOQbXwKNdabvN+q4gCPJHL5iSGtZuF2vQhVWW/
	 R+UPEVv4FwRmU70bac7xg+tHbTls8yL1QhEH/5L7soK16p/iVZ2GndEARfRwC3aPwnXM+
	 td7dA4OA4DRVMK/5T4+w8eSqhuRWBuRxscUe3upIZzE+oaxKJp4FmiEPAScX0ayUOMqAp
	 jIuNDys1UJouA92Q6ZwUqxo42TM9EVqdQSlR9ZA63pGfA8Wun26n/6/6e6teMApGuecAj
	 v/k55bnu1HEVeniq7t4lP24F9DwjF1vN7hJIJP6Xl9knkl4pz0tOShDFf4wwcs4P8pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MYhzgz99;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.59
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F305606A320;
	Wed, 21 Oct 2026 06:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F305606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MYhzgz99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftovl8Kb0uccIJtfhrEVLvEVokP1wQlbjlKqE5MHLTEFcdgOXIf4hYWwaZgBuOGng6z8pmwofUbmMLPpRWZrR1RIFrkZ5/r7UcCCjvR8k6niXZyhZ8OQIS8UaZIjdzP0iTYkauvcTXPLpc4mjGk2HkrrJ0QFDIyqVq4LcefmjGgHmJcKJQKpEmPEznIeOizUqZcfXaRC4pFaxVTD4JagZwToz300iwE3VAsP0jX2lOU/c8CLzLnq7v+gOj4tOxi8jd4xtM3+mnHRrsA+ZWNGNbs+Qfmub3JnOsBn8OrSnmk6WoTTdmANA7uqDSY982vpxAUz9kq+sFhS8BPwINCQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4uoYp7iebUpoeCR9I0ryRFEWbubLaTWKvE9tskfluI=;
 b=el+G7a6ke3zvaAQ9eE7fHHxHZKfuEJjgr1g00hjyJ0SgAjeEwbdtwXA4RwvDk8+LITiVjehiAMbqsB79OU0I2wnTRz0feliTWf//Mm3rCqD2Gt2P0m39jp4SK1PIaObChEe6fqrEHhDcaNxHqgQ+YSSNtySgdZhf1KTcBUcVyStF8W0rzU6kTCdPoxS++azF79Xjh0cRuJVFqFbFWt79xvx7NPdKotsrHgIUx54wEWoqULOB4jEfXhAEahU5Ovf//8bmZPAHv6bL+466MYm6hDYbwSA8D8tKaz6co64kolRnlVk0dJpV4S8kjoQoHmBKmE5zogUQReSDSHycGuZMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4uoYp7iebUpoeCR9I0ryRFEWbubLaTWKvE9tskfluI=;
 b=MYhzgz99M8VQHloYy1gChqCdo9ZmJoPkDojWh/R6Nu2GyIBexL80P0t4hvyCeqvVKdTyPJms1B4VTb7ktCnYLe2DyEe3l5GF0FLxLUBuLnHHWVbyqOt67/qE4EMEDM3VD5DOnxYJDh0id+h9whQZG5vafNWPC9LufY0TwEA866X6KR4K46etYaO0omp9fwtHSx7mH8J3j/Lr/ZvYbg8NW3T1gAKUei23kyFIIozaE0pE4lkTp7swTEJyinCrPVvtsGFezYwwi69euWnPBGaBSGU+Z3rglcV9P5M5ux/R4rq1Hh27AeiGP6xXTQ7CnTPxEQVflR30WqQQ+/N1iJn1KQ==
Received: from SJ0PR03CA0158.namprd03.prod.outlook.com (2603:10b6:a03:338::13)
 by DS6PR12MB500340.namprd12.prod.outlook.com (2603:10b6:8:52c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:15:24 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::aa) by SJ0PR03CA0158.outlook.office365.com
 (2603:10b6:a03:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 06:15:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:15:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:15:04 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:58 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 10/10] PCI: tegra194: Reject zero MSI interrupt number
Date: Wed, 21 Oct 2026 11:43:49 +0530
Message-ID: <20261021061349.1265704-11-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|DS6PR12MB500340:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d400828-ef08-461b-d6b4-08df2f3ab157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CQksPMBZXnUxnO16Qb7T/WYkMcQWtAOG/u6KNPRZhJpG2AI2JLEss24T8sVPXlS7kOLm6Dz7wyQaI/l4xuwKAlb/PB/cLmO9Timp3t/lrCDXAUf1G5LqwpSJvr2pVjkoYlYWIyvH0mRQYQPCLWK8lA9CeMbhibGU3tmoScD2dlGddd3ezQprNM1QokI7+qB+W3cnqKNFosX9l/5KADX0OZIQqlFLPKloDu7zQkPxpK/pHXCqbz1O3PToaq/eWqOjBNNpSU1fHj6/wAlmrQ2Z+yFoPcK9QM9uNI2XWiWb7MFc6auOwbya+aC7s/iyQijk0he6Mvzrrymdv1BLPtrdu1NQrm42AqAPhtF5BLKpm6CJTo4htN4rFT4YPcATD0xr9oIxy2cQs67K0MPi+dsxcW7GiZ4DNJ4ZxIjZm3fqtmeoMlmKi041FDaeI1eCyQxBfoI0Aq2SaeodmsGAjAI1Hco8wad/ls+R9k5Bud/uK+kYwFUDDOiiJBe0ORgVo6QJfG5iF0rK7BsOsXXMRYVLwwJHlrwieYfJ0nT3IPZ+aXd6PfwxUdbVzGSg1tpMjzK8xx6MvbIDf3fG8bYMXkzcTd0tRdkNnjFmq2iFHrdZFMdysi+HW7i+KwOEUgpXqaPJQGu84dJjZenXUm4F7s9bduimBAeyBZoVVFHg4iPnRAcAFADHAW2oB6B4nBuJF1uq8YHtq8h+bEFSMhWxZdUomA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7JFVUWhXq0mYUYT+lJ9VqmK4xsipyKE8GWVPlKNeoH0u2pev5C/6jNYJk4+NnGFpOObMLX5ZFIClH1PSUtjYZFrr6cJhZ3mwr9jxEENrrGnhtfS6MH0bHdkJLgrUi/vlOgPgoQkgj5yFxlvm6JQYsoPRXT3EBGG9sgaQYebG7Hgjq0RWr4ulhrrPyxC29ZgPdSHAiFOkSUEImop8rxceQdFHzjgw157HV6/OrGCVetzJMg9XJA/7o0G/Kr/ggQ4TVB6IUF/DK1Fx+abfAq6WIn2rVkkeaCJN50i3TqUYoDJgMyTFHFKZv2zReRMbVCpEr1n9tGIyminD5NhtTaPnj9UhSn2c9gInwwMmp6k/Cl4yT+EhJoqdGUj5TqNGNau+iHKcnayOeW5yk6u3Z8gD+C2k11lkjXXLDIvDPpfsSZwMa/0LSK3XM+/YdZkG8oc0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:15:23.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d400828-ef08-461b-d6b4-08df2f3ab157
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB500340

Reject interrupt number zero before computing BIT(irq - 1). The endpoint
IRQ API uses interrupt numbers in the range 1-N, and existing EPF drivers
already follow that convention. This is defensive validation rather than
a correction to the MSI numbering used by those drivers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2:
- Retain only MSI interrupt-number-zero validation from v1 patch 10.
- Rewrite the title and commit message around defensive MSI validation,
  and remove the Fixes tag.

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 632ecab3c8ea..0f49ea6df8bc 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2026,7 +2026,7 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 32))
+	if (unlikely(!irq || irq > 32))
 		return -EINVAL;
 
 	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
-- 
2.34.1

