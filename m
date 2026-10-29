Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285858;
	b=MdGfvdk2jt0+Pat4xbUgIFH1oXG/Qhn6fWbIqRs70cbcr9UWg0DOcb1sz8ZD8Gae5oRq
	 oFWy1v38K3TMFQJKWf8657va3Ycixq7vlQLo7mvmKZRc+P/2o1UTvDd8meUagDbc/g4xu
	 mx8akKNZA48PJ4bHCzQ7rWi20IXjGbV8HwR8cAwdecN+dMSo4lAVs7kzp7RMKwK6ybY2U
	 T9ENzC/NxYrcY9XLSODbhoMXhKAW21bNRKZ+olUs96JMZ68DsteiaxFKNKRCQsTiWTKMA
	 7OLM5Ip+KzStOc+6VIKGxfNqR7V9Ta9dZFvEGT6Ll8FwZ5yCXJEtfyuyiyyZzisc52g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285858;
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
	bh=DuhlQEeJMEi3lTwrhyL3kIxFohuNZY028ZhfJfFnmf0=;
	b=dcc7ocA+67si5/brED5Srjl1nWTMjLyec1qlaJUvnJ5JXJHBDHBi+0FRIzcf9yQOQ5EQ
	 dPCZZbsnvs5DRN54OyLsdFqVaW9LkECW15G/aMtcQGv4RLv4tWeWSK+UcPD8JVTdFOj58
	 pOUZ4BBIMWrVNj2En8kbru8HuepyabQMksmtciK0CRM+6ylhJOwypPxPG99vwdC1qGkaI
	 LXRPfQReOqoZzAsBaz4mHhm3NeZZz6AO2yFBLH0Ov5wJdz5ZtDeOHtLvthG2ip/DNOKVE
	 kSI/CvCKGCDTt5MP1v4bgPSQn6q2ddjLa+sY1FBbDK6kGt9PRUVcNhKVk9qP+EoFF0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Widw4L+1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE3606A320;
	Thu, 29 Oct 2026 14:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDCE3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Widw4L+1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIXQ6S/oadTnVCdpWu0o1585L0T+aRCP/PSbyW/bZKbLwexpz71QJcq3Lryv4X7ouJwGfvY8G2bacRErQtGr1JA0zDoqysQ7YHMiAwP1Lhyd8qZQfDH68Qki4V8sp4FU/JdHgKuYlSRabcCOyCGyLbfotxZETuls1Q7uUIvgXj99cFdC70D498EovDcMMEQC8T3yDAaXaQgibRN11ua5+eb5RZ8Z/mbD3GGDXvGYu1vXvJYKNnb6iHG3JvP0f0uRJbN+x0I+7Wnn+Ic+tGh4uGVWQTZv0wsHwOLudUR6DcDq3o7P/5dagtKwCUBYz77cEWjqcngko7e1i9MV8CePEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuhlQEeJMEi3lTwrhyL3kIxFohuNZY028ZhfJfFnmf0=;
 b=LEVplXl+mBqQJJ3PHy1zhJJZrtovLO8t4y4cVzXSxBnGWbnGWFEaQa1BzJq2g4E2vMx4n7Uu+DSj/JOzjcYcO0i509uTlLWOnFPhS4ZwvlryENUS/IhyFb588kYfsrFwQ0zjTUYgh/WpFaXgrIQobZDH11SLH7/oPG72vMHM1eYVof23cmqw5f0Rs7FSp7W1uRIf/gt1yTZt+Mcj0rADyQS2OPyBXC/OjsTtHsAra9OJQZIbFtlDf3chSZHoKJc/L6M/avqYygGVsS8SfHUMN34EafmWsKG5IEJ+HcCItX7kIOEjzNHa4CQpqPp2gunGZLVW0WvEVCaI0BWjblqdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuhlQEeJMEi3lTwrhyL3kIxFohuNZY028ZhfJfFnmf0=;
 b=Widw4L+19HwcCqEhfOPpSqGjXkQ1emTWOYkxbwG+2A3axFaPOpnIB7z1BDOJxfnv3pJ6KYP5Pz9waexrwA/YAd/mUUyDnpGL1EMnLE/5UCIzE+RLiogBsqJFfJhrwE2C8WcporWzK8c2kPEWpnnIsjQfFFSmrF662hesEJ+F2j+Udvpp/ymp28/sY49JiCp1IVgytBtKEOLCpbWB2QB1EulpcGkc2U7mYyj2EFEwNC0zionYaPrxmNwIzBAciNtHiVxwvDF7ZNcyFNv4pOiYvAbg49L7yHOFf4366VDhfTTAc9s/WMJZ+ZuiqEk+S+MyH0WAdFaLDJNBdgODou3cBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:32 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:32 +0000
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
Subject: [PATCH v16 07/18] cxl: Share HDM decoder register unpacking
Date: Thu, 29 Oct 2026 14:56:52 +0000
Message-ID: <20261029145703.2185231-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a6c633-ba41-4f9b-a708-08df35ccf5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|261028144727099003|260925021911599003|260925021311599003|260925022911599003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|10067099003|22082099003|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	im6SB0riVuMYxGMlenx95t7aoJOu++x5ZPxPDx5LLjXL2qZIb/mxiujd8psWcG9DonyP9/qGkqFCt+n8J5ZGI6HkKH2e45XYMlN3l6sFpoyW0nCgpw70pmtWmlJLsfzO961V2/bk4/0Tsp0SL7OHu5NPF75KGjmE/+WwNrV1fcJRwpuWS2dQu9QrN61x5RaBSREiJnDl6KETOlKd/no/HyxWwMFR7HLV4FsJHj/vMOKp3ddTcEKzm2XDr0huwQvXf5m1WdOPj1hDJVu/QHdn6CZkudVlibi77VgjuS+YZ/2NF23ggeZS8fhe5xXVTf1+4R6sPYeqPn1U50tHQ46uyN2qfA7+x5P5p+lVIhyzRhCzGk3k2f6WevAd1RHv3EHDfxI7i2oVWbDkqZ60hi/uGpJsNyCWq6BkUD7REPswOLvm0uEceAtwL8URjMp9XFB+f1fzl6EAWLKK0MErkLWGXTZ5AQKqVVgS2GHcbzZaS0BSIGIoAJ0ZGqljukfvITBbl1X9MORBu3OXLPWNxhQZk6RcBNjCx37NpHIp+UYPAbnOUBZmYwwwYwmyntWfxmROz7AlNtUg4+2E8HUQiKz7rNux6GYBK0FUacyCf+FuXSrUZoKVoCqPecnU/jsFR6G3hoVAnLBzU9pFF42dIzrgKd/pFemIGuwceBtPgduRyI34BYGjv6fNbRsNpnlsT/7TQqqdt1O1LvpG1YdfdlonkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(261028144727099003)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(22082099003)(3023799007)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?encTMIrQPtkxg+9o7IlKUKFhI1LynXNYGiWxCgGaK5YyNnn2fhpwWfy0TKWf?=
 =?us-ascii?Q?XlUoP7KRUFb2r8pdkA0DpHuqHza2cdxPRtC7JuJISeSBY4X2uexgu7ubKFnS?=
 =?us-ascii?Q?ZV6AStbcK9QG9vsqb2Tdc+4djFRxG+0CqkSzQStwdRvRrJFrBlpDzPBTtQgG?=
 =?us-ascii?Q?uXjTLR5O+GCgzbJSG6cntrRf75XJWxsBMEYh4+ciYuRuZRW+pibLkD7VSn45?=
 =?us-ascii?Q?07lyg231ZFWpD5x7tGpQHYZJs7AfsdFstFr3svBcWCm37FJdT9nOQ1sckyEY?=
 =?us-ascii?Q?g0rmEPzYvzSxM5cVcKAv7YIp0FHpoC/3liusAN/+gtm6mKAw9VrmUt9y5gxW?=
 =?us-ascii?Q?s5pkmX5IA0RaCXvoKLXcQL1pRMKXbFnItqOz2Oe46ioWolTM8KErD61abvuU?=
 =?us-ascii?Q?aWZrxdedmeXb0zMN7R0aAxRENtbtsTZvj0Me27hGFmVjObyStGkM6yBYi1wq?=
 =?us-ascii?Q?fp1eQqcwFQpQIXZ0GKnMb9XVlCsYpx+7XqU874TlDDkkQh78XhAtfgrAO/xP?=
 =?us-ascii?Q?mcDLtiZnlYmtNqB0PyzDbu2yJ+HDJxcjVQe3KlEQ8gpGa2E3xJNm7BhLj0ca?=
 =?us-ascii?Q?O6sY6/N+qYgobPA6b3OTyS6rQRiAsr2aE/bloSRc44im76bgU77RtjD+64Od?=
 =?us-ascii?Q?DuN00dA7gHxJ2FHFvGEctKhnVm80P4UrN3V1k8KgpnZk7LTZj+4t0a3PNVvR?=
 =?us-ascii?Q?0GjCFVyniebMOrzgv6Nm5cx8cPc1LOGGFFlW5Zsg05iflsRi4KeGl3oXRhMS?=
 =?us-ascii?Q?7O0V7TqaRGzB+0zgYMv7UWyL6EPaebw/owsiukQ9itg0kG7jdAgfkFOjo3nb?=
 =?us-ascii?Q?brgKP8EfBbWlEYFCXCZTFPhl/nge5UdT8ld1Le73b8EFJmvkOdqA/i8hT3B/?=
 =?us-ascii?Q?nqy2mh6cpLWQ494d8NWTpCDTTL43kh/9SJtRDWe7zlHAzA3kooYnFY4lDSKB?=
 =?us-ascii?Q?ySBbNEwzlXrSWMHsrP0Kqo6OJWwTVIpN7lfJv8NcUiA9+74YfM7XbGNnJq64?=
 =?us-ascii?Q?DEMDwqvXyf2mtnRxeGBjUXOpp/xR4PY6A69/52cpLKfMeudY/pPYvHwnOFa7?=
 =?us-ascii?Q?enXoKWc5CcfuxqEMZpuh+3rHkx25WKQQxeqif0eNHskito14Naj3JKhYJMzl?=
 =?us-ascii?Q?6VXDnNDur5T6G92R6xUg8Ck2k2k9dcH+0ql0vEW6YZCYYtbU4YIKGjIOrEeR?=
 =?us-ascii?Q?exh+dt0tWYGj61BtGsq/HPOfAiKnf9/Jx3D0u6tqIK27QJjQj6qqRWBdtkPW?=
 =?us-ascii?Q?9+ujszCguHTmjH1HczTGh37FFgOgwaiamp5y4f48RgClFfXnhZa182+Iyxck?=
 =?us-ascii?Q?5zMslj4cURHRuZOkBzNsUCDITkrVGzRlb+BusPXNO1bXOq9J8dMpqXKEqZWy?=
 =?us-ascii?Q?UrcwkBf9686raaqJvtdm6OzQU1WsIjCbVNdsX1Tmfheh/KcRXvp3197enJOr?=
 =?us-ascii?Q?3mns44bOuWB6b1SddZOnxQOxyy0LgDlC1XIXbYw8H4eIOG/dNN3VaskItl2w?=
 =?us-ascii?Q?aS7o2qSO0AFJNvkfE3xrl8quxegLBwHm2dLDml7Ak2T2/837LqaU1PjI4+Hl?=
 =?us-ascii?Q?qRUTnFKFX5s6JM8KzJmgKHUrKQCWJj9gVEXpFIkNbVRlv8r+wtreAa9V8iUk?=
 =?us-ascii?Q?l2xCctUQ/soqFvx84cGeEivqMmRYbcRV0MyhO4SnKZxbJMRASpVfTx7H6DHK?=
 =?us-ascii?Q?9RidFTLj3tK6d0gky+S26N3Jjkc8BydJHXbVALr+9ruAnRO1/I4c9djvEhJA?=
 =?us-ascii?Q?GNpVsildDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a6c633-ba41-4f9b-a708-08df35ccf5a9
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:32.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SDsESHUq6v+/5+H+QJiet99rDKj2dsX1gV7Nk3HRIgAmzeHQnEOEQPVMlsRVJXobHNOqrC/H5FMWRmo7sNAgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Factor common HDM register parsing into cxl_hdm_unpack_decoder().
Validate range and interleave parameters in locals before publishing the
decoder configuration, including enable and lock flags. Reject nonzero
ranges whose end overflows the address space while preserving the
zero-size range representation.

Read decoder base and size registers low then high through a shared
helper used by enumeration and the reset snapshot.

Read switch target lists and endpoint DPA skip in their respective
branches of init_hdm_decoder().

Preserve the decoder ID allocated by cxl_decoder_init() when publishing
the parsed configuration.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=7d6ed7faf7d8e14abce8ae23902d5323738868d2
---
 drivers/cxl/core/core.h     |  5 +++
 drivers/cxl/core/hdm.c      | 65 ++++++++------------------------
 drivers/cxl/core/hdm_regs.c | 74 +++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 49 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index fb14b222f3ca..ea539f00e55d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -147,6 +147,11 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 			     u64 targets, void __iomem *hdm);
 int cxld_await_commit(void __iomem *hdm, int id);
 
+int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
+			   u32 ctrl, u64 base, u64 size);
+int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
+			 int id, u32 ctrl);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 2c373dfbc070..5b5f5f22ea32 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -938,11 +938,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
-	u64 size, base, skip, dpa_size, lo, hi;
-	bool committed;
+	u64 size, skip, dpa_size, lo, hi;
+	struct cxl_decoder_config config;
 	u32 remainder;
-	int i, rc;
 	u32 ctrl;
+	int i, rc;
 	union {
 		u64 value;
 		unsigned char target_id[8];
@@ -953,41 +953,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 							which, info);
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
-	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(which));
-	base = (hi << 32) + lo;
-	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
-	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	rc = cxl_hdm_read_decoder(&config, hdm, which, ctrl);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->config.id, ctrl, rc);
+		return rc;
+	}
+
+	config.id = cxld->config.id;
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->config.id);
-		return -ENXIO;
-	}
+	cxld->config = config;
+	size = range_len(&cxld->config.hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->config.hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
 
 	/* decoders are enabled if committed */
-	if (committed) {
-		cxld->config.flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->config.flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->config.target_type = CXL_DECODER_DEVMEM;
-
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->config.id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1021,23 +1005,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->config.interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->config.interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
 		cxld->config.interleave_ways, cxld->config.interleave_granularity);
@@ -1052,7 +1019,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return 0;
 	}
 
-	if (!committed)
+	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
 		return 0;
 
 	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index 53d2f236e49c..684a17e9a601 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -116,3 +116,77 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
+
+int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
+			   u32 ctrl, u64 base, u64 size)
+{
+	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	enum cxl_decoder_type target_type = 0;
+	int interleave_granularity;
+	unsigned long flags = 0;
+	struct range hpa_range;
+	int interleave_ways;
+	u64 end;
+	int rc;
+
+	if (!committed)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX)
+		return -ENXIO;
+	if (size && check_add_overflow(base, size - 1, &end))
+		return -ENXIO;
+	if (!size)
+		end = base - 1;
+
+	hpa_range = (struct range) {
+		.start = base,
+		.end = end,
+	};
+
+	if (committed) {
+		flags |= CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			flags |= CXL_DECODER_F_LOCK;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
+			target_type = CXL_DECODER_HOSTONLYMEM;
+		else
+			target_type = CXL_DECODER_DEVMEM;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &interleave_ways);
+	if (rc)
+		return rc;
+	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				&interleave_granularity);
+	if (rc)
+		return rc;
+
+	*config = (struct cxl_decoder_config) {
+		.id = id,
+		.hpa_range = hpa_range,
+		.interleave_ways = interleave_ways,
+		.interleave_granularity = interleave_granularity,
+		.target_type = target_type,
+		.flags = flags,
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
+
+int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
+			 int id, u32 ctrl)
+{
+	u64 lo, hi, base, size;
+
+	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	base = (hi << 32) | lo;
+	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	size = (hi << 32) | lo;
+
+	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
-- 
2.43.0

