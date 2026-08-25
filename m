Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B83EC831;
	Tue, 25 Aug 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658564; cv=fail; b=grCDko0NCSWG+wUfQVx6aeJj4nYCayepGQ/XJZJQVsvHKaojrhvdbrbXOmiOtvXJ9FivfXZ9PLSIERVzd9WzkNE1iI1D/tQDTLfyL0aw/7FuZUVfngY4V13jAEoeJWk2UwhXUWXcx9tPVwM67QKpLNj9lt2PGbtEDMqpxn1w+Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658564; c=relaxed/simple;
	bh=sQ95Kb/Z3H+uYQqddxb/HH3O0v+4YwbhDWMB+4W2hig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r39zK/IXG21TGalGibRas+G8VjywjWMg0GPsV+UU2PCZF7VuFStIVvjlRksnsgsj+xDTcawNur0c6axkAer05uSUYolnP7Plo0nB+G48OGZZ555wkGxSvZkrOiIVnrtE5Vg2JLjiskDpi6VHPA+zEJwVUpW4cVp5Eb2cmYdtZTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0uO9xJ2; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0uO9xJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImVnN8OVSkFIaZYeDAWKtAA2Xjk2PiGBQUhAcCfrjr4tldQqzxb66zUdR6/Bo86avyVkjWyJnWEhu4IMLux9yumFoeKqx1NQOhoiZgR4+DZfmqVTYEShkeiuOJs1BQ46nQAvRTCpIdOUhuNr9L64WDkrl+dUGxOO5quKirwVL4es1qIRIMXm5dzZySUkw1f+oKdr7DMItJ3a962ch4fzeLhr+bs0QJCihAlIv36rVb+PC24ox0D6u+PZ0EPLPelRcBRtiaY1pLyzr0eDwkLDc4FAYWuLoVqgKmC/oc2ee4GDvOW5cjFmrXXxN6zpw4H8R9LtIrjKesd2586BDd3QSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ncek8gzDfjTSQdqvwfRjsSEDgQMdRP2gXvFrK6AAcv8=;
 b=dmD0+7dKUQRHUK1OafZ4OenU2DIzguz0/8MkK68Cob8InqPAtG6UfULK4N4Qn0SrVQDktsfW7Bef8EpfHyWRfqAnYsR0odQ5gj7TVgGcRMPi9lWXJwr5YnD88E99oCQOvMKT4bIVqvYaoi+8O3/3yVddX9WvcQgU6pLkquR9UVpqo5jwqH6uEzI1tUjDAf4VQQ6KwEku866uFpD5FfhmIMMso6vkSonfzKpnJdEhDVV8Jxl6jrPuHOm8twNAlp7h77sFtfFQEFXo8UvEGOb/Ou+r7YjrjesDBp17FsA4f62mrc9QPrwWOP0872nJy2A2oh5LsulxT9CGQcxaw06n4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncek8gzDfjTSQdqvwfRjsSEDgQMdRP2gXvFrK6AAcv8=;
 b=M0uO9xJ2VJh0PtKWBg9jZAUtwiaqiBBxvvCkaMcjiuYHYEDa7KsC1Kx/UGjzUYMIXNkrih87TBcii0mCiT/fVFC+aqvndLdFMHanZM2HMkLxrjfmZLAhhfX0INj+zOkfZ+D3PiygtvIcqKCZN8c3Zpvtia04iBEn3Clow2I9jOh1Dsq964wOwwrL1XQT5ZhDAor9DFu0eqGZekjeYvCRK8ZI6zEI4rzwl20h2yz8nmGK4WCWtjUpLepT2q4Oh+oGT/5eCNgWKSivtlH3QosWHTIPS+YxG31HEeoUK6k2mX8fEq+GMLpN08DY0LmdK1y9I55KmcZ722aEXQzgm8xv0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 11:49:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 11:49:17 +0000
Date: Tue, 25 Aug 2026 08:49:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <20260825114916.GT244917@nvidia.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao1vJxkZsJpr1qXG@google.com>
X-ClientProxiedBy: YT4PR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d33123-1c15-4eca-62ea-08df029ee48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yjDbMfv6mpoP4Bw2iDca1KYrQt+jD9LLOE5r3sIB5NI3+hRIhi0uefw4WQMtG8bknM2Qr9iZ3PBXFp3/JBL1xff+8P0HirwyRNgU+p2dAmUXt1tYyKadTuOl+5QZD4OMAW4L1T3acVXfqEYmiKV8VubE+MMiH5kvtbUtgol1oTFTTqiTMcUxgltPt24a0tTxRQ3Nl9fBE1im4neJFayZCR5YA5C0ywUakL6zGOnsI+tt4/uuaGaBwu9PiE0Vx6ahSdPgPhrtcKWtHucnrSu05ETj3T1xlGhsV0BNpsBm3XkgQ8rpfgfmZl0P7rTGcfDfipk4PcU1lL1zj6aNEFfYo8Shr5ljff5QyXmYGU7+15yApO6NsDJbhFKbpQbrSIqWiQkj1kU6euscpoAQ4vrF96lAJe0t0V/WpHp7kcwiJ86/osMHxAi3kRts+DnYO48M+i96Rf2dPQVXwZb87ITeJqDciq+mfc03nqh1VRlRzjJgSZXH81W492fkQXbvWIz/LcmMjLyG4NS+V6sXeruStRnihT4yfvUYFZJoc25BCdXdE5W1fRWxu4Jv46gq6mkSHQXQFbEZ7VdVp+SeyWQpk9PyFi/EfaunUsVDiWYOMinAd9/AnQ+xFngN3MvdhfP3eSB/N5AD3w7g9QJTcPYQEX4TZhdkZLVp2fGngVYyuBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NM4xF1vySLonoYHhxR/qAFN4qb6ub+EBD+YBFFdqUOVTHe+oPRFKme1jGogc?=
 =?us-ascii?Q?UqgRlEYoZ2Lwvvq27hw17XsvWrLmlcLvmW/Seq0AJFpu48pef8XnRG3pgkwQ?=
 =?us-ascii?Q?AEmu0Lkf8rH9TBNEdwd9NKuiwGDNahea3sxf6yaxmUAdpnAUOzrqed2Rq6eB?=
 =?us-ascii?Q?j3/BzueIdHf7BkKF3sqMPoteUeaTivsz7JtR5sR0NHwCIiQITdp4PmqMQISw?=
 =?us-ascii?Q?vFw1f8jD1rAWDSCwsgYxUOoDdZUTwc+ohtoeavW8atr/yea+wMpn8PPIFEze?=
 =?us-ascii?Q?FxXYZSRasxnJ9SHIVz9O/FarN/v+JOh/UE97GU0RyX/wr5Ap/msEEkrbngYo?=
 =?us-ascii?Q?tSPw0tnNGgH5Wh6SkblMyAvIQ/2EDT2ALjKUJ7iB4ScGzBxI92R9GBc38reZ?=
 =?us-ascii?Q?5dC2tUdkdvIxIPbs7q4buZXHYGZODvGHwwgx9y+0avBI5pHUSxxrSrXjXVKN?=
 =?us-ascii?Q?JuJnKIBQ0LhkGGMxoDwtw/xtkTd1l82okS2YcbBA5ZnIs0n5cdu4q5rbB5Xz?=
 =?us-ascii?Q?Vk8HO3JEF88m8SZa/c1fGWzwJw2Zn9nKAtRj0D81UIqaQN8XHcRZCL7qCWCA?=
 =?us-ascii?Q?mvGASce77oJOLC2SMH87OTfTfFp9ICoZAkCDsQCrtdtkf92VZ98GI3X5d9Sh?=
 =?us-ascii?Q?nE2WoUqSEKbL9x4pchACO6XWo/C7/D1zwnONV5WuAbUjjO0xyW5WnMOaHPFE?=
 =?us-ascii?Q?KLHGJPvBFuxmgQM8IUuF/4T0rEP8qzrcLilXpn2lQUqatfffnfrpDo2nKR5m?=
 =?us-ascii?Q?XcYurn0sghN4x3pI4CDTYB/PHircdZifRGRWpcNi0/LdiPaRRYTrpO2eOIpO?=
 =?us-ascii?Q?PqzxvxgJBpxBmyf5nRifNzl8pFUVjShWzIT9ldP/bKFwtdtPUDNdwQDJYlr3?=
 =?us-ascii?Q?DVcf+tiosiGkRFI17DOGz3nUSNgUnchLudCY3AxDP/XYr9ch6e28bIH/M5z/?=
 =?us-ascii?Q?YBRYh0fVb4pg+bjXinwASH3PbumoIyX1N5dZmaguzdngcU+MGG+NXUFLL1Jx?=
 =?us-ascii?Q?bFTX/9ZloKW4MxBNkA4WJ+QdMn2MQxFl0Km1uHZAj+E/H/f9RZ64ju+88NJz?=
 =?us-ascii?Q?eTzfLZnqsfXFdJuq9AaBVjvqyDr4h8J+fcf0WMZCzXPWQUYuCBGW+zqgcRkp?=
 =?us-ascii?Q?iTqBUhzP5CBWs3iVwcpZrKDPR7KJU8MEWGNaxdGt2qml52Yvp6XFdJNt9u5O?=
 =?us-ascii?Q?0mgtmBFPMxNuUufIXYh6NkiTWCJfq9qP2vl/IcfaUqF33MPjv3ncLzMcU3ab?=
 =?us-ascii?Q?c8UNvWCfwY21p00dtkisw4kdrSX0Mhp2ReG4+jSOFbU8X5sbiLjZFRkk9Y76?=
 =?us-ascii?Q?D6olbmXs9JONqjqqV2WIOivNanftitucXcS4pbRbwyQa8ojEViGuXLMEZR2Z?=
 =?us-ascii?Q?kb5bO+/ycsCQM89uS0SBEOLbs8jxORD4sKYHzBSdTd0NjdRi99GIs576q7Lz?=
 =?us-ascii?Q?C9N6oGDoAEufM9zGmUXMOUle/xEBVkE8jPd6lOTyf+KMzTQdWdJdCN0Ugk6l?=
 =?us-ascii?Q?zzXiveyzxY3FNKs2DiQysBwFSip8kXGMxjKYqpgLgV18kRlm9fl4Gdglxsgn?=
 =?us-ascii?Q?VH8RvQwgAVKiWKmhfkEV5k1SI8lDAwtWQSXYcmJIh8/VluLlLFTHY098Wg+I?=
 =?us-ascii?Q?7xLupe6kFARLSUey3YpinSZC0fymzMA/zcfA9c692yGuZZBEbWkpb9htkD35?=
 =?us-ascii?Q?BNx1ZpgiOkr9eSFstqTKFIe3psLpKPmLIS4cvPL3yKJenLuy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d33123-1c15-4eca-62ea-08df029ee48d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:49:17.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+OkmGqNf/DJMiMdhRU38kE8CSI7Ph/o1In/dikzMTaiSgBnJxpPl2pCHY55kR4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On Tue, Aug 25, 2026 at 10:32:07AM +0000, Pranjal Shrivastava wrote:
> On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > > [ ... 52 lines skipped ... ]
> > > +/*
> > > + * Invalidate a DTE by clearing the Valid bit first.
> > > + * Note: Lockless; Not to be used on a fully probed
> > > + * device with live dev_data.
> > > + */
> > > +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> > > +{
> > > +	struct dev_table_entry new = {};
> > > +
> > > +	write_dte_lower128(ptr, &new);
> > > +	write_dte_upper128(ptr, &new);
> > > +}
> > 
> > No need just call update_dte256() with a 0'd new. This is how all the
> > update flows work, and it flushes the DTE which this looks like it has
> > been missing all long.
> 
> I originally considered using update_dte256(), but iommu_disable_device
> is called from the early probe error path (err_deinit).

There is no reason to do that, the DTE isn't written by
amd_iommu_probe_device(), so there is no reason to clear it on an
error path.

It is wrong to write to the DTE table without flushing the
HW cache.

Jason
