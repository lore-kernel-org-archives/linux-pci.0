Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285885;
	b=PPqAhGbfSxCYvIUm11vsQ0rLN2Q6Oor+/XTi8KxK2/1yiLp0XZN6sK5igtdekgiDtXxI
	 caaX9KzFA8O0t/BB2bjAPVDs/tDfEIFguF3K0v1Pch0W+RJV/Rrog+1o22/1nromC2My1
	 yF4bCh7pBkObOG/+7+wg29TM1ohBBbGOt9YfqUCoJFb05rVXzeaZQHxEleZcuho4XkOkt
	 CA/GiXCmX8GVcP/albnqMqCrtdRuwXnqPxkJvtdHya1e7zk3mDsKX5a0+PaTV8hIXzObc
	 f9vjPZI/B3OPz3LmUwda9zc2FiPW36tdiczsw/y6PoYwNdKJ7iSmWO5gK3E5DfCFzbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285885;
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
	bh=s7JLoJ70AJ8xn90sKpkhMT8EGoDbayjB+Le773b1iCg=;
	b=MAg32pAaAiBKF8KCzQoE/8fLjqj9WF2pgeCkdNZDeuOmLCviKZmO5kXG3SqP08SNoTKI
	 18jZ0LkP92Oj6c37+tYONS/tOgAwQhUg7eSFjD7uTLbLqnckgyUO5wz+VKkbikz7zbCPV
	 99Bx1mg0fOVp0IvEvfJn19yvBojXqFjwMMXFAoAFNSMxgKrNsHAJes6ZMvrrDFBHHVa53
	 OwLhc/DOC5sG4iMqaC8askc7iRxffZdcsSWr64yjVEVWxpMQxkTAnjJSRezrnmVUyWLQ9
	 APbEpo/EUp+bQOcytg/WlYNpJN0dFbwzAVnhyKrdLCIDG8UPcaqQVOefG/XNJF22CqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BvWzptN7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515E60A2608;
	Thu, 29 Oct 2026 14:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2515E60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BvWzptN7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiIvbQfylFoCDyjfzrCBtxffqx2jCSkigP6fJiNbW7onCdSUuARjpHgoKonwiRt+UpPkVocvAS5HtVMRV1ZhfBLEHC5jl3w2j1s/aZhrhxwK7Fmy0eupg6Vi6j3k/ht0VoQwJiZZ5zQb1MYdf2O+EyCdkVBS/vR9HeVdQUPgilt4WldbIxT68mrgONKRDYCOZ6EHL2GvA4iwqjHnfL36+9LyACo3GlJxn3bPlT9xfGDibHH0707IzypcOiGxptLGyXlM8+WhwSZ+Uqf6D/IRMMEG7hv6xPVZNLPjo5mU270Xs1gDZsdwjfmtoSEeIqzeMY4Td1gFUg1ksNvMjaN7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7JLoJ70AJ8xn90sKpkhMT8EGoDbayjB+Le773b1iCg=;
 b=WJnfzf+5cPVpjv7YLrHr/UEDm4Nz0yHOj8na6KFJveSTIXSZyQzs8fU3H1P4Mwdg/j+loV8DH18fCJ4dUqaA9czoJytCRMRBbzZ1u02snhoD+MNmkuKBwAHw1n1WQCq7TwFqHLgUdn6fYfpinPQVpCveUttGOcYUACGGIzFX4l/J9dra/WrfLGM+Yp07oXuVN38DPpwVJWaefGPLRMycNuWgPUrPlQr4haDGlogb+v3RjWC2E7ViEnzow3KBBefhvPDne8TVW3msVxGseZfUO6K+NWLwY2/uI09+lK8jF/Nm3Gq8ynINwdHdZ79ljWvpLHimfkGuor5CXkasuDJZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7JLoJ70AJ8xn90sKpkhMT8EGoDbayjB+Le773b1iCg=;
 b=BvWzptN729DX7sVxHiVo9+Xa1mQnktOm1sgVR5XBdco6UDu/b/34I0rlu4Eu3V3pRTwLAG/otPl/ckRA+b8BucWl5ElnqSs5omZwPZXHAF+a3TBnGVTTAmwp0T17Cp89p6Cfpp+cdPa7kYNfqKcNBJB/JO79kr+/f0H2jcRCpVrNKgFgqggyGoBlnxGFWyi4F0I0wvTnc0DkwrYWaT0/7xEZKa6pcwD5U9Mn+Diko9vZWHJDSW1u3P6WUBID15cdRJmYItPqosliHyDcPxMTGJQnPDu4cwATkopvyLQHO+Bt0vI0gtOURlE6WzmFsB2Bm/SnFRycTds+gjU5o/jxgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CH1PPF6D0742E7B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::613) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:51 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:50 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
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
Subject: [PATCH v16 14/18] PCI/CXL: Reject reset with unsafe function scope
Date: Thu, 29 Oct 2026 14:56:59 +0000
Message-ID: <20261029145703.2185231-15-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:510:23d::26) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5d3d8b-3c86-4dc9-fa0a-08df35cd008e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|921020|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	O9ok91ULRpAjOjjEIh5SaQerRZ5Yj4uA+ID1OCggzfFRVmlGIbZZXNV+RwNPgGGF2PkwrLObfyzvCPE5cnGFrwF5cDekitOACm2b21uuQx3fVYObj6aiHAFbkDRlE+1b5VS4Rrb9KMJFt0mrb76MmBKxS0zrVbG+0RO/ea4DmrhyZGnO61cGu2UrDmPNNTqbp1jJlwudNXwsONQzrzqDntphtRtiIlq/5d8UM2dl5TRDO8aQFvDbSXPYUjMl87Odzj8D/P7j1QjIatoddlXMQcSju+1+qU9SfVUibiZmejZtR1XiD2VX7iqbLvsut0et1ZYTZxncVTp/Yle5i3V9x+s2BbzQERB1guxb0JPqACnHJXiJ0TFR13wfM4pwQ4SsxyNkTJnvpCLWc7h2sFN13SDCCKOpME36WPTzeCIImIfhhGwTEK77Bm9fiD23UFHYQuTu7u6fqA5pIcB9WY+n9Qa8oYA11xUP+leE+isTcmN53F5LQeZIyeqYvbxdOqzQ1HWZQzC0tFQxeS1vDAe2NcQIby/iRZh5SFGwXbvitHnGI57M/RPCx3LCV8CX2lbWXynCjJZpBvrQA8JA6tn4tnBZj5hqUxr8+qxiXnhOHQv+AX/U0RWBNzkWDcN3rqd+Ze2U1Z5V06DVmbZL06sikHTQ0Uq56z0zJ7NSp6XVYLJSEy3Fk9Vl+8YKQUZ4ez0b6dvRy/WqHcVAZq4EdqeEmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(921020)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMtTJPLQ4757bOnv7cwopdYMRz48SM/KNIlp/ZCspVs+EKr+vX0R5wvJFXO+?=
 =?us-ascii?Q?J/6iUbFM2c1PSjNrSPbY0Op/AsHD3Yv58Tp0DTXTgfqYIpZLOrpqSW/3mwD4?=
 =?us-ascii?Q?2isFV39flk1aegnX3VG0plx58xfiS84VkMxX06GWWosen0oEmDw7GjBKErAt?=
 =?us-ascii?Q?JD9g2Wnd3FViF8CPcZmY1DYk1AfPS1OXbUXyoYpaSKBVVWwJxTUJbzzmspiH?=
 =?us-ascii?Q?SiloBLwS+PmXpfsYlLxCwqBLKO2Xx2QbwIPsZ7Cm6qOG3iKQDitBHB+zREYJ?=
 =?us-ascii?Q?5pviTuP1u0RMxhL6r84CiMNXu9069ovBccvALVJeq4rtb1C28MgpWk8X2Jt3?=
 =?us-ascii?Q?7u8IJXkJ42a4wAwB737RRG+7C+iFjO6Pu3JGWlQQyY56vhGeB0eHfrX0quwd?=
 =?us-ascii?Q?zLuevFcdqOzqTl4wfZHQ3j6PLyeB0E1q9IqK9KY5IjhgtdLoUaV566Fe4939?=
 =?us-ascii?Q?gA0pY9q10waE8wmJdjLxcLkPKU+9jLIYWzycFkYJc9AksYKRBYa+Dl89mhGD?=
 =?us-ascii?Q?tDU0IGASJyr3vH/BxXIZ3xjFOyrZ4bkNufhToBceBOPbI7Xt72nN0W+Wmews?=
 =?us-ascii?Q?BC4gdMqcqbJeVcMspIKIOnxZJgvVgoA8BDOFO90wuc5Di8Rf9xFW4M4/fyGw?=
 =?us-ascii?Q?n9S5SYuVtir9EVuJahrUMjYHvMWd3D5wvP/lPs35GJOZB11af8oNOvcCgU1U?=
 =?us-ascii?Q?d6Wt6Yq3MGENrIv6lRpnMOkKwBGDXhPB+68e9B/nH+UILGxh/vlg1rnkKKI4?=
 =?us-ascii?Q?PW/LeUXXBkLXE9cpOUa5qK9nlabmGjvVSaMiMGcZ8a47K8OXij1dged4N2BW?=
 =?us-ascii?Q?KD+8XroOYZ0g0xXw6xwRJoOdWEjidYU5kDinGxZKvIKtbSYwJE+P1tdIw9kx?=
 =?us-ascii?Q?sb9dx5F+bg1HPXHDjxBej6MnZSQzRb5xLPV1lynktLBsCZxaYU01GDvDhOf7?=
 =?us-ascii?Q?YFQcRX3Lz1Ez02n9cEMPyiBD1Mnd0k/3O14m7px0yTr9HNt6L3Bv6JopNAyV?=
 =?us-ascii?Q?mdrN6UwrA6rontmT8nGD9uZuRncE9WWsO8wtzvFlFw6YpcMLDjL1zHxgDizf?=
 =?us-ascii?Q?8dbXYJJNPn5Gl6wvVu8SxNHd9mOckNUbEfrkS7Ck3aHZSeQ+9A+3tXwEVYip?=
 =?us-ascii?Q?uV5MOuyPLQ5YslkI3SJYD6xe3EW9Nkx/kF8n8hJ+TwILJ2DwCkaO900fPUT5?=
 =?us-ascii?Q?b2R4T8JuFTXfztaLF9/jfElFWYejEs6TubN9j4nHUUZQsGc6b9EMCygZzGkj?=
 =?us-ascii?Q?MiyR8xg+pthd3K629JTRX8lwt4V638wws/Z/gQNDSzAZGprjKJu37/vEB6qU?=
 =?us-ascii?Q?nLO8/EEQ2WKWNCWlNJYOqoPvqkbPuCaeXZRW0RVxFVVVUb3XbxM4KH8m8Zrl?=
 =?us-ascii?Q?6NR1ISouHOoNRIc4FyszVCYg7ol6YIM3nvXGtHIjlxNnOnqGPi9N3RUy8YyB?=
 =?us-ascii?Q?X1syie1DCNYXFfWPe1T+rxLXd4ZiWZtMusEIP8NPe4Rc9HI6mevd3/nXK5YO?=
 =?us-ascii?Q?VCw8mDSxaPPVXQje4rxsH18GY+b2031jwsNJODPeosDb17yrfXMAaNOgQu0K?=
 =?us-ascii?Q?DwY1hTTyvIE+m3eV95/EuKgDngQ9cSCT3n+3qk+gStxbZSNkk/i7JHb5CnyK?=
 =?us-ascii?Q?mhF+SEThXJjuSpHzXp/6dmWwPhz55zEvDGunXKnJMZBvxxIJdluIymsonkN3?=
 =?us-ascii?Q?5hx+IOnJ0w6WPNctttbvl75CteN0aKMSl+Dt/Cvd+HRxCeB+0tzgASsKwkND?=
 =?us-ascii?Q?+We9vKTybQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5d3d8b-3c86-4dc9-fa0a-08df35cd008e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:50.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbkA+3N0AkfGdtafbVoleZP8TnA/OU63xOKuelZo9TNyYmKLa5AGuns8vHnfkYxReUyUSUj3djd9cF9ma9XuDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

The per-device PCI reset interface must not reset sibling functions.
Reject cxl_reset and cxl_bus for VFs, multifunction devices, and PFs with
enabled VFs.

Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/cxl.c | 3 +++
 drivers/pci/pci.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 4a8969145f8b..9a298e90586d 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -515,6 +515,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
 		return -ENOTTY;
 
+	if (pdev->is_virtfn || pdev->multifunction || pci_num_vf(pdev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..9031060423cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
+	if (dev->is_virtfn || dev->multifunction || pci_num_vf(dev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

