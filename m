Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02731A9F97;
	Tue, 18 Aug 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067656; cv=fail; b=F16XaPWfJ5wKlXrhjuhUCZLNtF2gV83CpJ5xZOsFGBC+PFKYAprRl9Ma/vtVmunBxY0CF2o1RBw2tlY7HQbhqiTx0SmCQ3YBh4+7U2CORDuocZIbNrlhgG6kMo3WA9PGfhRdLbsTraxYQwkXi5MwmlInOPqSVkJ89VyCNeLfNbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067656; c=relaxed/simple;
	bh=i71QquEQYj+fi5VcJDdASGbUvzCXkRJpjH3h7ikup+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cxdUujDk4z43OHRkJ3qVLPkfHfN50yoC5UpTH1A6JD2pP+rQnArEfWhY0f1/E6gn5+DyX92MB0TbCMDeM1YpiRpptKTuPyhy+4rADRaIL73rWvLS1VTYkkVS8mK49yyImzwED27r2TzL2Pzwp1RmBayegUcawkQoq9FI1CFD1+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K5msX5jf; arc=fail smtp.client-ip=52.101.48.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K5msX5jf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg4+AXbu+G30pJ91Y+7NdmhPJIIcZdXI2JVMbKUGGPwElQxsweW8zXukrQhnPfBT2aQmq/Jq6LOoDsfeQvxzWxCPjN9h0zUIedmLjp1GIQCA7HjTEkv6gKWu8HU/Zbm5GlHWJBHOM/Rt4u8H6f1CIpwNACBtnY2+ednY4XdB7jtURZUObr0PYH+z+/nS+eZ0VsGyUW7mtCT4/tBD0ksTZGjp84iD2XrGG++uwezOpJaeF3AclA8Qh09eAtno1u/Va3frIj4Dtyll2rhVlD8zE66qT2lD2yH1AHiamv5h3CV84PFcbosEze96NneAhVR4g62A2B3/Rg33q1FflXBckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YjuiZc5zX+AGFTspgfRBOVuphW0KWdkySyUuvt9C9Q=;
 b=F1X6EsbDKfxxdtnq2+7tBM7H8dY6ZL2ejSisyjXp3s+rwoQElXmto5+cYh9jLF637qrtjNfDVC6bZhCnO6kYnvcPGxRVIaC7z8ii17odcGWfkEjV0mVV5mzJLbaMqxj+rUjMNfl/JLrQ27XvNr16+6Xv3sKwYERLkSRJeo+6P4RQOAnQtLQOfOMUYsCSS20+1JSsJA4uhecjrpMYlFHffRAxiQcY2wln73/yFiCvzKG+rBKZoUjtrLhUwl02Qb8RR2Z2CoONDVyInarGZKQI1ygBFrPi7H0dc2RpT7opBb5Enb6/53IKnBlqNEEvWUFLhJTnoZ0/+rXuvQ6BFKmvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YjuiZc5zX+AGFTspgfRBOVuphW0KWdkySyUuvt9C9Q=;
 b=K5msX5jfTQjVsbZCxyh7gObg9jjWOQX4e2zIhmMGeEzuBn84UnyzBRZM5hl/SfGjhSB4faBRC8Rb/RRTTb6M2s5ldEcyxz/d0VGzVQtxAa2yIC71DZb/2fKjpe1UHgm2TFEIlNsdSUnKrg9H9IwheHWB15aJYld3Fw8ZumbuvNE=
Received: from DS1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:8:44f::6) by
 SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 15:40:51 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:44f:cafe::57) by DS1PR04CA0006.outlook.office365.com
 (2603:10b6:8:44f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 15:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 15:40:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 10:40:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 10:38:06 -0500
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 10:38:02 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v10 0/2] Add support for PCIe RP PERST#
Date: Tue, 18 Aug 2026 21:07:53 +0530
Message-ID: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dd8ca7-1206-4587-20fb-08defd3f1551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DRz95xMfaDApG6/GpNRvkUwCGKc22Sx08+jhZ+xuqjjjqMKohZmRpyRsQvwedzioPxBbUjlULeyxczckjMgYZEdkOS9YwJ88u1bccU9D73PAoOQyvuyQ8DXT5XllFB/ldSemnIYWEE7gl4EBialED/rkj6sJmOJHcp5ywalC2zO7+57PaHXvscH9zLi4AbeIpAZXgOeYN11R+FUh8ymK2Ij+KvaJZk9CxSV2iH8GF0WLc3pJ9vZ1jwpUX5K83qJAFoMpRIZnGh7w03FKDo/PWykGAi/uc32p5BaDmIMkWn46vElKfIoh2rs91dwO/q4FyUizr+j5nk/C3skO9BFqNSIoqQQ8uMrnxj2uYvV3CNZVb1Os8d1RkwQI5T524/7jpHu7P98FHZ2ChREsLW+k8Nxg6Ue8BubvlsN/zAxOmROYG6n7NpKXnR1gVArSNSfOBS+/M0YvSstCqfp4FhE8SWvsWfD0BbnZDCfUBvVsGSHfQkuMZ+/lyhgeKGSC/Sxe57wNRR+azpKqjOKUB8oTNSvu+dcjsr0wUH84d1yUGYJecNaBLftBgbKYTjs/qQ0mgxFCALzpMm5MWdHGh+D9p6CuC+vcD3yGYmKmsQXn1fBfXPEhZjMz+imJwXY0rXgdTn/gGc0n3xkqw5DKWkNVygRyuiAj882SOZyJv9dVWFolGvTGy/VoNSwKk1ENlc2850nO36WC3M26qHeftui9Zw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gmp5Kmf27sLlBkUexcERZo6A4Y70lXFt1GmDluikid/WZ4qtDcnYDarEIEfom4PGZMxhSv2p3Xb5txXs+G7/5Vk/3bFQXE1Q/RpDyyoZ/2EtJwEXSYwONXnl6PEHQuMJdrguRz0VzwZJDixci7+vg9tvQGDufMKZYIF/fcZLi081tZrf0J/nDRl01Ya2QTCTYGZf2KzzlfZqaFUnkxZEqNLJzLbw3vnXGN5o6FerChoEc7nulAgi37ci/Ddvg3Fgxj9wZk2x81Zr4Vv1wXDYmLuNqy0OdaAVBT2sBO8RAVPu4IVTYkb+NwV1mnpTIiXhE0gkkHwrcJRm28lwya2AP5D+3Iz2nZLk/8v0387/K1yb9C2wREAB7vhSxB/37bDGzJR/ZFFA2HfRzKMYqcASIZWho1HXiOa95bu0T8PXH7pOtijtYAkbFw3rxzHwS6Pn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:40:51.5184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dd8ca7-1206-4587-20fb-08defd3f1551
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

Add support for PCIe Root Port PERST# signal handling
in the Xilinx CPM PCIe driver and update the corresponding
Versal CPM device tree bindings to describe the reset and
PERST# resources.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 +++++++++
 drivers/pci/controller/pcie-xilinx-cpm.c      | 77 ++++++++++++++++++-
 drivers/pci/pci.h                             |  9 +++
 3 files changed, 123 insertions(+), 1 deletion(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.44.4

