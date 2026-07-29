Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E042C4EC;
	Wed, 29 Jul 2026 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343695; cv=fail; b=k0szk583kgzvldVDGU739uJ7IdiBFSP0kuqxz3I/+Q9Ab2COmx4SXOs5AN+qMM4vTEBBGap44vusfrKKcPPhpqKtgmjRSOYFTGyWYRmaOkB1GmvYni8JY8/ObNd65wM/R8lpUetiBJexmEik6Wd9lo+FOHbAyocHScYUkHnQbdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343695; c=relaxed/simple;
	bh=1dl+aCxttPaJr2CvTSKzj/IrynXALaVKjTTxoBsusL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf0UCdt7oStojKsZrC3Mf+a8rzBKVoiM8/g81k/0jUCahk17ayk41a5Wgw0s0s3geLt3f8TYWaICp3tQAs7KOVPTiZ7hUcc5LrjFt0gD+VpRzFzw7sbwIVe53zNwYJAR6R0cTvyChq3WWwSSDrFFilCcJpfI8ZH55lV9psJDP0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tl4yr4mO; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tl4yr4mO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg6VCA1nXxsh3Y/z/abDzLgTwNvG0h1xCEty3LUDXKIuv72m8lY341T9cwjWK0WPvMFdbim+Ur5Rg/4qij3cMj261DQLENKt0w6ZAWNd+7pfTQy3lzbnNgE94UcnURc/ohSH1Xa2RB3wfO9BjUqWudl00broRvTu3+yGznuii99DtjAtjF0NXawRYpT2fvXg/2efDrPKnjaErf3heEjO5NbLYB+V51y5eVv6HDkSa4qqM+yd/hGcpL+wLSmPs5MbI4icuTTOCd9Ko7HlyNfjPr+x5M/tpITEqNoSvNX73h8vGIFnqoPYdjCU9Px6nLjrq2j/94roDPyPnj07iMYa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbuyJzASiL9nxzd8JGeNkedVLsd/xuxrRHsh8KmyIvg=;
 b=EPFYQOT9WrsQj3RcKxnaZMpJAnO8uYY/kLFztUlHwizc1/l7ZwRBZ9VGTI09MezMveG2OvxcMdYagFk9hjvN5Ue9c6oV06Z64Iesoj/iPis6RZBL+A92lrXWETZbSCwRlvXtQNG4gI7PPrHalnLPqfs5c+ou2JMm3MNKtCF5YF0wKAlkFmPX/oT9lTmEyywXAohnZ+OeUrvij1wy7rScohPU0Zv0BG1kjkSEaSC+BJ9YZ/pn+xfAgLONsmWRmlmcfQL5qLkmGdJ6ZhmHfj+3LRA+R2g+JJCo3SGB5Ve7uIT7qK8ux2hsOXm+LjOV9/zzAB4KUHCrTEmRRnb45oFQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbuyJzASiL9nxzd8JGeNkedVLsd/xuxrRHsh8KmyIvg=;
 b=Tl4yr4mOVFzoLvLfNg88FTp/NBew7n6Fez37olCXZPl6xdu/MZfrpHHw14YbkYhkUrhbNdZU/WTG8HvL5KziWofGcIJS1BCxCuDXs77Fk9GugSerDs/fIp8FPHVTkyCX4IpO39DYmgGmquB63SqLR6g30Qm31Es/SrI9RV1bk1W58teoGEd0JpV9wYcP3Fmwvuidb8vNnhsCOH4W0DEaDx2PPBz/qoKxsSbrHWtOiU78p8pjFk7GUHyMlE3x6C9QHKG2AFAZWz/SvBP3xENkUAKyOS7K/4YuzTqB3+LE3JSVe7ZwUUyTe2KAPKnG6o4w47pLkv7ikO9NE1cfOb395w==
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 16:48:07 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::69) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 16:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 16:48:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 09:47:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 09:47:47 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Jul 2026 09:47:46 -0700
Date: Wed, 29 Jul 2026 09:47:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <kevin.tian@intel.com>,
	<kees@kernel.org>, <smostafa@google.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <amousSY6qMX3felk@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
 <amkqZbPJs9qly4pH@nvidia.com>
 <ammMf5z-Gl-Wygk6@google.com>
 <ammO+4W/dGC8kTCr@nvidia.com>
 <ammTr2kvjpiOHkbT@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ammTr2kvjpiOHkbT@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: c29e170b-3b4a-4458-716a-08deed912a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3j1m0/lUBb6nsH5GgN9EgYWE8wIldjnog6FWMtE95VuRL4xygL+c/Qs+2BDk8uizdAhqrGfvNzr95gZqH8LBAY5EFQdWr/H4SjBqh6La7n/K/2J9MQORXiL2ZFu3QI4ww4A1IFqDtsVcmh2zdfbZJ9BLWpMd7EqQ10SL8ptF/gASyYXqMQTygUQPZMYGWC0hAJuYJLvbP36Hq9QiAFVU4vai8xMSIkuVKA5IqkGRxPezyl9+GFocLpq3BIAKZzTJ8oL6pZtYZB+k6jQF/ZNxq8D0MCE2z0QBZliIkfCeSg0Kz55KqdvAINkWDeN+bZQVxd4IsQP6mMGiit5lVrZqrsOl5VkcdFILfggyugBJZZ7N/ikZrLE04YI2F3hgCNsOKZluAp09xOWO7rCjbxrBGqSjakVlruYdrEkVjKyR9GzD+bas7bHxyjfiJfLvl1P+EawdvnD4T7n4GvO5q2aGhALBVmR2UpUtnTYK65fIIL99PzTiEJSp4R2ha6LRnajQ7Mp4klXn5qc4jQnNZAKqKvzkNCnVsKusnHxm403g+mrz5fqgheK6N4MaVvHvr+eNi4xDhMrUemAWZnFzJIrxlKD8wObgvtaD/RWXA4SgDOUJWFJkQSVJwvVAhXeEbxSnOxGUpkfB9DwVM4WawFm983BTHXIZmuSblH6TTv+CQNPX+tUDXyfa30hCKZn20lvbLXUOml/Qt/upyB3s4M9FtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vFiAvj98AqiA7ekeH8MhU3g5p+wLha41kWu1WcemhlDkkoCp5krNuilKgdVsec8DxiNUe72/xyse0DicGKKI7LpnK3sk8pNcyRnk1UXSYbbWSNXLYez6rSu+O4PVNAIZlti/v7k7lxh28DRXF1U6wwjKZoFwbpeJ1M7j5e5mSQu5bOyjnOHZVWcwg566npNhEnsyPbS0terGc+K6NX8b7BKpqsDqBcnmQ8IM11/zVJbubsRFMrPHqlue02QzkoQwqdKhgQLYkEdBza78UeQugJAVQ0VIQvje8CXRIsVI98n4S87MRTCkpk17Hhy4hDm4QDTsLxNBWX8JCS4JleOEONFyl0TniWwWkq79iVj1DxsSzy8nmtcFRleecIBTZPi4CqYBGzICUndtyoBvdjYxLDANRrtaCxvr+xATpGr/y2c8wBcPVHeGyO7uwRBgoc47
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 16:48:07.1436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e170b-3b4a-4458-716a-08deed912a88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

On Wed, Jul 29, 2026 at 05:46:23AM +0000, Pranjal Shrivastava wrote:
> On Tue, Jul 28, 2026 at 10:26:19PM -0700, Nicolin Chen wrote:
> > On Wed, Jul 29, 2026 at 05:15:43AM +0000, Pranjal Shrivastava wrote:
> > > For PRIQ/EVTQ, my only worry was the HW producing more events,
> > > say Device A is detached (we call drain from attach_release) but Device B
> > > (still attached) starts an agressive DMA with multiple PRI requests/evts.
> > > 
> > > Maybe we should go back to snapshot based polling for that?
> > 
> > If you look closely, "pending" is the snapshot, regardless of the
> > growing prod.
> > 
> >  * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
> >  * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
> >  *
> >  *   cons0                cons                 prod0         (prod)
> >  *     |<---- drained ---->|                     |             |
> >  *  ---+###################+=====================+=============+--->
> >  *     |<--------------- pending --------------->|
> > 
> 
> Right, but we write back cons to cons_reg only after we see queue_empty()
> We have a do { .. } while (!queue_empty(llq)); and then we call
> queue_sync_cons_ovf(q). Same  for PRIQ handler.
> 
> IIUC the helper relies on cons_reg being updated:
> 
> cons = readl_relaxed(q->cons_reg);
> drained += Q_POS(&q->llq, cons - prev);
> 
> Thus, if we get a storm of pri reqs / evts, we may never leave that loop
> and queue_sync_cons_ovf(q).

cons_reg is updated by queue_remove_raw() every iteration inside
that loop.

queue_sync_cons_ovf() doesn't update cons_reg unless an overflow.

Nicolin
