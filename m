Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246D34BA33
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428879; cv=fail; b=pUjWsC7+FhaUK537YVAyiGsDexumRj/ebkGAoPBBa1iGMk/RuVkBkjCaWEQnB83E2Rhh9GyYV0nEv0eZmt2gU4YqrtQBbZ8FhClT73qGmtMRj+KV2OWLCZWHm07ZwC1hzxUNFjfQJ/Tc6/fDlJbS3HYhJ8FnGunaJljeBEYJw/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428879; c=relaxed/simple;
	bh=ZP/419+gfDET7cQ7CkMV/f3dAyDaXDTZgkh9pdRsdms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ItXUdWMGrS1uyuIK5s++nkOyWP3dmKCylDVi+LiT/daAdFS8yeffFLBj9Gd3yBIj7+5Wxi/hd7MdkhCkHlaeDnlHefcxKEtFcdDMTmtBq8ikMcuWx1+bIxJjiPTKHQ1tJXGbeUVJHgfZ3Sw6Er8HHymXu8+fAy1a3tGMvrYHU40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1iJxOtt; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1iJxOtt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfVi4/UvHEaomPlTciOvd0XlBhj5X3UkxbxeFGNBPP2tbyM+KHL2LyD8zXMHwip93Ox/3FnEqDkVfOLG3pbdD9reOEYwssg0Qqi15nD27hnhDRPOcB4pfvBtFfUYQiNlxTXEGNojL1k4UR6LaTBV/mCKCoV3LAc1Ie2ed5QqRREeHQeNwJvuUe+RHHMIRyvi4yWJYqS6bChf/T9KZEeOHNPM/zIPrW5sNOyLgkp7SFE3f2Asu0kdDo2bAWYnEKXA1BzpyOf61x1XLm316sIz5tP1sxUE5Z6816SZ2FnHO+w+coh+DBA+En0I5iiJ+LneAOlhGcxVTRz80Nr9VBOk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEW4JpJPsUWgYq1VB1aeoH+7qGbVSutbsOELyWHGUjk=;
 b=iy5w2rlFOpY/UK2O6ak32snlMWU/bhX040cfDBNjdL44kyG0iEEVHdnToDaLYpP4JOXqHcP6q7H+Gl5b6jlpe/A1bnmZ5TOsBcrxjgF37SydOvOhIvuSi77UuQOHWxTxxjME331bLGMTq2Td+8x/OcjmRZRoSwB8lIoxnvqhYIxXrTFrRzK/5AvLTnB8xTbTZFSU6iE2Iw6l8D6Atc4sA6AsIWuqlcfihaNClNkagWdQMT2MdAk4Q02kvItkiZbZe51O26x4x0YkhvMnOXW0zP2N2p2pbG6YigRF2YPOHP+lIVoaQN+26ALnoo5EsQUyykP7HY0KwDFtJqcaZnB+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEW4JpJPsUWgYq1VB1aeoH+7qGbVSutbsOELyWHGUjk=;
 b=X1iJxOttisDVkUxNzM5XpO8Kr0iEjq+J/zMzQKz17DjTb+NFa0mBM7C6EA5556Ro2/43e8GlrBRyLTMjEWuhgvW+Wt7HbHd8lpLZ2mYszshxAs/PSZNuSmKHHW4YVeHm0VjDk9UPIpp8EhTNdTf+IVxty658KG5iVo0m3dlvY49Wq3fPaqWRTxHSnjt7pCA/AAPww7z7vv5nf77Rcm4Oq900SxHqTGn473e3qNsMKejRcj+yFHyVY6qKZzEnO19Ey2UMn0BkmKhY78dm8asVJ2j/YWaHbU7gPRZhfwviargvaKtgr6JtSTixr9T+ky7VpVGQsBBOW+A24HFoT6Gmpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 19:07:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 19:07:54 +0000
Date: Fri, 13 Mar 2026 16:07:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260313190753.GF1586734@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <2026031319-payee-photo-bdd9@gregkh>
 <69b45d178ae17_b2b6100f2@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b45d178ae17_b2b6100f2@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 85584f58-6992-4629-81e6-08de8133d456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	roYkbONocVJcfeKctuXOOUBABt1TQYvQZckJJJNfEdA59w9bZiH3LKnOKakmijo/UKGS+YrTXOJ/RjpxSxxKOP78EK0c8OTPenlT5+0BNFew7na0HOZZZ+p0U0V6qQsrvcJmgGLvBkapJxEGSz8UNnQOw9Dpd2WcI5LzlBeTS2WPD0POUlGd81SxBQJJdFzfCtLPUW+mZAAo0vMgIOOhrjmoWJ1zrZ2SmupC0lNdRM5/VhH63vjgQPUjOiegq3w0KwnW8rlKJUwft/rq8qVSSrL6IS++vjFJ4lTF2z8ShjlJZPGwjLrg/ZYVw/Qr3ajtMG/0O1x31YH79fjs1BkX8eHvvH0gnQsz9ZFz2U57Z1ZeEiUReN7GssNGtBrPxtgB7JdplQSiupH3083SdrtddC0uIFWTx/Pr7eLAGZ8Pte6Ns46rtJumMh1UKPbhMQUv5nyGPgms2KbvWkHtdtkVwQZl2gaK8eXABZ9HZbZBk2n3h5WosUW+NKPzqyBwBqf4Nrt7o/BTBSG1qltWC1hYsbVyZAR2n3LNG1M/u6rTCByHohbnpIJxWRezwNX5g9+0DRHnH1tAnXRsmLfqIOZRwGh2gUwKTekWZaXuxjqL4nct3i4p07rkpziWnXj5P0QCa6mfMIoC3x25EGlmlmSqcpLfCBXnS71TdxEhpSAmAUhoqxFNnKaI3lzRPHe6THgOHHfZ6XxOeanaZfYGkZSVH8BZtT9S8eT5DJOb34kVuK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KnGZRuHw1KvdQbtBff4gx8gYSBD/5QQl3J8twFVoOeClX/kYId1icmeNWMNF?=
 =?us-ascii?Q?hmKmmj2XnrGU9tLlKmv1BN6Tkc7JWwNK3WRZuY5ZgD0GMvzAJSCnqeljLnL2?=
 =?us-ascii?Q?e8MI0fANKzPmUSlvd3p4iz++zSmtUrI1sjpuD+NBhHH7zQLtfzLb21c1gsEX?=
 =?us-ascii?Q?YZMkd/VgiyyZilpqQ4c0dH0plU7kCGo5qVK3JHODqqL/igGIQSGTWgYB2woK?=
 =?us-ascii?Q?b/L7fF204LRrrst18sJT3J3HRN4UdYX3J+3hc1FZWDA5N1ZBnyQpVgkEbHgj?=
 =?us-ascii?Q?T6u/p2Wnl0yNXfthFIQA7SIARCsINXdNyR5Lt5EUUepHyV9uOBpqkPioxeoz?=
 =?us-ascii?Q?1cOrkqrVk1dEo16jq3qS/T722XsU5gqmmHjr1IxNvrvxpVFzgzjnEBsNmcg5?=
 =?us-ascii?Q?1v5sGz5gAmBW7zWZsP5iGf9En0EgD+WKqUPgvnneSn04x4SwEqI1H5rnAdFq?=
 =?us-ascii?Q?hvgXFFgGxGwd2ZPWcmVaXgmSRf8jEE3898e4wAHRNsN+Tan/GZdFrS3NLQj8?=
 =?us-ascii?Q?WrWY6uNi3bX9GoqRqrNTsLV8I6+XwiiIxcUv0KiZNXPb5O4tzQrJA/6mA0MG?=
 =?us-ascii?Q?Q3bLSFr0lAQUKOHKh5B5c5GvoPKhNM7O7yMqGuRvwBq6RMhZKbN6hGjGzsl8?=
 =?us-ascii?Q?8tAHzeKBEizBMLQzgWnVcK3TWhgsxYrWltyXtuOl2MFdtS3CraGUN9GkOxT6?=
 =?us-ascii?Q?1/4uh6QinXWQSyvnQTwwjB8dVCOX9bVg+SMgA5LiPDdKPSWOejQcyJsp7feH?=
 =?us-ascii?Q?CzOY6G9xEJaeQnT02+YyMUFXRs8WUUOKU6w7nZKCgnH64byf6xFq8VWAn7lT?=
 =?us-ascii?Q?UsblXIdO8KLRwyi1lrDCs0ReJuowOF/meCr6mUvgc/uy+JwRDJZWOouh8rWc?=
 =?us-ascii?Q?o8F5Zowt8cCA4AsM6/oXnFUgBxlAcOyKhzDiQbQDtE2Ycui1rZ8NSRn4J/LK?=
 =?us-ascii?Q?jHzbifDlypzxNMpGooB+mup4KU+RuoTNq5l7O4c3+VH7/ss/DkHAm5ruChKb?=
 =?us-ascii?Q?WwdUP+dOBp+nCnz5qBNOiZha112UA6r7ULghnXVYhFKLQy8iWl71WORJY27f?=
 =?us-ascii?Q?+bs6/1ogNVKnx/dwT6Dv2c/KTKMszO70ohbd9tB5g04+sz3+0GdPW33A61bA?=
 =?us-ascii?Q?MHkGsSHt1EbykNtC+zLrCaqN8DMJGvDumtARMXhkPjaXsv39G0tN7Y7qPy6N?=
 =?us-ascii?Q?XA+2obYzKQDY6iUoSZGnGh50eYDs0PFdqX3LDuJYHcHcA/xsxF2Doz8yiLF9?=
 =?us-ascii?Q?UBgi6Up/0zm61+HdBwTvS3+oQVycbBgdr+lpiLK7z1/MYOznM48DqAcx7b5w?=
 =?us-ascii?Q?kFYuVhG2Q5svwLbtH153UBm2IkxLKwMoaudAmjFyr7cJJlj6djISRK9K+97K?=
 =?us-ascii?Q?qpud8w43vnMGFwCOxDxJydDgHbS8IBWbfQpK8HcNRH4uawJeILiD+nlr1SAy?=
 =?us-ascii?Q?L9kTWFz98UHYxQBz681R9bG9NxjTY8UE4U7rKFmfeJtXk2SYqbQoIyjr8Yl/?=
 =?us-ascii?Q?xcz6T5lkmTyNVClOSeVVb97uJRDTNqOcR+yvp+byvWX60kWXs36gVxuzPzE0?=
 =?us-ascii?Q?nQFrRErOf3pBuE7SAFrIzfkWeX2us69n+Kdtl0UnILv4B9MFZK+1HLB/96P9?=
 =?us-ascii?Q?bJiC5DfgGAgStW4xjIx6vojODX5lUtgdfUJ+1B+31z6EwCd/XJt+DNaTOyX6?=
 =?us-ascii?Q?FVR+X4HbK1AIAUk0YohfE28dqYFuIA+6WObxvMtt8TVsxPjmD1Z0cEll+TiV?=
 =?us-ascii?Q?x2NAGzz+vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85584f58-6992-4629-81e6-08de8133d456
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 19:07:54.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qMftm8eC1IPWyKGVFISInrxxMIcQoaPEmrUwa+cR7KQua86GYHvk2wI/lq/REYi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912

On Fri, Mar 13, 2026 at 11:53:11AM -0700, Dan Williams wrote:

> Jason's framing of an enum rather than a boolean for "trust" seems
> workable to me and melds "authorization" and "CC acceptance" into one
> concept.

I think you can also fold the auto-probe into this as well.

The kernel would have some default policy for what enum value to set
upon discovery and instead of 'disable auto probe' you'd arrange to
set trust level 0 which would block driver binding and probing
inherently.

Policy in userspace then has to increase the trust level which could
trigger an auto-bind.

> > > Instead, give userspace all the tools it needs to deploy policy about
> > > when to operate a device. When it does decide to operate the device give
> > > it the mechanism to add confidentiality, integrity and performance to
> > > that operation.
> > 
> > Yes, this is a policy decision, and if you are only saying this is about
> > "which IOMMU should we select", then that's a dma layer configuration
> > option.  Let's not call that "acceptance" please.
> 
> Done.

AFAICT "which IOMMU should we select" should entirely be driven by the
TDISP state being in RUN

Jason
