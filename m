Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E539B48D;
	Thu, 26 Feb 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118614; cv=fail; b=X255hS8rnmKI6oBGeIq2wF3acS29ZtMo7SmVjPHZCvHIXzATWlP+2Q3pgWmntO3ZBKJigV7G/yEdusMDPP2SJwIZlPMb8fS5Vx4ISqBFfGYAU7IfRA1BHaqctMJf80ScMfsFf65EBbXHQ8UiG3PRpyOQV0FUotST29+BgAZIHRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118614; c=relaxed/simple;
	bh=fA1aJeVW9IWiRlcTMOJOCYcG+7dJBjzVskazbkhBnmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBEBKiRJnTaWoh/LjH2BvplC9dFEDp6N1upSqTObb0LCbJ9v4KFwm2gTBMM0yvcaxT3uhZMBOg104h1t/ecBg6Y7RKd+Fjo4zZoUO2bqTimCzE6HAJUqxW2JKDNmUvf4sIDJcxZXWTd8mStOCkwP0/DGaE618IZAAZmhIoI46Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gs9nJQ6W; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gs9nJQ6W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tutfhDyUVg6RHWRmAZ4hUC+f9ZjBmEGOi0jYWnuNvjSi+t0aBQHfrRludUsu1iG+AUzYvH0mIsD8mUJVX7ghEuNwq9kMexSQ9pDoG6+vkGVkibU8wP6QxYx1mj7awW9rUMB8/IH/a9D57TjzP9EtaIQKBZsG8GC3iVqitRtG/3exX0pXG0KPyn7dCqSPlEShetycAPa2jZutEIDUOqZXtY2nJ1bRcuO8+n4dnimhyBmITrUSWjpta9H7+bwyZekjmNgvJPUEOG53k+hUZrKrNHz+2YqWIHiCHPMqcrCM2N08EqpgyD3QPPBs2OHD+/9lvLd3vEt/8LlRZ5gu/afHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p/rG0mijpIkjwU7PtFF8PynamrpR89pcz/lUO56k6c=;
 b=lTOCh1wvJa2eb2o8p2yVP/hht4QQy2EMaLeMzGEm8y4zb7KALmsi9girxS/L5AlZ762iTU78Jxs0uxPz2LiiicgHjl1dPRlkWJSivBfdP10BS7aFcI11jkJwGeTLvK9st7z8DIAsX7j7TG0y3T9lqPPcMEU8wlHCJzuhacLtaYI2ge/ExPdHMowdRy78FC/Qi93cXiy73rh6S0kghQ5kLZ4XCnq3c30O9VWlvuuxSoqOqdDmuexX3ojSj+aD66MslBvtGmwlh1kQk/klRcPSWlFDW4ZLshU80PDlAnjHv/4q40RYJXCVPfRbBNq0bJxMDvORKEnyQI/hZURpOkR74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p/rG0mijpIkjwU7PtFF8PynamrpR89pcz/lUO56k6c=;
 b=Gs9nJQ6W5I+UDaFWIvM7+2bqHPzJw8O+hDhMn7z57UnygHwBSX5TpIXZxYGPoB83iqf+g2Pl4LQAooIfkDf7JLYufQTM2TGBvsDGOBG6JPmOp2PehPFQJzFknGGTZUt9R2sRXKZ2efGsuYGUf1xPAntRhqJLACDvlWkGSIqL90eu/8FtIDpqbFLDUeh3d3V0goH+HpZwZyEPmIUeO1qe12f0uQw0blaR0C2SIsuGmUvRBQTfB+sIxrvzFn31MatLKV/4FAouYAZ1XghljVFnAbcbKf2USp6tyXOtUFgQoMJP9NPzB6AFfLPdaOGH7Re9jN8tU2zLjdjOKtDppF7m9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:10:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:10:09 +0000
Date: Thu, 26 Feb 2026 11:10:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, dan.j.williams@intel.com,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260226151008.GD5933@nvidia.com>
References: <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
 <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com>
 <20260219174139.GI723117@nvidia.com>
 <aZfoqETxb31jp/Pk@nvidia.com>
 <20260220125044.GK723117@nvidia.com>
 <6a842339-3f0a-48db-830a-326add917519@arm.com>
 <20260220135124.GA1894399@nvidia.com>
 <c7cd42ff-f95a-4aaf-ab79-5af476bca894@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7cd42ff-f95a-4aaf-ab79-5af476bca894@arm.com>
X-ClientProxiedBy: BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f901aba-dfaa-4cd7-765a-08de754921dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	cRW/MOwQaMBnBmpWrKRklazIQSq6ec/y5VeE2+Ja9lVTizfQmloYArBlBjX+A/6YF/T6AkP/yjkag+UXzYrKsNzF3Qzq+oMe42dPHOjPV+4GdnQDmFnlALtfDGf4jWZQSqAeKdqW0iq6mZ7Vn9k4Z3wcYPdwRQojE2V5Y36+waOlQqHrmlP7h1Azva8W0ZojkprejXKZSmdVVFPmJJojxO73ZOOdlM+aAueVmH3YqNjnKEdMLkd52jBSHxRfeEZRHpcpx4W30TpxFexZMCmYRKVgL6Cf2jMDoQJ+WuxLI9sVLRoj2EB61rbxRMYerwqWanaBIWRUK0t7bnsOJh65ReS730XhOykBnln2hfzDt3hwRqHH72ZfFCUThhS5rwr+tRC5ry9JWnqYV50/1SWIAWU7uFdEX6lBrvtVUMbuMvuvhE4eAUWO3cPC74hDt0QF0dYmjUwOvPkYNS09aQy/vE39I4gmBnwPGuSfcqWn22CmlsWp85lHPsU278cT6UZpmDV3izesdTRtlh7LEI9WXBF2MgOqj3q+RnkzR/C4d+JyGpJZHO1xQSyD0Yj+ozhGkuQJhjxUv3i2oHQ08k4eDPQFbydtniXpdIy2l8qmhM9wCWp+HHWKghpjNSsOpM2T6XHoPLHDyMfX1tRAg/21Rjk8ADU+NJxAtr7wHEaCRuCroK24zQG0hni+LvJaMTeTQwqE8VRTT1fFbUTT/aX88mIWYBh72GjCYMQSNPzEhHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GRPQJr+zZ1ZrvgAe806JpS6mX7UXlkNZcHNyaeASO1QzOpK1Dr9KBI72OLJ7?=
 =?us-ascii?Q?6/vnNWrRacmryXYk3/mQd75VS2ztMbz/YZPlbb3pbE8e9hhJlukE/IIMUCKN?=
 =?us-ascii?Q?EPH6bB6eVcB+FNm1zLzfI5zNpin2P4+yU46ECf7TwFJosrzNtO6ryhY1n3dn?=
 =?us-ascii?Q?ftW8GV2TJ2TvqDJVZ6szJtC/LeEPiCVmQKK/SsCAYUVbQPb+Z1A/L75Xgxdp?=
 =?us-ascii?Q?rPhliWb7CF+6GS1BT40zczLgQe19oNkoc0yVpg7zHA4p7qG/yLsmRZoQlwfL?=
 =?us-ascii?Q?FOYZKgOuxavZ3ZMhCtHawQuToc0OKycVGoYT55RXgiV4gqKj8FirLVC9RiBc?=
 =?us-ascii?Q?ATI34ntm011BC2bJ8yeuZQCdUZt8IgsChE1UzEB7tQ76yjNq+yBxZhOBFAq3?=
 =?us-ascii?Q?OPsznR9f15HbddlRuNSlMu7lOSaG3yvwPDv9b6NQZV3B/Kmtp4bxYaenPsf2?=
 =?us-ascii?Q?+8cTLb4CoLzDmfP8mMrZXkaFH97tDmN7QgRHsqvdbzVpDwFBcOBzAlVoaDC0?=
 =?us-ascii?Q?70MCb8mbGeym9MlsBWnepOQqlinSBeVM3UE4GeFTtifunnSE5zD6j363xyP/?=
 =?us-ascii?Q?BKF5N4qlV0sEwhJsvlc5gsxhbSReBkrUcO/3vRXtFqq40hA9JhW/CJkRJkXu?=
 =?us-ascii?Q?2b8RiKDDGmzQwStW7j69kxFZ7zpFTOHsI2qBs9IekAMSyyU/jaPkDzFgkL2P?=
 =?us-ascii?Q?iBKU1erG57pFqrEqcjDBAFdICIv09Oq7yjEFasXz3PCVff21FTN5+CJPJvel?=
 =?us-ascii?Q?wEi/XjKwIE0XEvCCKXmdxYjlQef2vqwgp7f3TN7YX8oDuL7qCd167V99R1+9?=
 =?us-ascii?Q?pW6lfQzUDV9AkU8J2E8q42TOsp2LlgohcDf4fW+IARLVJ0Oja+oWTc7THrYW?=
 =?us-ascii?Q?HqIphLzfmvVSMoJFRmzBl0AZIuupfrg/xCIFSCy4mr6O+BeA6cFGny0chKBj?=
 =?us-ascii?Q?xGqUZfUOVsMXKBnnD2UrIjD70jxG9wFi22cPCe/FHEC90vn6EHWH/7JyfR9S?=
 =?us-ascii?Q?jtnSa7+vBl/o4S15GcPJrBrQiv5qn85F6BR44G9Z94Mv+lNOhtHsUVyLdDJe?=
 =?us-ascii?Q?9lPHIqIRIjtKzU/H1UUujm9S1G2HKADhUQM5zQO5otry2Bf438fAdXDH4woD?=
 =?us-ascii?Q?6iDuiieMsyROdruj41QZV6Ml9m3FswUup0pWW5m6glIXg1Uini5A2W+8DYdO?=
 =?us-ascii?Q?S1j/2eyBL/1tDIGqFQ8OgPz6V9/wbRTVWxdZx5T66RpWDWzaVH8g4NjXcc6f?=
 =?us-ascii?Q?hYHfpAviJu0wjswpUfWdKGi2vf651cSJ4ORnBm/mvVx2Is9/p3sXj4fhFPwC?=
 =?us-ascii?Q?Ey4o7O3fZ8qgJQ4bqxNrya43/eLkdrm0XxFf+3lqiUdaK65cviKmpiK4K5e1?=
 =?us-ascii?Q?d+IfY+Zx5H7UAV/1hY4Pi1w2FZozIKC4NsBS3FwgCueuzOZ12UocOnS61UYX?=
 =?us-ascii?Q?m6NCLJwvfd9GclQtArJrhVuQ1jIasjyTPdcgD/n3OTwaoC8IMCAf613tGkPj?=
 =?us-ascii?Q?pT/EfkJRCDIPBK/vRG2H6KbD9c8U+QshhsvXyY9OqCepYJEaL92N257yKlXf?=
 =?us-ascii?Q?Vhvk/WEoVXu09u5MgcOM0vGPN3d+ew8VyapdkyfQuYBtXdmqSOty+GFJL1oi?=
 =?us-ascii?Q?1AQ5EeXQIx0QjqelJnj14zWtoSHs1KszqY1ObMLB3FBHPFpYmjNSI9mrYIEb?=
 =?us-ascii?Q?fQnWaR+RNLVm4/ARXY90xCf1IGHTiljFsW6k77KXnbHvgiAc9+7ycHGq1AwT?=
 =?us-ascii?Q?azCvUjFTLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f901aba-dfaa-4cd7-765a-08de754921dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:10:09.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9YeU5LdhXEDKYiHP52S4B8ONsQs62HsiYilZgs/w6EbK6C0xx35yEl81ON5M7yR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062

On Fri, Feb 20, 2026 at 02:45:49PM +0000, Robin Murphy wrote:
> >   The port driver will start first, install the ITS page in the DMA
> >   domain, VFIO will start second an switch the domain to BLOCKED, then
> >   to PAGING, and the ITS mapping used by the port driver will be lost.
> > 
> > And nobody will notice this has happened because the interrupts in the
> > port driver are only used for RAS IIRC so the net effect is your
> > system doesn't print AERs anymore.
> 
> Indeed VFIO's MSI cookie doesn't inherit any existing mappings from the DMA
> domain, and that wouldn't work anyway since the IOVAs would almost certainly
> be different. So we'd have to somehow free any existing AER interrupts
> before the domain switch, then fully re-request and reprogram them
> afterwards, in both DMA->UNMANAGED and UNMANAGED->DMA directions. Oof...

I'm inclined to say we should disable this VFIO feature if CONFIG_IRQ_MSI_IOMMU
is enabled... Better to hard fail then silently loose interrutps.

If that causes problems for people then we should investigate how to
fix the MSI.

It is really hard, but perhaps the most elegant solution would be to
allow the group members to have unique iommu domains by
dis-ambiguating the 'grouping for aliasing' and 'grouping for ACS'
cases. Then the portdrv can stay on its DMA domain and everything
keeps working for it. That sounds like a monster project...

Jason
