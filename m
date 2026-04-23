Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96E35966;
	Thu, 23 Apr 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776959272; cv=fail; b=bcT2Y7IhcjdX4DgvUyss2uKFKGieGM2aOZzOvH5RmFREOjuO4gqQuqndJdEM9Sac5uehosgrCAPf2NRalVZM+nNNs8wFVyUfmsGcHTaicJeBXFH3zhZgux84rq09KLQi5GgHU+rVmeSNBv+82W6Vx8qWyOy4Lb7EqKosius94rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776959272; c=relaxed/simple;
	bh=PRmT//+U6fgEKyidfzvEpAgCO2/CRCiDvhjHwhohYC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/vTzC/M3Ee6LHaGT+uiRYdbRLCTPcILP8Ti8gixn+MEF9p1HkaUrJfExo11j/YXeQKX4XCf3q+210H+GVEB9g0yp17K9dv4chpzNLlkdcnHBFGK5luqKdLVxBLCm1R9hqt2IsHbZxIImTlFoTMrW8u/9G968Vhp8qNsx6dQppk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=poqKwhmE; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="poqKwhmE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgfzzNRR1/8JHuOyYM0SqXmMx7XeQZrjZj4FLuQcAwfZVczExaIPpt49lDHklcDa+cbdBur/F5WeQI1yaLsvt/+Hxcggkb2v+flTXeOgVMDVnC/ZGA/cFx5y0C4vXHRf4RYvrapqNYs2TWew6en2NNhxQRttuJjZujpKPKc2U18GhqmxvGjZ43GeI7/OXtyD6qBaOvTUErfUacyCIJ//lfzxcLhnKgdtcayESeIKftVz2oOH5m0N6C6Ui6xtrxnYuDSsAHl4E3iUjHPl0ef8XMu1PpxE+JX0L2ldWM5cTgHqZU3QStuHfzkjnzDlm5bJsbK403rzNOQmEZm1EtlSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC7DNEvH2Dc5r5NO1YFZU4U6vzo4Vxa0qfuO1PHkhoE=;
 b=scNcioX8QPK9zzmDjyw/PBTSQQb0tNT5i+3ETrIHvhcMqUL+Lb5DRPUAy/N2H1caqcxkKv97p3EWDNQllD97B7/p4tQAwfZ9SHAXLoJmBSjcTCMNB6BCFHhqPZQ8ifyAqBDUCFET8i79UUemU85UrO5m0PaUXouSJfAKsk4cbJXaWEKwavRGusj551dsDV6gvPYExA5Thvz3uF/b68HMV1fQg5zY2QghuWWeYWLMPbo0pUl4MnutQG1DIlGw50sQ013UUJsNyEchtkoLmaAOHadX3vwhrRLYA/4JOKFmk1XgJ9etXSxVwbDr7T7AVE4wTxDUxG1lUFroorQRQB0g5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC7DNEvH2Dc5r5NO1YFZU4U6vzo4Vxa0qfuO1PHkhoE=;
 b=poqKwhmEjjJWr/tA0FBURpZOnSW7lwkHum4WZ3MEpljQRRmQ6RBXI2DRvHgmYn8lqweAZFiAjYZhKJRdDc0XKV4RCwQkaYXulY5w19MfV1XvTap3RXdePrwebv4xU8TqdvYpdTXSIXnKGG2CXqjYpZ2Gn2bfD+Xycz33v1uZSrQw8Xig4huq2JIplFQro/QR+SnEBUC4DGAlHQZPmkDYvP6YsBxxjx8ql3g+I45W6ouJKyOeE9IDFzKigibtGHmGFfWnrhUE/dUJMlVT7/obPMCD+tIqTjci+CPr7c388dahz2IOKxdPQ3BR+cDULoaMVG5rYt+/1PPsoD2bzblAjw==
Received: from CY5PR10CA0028.namprd10.prod.outlook.com (2603:10b6:930:1c::21)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 15:47:44 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::89) by CY5PR10CA0028.outlook.office365.com
 (2603:10b6:930:1c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Thu,
 23 Apr 2026 15:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 15:47:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 08:47:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 08:47:19 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 08:47:17 -0700
Date: Thu, 23 Apr 2026 08:47:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, "Mostafa
 Saleh" <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 06/11] iommu: Defer __iommu_group_free_device() to be
 outside group->mutex
Message-ID: <aeo/BDwYM9yYHctI@Asurada-Nvidia>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <3f5d229267d1f4d918641bc5b896f54b5c4b7782.1776381841.git.nicolinc@nvidia.com>
 <3570e178-f887-45c9-a251-e089915cfbd9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3570e178-f887-45c9-a251-e089915cfbd9@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: add238e4-2238-4d2a-6b6a-08dea14fa898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FvJEpaecXYOhepOdyGIeR10eRmgp/o+6zOAENSVvrO2H0IzNpMeDK5o96/XYLfiNSO8YTSW10O8y5OPjG25j8fAFIXntgQRfpLOjP2lZ2IcR/3dYbZ09jvP3TeBQO6hFlVnPYJp6XJWfCqn0JqemBIBgIsmd9NsJjWRlH8bNL84/QUVy7Y2b09HiFBtDwKN+JPbn98sResqA/HszuGKAw+q0RIN3PS4ZqFL+JEJgN7zi/HDsivAooUk2NjQ8O7REjgE5dtWpOSmafBffiZYnA461aqvrU3px6DtJ8DDLtbByk7dEU5ix6Og+e7b+oqH4uqfD5Ts14r1Hqq8CNkaOiLiLyW5kMbooPCoQZI02zoKU8L8r6FOlNED65wFaM9BXVy4n+1sIHHLyALLT23X/QyTJjW84zPiOr95SkdbODWJ+JR39GNuJvxKQpOLDgWIsoyegtSIy7dC9yJczXJcQstaABcWCw4ukaC39edxs5MLj4ws46kO+u+3FqDzDZT83N6rb0stnVNYogWlUHDZOpS6MqkfwDfY12Cvwkgyc8RPn3uUExcZ8VUgV5bSauc8CTIubzGOUl6WMhlnZzS7vpC7O2md2Y2x46LXf/m6GStwFem6FEUWgaZTWwFNqPi/jBO8qhDpYv7B842d6Ov7cQ61qVz8+26uaz9IpbuR0K+GAHhKCsxBd08WGvHQUprmTbm9+LgRiiTwkQXIGJLpNJnVaXHK2ZFoSNpBmwhPz3oyX/9Rv/cqrFl+fADhmlx5iBVoEqUOIVJwXR9quHJX/Dg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O5VG5Rzpiv5WCql5oNpBf+/zZ12wKn55sJRj2Inj6bq6p+JyshRYeerh2onACbj1CfUeTvS3+9YCTVQJFS6Va3MPwvrVlAa7PTPwUXdHIp2SY+dSojzlb3zN9RJoucu+ED1ZJ/LBGyzkB91GAeXaKz33e4x3X+XqEYYUaL8SP7PZF50iL5natFnCc86uEv5BU1A+HEOFfW/8gUj2/x+2P68AHYV0w+SG+Hnvzuh1GEu1lZ9Y4TuGiwBlFkxpNNuO2s/oj7fHvK53ad4l6ElOCbNtVpCXem+RJ9hqk3x8izeusgvktxZtaRbgP2t9LjCnKVuAqIk5izTyO3XQX545hoS84nJZLnHRPOGWSQpi9s3HXzSaDM69BnFUjfoeZTqTrElQod+flFrF71e06dJ3sQl3MI9ezOtPjNSrwLkHvZsNvpXwrqfxvB19u+pPdWPv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:47:43.4935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add238e4-2238-4d2a-6b6a-08dea14fa898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582

On Thu, Apr 23, 2026 at 03:55:02PM +0800, Baolu Lu wrote:
> On 4/17/26 07:28, Nicolin Chen wrote:
> > +static void __iommu_group_empty_assert_owner_cnt(struct iommu_group *group)
> > +{
> > +	lockdep_assert_held(&group->mutex);
> > +	/*
> > +	 * If the group has become empty then ownership must have been
> > +	 * released, and the current domain must be set back to NULL or
> > +	 * the default domain.
> > +	 */
> 
> Nit: this comment doesn't quite match the following code. The code
> doesn't check "group->domain != NULL". Or perhaps in that case,
> group->default_domain must be NULL?

This is the original patch from Jason:
https://lore.kernel.org/r/4-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com

I kept the comments as-is, though It might be slightly confusing?

I think it means:
If group->default_domain == NULL, it does check "set back to NULL".
If group->default_domain != NULL, it then checks "default domain".

Maybe it could be "must be set back to the default domain (which
itself can be NULL"?

> Furthermore, if a device is currently quarantined, group->domain will be
> the blocking_domain. If that quarantined device is then hot-removed and
> happens to be the last device in the group, will this WARN_ON trigger
> unnecessarily?

If a device is quarantined, its group->domain is retained to the
previously attached domain. Its blocking state is logged in the
gdev->blocked flag. So, I think it can pass the test.

Thanks
Nicolin
