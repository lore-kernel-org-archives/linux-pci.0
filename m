Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827944AB84;
	Mon,  7 Sep 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775943; cv=fail; b=a1P+/jqD8FGVL4nZ7HMuO4cJTHCIb4vUZomW9Dzow7/aJ+7llgh96T4E+63hWoS/CxL1rJG6lEjfOS4hneTs8mCuX8mhO7HKsG22Q5Qw7WFd1C3YdCtvTgNnswYJTj8JzEOCJ41x8VEkJtdEaz4WckTIMX/l/KPWEHVFIOwsxnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775943; c=relaxed/simple;
	bh=HM9TrhCCjLdljc4DIQjiDNqadIFTGnr8GsOQuL7n1mE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n37ad7XTxu/BrdRMNIgbAfU7+ibghhXzsFHpJ+UcpaSb7FWPnTyZ6cyFU0VXr6YDKKJr0owpT5oBTDJOLLV32yOdwHydWP+nvg4X2LFoOfTxXB/fQeN1ZBHuikLkB0NnES0yZMT7N7hd1Fg6UWx0fTHIqrJQ6lIRH5mTuxFZhD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lpcPStTj; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lpcPStTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhgLzxNead4aaqefHl/RbeXibK+T+VuT5VY5TBnboLPJVyBgqrH65SQjz4ceoxgbvoCFEZyUQiyE77YJcLAFQZR8STkXb13uqnsVRi4DqRarceOlYkdgwcjY5mAGOyuZTfbG2DjpblO83XgcV3Q5L+HEGBxQrL75R6z8gDa7sXHP/d9xubWMElDGBbPhadgFCy3IukWjNMbd1v8gxsgYOKbJ/TGwq6i0msCzjAOkp0w1ILe1V+ifpd4c9y9ZHh3p374Z4W0xJO7Rv9LXL1/3bUej/tr0Tz7L7qiF7Yyb3zqc3J7qX9bJ6eSDQEgEIB0UeO/m9/8YtSIVkFMsLFdt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zT5aBq2yTyYPf4OusyTnyI7mbidNwbqOD6Abvt1218=;
 b=Y9oAj1bar7No27i+WlFTiBqI74PhfdPjUSl0A6t6xoyDbhUXMeDmxFGYMRhWqj4+nid4TtNMDgZEs+LwcTzrkH69RrAU8Xs1qSXQsVYfFQYXF0AlF8PoY6b6tQFuX6//OalAmaPFqyquC8tXg8nYWHGgSTgH3ncAarxN9/SgM29q/SPIEwRQj9Y1DtRF/b94PNbEaXhTz4mC9VUHmFM4J8Q91nxOPb/Ipnzs5tdc0BzWXJi6h6h9LnIIqTkrcM+vFfk3/WHIOd+GKhuVdAmClO7rtbYxjmVmbjEVD1mcx9WcpyhytpS1VxOtLPyAzL6ERi9BWteUs7htRzGrv+yvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zT5aBq2yTyYPf4OusyTnyI7mbidNwbqOD6Abvt1218=;
 b=lpcPStTjsGCdCkn0PTD8frcQpYw3jqAeqgA7BIlhgDw5CuTLGYeNMa2k/9jTz0ewq7uv8IBuiMCALlv1w5ivBbbzcmFSSwWrIq6ClOCXKy7RGf1axMbBmtvnT20B9nrK4Pza0B1w1TD2hALqQFsnwXlJIdmXgp0SNZqOkUACkrg=
Received: from DS2PEPF00004559.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::512) by BN3PR12MB9571.namprd12.prod.outlook.com
 (2603:10b6:408:2ca::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:12:18 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:b) by DS2PEPF00004559.outlook.office365.com
 (2603:10b6:f:fc00::512) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Mon, 7
 Sep 2026 10:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 10:12:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:12:16 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 7 Sep 2026 05:12:14 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v5 0/2] CPM6 Channel Separation Support
Date: Mon, 7 Sep 2026 15:42:11 +0530
Message-ID: <20260907101213.1917064-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2a6d49-9a9d-4864-d49c-08df0cc87f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tXuAjHb3DlpbSV9NHOOPiiJUCgoLyA5715hcLLXis3qQ4hxBgniSHaOGjoevxG6+IcjnjjkYZPzExi8Jmy6eogCLuhvswv3svQgOEdPNoBB9YvF36LQ3Hw1aHwDL5hnNxKz3LJG3BxbI3qzg2wRT4qfFrJ+t45naukNRUdF/0M/W3WoiUH5PHIdCnufWzgQfbKqg4bVbsHA0wSVbEmGmOfe54i+kG5ziI0rAhGCQFzjAG3Lf2ujjx5Iedavu4bBBxMCk3ftvze6rNQ8GdXPsaceSuKCgrtZHiCR0ypz7JgwnekeqYIc6cjk2zxhYbpIFYWHZCWCqpdqwFcE6QyAtiiHn6ZIdMEvZhTPqzi+B3lBDLJBpo3bfFXd8y8sv/9wGVaZOdIc3Oz8mFCZCUM6aWjpUs/KQ4tktBfAAz6zw82kOWudxpsAGzqMd4i29a5biojegICJwuAESKamKxt72VIuXTyMZduK0m4QNrKGD7vEBcnDmZBH2Upur8Is0EY4/8tiNFKAI97al9rlSbbCVcEnwF4mvv1EcIQ+zWpKvQO0qCZD2L0KOeobuShj9znB6G/B1Zid8y2+O1mWXpTt07wzctp5J+rDtIqTaI28jlid0a015RT5atd18LMmB5z5EGU1n2uld47wWnN30OZnFwSyUgCSYAcU/4/OUaQQfPxV0dXpuAlPiCk61XIe7IKUbkEC65twtifDOKLJTpzE8PA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZqLFoRIM1loP7qWjp9m3AT136NERWopUwyIBGUC7SlKVMKqCwM1yV4rBPRwk6etWXA7kjQtUEt/JBTWLeis7eBsPB7hPeBa/hTLs66BoDORXqX676jM42X7LgS+4yCIv97qP3e1kyx4GAkw7fuTGoGlMGZe2RZ3AXQbZsLOZ95HdG+IHB57HRVK8Siqt+sYcu+bQU4aD7O++upLOA9K23g4mO5p1ZiXD3J46NHHFbfmRwU1kSIyggGMxIt8zb7AtAabak1ZxwpdYGt8UvstrSHNZFlIEJzY2Qw0KHRPXB67/l9LSQS8VFGx6xhoBQlvnV9Qdur6AV4lxWXuPUhsBZJBhT8USaVTLh/qyP+xQz6273ZX8CL5CCLlcoT9fC8+yfCUjeT9vAj7/Bz7kU67EAFCjE5SY3cdXRlfOIZ3PP9YirZcZSHiADjiE+P02Pa4N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:12:17.4373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2a6d49-9a9d-4864-d49c-08df0cc87f17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.
In order to use the VSEC functionality following changes have
been made:

o Utilize the existing VSEC implementation to retrieve
  the channel separation and translate it to correct size.
o Modify the structs and functions to calculate correct
  DMA channel register base using the channel, direction
  and channel separation selected.

Devendra K Verma (2):
  dmaengine: dw-edma: Enable Chan Separation via VSEC
  dmaengine: dw-edma: Add changes to support Channel Separation

 drivers/dma/dw-edma/dw-edma-pcie.c           | 18 +++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 ++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 +++++----------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 ---------
 drivers/pci/controller/dwc/pcie-designware.c |  1 +
 include/linux/dma/edma.h                     |  1 +
 6 files changed, 40 insertions(+), 30 deletions(-)

-- 
2.43.0

