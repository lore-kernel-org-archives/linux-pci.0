Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036728CF76;
	Tue,  3 Feb 2026 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160575; cv=fail; b=N/J3k55xbE4Lh+p3vXFIumnVdj5/zwEfToJfbuNxITIACjfqF5xKhnAvyEcWV6hna9pR/HycZKorBjhWcwf1CITOgg8DFrPv9dy/gR5Lr/uGwdFo4q1YvP6n/IiFofHd4Y+FE6mxZ4xobV8CzgtLdeK13HRMSiwP0/f4iOEjkXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160575; c=relaxed/simple;
	bh=Z7WOj5U2IKN4VeRDxxTLqwza/w2Xwu+5kotPhqdf6QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aOpF3tvHxI4l+MrA1K5ONKfzh9PVvjQUlAAgHCT05IBS4Z2gEyKA4mGiPDkoBKTaQXR+6jHqlcevk+aofy2m0XRmZ4vprV3LOh6VaWaY9tkByB4H9c4lWcaCiuhPJ1ie8YfrsmFEQFiMv+x6uLhCxp9l6pqXzt9RpzbKKv/gqi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c5dzd0VV; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c5dzd0VV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7gbmEVO+W+EGHXIXp83IfsGwDj8Lp1XgOEsSyVqmGKbxIyd4Z8N3fN/JH4a3vZl+V0TulfKqQ6naZmB+gSa6KMvIEBkyUH5/jFso8SDURfQaTFz28G059oui60BuZfEj1P6eFaJTQrbbB27rjcRk39fpOsQPtk/5Spc6uJ+QXFLQO6x67yvmrkvDSQK3hyU4ns97ayUH7VLubEkqEIkRjIO+9M5WRcTuKQ0ND7WajnZvIQsGJuQ4vTGprNwX9VTHo9y2Ozu4VB9Ys6oSq0ra1Jd9327W1zbv36hWZSURXwKSWZz6tOIqiFTaDICNkF/sf6wliDPxmoyBP4Btm94+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7WOj5U2IKN4VeRDxxTLqwza/w2Xwu+5kotPhqdf6QY=;
 b=QTPmyNnAbe464QW0+oMeuD6qBFjv5vE8pkJVGCQZu++QSbWtc2fAbWba/wYN8kn+diGS+IZ6TJ/3AIRkt6PMvd4YVbiCbmk2idCcVEkbmxVvKS59xHnF/PY8cW/fg5NkG89tieZJRbY5YFXi6rzpD05EAVZ6U/eQWdCnFU98pp44v8/EPQ1CFAoWeGbuTGZMyaaeznvTwnI+AGg0INGVXXhKiynCel6mPZArqbYoLXCcT5YNrtXfppgPKTKn0aMSJLusjjbXuzUy8C/a0kDJ259okbpGb6gr5/u7rNXaR8oV3GsWSC2oW03YbYOm2uW8Km+hzztN21JvAM3TGwPkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7WOj5U2IKN4VeRDxxTLqwza/w2Xwu+5kotPhqdf6QY=;
 b=c5dzd0VVdocdJKQX8lcspL4tOBm+iBSwjBsiYEro0RS0YUJeYZLAr4Z4aUrp4smeD/YdKLwPsZi1YrIHSmwAhKxP5ZclMR8xOyYG6xmKDzEnAMMfVYe/QfDeOfzA3V7FNPWZ/L9Z+Qhlj8j7PwRnAqkzoMQ/bXwKHdF4v8IljQgIDHhMdSFm9G1AvlopMqFOA3OLdlSpycY6KY10DQWJXEul3agePVJaJG5MraPQdzMHfTFNOq1RZrGDvHIHwuKiBHplC1mQkFskWj6Uzo4FIPY9ZeQyATUluYvBQXFTxg5O6imcg6K10M+z6ToZTg2XliS7nfUwK+/fZYAQKqH6hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 23:16:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 23:16:08 +0000
Date: Tue, 3 Feb 2026 19:16:07 -0400
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
Message-ID: <20260203231607.GE3931454@nvidia.com>
References: <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <0472f0f6-2f13-459e-857d-d5003f2f0ac4@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0472f0f6-2f13-459e-857d-d5003f2f0ac4@arm.com>
X-ClientProxiedBy: BL1PR13CA0243.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 768939c9-cfbf-4548-651a-08de637a3698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qTyRa8nxyAUYqh/bJuQMFvV+yWDOO2CvXeks0RPduIYLorhjgUrMYB78zM8d?=
 =?us-ascii?Q?kcw1FdFh8Ls1rLPHaXjSk86mMCpAjS+O06PCWsr4TUgvU7PSFff90zjzsa3x?=
 =?us-ascii?Q?GA6Ao8OtUvnQ4eB6N7bOPq5Kw0gi0kXmMb/7QYjolnVSSsKyB7MxPE+lk7ap?=
 =?us-ascii?Q?M2ODVLwFDyz1G6MTbV3o/9Bp+pw/DJmWI0+XB2tW0QnDxMqfz3ywxshXqrgu?=
 =?us-ascii?Q?7FSSxmszbVrrvwCE/kCFd/8P3lxX7E7wNJ4nBthAiPXhNTaI7ejFaD4a4Z3D?=
 =?us-ascii?Q?9pGd312BVJ39kUg4YkGHR8ba3saCIYUlEDifkEwjxme8/5cAk/Msyxkrzu0Q?=
 =?us-ascii?Q?gM/0qYJx4c3OAdhNe+MNErUreTP+pgFUSeyGp8C5tGG12egDa9mWKePVAxJc?=
 =?us-ascii?Q?llNNG5vqXlA+3HGp8vw2SGMWPc3m3owI/Z8/AandI2NZoXs/GzQe85C4wVAS?=
 =?us-ascii?Q?9Y9zzjHzSfTSY3GPkc/V7CGpNSGAh5zcyl+LboQ1YKdJ0UyV43vRDukzKXwO?=
 =?us-ascii?Q?t8xUykhjou0vWaw0RSdz/bT0CWaa9uwvZbr49LqlF6pyUGzQsqgvgjlclz5F?=
 =?us-ascii?Q?CUepJlULamFCKdU8Hq+6jaQBQG3QFJmMLdUP7vJBEM1+9BVKCshZT6p1rRze?=
 =?us-ascii?Q?2cqpLh/r32+jvB0oU0IFw+T6ZDKd2J9ol3am+iAkRLCszEwMW8cQ9ap3PESw?=
 =?us-ascii?Q?jx8/5GxMHNtYCb2ytNxU9iNmOBDVstceNhbPc1O4fXsZ+3rF4iIuFNSgs5QY?=
 =?us-ascii?Q?dJOakCPEB4/aMJLwyWAh69hSbNIx+eFx4Yzy+ihmKDQLdiMQhQ6Ledy0sbxS?=
 =?us-ascii?Q?2kHaabFu6v/ffl+YkBFrLLOUEkzCoqZwITXfs8iqyntFWHMNuF43up7NZujN?=
 =?us-ascii?Q?VPG4fhG2ZBdva6xBTBNnQ1w9surTIYArGjFdoVUnv5p8ntmcaeyFHhoZzMoo?=
 =?us-ascii?Q?jl2KHjuB3oatDK5HO1htIPLfWQrUG2pNk3bQYlH9vMmsbOGKxrlJlr2wu5oH?=
 =?us-ascii?Q?mm8UfnSwCgezWjGcKJuoJtTixt4FVq82XonyC2SvNmmrbDotd9FFGJulfqwl?=
 =?us-ascii?Q?XzT90MmNnlJmfD+nhvBa8zxg11owDBg8cyGCqmf0GqzayCoxdG1vAIC8UYoN?=
 =?us-ascii?Q?ORdH4qXhco+AdjhHyoRnVKQD+SPGqgJPhJYGc08DlWKy4AfX7lQdKcCqjAFZ?=
 =?us-ascii?Q?A5w3nZzEMm7ABI+IUfm6q2Isuadd/tUDIzgA40dq4T2e3OjOWpVOLSSEClfR?=
 =?us-ascii?Q?XJkokfbFVI5tMckkpMKS4VCP1eV+ecuxYGxYdR2DOsuXV62se41OWOaNDmpq?=
 =?us-ascii?Q?FxoYIgIBgAjCLGwC1vNj2zrlKRg4Lye8My0kDgseTp53aJ1YeM5MEQrKBghh?=
 =?us-ascii?Q?m3JEGTL79R1quopJ3Ixkl/kdRealOLF8KPWJgN5VudQM2H5qJdf/IgHta2mn?=
 =?us-ascii?Q?h7kv7ladJiLCY0RyX4RH+6d9ohtsVIzwc8DrlX3qy7j8b2ewdsclzRNoSxlS?=
 =?us-ascii?Q?Lf+s+oELjl5otfLAylD6kOcsM6a/tA4x5XXaATAFeJwHVqLmV1mXKuUI6YY4?=
 =?us-ascii?Q?irho4FWvx66dL8tCJl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0H2SD0rqoca4jP7ZaGonSuKYb5qu1PDswJK7JOW8z4PghWKviLVVOE+kdFl?=
 =?us-ascii?Q?z5Gm0XepIbPc4B6peCVccAlaqEfkL4oHDQ2Rh4qMKT6S0bNEVgI+2J0heveH?=
 =?us-ascii?Q?1jLODBAN46ftO4QLy/I2Ef7Le3BQo1/05oDQb0UY/MmcgEFKD2kyFmTXt0MX?=
 =?us-ascii?Q?EufyNRWIuGzSynRvNs4ohmkCFmiojCyHyNv7Am9gpmHpCOIwypivanxU10/R?=
 =?us-ascii?Q?szzhuMy1VjvlNrEH1pzsohwIkF8FwsFOzQ8RUyKP0njorggeu2K6OMhPFxQm?=
 =?us-ascii?Q?mba42v2A9JAlmyvn5HXjEEDFXAI1T2yie/vrpybsoQhRTJGbLTCnvscQUiiT?=
 =?us-ascii?Q?oyyKOtuZWN6MXHyS7TU3san3PQESYzbBTADvtbPRoNcUt2Q2RwCOtu8scr+B?=
 =?us-ascii?Q?SQa7F0wn9uMtsnHmP2apmElEWDXwCINAFRQmig1nyvPTS3/2+RdVBpBneL4o?=
 =?us-ascii?Q?Myy5AjTOP3iAAJ3M3+coDOC7auY1L2HHHPZNRVx4IC2fOlZYhxZONZI59J+4?=
 =?us-ascii?Q?hwQptcD7PJjnOYIssIyv37+ru2VqjDxe7Br7RHYiQ8J3FLvffww4o3O6ZKWS?=
 =?us-ascii?Q?rCHGs6fw7s2WQAaiOWtkBL3f8KEe3uhuXuDf6LA1lNxi6+nUe4b3cxkWl/2p?=
 =?us-ascii?Q?hvINuzijd82bBV5ucbieHUlKD1Z/PSKHoZZVu4uC+hLktPPr65nhmu7lrgsE?=
 =?us-ascii?Q?S0N7QtB4fh4JLcN/G67hre7AbM8AlgV37tEs+6jGcceS9F2qdHM+18gCEDtT?=
 =?us-ascii?Q?pKE0vufDylkFUb/5Rgw4heGSz/sPp3cGP3YGrDIXk3+Z2Y4sV8U3wDnTu0vs?=
 =?us-ascii?Q?z8xrLyhBGPQXlz6y8pX0FsD5DgE3yD7F7XdkB0P0EqjtrBbZOnD7dDOyTeJI?=
 =?us-ascii?Q?Km+dJ5fVwWWW1IpTvgCr/GIvVQvKb3+WhpkCXk2LP8ukxzuKCs6AT9TuH3Xi?=
 =?us-ascii?Q?7Rb9WVvB3249MIrXG8W3RDWFZgsPiKURNbCXuQZ//QmmCyCMfthnbG4KxjNJ?=
 =?us-ascii?Q?nOJ6a3z1376G/uK+EAd8zlRs91o9avpr1Wn/2r4yePDZX6j6C7Dc6yMPPM3V?=
 =?us-ascii?Q?AfkgoVwv8Rjcm2RFL2S7auPF88WfoeJAEv1nVcpky7n7566sOqEYcgaxLxI0?=
 =?us-ascii?Q?j7uiDrZlI9J0Bv3XQW8SiRC34ew/JpdowPDXyzN21uqkEIkxEpA4EWV9uIXO?=
 =?us-ascii?Q?z6rGVwX5HScDW5LEmkRmlJNGWbB1TyGjbb6+1Qx5aHGv7YzTHC2HNQ+WxnPb?=
 =?us-ascii?Q?E9kjyV0JUNcv9G7gIP8z+mrW2jG9v7Zh2rtuvOZFdhsgoNI3W0rB/DCJ7YqZ?=
 =?us-ascii?Q?t5zEGQMUp8uY4ITYy6a9l5pP/G+r3/obZS100ydEK41aggZ1snR7U9t9QlLB?=
 =?us-ascii?Q?yG6vz/HHSkyAlXZCeZ0LQmmuka/uArHq3HCXBnEryoFAJ2PLB3TGavyjZBX/?=
 =?us-ascii?Q?eBjWR52UfpCq/bqzSsmnCBvLyTyKs4S91T+uHVsZrYtVHMAVY8C/IED7GbgU?=
 =?us-ascii?Q?miB4duHWWQaUsEJy8R2s9We95DQJirk6X/vtUrCj8/r6ypKCMKr4FPbJ8ilh?=
 =?us-ascii?Q?Jx+1SpKm6/Wr8/yKStHFQhc1JHe/wDDNwgYjlLjnBikc6vxHcKW/nJ+sbngR?=
 =?us-ascii?Q?Bvru+s+vS+cHcoiKZ8xvgJSh9JxSK+bXn66YlBO44FNTB4XrLrIiiBpKINXt?=
 =?us-ascii?Q?hO6vxTnQhwLcd3d+owG1YVY3e7JoQeCWDXt8vX/JEDAc17G+3PLDA0+z6hXB?=
 =?us-ascii?Q?LCChyZNtAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768939c9-cfbf-4548-651a-08de637a3698
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 23:16:08.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb3bgv8UN2bo3o+oCvMo9MgDX6iyQrorxw1v1FIk1oQLHUkqJrybnKiMmTOxpYzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589

On Tue, Feb 03, 2026 at 06:59:35PM +0000, Robin Murphy wrote:
> Realistically this combination cannot exist bare-metal, since if the device
> requires to send ATS TT's to access an RMR then the SMMU would have to be
> enabled pre-boot, so then the RMR means we cannot ever disable it to
> reconfigure, so we'd be stuffed from the start...

This thread has gotten mixed up..

First this series as it is has nothing to do with RMRs.

What the latter part is discussing is a future series to implement
what I think MS calls "boot DMA security". Meaning we don't get into a
position of allowing a device access to OS memory, even through ATS
translated requests, until after userspace has approved the device.

This is something that should combine with Dynamic Root of Trust for
Measurement, as DRTM is much less useful if DMA can mutate the OS code
after the DTRM returns.

It is also meaningful for systems with encrypted PCI where the OS can
measure the PCI device before permitting it access to anything.

So... When we do implement this new security mode, what should it do
if FW attempts to attack the kernel with these nonsensical RMR
configurations? With DRTM we explicitly don't trust the FW for
security anymore, so it is a problem.

I strongly suspect the answer is that RMR has to be ignored in this
more secure mode.

> However I think there would be no point exposing the ATS details to
> the VM to begin with. It's the host's decision to trust the device
> to play in the translated PA space and system cache coherency
> protocol, and no guest would be allowed to mess with those aspects
> either way, so there seems no obvious good reason for them to know
> at all.

If the vSMMU is presented then the guest must be aware of the ATS
because only the guest can generate the ATC invalidations for changes
in the S1.

Without a vSMMU the ATS can be hidden from the guest.

Jason
