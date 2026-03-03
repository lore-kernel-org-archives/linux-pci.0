Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F75386433;
	Tue,  3 Mar 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521149; cv=fail; b=kKxGbW5b/g4QFlpVI5NNsLhb50DrR/2dZLpujNF9y9NjqR1dp0Z3+A0RzEzTwAS945nAg+KuM3xg580aBAFkHQKso6ICD6ZHB4z/QMluxhjT6WCit1UCYKinZzauvNmSIxb4kKwt9Mp9/7W0fKJ7x58zKo26kMq5Y19X/TQ0af4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521149; c=relaxed/simple;
	bh=bdfQo6IKxmnnimm+x8G9ot1wFhmhRkMWRVjn4YgOKLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZENbzLdvp1ydHJGt6oOtd5DbBvc5ue/GNBCoOInCoO8bYegkHijiqLQzBTBwPKp9avotZWbmVthgstmtoGsIz03/GmHmbUyjzgk4Ju7fkHxuU8K5YnQKd38onA6dnQKF5dSpFMNKkfNq7+EM7WgNNa2TFZyOOVMq3zapzY5SBno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A43RoLjm; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A43RoLjm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sio8CF0bWmNqY0GUDQyt/EUCvmmQcVYi89nxQyku8AA8N1lxexzztdwHaFrEQqPhpvyxPbaYdIHv0fqEEKkC1CFsFr9/SCNSZfrMvEvuUfyR4hS73HVZXSM00VoQotEfDckQ2ZoFID32QnWm5XdtRkoN8XKj8in8TaniH6nxcyOh2m+UeTrjmIt7qkDwCt5xuf0DJzkq6nR8wc8SHq7b4vq3MXaU5Kh4LSi1jSzD3nqoSUDziFa9LAaRI5cqevQf9nz45QbyvP8tkjlkQlK16l20/7RUVXJc/E3CFRNnSgxDrguWOZ9SjbuZHnM5KYI4i/ccYwtcX8ku9eq1iRRNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcXjwMsL6U1otbkhYakGwN71cGDBk4//c/fVCF4CUuU=;
 b=x+HDPclLSy+tMVt35arxJCu1MRhL8P9kFAgs4/BInXHaCofSjz4JecYMjvjH80sStI6/SJT8vFlmk8J/vzEdymtnwV4j3iC0lySENNu+kbSU+sUQ0A7L1fiAubbSOUiTNrbuSuMqgGY27Fl7yoNmK6oidH3uJqQyCeVyulaeP7JcqD795VryXCQik+F4OClsvbj5INhtCS99JeScm1Vr89U7RrL7VSLaQ70tTgrwhqijOxHMsVPnI4d7sH57JZBcNEa6kd9r2Iyf19JpzbeWpjRQgmriwR42ynk+7gZKRzmg31YDiq9Hst2k4gTzqQAnmLSETcwH5XqaR9XY640wgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcXjwMsL6U1otbkhYakGwN71cGDBk4//c/fVCF4CUuU=;
 b=A43RoLjmmg3on2Wa3cWajfR0MUCx1K948X7GEE+VdsgwPZs/BcPo4MkIw11nOg6vVdtKdsAUJN+DaYOJxHQHjgjC+AzwbHb/g4BKa3Ozw7Dj1o13ukGq21a7JfsXtkrEcScAV0UN40wvMFfqm4jDCHlEnoNd4wPpBaHnFaJ2Ws4gIC3munzwbKYDNbozhI01GorI7IQ2De5BQ4c8jj6p7LRXwsrBnSgxjA4DopSpGib5SZS4U13pNOlnf0auIImD13kX5ekqZ7DW8jpPwHFhxvy3MXqN5t1aLFcBBekiU0h/4C1CmPK4HiItdVu44S3dh/kbgmwp2DEn8Ixn5DgZbg==
Received: from BL1PR13CA0263.namprd13.prod.outlook.com (2603:10b6:208:2ba::28)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:59:04 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::ed) by BL1PR13CA0263.outlook.office365.com
 (2603:10b6:208:2ba::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 06:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:59:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:58:51 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:45 -0800
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
Subject: [PATCH v7 5/9] PCI: tegra194: Enable hardware hot reset mode in Endpoint
Date: Tue, 3 Mar 2026 12:27:54 +0530
Message-ID: <20260303065758.2364340-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d01a00b-90a2-4401-80c2-08de78f25bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	HaS5xyvzqnw2klztCAowpTfeD/JgYrRcFEcXCp46oe6X+iP8SJ1OR3Ml13xO+/CFlUCF575zHk3hQVqw/dJlHXvDsMjHY+Z7an0qHN6Us1eTpjmyHVNgmuJnVqdHpy0anoC6fqVUMsMHGD/1drL7WjV4rHb2T7A1q1blKs/lwgxvy4CSApUGIv7wRIFJSCfZAA5LJiMeI4Yailiara/8TcuFRA702l14dKp3uRWKRmZ+NPBAQFy6G4jYTl7CSSSJwkl4+q6YBMM4vNwBJpntUzb6ThjPvDMImJKHnL4PnAsMu120SkmuDVzsS7XtvAA3uGY6RpDy+xFCWf7hWB3nHCrq+9jrY2DZWRGXuoOih/0GzABHFqatBFj9sp3Qw1e4ozDfaYNWjIBovoefqO1Z4GcguaswK5r5Z9y8KolCW9h5apCjCoC5VPi3uqD+OBQD52/GFSsZBAUONlch7T0G6d777QbUveTn+lRVjWZ52QBX0bSth6QEFxhB35vttJ5fpNXU7+y1LWmADbBkfJumL9d59WxMgKmoqpN5n0j0ELAfiaqPqMhxzCQobOhQRtq2bpRouFgOc226p65cdUJSvUZdfrJsfuT/vqMTqoLXPdrJG93qtlvIQfNJFLmP0KFjz5B6YT/Mw95FUj67gJLVmA5TUJ+O9MA08wwg4m9KAMW8cgcmQYwLI+aBfwTNcBiU6Vmu9YXVGMjlLguyPN5jNlUkVOx5saPkbKN8hHvg8CwdSNHlM8IVeTvAKJ2iIB0Ju2XbP4SMl4FzO+d/rg7gKQjMVkWKBjos+dl5PXWyPjc2K2fU7ZMSjgaWpDEWc4Tl5ZojGkpm3CHEDl4MmTwqSaLqfQECojEfr3uAnxK/OgM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3XZ+GKlc75vF+ruhAD/OX+3EJCAHRBf/zRbP+uma3GNz1JUXUcQJdxeqBfr6GB0/FT6up5mnqeB35rwJ2G+R5l/WKs56ADG8P0DRF17xeDsqrapdrYfgxnrXZkOy3lOW/YbkH7ksM50hJGa+kC6lFPx4mh5TfJc+EdfB86hTjFTt1gGH+GaMDzo56lRu9VxqWMguO/lyixR0nwJR/gVIPg5Zv7bS2JveUZbzrILcivewTRNxtZkUwkzlbcR8VzhaFqgflt/w0NoMi1qnb+3+sRweBceJn4PrlS3Wgy5uXyvXzjdDP3IG07AgLaHBPfM9NcYO4zM/4I0bC9MWjvtzR77e3mRRZAv4jStJ6F+HHTiHOPvTFZjFRk6r9kz4+Zpp2UXPpIz2IK1modg4kqCw4phuJ4S4ZuPZd8SddqoOVTwvvlCD7TyAxoifuH7ISAhn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:59:04.7208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d01a00b-90a2-4401-80c2-08de78f25bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505

From: Vidya Sagar <vidyas@nvidia.com>

When PCIe link goes down, hardware can retrain the link and try to link up.
To enable this feature, program the APPL_CTRL register with hardware hot
reset with immediate LTSSM enable mode.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 918e864b74a7..8f95910e99bc 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1772,6 +1772,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-- 
2.34.1

