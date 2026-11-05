Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905193;
	b=NjsGTIjRGjl7b2/j2NlF72owl+rfuOKADpGEJHacO2SJJonviYeqvl/WiloABd/rK6ba
	 LIpAaaO9gzJnXMIWG6/snTYyq8wFyWMCVCm1OviIilJqvrOvT8F3wIp7F5LNJIyjTRd4a
	 SrKI6UaPhGuIROXRpYsZPi7OPiK0CVeirYdK94r2s9maM1CJRwyScuOMdYz/7AIBX++QC
	 2z0BgnRAZGtW9DUsSW4INoe0Banf8smPxg2FoNLGkN4lFzUrXJZ/yy6CXG87dYfdWyMBP
	 7eE7JKbS3YaZWPozbyrJ67nse29JqsCbjnDjOpZ/+JWiYb5SLEUEUFuuXjpQIPMHerA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905193;
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
	bh=K3wsEGnIorehgge54Y5B/uaFArbFlFMksaBviLQ/AJc=;
	b=PI2RqmOFqs/PyI6HapCpJqY+MUw0uPtFN2vzgVNNSNglYcKWl99+dEe94GALwjONASkr
	 7Q/ym+a/ttqBc7yqVmPZbiqyQp0UdwS7XLvXiBBdLEFapeBerlmvaSijdYK/8+Lku1Gjy
	 a7trNtV1FUaEnD2sj9XzQPjVmc6kxg0cxpIcjOp5W/5+LK5JtbI49ymehPisKD3l/wFzt
	 jBJT6KroyLqlMfdiryPwvvfg6X7l/hw/DndVKDTTo8MrE9K4B0swJBMWZCFzJ/QMzS1Ry
	 1AOxYAnc75KPHLRBgDoJaSt8azop4phc9yZlsf9yn43ANuacUf5zeE17Sqz8TE4GNRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aGi5HFgZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.43
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6E606A328;
	Thu,  5 Nov 2026 18:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF6E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aGi5HFgZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaRLETiRUsHNGxmtp3lcxOSnmM5O9LDLW7Xqd1JEFthYcfXWWEzftMkMMB17uUqwWJaKcqIf0w+k2xvx4EV4NjEAzcHuVmir96HWix035ukW9aaHcD2XtRA0WxyjCtIfqpzCOxTUbkOZCm1VeSZ8k7ckPItdagywkuvW7XOjuAs5EjVGN7K+T2Uev0m+bxtikQ0x5fiz+P8vQZV0Bkty1YG2ns2p+fvLnVIrceVy+NzYeJboSMcaDYaSPSy6RlO6kWtQwCyPwU9ACreW6xhBf765Cl3Ta3af3SWeBERZ34RHoOZH2WnZBvdRMdpG9b8IbIb6poGkjc0RIDB++C1Oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3wsEGnIorehgge54Y5B/uaFArbFlFMksaBviLQ/AJc=;
 b=it33gvuowHPwyCgijF2GdkH16eUhP0TSUKbXyML/05Xjom9skuebhp6Cq/lYZCk3BGLhMpiwlQNnxKk7RhYUimtmg6t6bwWqS9ZOsqpYE9WkgPphIMUVGxxGvJBMfjc2kbtietlyvrxkpC2mu6vmrrxnyFMIt/JZqaTvpaeNALGWGu5wTZCd9R2JjGEAGsUNTBfXBn9dVzLJBe6Wl0ek35iFDyK+FllsjRZ2+6Mpp/jFNazBaqcTfJROJA+3xRuzTpFdJds9X5Qj3wMajJRwDIeAzv8KHBkE1+nno6k1p2KuwG34aYQQ1iWHqGcsDqnxxTX19rJ93DGnJK8/NDmXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3wsEGnIorehgge54Y5B/uaFArbFlFMksaBviLQ/AJc=;
 b=aGi5HFgZTXD7P32xzwmBilGjOT37u7mixwN65iU23JPiLl7NekecUa1QSLYFJ0e6dNJ+JwePmN7qjTUb4jFuW8Lldp4Zd8woNMAZoPes0yx2VMUC/AXqwgrrOpDpD0/XiHefi7cByg/5hsq7Aw72xuu9sKl1CxFt4kXb7vbMD4/4vp0zH1EqGfqXH1ijt9+KvgOdcwyMWPczfYd37NRg9Sp8SaZgAzKHCwWpcnm8hdOC69xbIP9Wxh5kXEcwkQbWCspjhTh6Hho7p9zg2NpJp/S44dem7Dj2UZEAigchGil3KEMjCjY6ZbwDEtGxCliuigfngTvJZd+ARv4b6jkRXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7884.namprd12.prod.outlook.com
 (2603:10b6:806:343::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:46 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:46 +0000
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
Subject: [PATCH v17 10/19] cxl: Build register block helpers into the kernel
Date: Thu,  5 Nov 2026 18:59:08 +0000
Message-ID: <20261105185917.2667656-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f44f10f-79a9-445a-7bc8-08df3b6ef59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261026121527099003|260925021911599003|260925022911599003|260925021311599003|5023799004|56012099006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261102130727099003|261026140227099003|11063799006|261009223027099003|261028144727099003|921020|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RObixyYpjPYcosVgelOKhiqorEcxiy1Z9CPttzZBbOeNLq0YnWeN4scm8H1oYW5guTeVp76Oumwc8IwkwynSjJJ7XJ2q2jRtx667xrmD69zvzba8V3gA1M5zd+iJ8Er1j4l0saK/erFOqiTlfCSCOnba8m1BBY1mtU2tMcb0k+lj7ygw2gM4Po+6xxhEnE722SFJ7Er+tpQyv4fam/jdaRPcAh9CTBvBSc9aBfpogKaIZIxn/uvlLtUSxT0cCYBLuBWoIfZrzSBHfB4g8ZmDR6/ma23yBIR+Yi9wQjrno5ZDkdwynE7fKWxPFcGckhEbpuqw/MY9qC9l5Jgyhn/wdso1/I75Ev7zegH6RgGvbrPpR2MYI/qL0EHtC3MnCb2LTOGfnHLhOcpNunYr5KV1GEA40nJ2DjVK/ETK8TrdocAJGye/oOxeRUJe9QsLbf1726SR2Wc8BiptzK0Qit97sOuzWXjQzmoY/xLFYVE8O4LRnrF/dZ5tdlb4XIROOQh5byrCoADPRlEmwuIKQHd0quFWnexetplfMQuCo0Pp1FROcmXKo5VKCZBW3RnK0Hq+u1nc67Wa5sXJY+FkPfdn+0vfSocO1VWstxg0Dcr4wo2zNWeXQ6XAl+VwNLfUDN806R3GeefMsa5YgOMOwQ0cCrHVvidWOd1GdqS9k4LWzvHfxN/IEaMTx1X4lSetzhvU9UcttFtObkZ2sNCvhdzjlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(260925021911599003)(260925022911599003)(260925021311599003)(5023799004)(56012099006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261102130727099003)(261026140227099003)(11063799006)(261009223027099003)(261028144727099003)(921020)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GiDpe5UY1/FNRj/rLrtqgK8kqjITnD418g7Mk2mOe9awbKew/A9IRHohxDBQ?=
 =?us-ascii?Q?Zon8WLhWmyNJJfSFhxaJam7v81MLm42dDmaOh7bl1Eua72tfZC+OvymrGXPH?=
 =?us-ascii?Q?atygy/xXGIbT8y8nV2KZ479HofSSGD2IZByaSa6LgQDSNO3i8a/02tUKHjwV?=
 =?us-ascii?Q?M8u0qkKalDCuGCr85Ix+gvEtLCiqisPWUxG19fP+2nuNBM2ZUUnCuSWk9JhD?=
 =?us-ascii?Q?fd/dejRljh8DVqugO7rxG14IdUZDaEK3g2m17H5/PozP+Am+KMVfvr2Dovzv?=
 =?us-ascii?Q?dQNDize8vkdL3+rYeRCl5Z+ptD/bWFv+IzBT602F/3MBQS8jX2bv4m9AjcK1?=
 =?us-ascii?Q?9bI1nf64McPjA2qSfchruinQS1H/vy8vkQUPChtF3KYCRcpDhvZmRpUGH19I?=
 =?us-ascii?Q?WSJPe+lxQGvy7jWMBnpQXTIxBnrZ55yrIZsyN0CRQyIb1K6MbkgXG3MYduhM?=
 =?us-ascii?Q?MXm23PrGXcGl1/GaQlcFf8XSss1xuSZzkIHKBnZO5y5pcr64+l6IyAlsnUQE?=
 =?us-ascii?Q?OXJB9uf4PI2ymV67B47NIX0l5lFGtGSFjT4SGEjBJDnj79j697V0YpJFBPV0?=
 =?us-ascii?Q?1vnw83wqBL9mcpdxWWSs0bokKFGCLKS+ubqvOS7kTqB/GJYIuo2R1QS9Umgo?=
 =?us-ascii?Q?JLGSCye54DV3LlImbGcikDDYJ5oR7OVjgkqEjeF+1M6Sqw2vXkUyWcWYdpv1?=
 =?us-ascii?Q?d7XzIed13fLdKX9tS4NIU+RziRpl2PZvC0r4qfgFLhyqZuD6QJ34epoCH+ck?=
 =?us-ascii?Q?WTzSGEPfV861sW+NVp/pv8K78Lcce+OE98iDWBEHbyDSvvDeEoJ9Us43SDzf?=
 =?us-ascii?Q?zLdKwgMsbUIG/TC+PXiohmAS667J3dpkNy/4OdaGb6isYJjirrbW8XHyUEjm?=
 =?us-ascii?Q?xnAeCDlcbpCtMlJVCZUuF8amcj9PAT4f4rrgLDeXDufeh8RwMxFRYmirubqB?=
 =?us-ascii?Q?GrNXC7GURoQZGs/EDtt1GGk06NkNlOfC4B7zdfUzuv14oBItqfY5Kp29yljb?=
 =?us-ascii?Q?WQH/jbJHPSBeLDCyZXcp0/o8QBjfc5GIzaH0OgWHQ/ty6dMOY1cWR0CB+3NC?=
 =?us-ascii?Q?TBqukQuFNBRVShbxUbIkHBOFJ0jgBTcGlVraDiys+ZK3uiIRuxm6He4fu/I1?=
 =?us-ascii?Q?I9QLAyQVU7IYd6/NEADIW0JEPh84WUbHiFZOQ7JLZ9l1MoR0smEn46XwyRQq?=
 =?us-ascii?Q?95YqaFdN9iPZSe3MWabo7Jph64XIKVljFo8+pO9Kd7j4iiFERFUtO869ucQ1?=
 =?us-ascii?Q?ueiLBFwu+iLZLqn7DdV2wFcbHOHY0V2E7kaasqxP87aKPPY+kIQfXOcIhEJA?=
 =?us-ascii?Q?cRwPAF7vRagPagulQwB2hdEoxSqkzgOSacdOqW+OsdMMHllH3r8WJ0Tg7H3/?=
 =?us-ascii?Q?tW6Wt3lC65x312i6BfGqrJH0PJONpQ2rud7yWkhzRfvCNtXYyKiAiZLnAhOh?=
 =?us-ascii?Q?9ZH05216RLOxvF1YyhSz+KzY9miSMCjY+cwVZyNKsIu1ckUOGy80zowiNpzW?=
 =?us-ascii?Q?dqbqDl5VpDtC60k23Kuywx3XtpMVi2b7k2DAOoi9Aa/W0wwO7vzvywdXJAXC?=
 =?us-ascii?Q?zuwAcjoQVy/UHvC4ShT+qFkzsIxJYdie4MctUfL5liAs6f4SOmW6meNylFPQ?=
 =?us-ascii?Q?gPzZgjNc3E60Mh9vZ2hav73TjnZxQ6X6EFHRWUFZVlZHCnF3ZHpNqt0SdK+1?=
 =?us-ascii?Q?3iNOCK8vRwN0t4C/LczLHsoh5b3Q+LrH3oKaM7eFobVBD5v20oqp5ijOAO9s?=
 =?us-ascii?Q?u2Q8RzxSsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f44f10f-79a9-445a-7bc8-08df3b6ef59a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:46.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx5dXM68eXWgbdHz8aIQHv6LAUYXPul+aUEHQswuw1NnezxEbgein5o64/FkzDIWuwnayEyKo9U/q8hPAytO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

Build register discovery with the built-in HDM helpers so PCI enumeration
can use it even when cxl_core is modular. Export the interfaces used by
cxl_core and preserve the BAR and offset in the register map.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/Makefile |  3 +--
 drivers/cxl/core/regs.c   |  9 +++++++++
 drivers/cxl/cxl.h         |  3 ---
 include/cxl/cxl.h         |  5 +++++
 include/cxl/pci.h         | 13 +++++++++++++
 tools/testing/cxl/Kbuild  |  1 -
 6 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9971efb237fb..9a77e68d44ce 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
+obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o regs.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
@@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
 cxl_core-y += pmem.o
-cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..def3c20d1a7a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_FOR_MODULES(devm_cxl_iomap_block, "cxl_core");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	}
 
 	map->reg_type = reg_type;
+	map->bar = bar;
+	map->bar_offset = offset;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
 	return true;
@@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
+		.bar = -1,
 	};
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
@@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	}
 
 	map->resource = CXL_RESOURCE_NONE;
+	map->bar = -1;
+	map->bar_offset = 0;
 	if (index == CXL_INSTANCES_COUNT)
 		return instance;
 
@@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
@@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 
 	return component_reg_phys;
 }
+EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
@@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 688350c7c5fb..ad4e80be2bd7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -239,9 +239,6 @@ enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
-int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 341a7c52894a..ea23bc15d00e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -27,6 +27,7 @@ enum cxl_devtype {
 
 struct cxl_region;
 struct cxl_hdm_info;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -150,6 +151,8 @@ struct cxl_pmu_reg_map {
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
+ * @bar: PCI BAR containing the register block
+ * @bar_offset: register block offset relative to @bar
  * @reg_type: see enum cxl_regloc_type
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
@@ -160,6 +163,8 @@ struct cxl_register_map {
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
+	int bar;
+	resource_size_t bar_offset;
 	u8 reg_type;
 	union {
 		struct cxl_component_reg_map component_map;
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 3e0000015871..b15d7e415e27 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,8 @@
 #ifndef __CXL_CXL_PCI_H__
 #define __CXL_CXL_PCI_H__
 
+#include <linux/types.h>
+
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
 	CXL_REGLOC_RBI_EMPTY = 0,
@@ -19,4 +21,15 @@ struct pci_dev;
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		       struct cxl_register_map *map);
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map);
+/*
+ * CXL r4.0 sec 8.1.3.1: a CXL.mem capable device reports one or two HDM
+ * ranges. 00b is illegal when Mem_Capable is set and 11b is reserved.
+ */
+static inline bool cxl_dvsec_hdm_count_valid(unsigned int hdm_count)
+{
+	return hdm_count == 1 || hdm_count == 2;
+}
 #endif
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..e80500f457a9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -55,7 +55,6 @@ obj-m += cxl_core.o
 
 cxl_core-y := $(CXL_CORE_SRC)/port.o
 cxl_core-y += $(CXL_CORE_SRC)/pmem.o
-cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
-- 
2.43.0

