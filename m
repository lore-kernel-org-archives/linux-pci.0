Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5211AF4E9;
	Tue, 24 Mar 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379326; cv=fail; b=ID9rzgkXipZ97rHDGhRuRZyewmnZmbqzHqr22vvBilNqMV/QkIGZYjXOgVrrANSBx4JHcG+Ql8YMP8Vxg8tmekY48S4KhrbwuJS1CnflsRGys0l2INDPHi2O3+NXuBHmc2HyHvvrOUt+0eRzIbov+7gCdxhYD6HTYkG6ZWVZ5PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379326; c=relaxed/simple;
	bh=y/UAhxdvvHoUM2S4NHmsYK/cDpVGVxeJDIWGIharU0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GyXKPdycaxQi2SOcVCZVCiRuqvW11l39yb6m7mHTncDV/AR3A3wuIb/2DcT17EsJ5sLlcttvGH3qMX14bfKJfZvg3v7+kQAQO4mCR/W1Kw5lZs2ZGlGrcWnbrYb/liOBRLYc90+AjvJrf+QGgmulT/n7U+FhlGbDXWlixNKGwC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=smT63fdr; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="smT63fdr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRvXZmluQCalZRtvkPJqHWxr4pxQRIvr+Nbkkk61aLaKelSl25alnHYXxinl5MElOg6yG4u5SmgHDHqqxVJSBDvoIYSCq8j//5Wy4U6yiPBtidL9megZqdIPRcWgSOjqY1qAkJ4nNnZVpdgEU7JjNtL5xB9MvkZXAJfp/jsKJPrnDZfWzU6oyRn0Gf0GEISU+y6nHQwQD0MU++nWcWJJVzQYEwVsdbTbfRK/JmMpry3B/iJmbRzHttxJPVnoMeLBfcp1IzBoSSTM2lk9yQ6lJhA7L6mGzo2/9K1wNGxw+IpHDCNaUthNFHgDGnPwAT7cSKLyoQkqvG2ictGJN1DtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeAVohJWyDz3YkNxQmhembpIBB4iZIpbWfoIF6M/Czw=;
 b=bIYFw5+3JaGKcY6XxO2NG1n4zwts/097/j3YYofRpHS7ZSFGiuAfDXRd7WMG8b/pk+uD8KFociqFFqFhVPTjANNyro07UWSt+RrDKMI5DMA/8gaIOF4fg1UHcTgTWl3bwsVsgxTeqd+RErYsfFIp2sV43EoDHJgmhtraXLkiXWwqarERE1mwo94HFU6JGXssbaQQGgsFs33z7guAbEcK1a08dJdEpo5yUf1v9AE+CkQghWSzJodnmfk6mp1pz1F/gDtJcU4q+m57p8zwSgUj7B25UKtUM/Zexx1NtdReIWoURbHccubXNXRzuhm0bg37sRj2IuTFnuzpoaVnv7D09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeAVohJWyDz3YkNxQmhembpIBB4iZIpbWfoIF6M/Czw=;
 b=smT63fdr2LdT4+ls59g9MdDHNmxBQFDYl7EuZnEq/nObYljrc3VzdftEpPvOZzQLIzwylBZg7KG/XGhlzlncyWRUVumA2RlAmDzHXeKNpsDV30GYPbeigm9OqLJ3fUXBcE6AdVsqaG/p8asiPex69AFqI55PhMwxOjhJvKaK3LrWo56vGELMJC5jytevwizTOG/oYOrPEmIZsmyjfqdQNjW5Wxs9WvRk2sa4LYSPfRzQ3aopwjzEfdxxSWKbNiE8iOiqergahhAxyYeWuDXk/693iNNms9vFsWXxiICUre9JylnnX6/RCwAGJRiaw0QLWCUJqtmOgw5rO3PzymaFlw==
Received: from BN9PR03CA0768.namprd03.prod.outlook.com (2603:10b6:408:13a::23)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:08:39 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::bc) by BN9PR03CA0768.outlook.office365.com
 (2603:10b6:408:13a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:08:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:14 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:08 -0700
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
Subject: [PATCH v8 00/14] Fixes to pcie-tegra194 driver
Date: Wed, 25 Mar 2026 00:37:41 +0530
Message-ID: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: f0602c40-d557-4c90-00e6-08de89d8c1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6pYv0wbmx5YO1TxlniXM2fRZtwFFZPNmVUZ7JEzt7b3eNAFvCtpd8q8s3P13YEOTKrqolDs9g9REjXDss/5D2F3HUC9EGFUhC3z6FW3AGzCQ+SJ72v7+jTYwsqSdNyIbfnpKDPhIrgWcF5QaTWAfXxHGlnKxuvy9xQVmJ5xxmc/cCf5aBCP0rSR93imySBGSDH4w1OOsWxD3XGEM7O55uuImlmLUhBwYnCrgqugKNNDqOXby18Sx7iRlxxI0YASnBfjEd3ikfbU/raEm03tHFSrYnV1E49N29zl8WZmkTxVV37TlInQSpAq38XArADu7t/vAR34qwt9e9oTI8OnnWDvUXCcZKllecNhLubWNK6qPnkrmBeE2NKj+2luRyY8rK6zb1eWEyiIdc8XdmVLpAMDTq9bM0v2TQn6qqVOZjvq/5YWtCbD7jLea6zWitPcXSvkh1hyvFKqVolGT1XrvCsI2WJQtPQ2J+s5d2Z83Dhja7phlp7DGHhegCpw9wKmBPKG0u3ecWHfj/8b6D2HuSktSSF/lFdhP2xMczNoj9X6Tf/cuewTW6bGBGtBZSF2YHb4aHhEwFWqP3/RZ9k/Mx9rbfyZwP4I59Dsp1TZdhM7Y68uY0da263d0wb38DuAbD17FSnbcux6w6GUR4IwlYVYPNqg73vOtWGnoKp31hvxufsaAKLoTbPEc9ZOuvzd+PqLkn+OguYKrsFnvn0EGJZxQo/c+KDKRmjStIpNjRZNlHH4DZzLRtvnQML4CakkeTrcZ/nPCr4VSm7DXD6zkpIXxz/zleFyrkB1A5a57Sit5O5N9UE6zGPr9LNoT6nXJg5fYC6wsPbXSLx4WdeuOUA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t633YXyYIau7jC5nHnVriBGykCYjhDzIiHpcEzFyFkaf/pbrR03Sc77Ai5uEaCqZxXHZeyjH45bt0FqMnFcxwNrrsgwAUdHUPlIwBac+0fH4BW1ZC0ACKX6fz0D+0IgDZLGEmYYX+duGxio+WJUyQK5dCMCJROAoU1U87ncGb2hfff6KIVDhKeU/uwnCv33L9JYtRSmDyPzGSJSHK52YzlQ7sq2xGAnTc5N5i84/TjyXzB3Q2TpH5KlAgpI+snIGIhOb1ra2zwVdejknWxal4U8B2+f3o7EFvNJrPC9uDplhrPeue2/mzNCHqK59vuvm0Zq7WMNLVIXNKy0B3Ajo4CR7A8HaVR4cZNNjDFWSjQhEh+yq4dFuruxlyS1dZDqBsr2+DaxCyJHqP2gndq8rTjU43RTYEoyBJPnk3Zi1PFIYSAapDo0O2hH9TDkTXaIA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:08:38.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0602c40-d557-4c90-00e6-08de89d8c1ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments and split this into
two series, one for fixes(current) and the other is for enhancements.
I verified these patches on Jetson AGX Orin(Tegra234 SoC).

I added below four new patches to fix bugs, commit message of each
patch has the details on the bug and fix.
 - PCI: tegra194: Use HW version number
 - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
 - PCI: tegra194: Disable PERST IRQ only in Endpoint mode

I added fixes tag for below patch and moved this to this series from enhancements series
 - PCI: tegra194: Disable L1.2 capability of Tegra234 EP

Rest of the patches are same as the original V3 series, rebased them on
6.19.0-rc6-next and addressed minor review comments.

I reordered the patches with regard to fixes tag.

Verification details.
 - I verified both Root Port and Endpoint mode controllers on Tegra234 SoC.
 - Basic sanity Link up, configuration space access and BAR access are verified.
 - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
 - I verified suspend to RAM tests with Endpoint mode.

[1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/

Manikanta Maddireddy (6):
  PCI: tegra194: Increase LTSSM poll time on surprise down
  PCI: tegra194: Disable LTSSM after transition to detect on surprise
    down
  PCI: tegra194: Disable PERST IRQ only in Endpoint mode
  PCI: tegra194: Use DWC IP core version
  PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
  PCI: tegra194: Fix CBB timeout caused by DBI access before core
    power-on

Vidya Sagar (8):
  PCI: tegra194: Fix polling delay for L2 state
  PCI: tegra194: Don't force the device into the D0 state before L2
  PCI: tegra194: Use devm_gpiod_get_optional() to parse
    "nvidia,refclk-select"
  PCI: tegra194: Disable direct speed change for Endpoint
  PCI: tegra194: Set LTR message request before PCIe link up
  PCI: tegra194: Allow system suspend when the Endpoint link is not up
  PCI: tegra194: Free up EP resources during remove()
  PCI: tegra194: Disable L1.2 capability of Tegra234 EP

 drivers/pci/controller/dwc/pcie-designware.c |   4 +-
 drivers/pci/controller/dwc/pcie-designware.h |   2 +
 drivers/pci/controller/dwc/pcie-tegra194.c   | 199 ++++++++++---------
 3 files changed, 109 insertions(+), 96 deletions(-)

-- 
2.34.1

