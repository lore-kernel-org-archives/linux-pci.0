Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905215;
	b=wG645tcc3uTSzsw0AJ/yOjdAqgxEzdttDXrQiFMPIbjg/mFd9rN8FB2UZGeDyZc9121e
	 vQ4FqRrKim0ObZRncKF9Cf0Te0SVgQ/pL9rGRusswBrbgTX/8T2XJCH6mmtm0eC43hvE5
	 fa6iGTluG0FOJWDil+pbX3qjP/h39dhiX7SsU+KH64wxzDIwEy+gnicP4IIIrHPVGukZW
	 55IcRKVBTbvqVNXd4AbmYLX6tMkMFalbXW1I4MDvHTeo8BmfpDbLVbeJXjnpnu04EBGU5
	 V8yMvOXN8WyKyxRk4I33o6TUTqli9IglE0bXHG7MPkubisOowFp/ZrQY6KwLR3GuL0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905215;
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
	bh=s/Yk8TTMihgeadVaj0Sb5emW9T6hcIxOCZkGHo1y2CE=;
	b=qxfu57OxzKxe68H+1GJcSJ8CUke3+Ta+CdcclzHmXC5j+22LqubFY+4OOgVxOg0Oftu6
	 gIJWbaIchplXA1mVvHoYm+/OT0v/7zaCiA3nycdSL/PrPEzlFunBS8AkREJgMo826Xu8N
	 x0KZuIylUm5iK2zKtRZ1kabxt2rlDYfW5rMJckzzrRr+wLPxR24DM1dID0aDIkAVy3yP0
	 H138ueKLj+KtOmKFaieQxbt6q2PbNdQdlCFC+5R7hHC91LgPSkKUg6qT1ZFiedjpY0YOr
	 oi91lEO2ANovcngYgJmU70LT/i+RkjjvJy+9yKp4xQC335JCtLZVp2uEMrGAmRmZFBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KJpSRqat;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2E606A332;
	Thu,  5 Nov 2026 19:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C2E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KJpSRqat
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR1QQFqi3K3wzgZRbI4byfT32A4C+zESj5rOYtEQUii8xQw+8o2ZZssW1lNqhlioPfjvtm3/plkoyK7Pmp2DAOQJriaj+ERN8l3Vo+PuJvnC3BsbEvfArAF+sjxJgPwmNnZBWafKNAmHQTy6mPu8vpZjuyKX9Ole7zLyNbyeYXMCauDpsvv4BiUm/P04F7TNgahkiZBvOkGnLkDNS7x2SSDGTCJ/8qo0bDSqTGEMI6M0spsGbGee1gC68tDmxRWa9I7ThEmv3UhZLuXiwNQJW5+4DVWMR2bi4Y8lKdUub5HFEN0SqeS48HqIB3QnI9rgJYD8EYgifpHVcbNL0pwJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/Yk8TTMihgeadVaj0Sb5emW9T6hcIxOCZkGHo1y2CE=;
 b=fg8Pv13791Rto2Kgc8NXEala6fR9yTiqqwI5baWLHqsFehJE2J3m95AUx7tZM/mdHc593oLpwNxqz4y/7YLtgab+Lt12F9HaNndH9gPlOJbgGKmIKYUdChhyAcyKVApaPZ/NwqVQ9IWMTQiuThZTsGSizFXobWA8R1F+2DVG18Uyd6o9irPV8b9HsAPKC3SPowB4VQwrsI2W+ApVzhwiG+z/xEBAHRdl5LrGCZoG6ZwdjBBjQTj6yQfC07WlsmP/3Uxr/oxcxXHKcQjgV90Qt5UoiEzuFhDlhsI9bsZ4hirTIFBaRx0Fdr1PcF7EcBp+/xVS6LQBcDkPHHJ4mmzFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/Yk8TTMihgeadVaj0Sb5emW9T6hcIxOCZkGHo1y2CE=;
 b=KJpSRqatwSJSSaa0/89ztvCXgoi2JTITVht2FeeokrzqYMRwLuO22GNCQSXpprSrliLEFivah0g4UNBUacLN2+AdAP4rRVYCqPzbdXO4ez6P0VoycP3laMB6QsDD/ebDW0v8psZdKggA0QuPMDpdtN2q8G1JNo4qbRbKb2BYjgh5rSKusYaYe/tqcSmcAoJLy+tXFjxQy/ilZrobyCpDhd4Wd9zywOVm2M8CycaeYSrOjUfqxK3EAv+YsFNCDHmxgLoJx6ZgU4Fe8FgE2GKN8jdnxMnGvTplHv9UXuDfGT9fpWo2FUbuy+Rz1cOfn9CdGJJmjLJ3wZ2wwVpDzq1tAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:00:05 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:00:05 +0000
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
Subject: [PATCH v17 17/19] PCI/CXL: Restore CXL state after CXL bus reset
Date: Thu,  5 Nov 2026 18:59:15 +0000
Message-ID: <20261105185917.2667656-18-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 00d95f58-3a39-4037-c865-08df3b6f0105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|261026130827099003|11063799006|5023799004|261026140227099003|56012099006|261021135927099003|261022113327099003|261022115727099003|261021133027099003|261021123027099003|261021130227099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261102123227099003|261026121527099003|261026135527099003|261028144727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8x8xy+gDI1L8vOMbzysLCXF4kp4Ce17n7N5FjuNCx+LS6y3EivqLUk9mxl7Y1p2JO8QdH6tbArOkTsrVTavlbI0FuxTRVEcl7OQU5SpSSoRMWY2YpdkzjliNByk+O/v/f1/mY4T3jx0WZTP9mSU7Wbcvwm07NQ+yCTic0JZz3BnpBLyQj6OT24q0K5ncw3O00bH1JuJloXzZZ38+L4q8tjGHq98Cxw/EWpM29lMV9NySp+IRbo96miO/RJWU6ZMBw+o9sUOoNQnFymBSIb4SJU6IPv6nqVu2ksGDn5SU22VRXCtQc7JafDsbvWyuyIW7ZvkKks1w/DjyXAdmd26AFujNZdPnOv+G68n8Z2eS+j8+EvZmVfQqxmijfW6PNI4nesIAk0d5tP5A+zJ2Q68bELAnIuhlL33iL9NrOUMlcG4qpDlW1Ajpe08XgNqCWJiUgsjODJOuRRNYdbm39nbPkmk/MDe7YfMeAZLVNQfTFr3rQTc5PSWGYyNfGqiE0Q2ekHRFeQfT06M+pzCt10bHjNWC6H6/n8QVKOd0ZOJeGg4M/0MQXDFekAkQGYyl/K35as3e7TU+IyErMR2uqI+w31ShLTGvRoAjGZEzQqy+vJpR0WwGUKlwFkjr5tkqf5lWCQidTqikXeWu6hjwB7olF/1nLoZF8MfP19rvJh0W53wGm/5K7glkf8GPh5hXbjg1f/lU4GN2NUQiYR/YZ7A/yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(261026130827099003)(11063799006)(5023799004)(261026140227099003)(56012099006)(261021135927099003)(261022113327099003)(261022115727099003)(261021133027099003)(261021123027099003)(261021130227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261026135527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rLncJOBWPw0rbCI7fBIh9FzqG54F85iWs6rsmf3b8x9ivVeBfnsw+b3mrW/v?=
 =?us-ascii?Q?fFEf3pkAaRHnF/xmeyC71ZnAelVDepidUFKSUTEgLQKVy3AWVHqVWyq0DuOl?=
 =?us-ascii?Q?PI9PmyDUNizqQyeZKmOLDrxqWa34wYy9mi6bejroSHM3G9uH+DDdHmUWij7Z?=
 =?us-ascii?Q?r9acO1/amKbl24DVnpfOSqTL1WMKW2Y0YpWvaRzWTFULt7KHUcqPR7+4c4fG?=
 =?us-ascii?Q?RxzaasHJprEzEbgBrszH9sdtKUjECzdzDOtnwcEEkOe8ydDTVyLUsKV5FoJH?=
 =?us-ascii?Q?tIB2xSRCE2CzWWE8LydtL64ncP4Nh/R0lWpGWDtxkFZYm5/WvshEcAnYnlKf?=
 =?us-ascii?Q?qvOXmMjQKtPuLU29pe6uzdEHcrWw9kTNQJ0czGMYSnq0vZSFTUSnYh8n3gwB?=
 =?us-ascii?Q?JCNmJOzqKcJw2LRo6Uzj+OvnZ7N5a2Z0gbsg3vBLl+fi3Qy6ozLVMup71coY?=
 =?us-ascii?Q?QGDWimcr17QAKRFaYHe8haQERmHjvSBDOaa6wsVAUezqY6fNOu2MFwkPnNPQ?=
 =?us-ascii?Q?I91+D3td8IRl8lr8LZZ9nP1722xuPtM2x6VzmYR9KW7ZHuWAOc6SI6g+HcAA?=
 =?us-ascii?Q?/zVuTL/wMaL3iItu0PKzKivoeA9w4XRCr6YzywkBHQsgWNUPryLKjsORsvtR?=
 =?us-ascii?Q?j29P6/TlPI6+LPMS692VJXzQCcQx8QTQhj1yPM/YXo2OYBPRFmYBPmjTXeAn?=
 =?us-ascii?Q?vu/ZEzEWyNJa+1x16nAVbgb4cPnnHXinbh3YwY1LgKYxqcNQ4UYL0uZEIz1j?=
 =?us-ascii?Q?abM8DlI9bb9iaBKG7omSvoWyn8cT75QTEtNoTTPFmhujiDYGhGdszpM2zK5a?=
 =?us-ascii?Q?WdbLXyOYeP6fyO6k9PG32+G5+BdVcdJurgJsRbAJ3RSlE5wCbZM21nnV907j?=
 =?us-ascii?Q?xmh0ZwMt1dYHTsCwkFwCtLp7S9CF18gat2aeBge505KdFJl7ezGdDE9WBG4D?=
 =?us-ascii?Q?NYNiFLIjbZMUwjSZhQlLA8+JNC8Tmj6nT2J7+nxDkhOOONgwuN3KGmFY1Dtw?=
 =?us-ascii?Q?P1NBjCTBBszJIuWWfdLf1hoxUJ3KJcCJnQRcDteONSvWVuQUuPQNIEgAd8im?=
 =?us-ascii?Q?61b7OsA6DwPHppi15y5bE30trhJ6CueJIUB4aZnSeLlW7ovzZkh2T3TApuei?=
 =?us-ascii?Q?B5X70JHehohzm5/ybPFtuHFDLb5diOJ4AWr7WFMZnnViZMvRdzkgXvlkBWJ3?=
 =?us-ascii?Q?Odt1EQOor+OmOwn1PSPUY0aBo9gZn2jwYoE60UsDFdoDxXCIZN0ksoSWrDeZ?=
 =?us-ascii?Q?ctfGJCiMtJhgfpQIdxDH+53ZAFeKhhz0W22WxS2QLsZtKKb4QMwHYkeIZMK/?=
 =?us-ascii?Q?9ti7/yroo/REvImJdFLuAfVIDFbac3kueGGWvXHvV3UiAXR9ql66pjazXO+Q?=
 =?us-ascii?Q?s0ZCa5zU6gK2WzytYyRPy/2j0Fg32ZXQoJWL2WQHmv5vFmn3Obf5bqHh0z4/?=
 =?us-ascii?Q?I8Kcbgs9f3nx0igj98hYevsZZwbkIwvW6dkrRJLLRi3qMzO2MxNXgqWn0s0D?=
 =?us-ascii?Q?7HH35nLa/C05yLHFscesyVI/EURnDhXS/xkMAtoLOI7L11uvmCXE+Xxfk+7R?=
 =?us-ascii?Q?M1gQDWA2hX5MAWhg+QZmusBzNfMEotgg9ptr/4ubl8f7mOZ5/fQk/GoNLN+v?=
 =?us-ascii?Q?RnmfR+fxWnZd4gRUAH7sRnv9iHJUNenCQYDauFFvGsw1TFqD7FeJtZm3KciS?=
 =?us-ascii?Q?72l7Ae6SSr+rZ0Zj9fjVe8eDlh2dMXt4Ixl0NeSX11wjXwQDhJBcyJNLyDb4?=
 =?us-ascii?Q?vbM739to3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d95f58-3a39-4037-c865-08df3b6f0105
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:00:05.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZ272iWzkCEhKUmkOVTVj1Ku3fLfYlH5oABcpylfA+TE6GIicbsrEzAoFhxCDlPgpvNhjM1txV0Zhs2gi3q7wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
control state. Restore the cached state after a successful cxl_bus reset
while IOMMU exclusion remains active.

Restore PCI configuration first so HDM MMIO is accessible, and preserve a
disabled state if restoration fails.

Copy the cached state before the reset, then refresh its decoder settings
from the cache under the CXL region quiesce once the reset completes. A
region decommit during the reset updates the cache, and restoring the
earlier decoders would leave the endpoint decoding an HPA range that the
CXL core considers free. Keep global and DVSEC control from before the
reset, since a refresh during the reset can read them as all-ones.

The prepare/restore interface and decoder-refresh structure follow Dave
Jiang's cxl-type2-reset reference branch.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci/pci.c
Assisted-by: LLM

---
Changes in v17:
- Enable bus mastering only after the IOMMU is restored, via a separate
  cxl_restore_command_after_pci_reset() step (Richard)
  https://lore.kernel.org/linux-cxl/auRhJa-nzR0CnKf3@MWDK4CY14F/

Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b93f0c8e67b198a63786fd3721b7177ab9df60be
---
 drivers/cxl/core/hdm_state.c | 31 +++++++++++++
 drivers/pci/cxl.c            | 85 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c            | 14 ++++++
 drivers/pci/pci.h            | 24 ++++++++++
 include/cxl/hdm.h            |  2 +
 5 files changed, 156 insertions(+)

diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index 51df56377f7a..7e0903ce0b78 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -182,6 +182,37 @@ struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
 	return copy;
 }
 
+/**
+ * cxl_hdm_cache_copy_decoders() - refresh the decoders of a snapshot
+ * @slot: cache pointer owned by the device
+ * @dst: snapshot of the same device from cxl_hdm_cache_snapshot()
+ *
+ * Copy only the per-decoder settings, which region commit and teardown keep
+ * current. Leave the rest of @dst, including global and DVSEC control, as
+ * captured: a refresh during a reset may have read those registers from a
+ * device that returned all-ones.
+ *
+ * Return: 0 on success, -ENXIO when nothing is published, or -EINVAL when
+ * @dst holds a different number of decoders.
+ */
+int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
+				struct cxl_hdm_info *dst)
+{
+	struct cxl_hdm_info *info;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	if (!info)
+		return -ENXIO;
+	if (info->decoder_count != dst->decoder_count)
+		return -EINVAL;
+
+	memcpy(dst->settings, info->settings,
+	       flex_array_size(info, settings, info->decoder_count));
+	return 0;
+}
+
 void cxl_region_quiesce_lock(void)
 	__acquires(cxl_region_quiesce)
 	__context_unsafe(token maps to cxl_rwsem.region)
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index c68b08f7f95b..a9aa2e1c631d 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -393,6 +393,91 @@ static int pci_cxl_restore_state(struct pci_dev *pdev,
 	return cxl_restore_state(pdev, snapshot);
 }
 
+/**
+ * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
+ * @pdev: device about to be reset
+ *
+ * Copy the cached HDM state before the reset, so that restoring cannot fail
+ * for lack of memory. The decoder settings are refreshed when the state is
+ * restored.
+ *
+ * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
+ * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
+ * failure.
+ */
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snapshot;
+
+	device_lock_assert(&pdev->dev);
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot))
+		return PTR_ERR(snapshot) == -ENXIO ? NULL : snapshot;
+
+	/* Raw reset callers may not have saved the PCI state needed for restore. */
+	if (!pdev->state_saved) {
+		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
+		kfree(snapshot);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return snapshot;
+}
+
+/**
+ * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
+ * @pdev: device that was reset
+ * @snapshot: storage from pci_cxl_reset_prepare()
+ * @command: returns the saved PCI_COMMAND value to apply once the IOMMU is
+ *	     restored
+ *
+ * Under the region quiesce, refresh the decoder settings in @snapshot from the
+ * cache and restore: first the PCI configuration needed to reach HDM MMIO,
+ * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
+ * failure.
+ *
+ * Bus mastering stays off, because the caller has not yet restored IOMMU
+ * translation and a DMA request now would hit the blocking domain. The caller
+ * calls cxl_restore_command_after_pci_reset() once the IOMMU is restored.
+ *
+ * Refresh the decoders now rather than rely on the copy taken before the
+ * reset: a region commit or teardown during the reset has updated the cache,
+ * and restoring older decoders would leave the device decoding ranges the
+ * CXL core considers free.
+ */
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot,
+				      u16 *command)
+{
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+	cxl_region_quiesce_lock();
+
+	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
+	if (!rc)
+		rc = pci_cxl_restore_state(pdev, snapshot, command);
+	if (rc)
+		cxl_reset_save_disabled_state(pdev);
+
+	cxl_region_quiesce_unlock();
+	return rc;
+}
+
+/**
+ * cxl_restore_command_after_pci_reset() - re-enable the device after a bus reset
+ * @pdev: device that was reset
+ * @command: PCI_COMMAND value from cxl_restore_state_after_pci_reset()
+ *
+ * Call after the IOMMU is restored: this can enable bus mastering. Save the
+ * restored PCI state, and leave @pdev disabled on failure.
+ */
+int cxl_restore_command_after_pci_reset(struct pci_dev *pdev, u16 command)
+{
+	device_lock_assert(&pdev->dev);
+	return cxl_reset_save_restored_state(pdev, command);
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 426b5ee38d04..1d4ba90a6976 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5014,8 +5014,10 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
+	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
+	u16 command;
 	int rc;
 
 	/*
@@ -5040,6 +5042,10 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
+	snapshot = pci_cxl_reset_prepare(dev);
+	if (IS_ERR(snapshot))
+		return PTR_ERR(snapshot);
+
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
@@ -5060,7 +5066,15 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc && snapshot)
+		rc = cxl_restore_state_after_pci_reset(dev, snapshot, &command);
+
 	pci_dev_reset_iommu_done(dev);
+
+	/* Enable bus mastering only once the IOMMU translates again. */
+	if (!rc && snapshot)
+		rc = cxl_restore_command_after_pci_reset(dev, command);
+
 	return rc;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 743e65abd758..2f819e1fbead 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -730,10 +730,16 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+struct cxl_hdm_info;
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot,
+				      u16 *command);
+int cxl_restore_command_after_pci_reset(struct pci_dev *pdev, u16 command);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
@@ -741,6 +747,24 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
 }
+
+static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+{
+	return NULL;
+}
+
+static inline int
+cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				  struct cxl_hdm_info *snapshot, u16 *command)
+{
+	return 0;
+}
+
+static inline int cxl_restore_command_after_pci_reset(struct pci_dev *pdev,
+						      u16 command)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 94a8f8a1a65a..81767f21052a 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -64,6 +64,8 @@ void cxl_hdm_cache_set_normalized(struct pci_dev *pdev, int id);
 void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
 bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
 struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
+int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
+				struct cxl_hdm_info *dst);
 
 /*
  * Region quiesce blocks CXL region commit and teardown, and with them decoder
-- 
2.43.0

