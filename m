Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905167;
	b=K1kyR6A0ZNPKtsRJzqSyRpq+KcHJ8P4TyoXS7bDyvEIpluPozPjm9JfV39LPM66TouTZ
	 qyJ050QyGeQAIuJsrc+ccBZMeSDNdaqbsi98nDXUdvH0sKkpKBZD30UQhdokbdgxkzbLz
	 7+qmBVK6PrXbADokRhchKVpTvazfY16qrU/FlVXpCCn4zAoxx0339dsolXQGa1f1woZLe
	 wIww3IfUixHnVGaEPaJPlyKuBXI9PMsMAjbDYyZ8Cxha07OQfh92Pv2958M4Dp1WL0ab1
	 0RxdUkYCxqbUXxQ4DiFWIKJq3ffP6KbDdbGCiCDhlSg3aheq4h5EQv78+sp3Kh/0/2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905167;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xShBYn4FkGkt8fNNdsEGHyNDAc6w8j5MDr5I0OiZMX4=;
	b=jnsFp4jtJl9GbWhUqDEUGufkTrLWEl2oDdBys4Ata1QD27PMTBUTnwy5qrIGxYRaazY0
	 aR7I+K0idAZ5ElZBlvMorU1ZERf6CI9Er1XSDjEAnk/Hyu0Z2G9rAjijz7RveRdvb4Qm8
	 y3S56I8N9JuWnfL/e7v2+TlJtnfsEiAe2Jzzv05O3CgH+ZSDX77lnKB4gf8sMB0WGZjEf
	 Sp7Qy5PFaQiWVQozhT4sL/VHBNeWfcDtwHmwRlYQ5yoir6+wD+7IZF0NDhfvLTr7eAOEm
	 KwGuP7TVRpxEMog4/VF+0iDIf5HbFY7Mq3ViFJssJ9sZaKp45Ri/RqNwZnJJyMAQa/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sFwBw6ns;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.34
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D83606A31B;
	Thu,  5 Nov 2026 18:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D83606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sFwBw6ns
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwqULL3bWAIkCD//vglOZQs3qGejusCk6VpcOlFzdgAy+dxaHYntH5sYO8XoiVNYridjp1DKnw+6nN5JBkbpqpKac/H0pNoF+dLdcUdkssQbYPngiyJ3Fju/mnfQ/sQ8A4fn1l3ZmqRswoe6lekrNzryF4hZgUKTROP3wikDxosKdYUByT9uX0ndDi9i+QfZezV0g/a08pq47YResoZ+XmomeKvXLAvljD5giJ0+6yEtSQ+ur/9pzLZk93ppfQ0kyDZEih04vFEZq0JttWKGfQeq336ysM/nfLHf4LBk2Y4qHVm5bDadvoSeuVsU4+bGXXQDftjs4jYJElfUCk2Qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xShBYn4FkGkt8fNNdsEGHyNDAc6w8j5MDr5I0OiZMX4=;
 b=y1jn6UAWiVE2OjN3tJhs0dvptMXy83dqwU+oOH+CSg47NLGHxxhPFQqcMxEnl30VQEQXyGZs4tASRXSVqtHNCwZYSboFSLtudRftGNL7saY/9SY34m+XMDxbUI3QTRNkNt65VBTj4p3csz9qaJAEXPJuMWnZFzlGgr20RagBTYIyPDpHbKM5N1RaU23yOU3yKtR1JnVnn5Nd+iexP/TC6kXqR25+pvjHQStDwRrlqVxLKlxNiXnwvuuiCCyxLgjBSWNP0P1J9gTIDySg2BUKIA+Rj3r7x+rea6Z1yTNWXoRNHvZ+xcff+711v6vkCSqo9ESNXOJ52eNORpzBU/NyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xShBYn4FkGkt8fNNdsEGHyNDAc6w8j5MDr5I0OiZMX4=;
 b=sFwBw6nsGCWTczk6dL+m1RCxl8IuNJ5ilCUMCDBdspJsg9vvwBgtNyvd2V/gyschbLsK+wz+6TZTTj4Z4yNJk3AGej9IOtTXRsnXH/5zHqpdDu6Ks4cExhijpAbrI0OEG+klXJj6IXtqVauek74DoUrBDPIHFSbkvkYocj+dorIcAIGUVgEVCKeD6lEfqsV8lb1hxHChOwgW806KHBcgOqci4FRJofkX46iM2D8azOvWyr8TKShVXB7EIjfC0ne5Kroindd6qY1/20M4Kl2bOYNwNuP8fhdYbEXP19uxXJDsbs4f1jXCnzpoFC9rAWo7F84Z9piB1miFs2WlMDeoBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4105.namprd12.prod.outlook.com
 (2603:10b6:5:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:20 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:20 +0000
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
Subject: [PATCH v17 00/19] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Thu,  5 Nov 2026 18:58:58 +0000
Message-ID: <20261105185917.2667656-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 07758ae6-9bfc-4acd-8ff3-08df3b6ee644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|260925021311599003|260925022911599003|260925021911599003|11063799006|261026121527099003|56012099006|261021123027099003|261022075727099003|261026140227099003|261009223027099003|261022113327099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|5023799004|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BpL2XEtiPtEylMekAwkRHOP4SeqhvRR5N73wTA8mxfMe9YawqnVJsres56xC1YLEPFU0y1fXSAbanytcFdAO6lKeMAqTiRZp40oGDui06m/AnvYzhnUQEZUVTH2stzm9NwnKQLGAHaOFc1NRkxsYbPjypqERUQ4o8zm+4k/IOghW4akTPao9SQGQF8eAYXSUZOYYuwqZg0aueB8AxMjQAwqTG9fVGSdCR6d0ttZ8bIBmIPTkYYr4k7APxx8DRexjSv6PW2d9G9RSkis9D9f/R9aryzWvPdAsvsoXCKnMUhA0/xdU5zejUmo4D19ifqJT+rHSIU4aQq+nqdg2Cl4c/LvUHIHB+sXYth682z/j/HMbZoJwDeD2a60fLtZnbDZmKmS8TsYZWi7mRBOunvaJkNPsb72biPSmcK5L3z7agbqsIqC5YsehIWLXJMOUYurMHhIoFc4F4cJvDYjjGj9yACrpTYC1p4GofSyp+9boEl7etgXeLWAYQ0CE3QQqBzzcwrg7n7FKp7iGaPge5EeGzX2ke/Bjx8V2nhHIcwdQbVMDpFwnbG1lBSr90HSpgmj3iE96cjDq4RcqxSpiyGRmt9Q7tx3RbnN+fVWyCgPNkxYPXpbd4CgXESRfV4VqvAzNvca/YvJdvnnTL5HRfxc3Yj3lYuPijWMAeAuvvslhtky4xwd9gViD+jnh+mAS96P52YzbO7q2je3/qYB9hshvVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261022113327099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(5023799004)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kk1F6MKiCa2LNHlB2coKmCsTz0CNBmW3zt3X/0W1/+5PBJPxURow+ivXcQrJ?=
 =?us-ascii?Q?iMvXx3HaLXFHjLB1MjlodZywt8zH2ugdCN3i/BF6HvsNivjGWN6Jp43KcSb1?=
 =?us-ascii?Q?mIm40DWW4Tk7kCAdjgU2aWT/8eBmG42/suHYPC/WJ73G7we+Wt9Qm7Rbss00?=
 =?us-ascii?Q?1563X2zaKMR2Qa4WuLPODGg91vcNKdK26muO3M7Jc8HiPHYZlAiiNjn4Nlb3?=
 =?us-ascii?Q?+okg1Zctsvn1nJmhyaU1W+IAXWOXpFpGPZLKD7jhRh9OR9L5AU/+9QwGBDqE?=
 =?us-ascii?Q?HQGze+1MPJyIU1G0lDRiQI4hkE57p3mNE2ZlBZaptyTQHHG1f1WyTSv9cuZt?=
 =?us-ascii?Q?/HtK5F4WiHKpGtpx+Y47TZAHiMPnw0orJHPaxzA/yLiHQUaN1+t/v6uvD1hK?=
 =?us-ascii?Q?Cm9AwKOkBZ3knvRLOHa45PEglGmDFUSJDawaI67/cKEZjxjL6uvuDRM5mPGa?=
 =?us-ascii?Q?hMUXDikj+aWfv8fHdPq5AbczXbhSxLcuU6lW7CPureOOKky6R4m5uU38hyIi?=
 =?us-ascii?Q?ZNt3chtaLLWtP+vVKRIlX+HYZMsmG70yr46SHYrOZWZjWtWxUxgIPpfIyL0h?=
 =?us-ascii?Q?7f7ILu1Fr+/YoxzcVDSl68dc/VgXrvnrrWJKF4dGxM7cbWwU3reC42FEJdsy?=
 =?us-ascii?Q?LFbFraxaXXGcyGl2MDfPa80ZOySRBcuB/nmhw3X8tPIZMZAfJXj6Oo0pnp1B?=
 =?us-ascii?Q?dTnfBhuVTPDRQSp+cRmmY07SKE2MfxVY+qkuxScHHSbCZHF+waedwHXbX7aG?=
 =?us-ascii?Q?OsllZH1tFYbLdYCHPX5/JbhsUe9cDrfd9HqiwjO8gJHbl6KOQj2QwA9HVfvG?=
 =?us-ascii?Q?ml0Vl862eghI/EbuCQmpBaRj6l+fqIKdtvpAIL4CL5NAZfxuZ6S0i/WP2VcU?=
 =?us-ascii?Q?6Ec3sPEOCE5cA9gDgVY77zU2jeUm8aLuYfkag3+03Xg9fHs4H4dqw64S67CT?=
 =?us-ascii?Q?d7rwfPIHFkxK6fkuhXMV9/6nYcuJs05vxsQIxv3oAqciu9gujmyBQh9HBOeJ?=
 =?us-ascii?Q?Kzg9iWgLYcCjj22cS1DgE85N1yfBUX5kYVNbSi+GNnKkKBC9ZalqviOUeglG?=
 =?us-ascii?Q?DeiHhtboMEaZxDVXenDmf6AOFNhv8ZTnE2YO7H9nPzJ7f9UnfAREwiXwCSYM?=
 =?us-ascii?Q?fZjCrBgY7lzdvfy+lCDg7ZFTxeNM95HVL+szr0sc07Di86F7ZEqbSCXF+PUj?=
 =?us-ascii?Q?Nitn9cYuybw2TX9TvWjCN0P7xTYSogADPAmwmZBCrgN+/kNIwp1PR3KodNNc?=
 =?us-ascii?Q?ucG/EEIB7ZfdmRVkK+iHZz29nOkHlIGQ2iap5ls+AY9NPr2m5TRM4AQe2J+N?=
 =?us-ascii?Q?LJwl6nqaMTUVDFxzmNRGuSj3YRTHp0lmfFv5PfNgVrcVu6TvIFcUFmh3D/Sd?=
 =?us-ascii?Q?K+2Jmk9M90X4AwLq3bEqFiQyCZZztIhYIsT4OqlfUFCtntFBK3XqrRJnmwhv?=
 =?us-ascii?Q?LqyxAufxduD6YWtiXroxCRFkBy34MIIVihXTVIHIN1zmBE1mNgkmGegBz8uN?=
 =?us-ascii?Q?hL7RBVNDVcBBnMu003jD1oHHWoWxtKn/DoTdGE0TcXlD+++ivpMkxnoCfb8I?=
 =?us-ascii?Q?z9uk2ObtAy2rsr9q+UWR7CLpsjEaiQlOj/2Wr6l50zce1YEMISHDZqz2tDEr?=
 =?us-ascii?Q?aj7HXPvVJ37COr5pMLTAlM+LAIfNQtgpAUP1pJLGoZIb/I0xUMpb1+pa4VEL?=
 =?us-ascii?Q?DFAZraRdNKoo8gE6CIEvHmEHWGYo+9g0Sj648rkLau3eu7CkxT9K2NEzJ+sC?=
 =?us-ascii?Q?HLBwhGyULA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07758ae6-9bfc-4acd-8ff3-08df3b6ee644
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:20.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIvaV2+jrhJZa6ci0s3oKTxOjswLi/YtNCRHzwGxqxm2TfDuzhLSaQThpcTSe/k+sauEJDHk16RTqT2o7EeeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

Hi folks,

This series adds CXL Reset for Type 2 devices through the existing PCI
reset_method and reset sysfs attributes. It disables CXL.cache, performs
supported cache writeback, initiates CXL Reset with Memory Clear, and
restores cached HDM decoder and CXL Device DVSEC state before PCI use
resumes. Active HDM ranges are reserved and CPU caches invalidated before
and after reset. The method remains limited to eligible single-function
devices with both CXL.cache and CXL.mem enabled. CXL bus reset restores
the same cached state and flushes the host and device caches around the
reset.

The reset sequence follows the CXL 4.0 specification [4], including
CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
define the completion timeout encodings and reset access restrictions.

The userspace ABI is the existing PCI reset interface:

    /sys/bus/pci/devices/.../reset_method
    /sys/bus/pci/devices/.../reset

Userspace selects "cxl_reset" in reset_method and triggers the reset
through reset. Following Dan's v6 feedback, this uses the PCI interface
instead of adding a memdev-specific sysfs ABI.

For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
callback when provided and disables PCI I/O, memory decoding, and bus
mastering. The CXL path reserves affected HDM ranges exclusively and
blocks IOMMU translations where applicable. It does not offline memory
or revoke mappings: userspace is expected to offline CXL.mem users before
reset. The reservation enforces this for claimed ranges by failing the
reset while a conflicting resource is claimed [9].

The global region lock is held from snapshot through restoration. Memory
Clear completion is awaited for the timeout the device advertises, up to
100 seconds, so the lock can be held for that long plus cache flushes.

Changes from v16 [1]:
- Publish the PCI HDM cache under the PCI device lock instead of
  cxl_rwsem.dpa, and drop the cxl_hdm_cache_present() and
  cxl_hdm_cache_publish() helpers (Li Ming) [6][7]
- Wait for the reset timeout the device advertises, up to 100 seconds,
  instead of clamping it to 20 seconds, so Control2 is not accessed while
  the device may still be resetting (Richard) [8]
- State that userspace is expected to offline CXL.mem users before reset,
  and what the HPA reservation does and does not cover (Richard) [9]
- Enable bus mastering after the IOMMU is restored on CXL bus reset
  (Richard) [10]
- Explain why cxl_set_mem_enable() refreshes the cached DVSEC Control when
  MEM_ENABLE already matches (Richard) [11]
- Initialize the zero-size HDM decoder end to base - 1 and document the
  zero-size case (Richard) [12]
- Set Lock On Commit after programming the decoder registers and before
  Commit when recommitting a locked decoder (Alison) [13]
- Record Normalized Addressing in the cached decoder when region discovery
  sets it, and note the short window before that update (Sashiko) [15]
- Reject an all-ones DVSEC Control read in cxl_set_mem_enable() (Sashiko)
  [15]
- Add the missing context-analysis annotations on the region quiesce
  lock and unlock and on __cxl_reset_execute() (Sashiko) [15]
- Use an explicit pci_dev_put() in read_cdat_data() instead of mixing
  __free() with goto cleanup (Sashiko) [15]
- Check for VFs and multifunction devices before the CXL DVSEC lookups in
  the two reset methods, to avoid repeated capability walks while probing
  VFs (Joshua) [18]
- Fold the CXL bus reset cache flush patch into this series (Dave); the
  series is now 19 patches
- Added Richard's Reviewed-by tags to patches 6-10, 14 and 16
- Specified the reviewer behind each change in the changelogs, per Alison [14]

Earlier revision history is in the v16 [1] and v15 [2] cover letters.

Attribution for Dave Jiang's reference branch is still open.
Since I am unsure about [16] I have not yet added the right tags.
The patches link to his branch below the separator for now.

The v15 discussion on the scope check is still pending [17].

HDM caching requires CXL.cache, CXL.mem, CXL Reset and Reset Memory
Clear capabilities. CXL bus reset state restoration uses that cache.

CXL Reset requires a registered CPU cache clean/invalidate provider
and matching firmware, such as the separate SMCCC provider series [3].
Without that provider, cxl_reset can be advertised while execution returns
-ENOTTY, unless the test-only CXL_REGION_INVALIDATION_TEST bypass is
enabled.

The KUnit suite checks HDM range boundaries, zero-size and uncommitted
state, lock and target-type decoding, and 12-way interleave.

Testing: v17 was tested on an ARM64 target with v5 of the SMCCC
cache provider series [3] applied. Reset loops passed for both cxl_reset and
cxl_bus after running bidirectional host-device traffic. The
cxl_hdm_unpack_kunit suite passes.

[1] https://lore.kernel.org/linux-cxl/20261029145703.2185231-1-smadhavan@nvidia.com/
[2] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-arm-kernel/20261021224557.1827361-1-smadhavan@nvidia.com/
[4] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[5] https://lore.kernel.org/all/cover.1791949910.git.alison.schofield@intel.com/
[6] https://lore.kernel.org/linux-cxl/d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com/
[7] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/T/#m7f8d0e51d4cfe09fefcebd93d49dcb916be9198a
[8] https://lore.kernel.org/linux-cxl/auQC2UECQ8vaelPz@MWDK4CY14F/
[9] https://lore.kernel.org/linux-cxl/auQRSOGWEDzB_qjF@MWDK4CY14F/
[10] https://lore.kernel.org/linux-cxl/auRhJa-nzR0CnKf3@MWDK4CY14F/
[11] https://lore.kernel.org/linux-cxl/auRQN6a3QVtqjd5a@MWDK4CY14F/
[12] https://lore.kernel.org/linux-cxl/auQ27s1rSCcbdRJ3@MWDK4CY14F/
[13] https://lore.kernel.org/linux-cxl/auAg6MFDGyVQvQxM@aschofie-mobl2.lan/
[14] https://lore.kernel.org/linux-cxl/auOXW3BTb8CYIh4m@aschofie-mobl2.lan/
[15] https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com
[16] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/T/#m2f61467417f422316cb15b976773944dcdcb48c7
[17] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/T/#m4f62ed0f038f2d136158c74c1c6c338129266131
[18] https://lore.kernel.org/linux-cxl/20261105143611.31563-1-machaujo@amazon.de/

Srirangan Madhavan (19):
  cxl: Clarify decoder interleave limit
  cxl: Share CXL port upstream PCI device lookup
  cxl: Move decoder declarations to shared header
  cxl: Embed decoder configuration in a standalone structure
  cxl: Introduce endpoint HDM decoder settings
  cxl: Move HDM decoder helpers to built-in code
  cxl: Share HDM decoder register unpacking
  cxl: Move cxl_rwsem into built-in code
  cxl: Refresh cached PCI HDM decoder settings
  cxl: Build register block helpers into the kernel
  PCI/CXL: Cache endpoint HDM state during PCI enumeration
  PCI/CXL: Add CXL Device Reset sequencing
  cxl: Validate and synchronize HDM ranges around reset
  PCI/CXL: Reject reset with unsafe function scope
  PCI/CXL: Restore CXL state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  PCI/CXL: Restore CXL state after CXL bus reset
  PCI/CXL: Flush host and device caches for CXL bus reset
  cxl: Add KUnit checks for HDM decoder unpacking

 MAINTAINERS                          |   1 +
 drivers/cxl/.kunitconfig             |   4 +
 drivers/cxl/Kconfig                  |  18 +-
 drivers/cxl/Makefile                 |   1 +
 drivers/cxl/acpi.c                   |  26 +-
 drivers/cxl/core/Makefile            |   2 +-
 drivers/cxl/core/atl.c               |   4 +-
 drivers/cxl/core/core.h              |  15 +
 drivers/cxl/core/hdm.c               | 273 +++-----
 drivers/cxl/core/hdm_regs.c          | 437 +++++++++++++
 drivers/cxl/core/hdm_state.c         | 402 ++++++++++++
 drivers/cxl/core/pci.c               |  85 ++-
 drivers/cxl/core/port.c              |  68 +-
 drivers/cxl/core/region.c            | 116 ++--
 drivers/cxl/core/regs.c              |   9 +
 drivers/cxl/cxl.h                    |  46 +-
 drivers/cxl/pci.c                    |   2 +-
 drivers/cxl/port.c                   |   4 +-
 drivers/cxl/tests/Makefile           |   5 +
 drivers/cxl/tests/hdm_unpack_kunit.c |  91 +++
 drivers/pci/Makefile                 |   1 +
 drivers/pci/bus.c                    |   1 +
 drivers/pci/cxl.c                    | 907 +++++++++++++++++++++++++++
 drivers/pci/pci.c                    |  27 +-
 drivers/pci/pci.h                    |  44 ++
 drivers/pci/probe.c                  |   1 +
 include/cxl/cxl.h                    |  59 +-
 include/cxl/hdm.h                    | 109 ++++
 include/cxl/pci.h                    |  13 +
 include/linux/pci.h                  |   8 +-
 include/uapi/linux/pci_regs.h        |  14 +
 tools/testing/cxl/Kbuild             |   1 -
 tools/testing/cxl/test/cxl.c         | 158 +++--
 33 files changed, 2526 insertions(+), 426 deletions(-)
 create mode 100644 drivers/cxl/.kunitconfig
 create mode 100644 drivers/cxl/core/hdm_regs.c
 create mode 100644 drivers/cxl/core/hdm_state.c
 create mode 100644 drivers/cxl/tests/Makefile
 create mode 100644 drivers/cxl/tests/hdm_unpack_kunit.c
 create mode 100644 drivers/pci/cxl.c
 create mode 100644 include/cxl/hdm.h


base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
-- 
2.43.0

