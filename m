Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC420125F;
	Wed, 20 May 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286862; cv=fail; b=IyNVAJqmVe9jjwXmJN4hw8wCeYq2DoGvl9fwkwRau9iBsoGJyBLoBMkkwUVijGMQbfDkXFfBMU9/H+YN9ULF0zLIxwFJjBfNYIWecCwLyUAxrwlGreZ9NGCm2A6jLfrDSW7nJC7h4HIeoOYk7YoLxAVkotzicrMHocJmcCO0S/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286862; c=relaxed/simple;
	bh=yAZDbra+yf6/ZDPdWnwpLjgRsk17tpXTenQg1+uVylE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CkPoa8gvY6Qj//+7e1VwvzcRBPWYssa/W3DC2xcisvs+LMX3KN3ZxGG5UhugTO8YMcm4+5mQtlf1UkuRWw9u+s29RXMDAGCQKsvvfpDP873LPQwxySRtzrQFtx8OjtyiMLdS7sNxPRgIFoAP7CSwiWu3vEUCM08wg63+IMDJrgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M2uascIg; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M2uascIg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mef6JPlvMolRLDEsFHOVzxfZ/3Ik53+JeMK/WQo1e5Xq40BN6Mdi+9tV39fIkMoKy79x7C/jMbSobykRKPgrTqreKaBNXXVhD+FD6t3xzhzklhF7eX6QLpGte7v8quE0/v2zOOdvsh6lDppsvT2zmE9+OFZqsH/h3Al6/AvfMfqIHbGabUcCsKzLHL2Ir85DuYsKBAzbZCxHL059L0R2VWk+Q6iiItU1unednF5L2yI4TUpN13K5QT/i0o4PS27EHDsrVTQj7sjXbmlkAE7EkCvx8tjjBRLKbjYTAuBHZZZfaztxSSDRKFTMBRGA96F0p2jiGTBImpfkHQ8Nl/naXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0PqQOkKfZcx0lCvpSlSnK6ND8aYxYCxGZ8tLCuNGpU=;
 b=w/Nyb7KyVPtjcFTeaFTsFic084OD4pqn4TT3OG7NCy+tZh0nY00AcgAKW1ZLL8ktIOT6sK78ETUSJPMNOkfsR9PQuio1qccaslBCxGr3jkFOVCsTGSzv3CvKfid41MEqk/INVJwjo8WfcsT63IdC5cHJrnttwum8BT6+nisbexwJmsFC8/14OsY72Vk53dQbaRuYIHaj533dRfiYuXudK/u9AnmZcilVdofxY/5EmMpApxvddUAKcjyHRwsYrc5nIx+NbC9LG6GlqRgrtx933UCcxKSPPp8QWGyywQDA9dgJ0ErHwuca6XiNvIN/e8C3MGXvmvrkh7MUbQhpMQ4qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0PqQOkKfZcx0lCvpSlSnK6ND8aYxYCxGZ8tLCuNGpU=;
 b=M2uascIgCmO+sBdcD5wDAQGRhBHIA/Hgz3JX/fts/897Oz3ih0drs8rgC7xujpcyBMb9G0LDvwRh3gOfCGSSi6ySkPDBDofboBcZUBguQBwP+SgXwzf/WqifYNqyym+eN07o47ohb6OUIkz/1QfWRsRlKepeKoBPJg57aqjUxquKWOb1aWiBwHJO8nmfxg3GM6AyFUM1uoXejOVOlS+4IhEx7cd7zMbTgnisf7dCgWGp9cT/F71v/3o92mChlMLFJhNqV7L+lIbtgdRDh7hSodbxWLuSscV+/Um3btD/3beo6a0LTZbtbkCxu0KY8VLmxuBM1v/+Ue80JuiSuADg8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 14:20:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:20:44 +0000
Date: Wed, 20 May 2026 11:20:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260520142043.GT3602937@nvidia.com>
References: <20260519222335.GK3602937@nvidia.com>
 <20260519234801.GA21369@bhelgaas>
 <20260520000504.GQ3602937@nvidia.com>
 <ag0IkpcWvhQUfzf7@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag0IkpcWvhQUfzf7@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 4661e9fb-eaa9-465a-0ee6-08deb67afab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	8qyOoCbPTdvjh227a0xqp00eRZbuM/lhsGHX/c0uzeCPE3peqfAmzVDchSzOQsPbRpqAEr0WVmp3YCo5/DBQCdLNNSGUgUvVJuUMKDXczzVbjhyoXq/efVCi+Q9QQO1nAJPx/DyOPI5F73XKcfy00zbOUEBLl9uy4CUbEPo+tRSimQhHQ9v9T/JScM8GANCKu3VFkXXOdD9B0D5cGEMu7HmhEvzdq1iYBsXYt++aQTTr2c7hQqseWOocMV+tCPzI6LPqJ1VaoWHmGsYF+lAc+cNIkB9RibIyuPZAQWXd58QE9LZyc/M/+ZS1Hw0ogFkJi10a04aZ2C4nqUVZqQWCJMStAcKhsamcMuECe2PoBxfCV8Id5MLGD+nWJQsVA4jDkn6SIHWOvvtSrkCcJlKT8RQLCaS7Os59B85thfKFPLrMQ7BxuaSoYJ8CAt9pipmJz//nAYlmaZu0/8SAo2OPtq/5cz11dI085zIyNsJPKXgr9bVgDIyejcqE4e/37ud6zSsKGr5cWmE6K66r5mX/0Esn7AwMF7lR8JujLEWMAyBomxdwPuJ37IWAMrlDTQxNKGRxTGM+ZPciRqhWGX08+t1DgaAjrfwv9aiJ3i0vUSj8fvz1987VEGyyFtXxjMJolNUQ4di1ckwPc2jqu/3LgltV3VJgtNM59PiWN4wf1exl9b39IbO7T890MPuxftsX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GwxzyF820DaQRZR50B+29+Ku72VvEung9OjJcTsxi1v+lYEEoURTsmdh1e+l?=
 =?us-ascii?Q?0sncwpxicJexFuLHn7V8+WAUbhUxmTBDmSsXwsFfTohpKmQugG1znKT3uFSN?=
 =?us-ascii?Q?0FAFTOjAn0hutkUOCUuesBjAF1bKzimNHrdioE/o1v0O3g724FLWmWcF3+Ef?=
 =?us-ascii?Q?YLCby4034+RgEXCC5v7Znda53vChuLKG/UqMao8mgOO+mnX3msm7S00lQebY?=
 =?us-ascii?Q?xKz1CfoikvYgUn9CARhM8hIY9Ii2scvNdQT5vUxVGdwj07wy1pPfD45rtWX+?=
 =?us-ascii?Q?YSYOraFNSS4Khdn0lTW3ssS5MIJETijE3h+XXh4vwpGqPoJru6LAk0jCk+N+?=
 =?us-ascii?Q?y+MBHR3lwYcA3+RkP/wbZN//6yJBOzac8IQxieWAU+lVpLqMYFKY9SC7OI58?=
 =?us-ascii?Q?ZWX7l7neoCv+x7BNow5Eox+9mgTkcOlyiEIG3gOXalxRM8G4CnqEG+meoGwf?=
 =?us-ascii?Q?3MU9NnGs+Yr6gvHbg/EAt2ce86CTYp3eAoAn5SBfD91BC5suovgwaJWI4S+q?=
 =?us-ascii?Q?DF82U+EUIiXqiwRPWJxU9OYr0QN4t+Tu63IMuD6cuEnQlb8n7MC8jHuTchmh?=
 =?us-ascii?Q?02cflHoy16ZlKFDWchEWNka5NacfKJvDPK7e7ajZgAH1OFknAya7yw/2lAtF?=
 =?us-ascii?Q?ySJs+NzlZI+8MGSs45aEl8wuLvch6A4VGZboLyCHZgfwwX/Mb/vIcfQQmw32?=
 =?us-ascii?Q?vnuC135ysHK4EQ3H47RwNhf3YmIo3DD9rFFVCq1uXvANqnHJx+z232eNLjzC?=
 =?us-ascii?Q?rKlpfZczkH3br+qYXVGAhgFR/Xe6EbAiY3M1935sJhGTtOEfygIW+6qUqspL?=
 =?us-ascii?Q?RRIRyIGCXvp3+fV+y/BPWqKTCowLIyCrWEF7+Pn7ESGCqP0qmzHUeYrDKDev?=
 =?us-ascii?Q?Zs8K7B2P1wKgRnkCEztdXVeLxitYVv3zHmvVdSzVjK5Cd3ltShT89c007Nmq?=
 =?us-ascii?Q?gpGORMMMjN6niZHMcTkcVRTwbi9+KRKCtmBCACGA8ZfB/Uvp/GtsFA6gONE6?=
 =?us-ascii?Q?VNApC9A8CgGxiHoIK5Nfi4WRkE+kEucBLXlQtMB+D+szhxx3fd+rwLbXWBXF?=
 =?us-ascii?Q?6zWPM6z3sVKFKhn593c5Z59WxKSStK5Bc1/rYkkPRQYnKbyyxLI9n1DxonsV?=
 =?us-ascii?Q?IUa9uxhfgWEkMRWNMEWlrImH20p6Gr+ydGcF/COkLwBBg1Oz4hoPPeQsDW4G?=
 =?us-ascii?Q?AHohbFyEywRelKKYYQaHaR98RoLYg1Ns1WV96msbxoxfgZTFcU+lnDlJKpwy?=
 =?us-ascii?Q?BR4i+R/jvG9nnYWArDEmElaX0gAxHwHw+PvubXVHEYqC2f/w6SiTwl5xAbkA?=
 =?us-ascii?Q?SyxhwVk7A3BadkegzQJMvZhfOIt6BcyxzMmYbjyLQ7VZTLgYN8Ai2a71Hl/E?=
 =?us-ascii?Q?iXkcyk6gxylMSQ4ylNisReMha6lTgjhPOczULiivGCSvdBrNgvbeCd21hLgO?=
 =?us-ascii?Q?JLGJR6O9i+Yn8OvhZQm4Zb0Psk+IsUocPZYZVGcWm/WxicxWw4U48VTxy981?=
 =?us-ascii?Q?VPVmVKRWLl18PpBy8V7P2a5DpHwSWqx7REApuF8eC1M1jdB/Wx7tgaAbMqO7?=
 =?us-ascii?Q?TldeE/OCAIqFX+FhZAaQYMyYOI4LEj97pKXOgHGbJdGmGhAdewEt8ui0w3QS?=
 =?us-ascii?Q?gBWLRg1dHJnZWQlBd2I+lFRPKk366YM1sqn/Fixu3Ohsl+zgrXPPhMbuQOb6?=
 =?us-ascii?Q?AWlXoFQycX7GRF9Mk4yLrX1I8M8xfiASLzHkIBRa2V9Es9sN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4661e9fb-eaa9-465a-0ee6-08deb67afab3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:20:44.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JqEZyAz0VTj4jI6IpDMPKIbfGtWcwoPebofNejoWcbODiBuDfthDReU449mrmfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0

On Tue, May 19, 2026 at 06:04:18PM -0700, Nicolin Chen wrote:

> > Yeah, that's fair, so let's rename it to 
> > 
> > pci_translated_required()
> > 
> > ie the device requires translated requests to function. This is what
> > CXL.cache implies (IIRC I was told the spec specifically says this)
> > 
> > Requiring translated requests implies you have to enable ATS in the
> > system.
> 
> Perhaps we could let IOMMU drivers check:
>   pci_cxl_is_cache_capable() || pci_dev_specific_is_pre_cxl()
> directly?

I'd rather have a single function.

Jason
