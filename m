Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905214;
	b=HfnlS4SEtmSopmI/QdfBnB/6uGkxLTJbe5mtxLMXW48mSbIEqS4XP6fqGOQ5Jb1Y7bjL
	 mZlevib1dOOQBkZLNKBv/bkJ262kdxPUup1C3M051PdC5TM/SaVr8VCpdxvlGTcqIWfHM
	 eiTlIUmIWHaLTKLYiCausGg1jwUJmPgMBYwHfLdo5eGSJPROA26J+PaLBl3Uy4G9DNHA8
	 c4F4uz3FFi5WCIixzycNcsf5dMBpFhj7fdesWBOLLkIbbBDgnOCj87ZFsoTKDSEC1WxGT
	 uBbNyMWGIOhFk6tUjyFKGd+9rUWpHZ5G9+OfBjCK1FC+5aYCY60P70zYazduph5r6sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905214;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3nL/rDKe8W4TqOceAf8rBqssybDbpY+l3Jy6+ggYxl4=;
	b=NDSdLWdM/Cle6RVm0d+VQtcuM2Y3c3D3Qq7xXmb0id3vLdoUSuDrXM8LO4TGnS+a0KpL
	 ouGjgP+MrX6uxkbTo3n87nbJReGl3jUl77rpVBf8sKjEe+PSHY2VvlLTNUPYP24RIBldY
	 TOo9hGXCzaWOrwaH1BeZbt88AaAcUsWSDmiVerBTEdQLxJk6uFP8VXmbadq3kC/whn+5V
	 Sf43VqkHRkJybfWpWMSrgjbF6uvj0grkPSgCjuqz0Hbe7OTkZsFck7UEiVx3I38ebyMR/
	 Xxx5W29Vp3hzb7UmNHehIkFvdQ58GD8zLv9KUIVttRYqVYtX12N5c/Gmr4iNuwFLE7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OvGu3Mfc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6131E606EE90;
	Thu,  5 Nov 2026 19:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6131E606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OvGu3Mfc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK9Crn7iaZAP5Y07r+as9Vy64xodbZx+bc9SM8hNkYszKzhyL93vAVW2+vGL1q3uEnTYZsJ021Mq1TnDkbUuSBHdBvMN5WVGM0FHzifVSyJeYN7BDWZmQfJW3OeQhXRytHixvgxNxtuX8HbH7QkwB6HaTTfEhVdsn/lAK+sDxnd82ok0UwIv6WR9EPh3om+02yOGjythXZBi8uMPvA8LvUxzlwLOebzoMyu8NgfUNfEbzbixBxJS+v8fSq9oWYCVP4SKHC4zyh1gl3UIj28zN3573TNimtfPbgEfpS9tFqa7IUwQCl4mUfNqmxGf6T887dOztxAOOcFx5Hl9oOnvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nL/rDKe8W4TqOceAf8rBqssybDbpY+l3Jy6+ggYxl4=;
 b=EkcZoq2EL/DLVtwHYRyoT+CEwMiGTvaLGHHfgbNUgHB2MGB6O47tvoID2Q1V9L7tgS0UOOBc/ogl7uSNR5Fgf9i6elu/dY2+ioMCpl/hv7eL0dCCHQH/3iv3fxOATscSheJXKJZvSLg8kPYgg/wyalHP46bzLv5BZIztZic1MGbfFKUtAIcTIf3nYKqF4S1JP6fmeY3BGilHwtgvZne+OUxYrZI2XYkMlt+upIsiSvgJYnYP14O/Mn9rHekWSnCeAymXCXoNVZSuPR63sKj90cvP4xxdj8g475tbfnsaorD3hZc+QmyiiimlX/aEoTdmVrtiVJrn3YDrcJtnPRvtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nL/rDKe8W4TqOceAf8rBqssybDbpY+l3Jy6+ggYxl4=;
 b=OvGu3MfceywS+S/fGCNPFtCR4LERd2tmEXIsnpJlNeFjU1UlwxGBCf8R1u4GMFrmFiJV/PBX4Akw0FN6QZWQsZoGILVIrzahlkyF36D4puS7PfEV0Kz+z3rrK+16z57THmz5sWX8C4+hErZA+N4zuGNhZRy8jftZgG6FvwgESRhL9mHWjDReywRlOhoHguNMESGkfxtg+rPHiIO5UJCBhPiJ7N9q+LMgPDgPyQztnTyjIkdlbH2tuWo6hbfi5hTULjQ0eenZ85jo2PsKcMw+QLlDmbKmav1qL+D0+/HzILqd77SZBI2Z1Yc6xmLb4Jj88BkpOnuEOHZV30+sDXiE0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:00:00 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:00:00 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v17 15/19] PCI/CXL: Restore CXL state after PCI reset
Date: Thu,  5 Nov 2026 18:59:13 +0000
Message-ID: <20261105185917.2667656-16-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB733495:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb2a5c3-3109-4899-5bdb-08df3b6efdee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|261026140227099003|56012099006|261022113327099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261102130727099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9oycil2z5uVXBq0tv0tGzmH1zMdoKfFbdRCZMPwjX41X1Ia88yPi0u0m7No95p5Bmfu/InNE5AE6mnx4dBlNmctA+wrtepS/yQzNTDPcwzxQLmg9b18jBpMqtf5+AAauDFGn+rZfu5+4UR7rQEyKfmEPW0mCFGE3//F9fKj0Yqnk4B5g1KQONUWUbWXsEGRX8XxDOLcJUGUzsWDYIfteV4NZ/lRjcyjnfJdJPDIPyuFQA/ZcTku0bJ2W5SrSi3+kxL4IEx5MEAhkU2bwvpVzDD4520dyzVQrGtt++DPSwn9nvPjkFP/3LKM/gWMDjj1jc7BLX2B+zslRgSxbUsWp9zxQFTLJf9CK2li6CNSNxkQNQ23y2pkZyxEy3cBcMRSDr7UMZ8Kt3mtTNf+7P/8yY2ytl1SKcWGPrFDnslXGSSlzxpvzje5nrlYM/vg+j4XK1aaYUfLsTo3rh+pwxzC7WlN8IsXj3nB1ib29DdsBktASrPNuJl+i4jDpjFsSYFxu5Xr7RfLZTsEdxA9mG/+iI587p2RO2HVHKTcq0NyoUMi7XBx/cAWd65I/4gHt3WHQDeW2M+e795+CwN175HCroQn7HYDtJiS7ZeU+KpHFptbW6WEigrGtU+FT9A8O1NA1JUzCZwp7MuI2XxvbVJd6ykDaV39EA05HS/1zVBHHMhLgL8rAQAj7DCEkGVIiW91+BKrlD58PVJiTjhu6kL5NyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(261026140227099003)(56012099006)(261022113327099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102130727099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrg0Sj1dXjWZNMWsrCSoeKOdOIrmlT6OKlhfR7CRN4VnHGN8ggUqzdbCkaEw?=
 =?us-ascii?Q?l9DAsl/0ZJbJEkH37f5qrx8nMKHH8AXjJNHMLePWK4cj2Atzv9tKoJdKbdpD?=
 =?us-ascii?Q?FOeEkmKHDS8UzaTepPNz7ZgI49L46VT3ho1CXQOqSAMjhRybPzaE1gyV94PR?=
 =?us-ascii?Q?qIpJplnpckYqoZpXUBDeLQDg9mdwuScCmUwnfJoG8/fDdAy7fXJD2Wylepjt?=
 =?us-ascii?Q?bHjn/oomm8QCI/R5t3mjJO3i6ZfKZDp6LZbw+WOZZRHzOWnQsNhIvSISh4yX?=
 =?us-ascii?Q?Ne3KG03+sg5nIg5vix0UHwbbEgY0ZKDFpXB1bOaWm/O0fcEdeYSSo0lK2U9Y?=
 =?us-ascii?Q?1i40VQ9iejIpiZ8rGneOUd7rglW1f9P6PhC9L2LgW1zqPthBFGrf0eJ769EL?=
 =?us-ascii?Q?KuX3y874n321rHZiwtdfQ9gfzDkmazsLuJblJFA5G7K0LH9W3Gd0jRbNbeCl?=
 =?us-ascii?Q?wDV6zoSPKZ+N7yVdY/3Z3Qy9VRtPToCkmWU0XhlgYMGuMkB+swOCOThcLnfG?=
 =?us-ascii?Q?hW7wkWRP8UaUji3ISQVZ64XXVoaX21cdx72OGbNkFMYtv/gRGfJZUCJWI+iO?=
 =?us-ascii?Q?auD+H/5J+vjrONA2Id/ZGMRdQqG80zMGK+YRYafoDuh+J0xJc2sWgys/i/nG?=
 =?us-ascii?Q?mFG17dHzXvECYtUherDoAcBsREq+4vVYMnbrXqrdPZ+xzDPwIPOGOjnQlFCX?=
 =?us-ascii?Q?go5zvYmbizy2GRZ0QXtkK+Ghl9pNxE+wOgLYxm6WdU2itCSO0Gut+S73ZNcS?=
 =?us-ascii?Q?uVPODS3kGow76Mk7yegR9MWGHBzoXD9LT+WHHnOHQSaily7S9WTOl/wnJY3B?=
 =?us-ascii?Q?2MvfDUkIWw47gPRZ3v+LTp1I5TjffXVZ4fdhfWCljcpHBg2Dtqdvc/ehMnYy?=
 =?us-ascii?Q?E95B2BCz2txHcadUkiB6ysxTDJxt4wiArWhK3HxhTpY2k3RrQNJWQjKLCy/V?=
 =?us-ascii?Q?vRtftrjwMDbgAXJjHKWW9hZLObWG6No2erukU8fHj3gMI98sTsxblJwdEQs1?=
 =?us-ascii?Q?b5JLgsphlBXI5jNjFRvCO8D5/r5ljSSeWJZlkG0J+RPojgFg7Z7bfYuqmQV6?=
 =?us-ascii?Q?0Y3oMvyLPM2aAatJg51Vt+6neRGArGibYNyQRFvJ4wGknPEPDrkh5CoM0pvk?=
 =?us-ascii?Q?7WqJ+e+unn9+NkgTaPnwLrdCFxat+1CVcqXOf7Hz3qvl0glR+gU+iRIZeN5e?=
 =?us-ascii?Q?qXqz4+dBE0289TR8nkBxuv69TzNy/Qq2VmywysKua8gihdGd8CmjPTMQWuUi?=
 =?us-ascii?Q?7ZNmEj4RjqHgr7Je3hNHRBWDk4fIDqUqJAg5GsvuuH+Eeanouq65U9W7XECS?=
 =?us-ascii?Q?6tDbtv8WmjmTqf1OlQNvCCjb3YFTF4lpPr/bJlH7iOhmzAbGrRfgFXmZn2A+?=
 =?us-ascii?Q?FxvUnIt7lxmmYt81451ag03hN8X+mnP7uGeablcG7zUHrWnlwBd/WZTshuKO?=
 =?us-ascii?Q?fPRPP4ANHbyVN/TCEH2o+ZaBZmOOxrU67vkhJIKnXkXcRY+vAykESMJlSe/t?=
 =?us-ascii?Q?Z/KqddEZceUSJrD4p8kn+2C+Su9iw9ReA1oc3MTsw1NhaK/GoFZY0xEMvE5J?=
 =?us-ascii?Q?0Nl+7rYPuNFWFw2nCnE0bBjrpOlXE7xls29kF7qwWUHxy93cK6lfjFZFS9Sj?=
 =?us-ascii?Q?C9cXvxbvxcQSqxRlIYYcqKwame4Fmitucso9yHkrWVIOV26TB1a7r9vrXjtM?=
 =?us-ascii?Q?1zvEzqTmAyG1KhGoyQeRJ+RpgreLnZYwUzSHIH3FL375oNrPIgVq62tudh7e?=
 =?us-ascii?Q?JsER3BouMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb2a5c3-3109-4899-5bdb-08df3b6efdee
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:00:00.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HnzvOhaM1N3snIS4Z5sxhxHWKv5RuAXZ86kZeIHIhnpJIe3U64eLslp4787Cob08P27ryWYDzbP+p2daT3JOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

Restore the PCI configuration needed for HDM access, followed by cached
HDM decoder and CXL Device DVSEC state. Set Lock On Commit before
recommitting a cleared locked decoder; leave surviving locked state
unchanged.

Stop at the first restoration failure and preserve a disabled PCI command
snapshot. Keep IOMMU exclusion active through restoration and post-reset
cache invalidation.

Program the decoders from built-in CXL code that takes only a mapped
register block, and keep PCI state handling in drivers/pci/cxl.c.

The restore helper structure and diagnostics follow Dave Jiang's
reference implementation on his cxl-type2-reset branch.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Changes in v17:
- Set Lock On Commit after programming the decoder registers and before
  Commit when recommitting a locked decoder, so the lock takes effect at
  commit (Alison)
  https://lore.kernel.org/linux-cxl/auAg6MFDGyVQvQxM@aschofie-mobl2.lan/

Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=81fff5893a3140361cac625b09ada798afb92e03
---
 drivers/cxl/core/core.h     |   2 +-
 drivers/cxl/core/hdm.c      |   2 +-
 drivers/cxl/core/hdm_regs.c | 177 +++++++++++++++++++++++++++++++---
 drivers/pci/cxl.c           | 185 ++++++++++++++++++++++++++++++++++--
 include/cxl/hdm.h           |   2 +
 5 files changed, 346 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e34d574f6594..9fc9fd6c771e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -145,7 +145,7 @@ void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *setti
 			       void __iomem *hdm);
 void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 			     u64 targets, void __iomem *hdm);
-int cxld_await_commit(void __iomem *hdm, int id);
+int cxld_await_commit(void __iomem *hdm, int id, bool committed);
 
 int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
 			   u32 ctrl, u64 base, u64 size);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ec387070d7ad..ad8cb1e76afb 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -815,7 +815,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
 		setup_hw_decoder(cxld, hdm);
 
-	rc = cxld_await_commit(hdm, cxld->config.id);
+	rc = cxld_await_commit(hdm, cxld->config.id, true);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index c92dbb017162..4f5e843cd141 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -52,7 +52,7 @@ static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
  * clock skew and other marginal behavior
  */
 #define COMMIT_TIMEOUT_MS 20
-int cxld_await_commit(void __iomem *hdm, int id)
+int cxld_await_commit(void __iomem *hdm, int id, bool committed)
 {
 	u32 ctrl;
 	int i;
@@ -64,7 +64,7 @@ int cxld_await_commit(void __iomem *hdm, int id)
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 			return -EIO;
 		}
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+		if (!!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) == committed)
 			return 0;
 		fsleep(1000);
 	}
@@ -92,8 +92,12 @@ static u32 cxl_hdm_write_range(void __iomem *hdm,
 	return ctrl;
 }
 
-void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
-			       void __iomem *hdm)
+/*
+ * Program every endpoint decoder register except Commit and Lock On Commit.
+ * Return the control value to write; Commit is not set in it.
+ */
+static u32 cxl_hdm_program_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+				    void __iomem *hdm)
 {
 	int id = settings->config.id;
 	u32 ctrl;
@@ -101,7 +105,17 @@ void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *setti
 	ctrl = cxl_hdm_write_range(hdm, &settings->config);
 	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
 	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	return ctrl & ~CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+			       void __iomem *hdm)
+{
+	u32 ctrl = cxl_hdm_program_endpoint(settings, hdm);
+
+	writel(ctrl | CXL_HDM_DECODER0_CTRL_COMMIT,
+	       hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->config.id));
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_endpoint, "cxl_core");
 
@@ -220,8 +234,7 @@ int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 }
 
 /* Read one endpoint decoder; a disabled decoder keeps only its id. */
-static int cxl_hdm_read_decoder_settings(struct device *dev,
-					 struct cxl_endpoint_decoder_settings *settings,
+static int cxl_hdm_read_decoder_settings(struct cxl_endpoint_decoder_settings *settings,
 					 void __iomem *hdm, int id)
 {
 	u64 lo, hi;
@@ -230,12 +243,8 @@ static int cxl_hdm_read_decoder_settings(struct device *dev,
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 	rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
-	if (rc) {
-		dev_err(dev,
-			"CXL HDM decoder %d has invalid configuration: %d\n",
-			id, rc);
+	if (rc)
 		return rc;
-	}
 
 	if (!(settings->config.flags & CXL_DECODER_F_ENABLE)) {
 		*settings = (struct cxl_endpoint_decoder_settings) {
@@ -267,10 +276,13 @@ int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 
 	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 	for (int i = 0; i < info->decoder_count; i++) {
-		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
+		rc = cxl_hdm_read_decoder_settings(&info->settings[i],
 						   hdm, i);
-		if (rc)
+		if (rc) {
+			dev_err(dev, "CXL HDM decoder %d has invalid configuration: %d\n",
+				i, rc);
 			return rc;
+		}
 	}
 
 	/*
@@ -286,3 +298,140 @@ int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 
 	return 0;
 }
+
+static int cxl_hdm_decoder_uncommit(void __iomem *hdm, int id, bool *retained)
+{
+	u32 ctrl;
+
+	*retained = false;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl == U32_MAX)
+		return -EIO;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR)
+		return -EIO;
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			*retained = true;
+			return 0;
+		}
+
+		return -EIO;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	return cxld_await_commit(hdm, id, false);
+}
+
+static bool
+cxl_hdm_decoder_settings_match(const struct cxl_endpoint_decoder_settings *saved,
+			       const struct cxl_endpoint_decoder_settings *active)
+{
+	const struct cxl_decoder_config *a = &saved->config;
+	const struct cxl_decoder_config *b = &active->config;
+
+	return a->id == b->id &&
+	       a->hpa_range.start == b->hpa_range.start &&
+	       a->hpa_range.end == b->hpa_range.end &&
+	       a->interleave_ways == b->interleave_ways &&
+	       a->interleave_granularity == b->interleave_granularity &&
+	       a->target_type == b->target_type &&
+	       (a->flags & CXL_DECODER_F_RESET_MASK) ==
+		(b->flags & CXL_DECODER_F_RESET_MASK) &&
+	       saved->skip == active->skip;
+}
+
+static int
+cxl_hdm_restore_decoder(void __iomem *hdm,
+			const struct cxl_endpoint_decoder_settings *settings)
+{
+	const struct cxl_decoder_config *config = &settings->config;
+	bool retained;
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(hdm, config->id, &retained);
+	if (rc)
+		return rc;
+
+	if (retained) {
+		struct cxl_endpoint_decoder_settings active;
+
+		rc = cxl_hdm_read_decoder_settings(&active, hdm, config->id);
+		if (rc)
+			return rc;
+		if (!cxl_hdm_decoder_settings_match(settings, &active))
+			return -EIO;
+		return 0;
+	}
+
+	if (!(config->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	/*
+	 * Configure every decoder register, then set Lock On Commit, then set
+	 * Commit, as CXL describes. Setting Lock On Commit before the base and
+	 * size are written can make a device drop those writes.
+	 */
+	ctrl = cxl_hdm_program_endpoint(settings, hdm);
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (config->flags & CXL_DECODER_F_LOCK) {
+		ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
+		writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	}
+	writel(ctrl | CXL_HDM_DECODER0_CTRL_COMMIT,
+	       hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	rc = cxld_await_commit(hdm, config->id, true);
+	if (rc)
+		return rc;
+
+	if (!(config->flags & CXL_DECODER_F_LOCK))
+		return 0;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
+	if (ctrl == U32_MAX || !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK))
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * cxl_hdm_restore_state() - reprogram endpoint HDM decoders from a snapshot
+ * @hdm: mapped HDM decoder capability
+ * @snapshot: state from cxl_hdm_cache_snapshot()
+ *
+ * Restore global control, then recommit each enabled decoder in order. Leave
+ * a locked decoder that kept its programming across the reset unchanged,
+ * after checking that it still matches @snapshot.
+ *
+ * Return: 0 on success, or the first failure.
+ */
+int cxl_hdm_restore_state(void __iomem *hdm,
+			  const struct cxl_hdm_info *snapshot)
+{
+	int count;
+	int rc;
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != snapshot->decoder_count)
+		return -ENXIO;
+
+	/* Restore global HDM control before committing individual decoders. */
+	writel(snapshot->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		rc = cxl_hdm_restore_decoder(hdm, &snapshot->settings[i]);
+		if (rc)
+			return rc;
+	}
+
+	/* Flush posted HDM writes before restoring protocol enables. */
+	readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	return 0;
+}
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index c07266ab0133..77d0e30841d9 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 /*
- * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
- * memory device at enumeration, so it can be restored after a reset without
- * a CXL driver, and implement CXL Device Reset. HDM register formats and
+ * CXL reset support in the PCI core: cache the HDM decoder state of a CXL
+ * memory device at enumeration, implement CXL Device Reset, and restore the
+ * cached state afterwards without a CXL driver. HDM register formats and
  * programming live in drivers/cxl.
  */
 #include <linux/bitfield.h>
@@ -16,6 +16,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -236,6 +237,162 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	cxl_hdm_cache_release(&pdev->hdm);
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	struct resource *res;
+	resource_size_t hdm_start;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return IOMEM_ERR_PTR(-EINVAL);
+	if (!cxl_pci_bar_assigned(pdev, bar))
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	res = &pdev->resource[bar];
+	if (offset > resource_size(res) || size > resource_size(res) - offset)
+		return IOMEM_ERR_PTR(-ENODEV);
+	if (check_add_overflow(res->start, offset, &hdm_start))
+		return IOMEM_ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
+static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
+						  u16 *command)
+{
+	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
+	u32 restore_config;
+
+	device_lock_assert(&pdev->dev);
+	*command = saved_config & 0xffff;
+
+	/*
+	 * Restore BARs and the related PCI state needed to reach HDM MMIO.
+	 * Temporarily alter the saved command value so that
+	 * pci_restore_state() enables MSE but cannot enable BME or INTx before
+	 * CXL state restoration completes. Preserve the original saved value
+	 * for the outer PCI reset path.
+	 */
+	restore_config = saved_config | PCI_COMMAND_MEMORY |
+			 PCI_COMMAND_INTX_DISABLE;
+	restore_config &= ~PCI_COMMAND_MASTER;
+
+	pdev->saved_config_space[PCI_COMMAND / 4] = restore_config;
+	pci_restore_state(pdev);
+	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
+}
+
+static int cxl_restore_dvsec_ctrl(struct pci_dev *pdev,
+				  const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	if (!snapshot->dvsec_ctrl_valid) {
+		pci_err(pdev, "CXL DVSEC control snapshot is invalid\n");
+		return -ENXIO;
+	}
+
+	rc = pci_write_config_word(pdev, snapshot->dvsec + PCI_DVSEC_CXL_CTRL,
+				   snapshot->dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore CXL DVSEC control: %d\n", rc);
+	}
+
+	return rc;
+}
+
+static int cxl_restore_state(struct pci_dev *pdev,
+			     const struct cxl_hdm_info *snapshot)
+{
+	void __iomem *hdm;
+	int rc;
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, snapshot->hdm_bar,
+					  snapshot->hdm_offset,
+					  snapshot->hdm_size);
+	if (IS_ERR(hdm)) {
+		pci_err(pdev, "failed to map CXL HDM state for restore: %ld\n",
+			PTR_ERR(hdm));
+		return PTR_ERR(hdm);
+	}
+
+	rc = cxl_hdm_restore_state(hdm, snapshot);
+	iounmap(hdm);
+	if (rc) {
+		pci_err(pdev, "failed to restore CXL HDM state: %d\n", rc);
+		return rc;
+	}
+
+	return cxl_restore_dvsec_ctrl(pdev, snapshot);
+}
+
+static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
+{
+	u32 *saved_command = &pdev->saved_config_space[PCI_COMMAND / 4];
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (rc)
+		pci_err(pdev,
+			"failed to disable device after CXL reset failure: %d\n",
+			pcibios_err_to_errno(rc));
+
+	/* Preserve the pre-reset snapshot if PCI state has not been restored. */
+	if (!pdev->state_saved) {
+		rc = pci_save_state(pdev);
+		if (rc)
+			pci_err(pdev,
+				"failed to save disabled state after CXL reset failure: %d\n",
+				rc);
+	}
+
+	/* Ensure the outer PCI restore cannot re-enable MSE or BME. */
+	*saved_command &= GENMASK(31, 16);
+	*saved_command |= PCI_COMMAND_INTX_DISABLE;
+}
+
+static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_err(pdev, "failed to restore PCI command state: %d\n", rc);
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to save restored state after CXL reset: %d\n",
+			rc);
+		cxl_reset_save_disabled_state(pdev);
+	}
+
+	return rc;
+}
+
+/* Caller holds the region lock and keeps device traffic isolated. */
+static int pci_cxl_restore_state(struct pci_dev *pdev,
+			  const struct cxl_hdm_info *snapshot, u16 *command)
+	__must_hold(cxl_region_quiesce)
+{
+	device_lock_assert(&pdev->dev);
+	cxl_restore_pci_state_for_hdm_restore(pdev, command);
+	return cxl_restore_state(pdev, snapshot);
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -415,7 +572,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 }
 
 static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
-			      struct cxl_hdm_quiesce *q)
+			      const struct cxl_hdm_info *snapshot,
+			      struct cxl_hdm_quiesce *q,
+			      u16 *command)
 	__must_hold(cxl_region_quiesce)
 {
 	int rc, rc2;
@@ -441,10 +600,15 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	if (!rc)
+		rc = pci_cxl_restore_state(pdev, snapshot, command);
+
 	rc2 = cxl_hdm_quiesce_flush(q);
 	if (rc2)
 		pci_err(pdev, "failed to invalidate CPU cache after CXL reset: %d\n", rc2);
 	rc = rc ?: rc2;
+	if (rc)
+		cxl_reset_save_disabled_state(pdev);
 
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
@@ -455,6 +619,7 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 {
 	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
 	struct cxl_pci_cache cache = {};
+	u16 command;
 	int rc, rc2;
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
@@ -478,11 +643,19 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 		return rc;
 	}
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap, &cache.quiesce);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &cache.quiesce,
+					 &command);
 	/* Restore cache policy after any attempt to disable caching. */
 	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
 	cxl_hdm_quiesce_destroy(&cache.quiesce);
-	return rc ?: rc2;
+	if (rc)
+		return rc;
+	if (rc2) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc2;
+	}
+
+	return cxl_reset_save_restored_state(pdev, command);
 }
 
 static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 49b36a45c682..94a8f8a1a65a 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -54,6 +54,8 @@ int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 				 resource_size_t size);
 int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
 		       struct cxl_hdm_info *info);
+int cxl_hdm_restore_state(void __iomem *hdm,
+			  const struct cxl_hdm_info *snapshot);
 void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
 void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
 				   struct cxl_endpoint_decoder *cxled);
-- 
2.43.0

