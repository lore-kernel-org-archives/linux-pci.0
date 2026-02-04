Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785112773F0;
	Wed,  4 Feb 2026 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211244; cv=fail; b=kL7psni3v1w7alVzBc+EqHg+f4ccZGwjL2n44eGfr81Hd9F5xnml4pBFDRqs9bRR8KmK+al2vx3w/tJP0gC6YwxgfOb5ZK65Jtl/Gxk5/9jDI+yx4LbT+VQ+F+4xBwIn//rOeqsGaFflsfjCuMLSrR7yMDDrmATJWm+rySI45zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211244; c=relaxed/simple;
	bh=XnjCTi3JpfAc/m9pxkszcZr/uylO+1gQiwb27iGaxn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSDGFPvIPqIuUXjUjgseFvYT8Gind+rMU7IgNiarglsrQRJjjS8J5NE/JAqM8+kf5xnv/dmPu3Wxbmi9L8RWd2tUJFKZkzpm3r8Y3aXCjDpLuSnsP/U1qbcowabEYEEYITOnLmJNt3sxhPIuTljWbFk8yBV/qbC0peGxwDexilo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FrCgvFaB; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FrCgvFaB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXAclwh2Cml4Z/th43shG4D11O1IPD8HS5I2Oii+tXP6pvlbDK8AML9eancvfKijFVSvnwiHZQYSD8mqm50Lx0NNvZisccYIJkkX5G5lN+AitXfeLwTQa2J8Sw+Dyb+79F0I2GYqi9nBVNYgOHw+DlWzoMzWN2x2DcMre6qeHpfxGZ0mhLJ7KJc89OiOf7/3rCeTQYntiyctgtzGaC1sKI3IqEDvmxsqHLqo3i8SuOThHocA3SMAfDOTCrI2JjKXPwWKciOkBwo5VqR6jnaQvhVQbgpYtq6CKmQvIwCJJprbVAIsnpmvYvjO2bIsWBMpj0aJ4cOxC17FxR50nvLnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBoNm0G5dE61sa1attSq4k6MykQBQSe6yo1GcDwbHsY=;
 b=c9M7WkXjXOmhUp0e3pz5JqtU6K+TJaa2PGdUknvWKpXIs9gFscgCDWftuvvIPBswbNQ6fQI0Uh/vocmB9iralG/w4UpODpcFhZIpBsQheT66Uxo7WvF5EbE5pByPrsTzDqrqIYrK2tH7tMZv4r2xHnk+VLzZCJhM9qfm8o6a6aW7dtxxsTgSqBd+aeKmBScQdRw2gPS2c90xL+x6TvlN6kRcoNRwsngN7//Nnbyf/L8Ep4QmBbGeayfCXmbwewb47dYWrs7rzpbGDCm6okDbUYBw1jiWzhfZBQThyE9vGhUkQGfal1S71oy7eCk17DWgJZoRiqbqcDf5GDpj88Wkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBoNm0G5dE61sa1attSq4k6MykQBQSe6yo1GcDwbHsY=;
 b=FrCgvFaBujqa6TugJjRBNNCmwgyB4LXyDLLtatsSzxxry5rtR4SbepjZ9JSBS2R+gDyFN79J+y4XGIxqB1zqNp3i2cV7E2WycZLqJsKhUv0BWagKPkDnYhgiMBJ1Hl+hWmAgpTlrOCzE/4MA+yh33/ZmxBFai64gIUNqWZ9obvofVe1oNCrvb4zw/aDijARPfR9twCky6J2Do/rAs4kyMl0gbrJZu/aXgWDPMs2v/Tss/6oUfKlsYSQz9nH2s0O8V7vrUll1j/01WfwvMydQddpXuzTpU7cosfkHaMs4oUUbGwhF3trHHybXz9GQp3XsYRdWSCwDnVATgwTLdctO+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 13:20:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 13:20:39 +0000
Date: Wed, 4 Feb 2026 09:20:31 -0400
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
Message-ID: <20260204132031.GF3931454@nvidia.com>
References: <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <0472f0f6-2f13-459e-857d-d5003f2f0ac4@arm.com>
 <20260203231607.GE3931454@nvidia.com>
 <69b9a009-55bb-4330-b64a-99b20bd9abef@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b9a009-55bb-4330-b64a-99b20bd9abef@arm.com>
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: a2967390-9809-40d9-ee60-08de63f030e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyvNOvp9NUanJZARESEB6uzebY4EjNUjvk5bPN9qWE/xqqTVQC2bTyqtXA/m?=
 =?us-ascii?Q?mctbvbp2YqTk6sk4tYwK1+qRheHZavTC4tjZ88kamGAAVNRl6SRElN3XO9eU?=
 =?us-ascii?Q?0lnE98LKMYnZ7sbQEIlEmdNNHc4RIZ5EfeuS/HooSpwRoY7pdgTXyIqYo1c9?=
 =?us-ascii?Q?XWvYyq981TLqiMi+12+fmruejRhga1fB9wFXT5L0YGbhzTFdPxN/gxkLRveb?=
 =?us-ascii?Q?FqNN79ICY1HfyrYXfrACa7wk1YoEgbkjBZZoZKSpJa4eUH6vlPmStvuMW0Ot?=
 =?us-ascii?Q?31XbmoOjZpXbJteTm5Ag6vr1yENd8aC17UGAAkm18Y4LAgGFi3ZTMTenDmNN?=
 =?us-ascii?Q?VhiJYiK9FPiSxOo0jmZZQAVVm6A6Qs0UtC6t8Uj5NVWLauyQc6ueF5D/s6KQ?=
 =?us-ascii?Q?ryJAwXXmYyiM0sD+DMUoiq8A35A93j9HIcraFpMNNB18lQFtDLyj2sqVP5F5?=
 =?us-ascii?Q?foXo7k7f1yTqmIsNVXckjvU/U1ohUsdwjA23xXUCOSLKNBA/kFREZVpEtewK?=
 =?us-ascii?Q?wJeYVZDx+O7/HlNNKgsz9dwztQoBguvvwaPD5KGgN34yKhggGR2qiUjSv/oP?=
 =?us-ascii?Q?WAVPIhi+0JfoNr9pkgdOb41QyXx8Kpsqfj6QhFGgdWk4XswgQ3/tq0MR9Q47?=
 =?us-ascii?Q?Jswk0ye19GL1JrEUZgqQ9i/yV6X0BMdq7tIgPec1W5Rtz5st4VZ5sO8nQOUa?=
 =?us-ascii?Q?YXYuI/CXFxatGB71vig6rCKnJVTDVP6TQqTUfTKHLzVydNWqeaXj/o3gD62E?=
 =?us-ascii?Q?CPNUZzRMg6D8XFB41a5V8MkCQaD63AL1U3hKxoUZB0BxKNFbipcM6WZF+zx3?=
 =?us-ascii?Q?2xMgk8Hq1feDU4GNaAA+75w1muY733NQ61wx2+j08WGv84VDH6C+c11wNJDy?=
 =?us-ascii?Q?2MW4BHt/dTVWvZLCMNJGiQXitgtz5nQI5538wl6ubp1A/C5vTZO6ITKNPJrq?=
 =?us-ascii?Q?m5djESw/TEJgv2I+r1PkywSj96KbHSt+38/SYK2VlfpdaWWLOChcwqxJe9Ml?=
 =?us-ascii?Q?1f9NW5C9lHyU/c7ID0ij7lyAyYF6RdevLozmpYBJ3F8Mo0LdX3126VbAERZD?=
 =?us-ascii?Q?jxgdiT3IdtFopWGku+PFo06dCWZ7WVg4YHtA/1ifOJjBMLJgrqE4qnka3uWW?=
 =?us-ascii?Q?U1bVy9NXkP6RmYgR+oDwmBxPEqW0k7jXlA4tp8xfb9J8nO9Qi/sD+bgXs506?=
 =?us-ascii?Q?y+db5EoF+UIHO7NlRKhEBLraOWPmL0i8Rby/niXgQyKlG/eeP98nCbioHl+Z?=
 =?us-ascii?Q?pevBUy39YRB0P2S7Liq5hT0QJ25+B+UZ4zjE1MtNdMWC5SJ3yQFZfTZIkuTo?=
 =?us-ascii?Q?ec9jSOZ5O/NrEnBfeFZ1BZh5yyKH1A8R14oUidwU6neEirSrZIMncyzw428+?=
 =?us-ascii?Q?Dd74YqrpG4ke4h6ZBJmKIZgoWbFDhSHMafwti53tqzgrYCRgiFOdCAdNdMjO?=
 =?us-ascii?Q?S+mbF9hk0Vbtcm5T/Er1jrC81EGojSM/5s+/b57o4ZssicdtxUI/TH8dngdE?=
 =?us-ascii?Q?vGXY9mAkNFpDVG1VIIw15qVwtHDeO9LmQTgg9w3MnCq7kX5jiGSLmjdDQftv?=
 =?us-ascii?Q?KuLPRkPRGU19B3RvO4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lfks73VkRyzYL3lctGQxXi+bpEfxlJ4fg8A1uLxXmmpwQ6ooso3ezVfIEAZJ?=
 =?us-ascii?Q?oZT2TC9vc1Z/wZeK2ySXIVIm0cDrU60sxf26RsjHhGdI1OLtie8N88jC47ba?=
 =?us-ascii?Q?Z1uWBdLsKVLHeQ7TyeawobrfSsE4+ITcG+pMy9Q5Q2i86bykrKaWWa6Abgm8?=
 =?us-ascii?Q?fOVTJR8rpO0N8quU8GAUFlzx5NKXQu/zc1fYKsuiOOFbe+v2CBwCWvJ2PHnu?=
 =?us-ascii?Q?GSypLwD5lNC98Nuqm/sWRDCl+z5W1i42OvbNoU4uUadaSuA2BCnJBwsfva7P?=
 =?us-ascii?Q?QcH2VthEhJXVljRM+1PGQeXv6BB67DPW52AS4sltf1dZeChBhc73hHSmAgnZ?=
 =?us-ascii?Q?QItndrSG41EWlt5s4ZGDv41NXpiCZ6N+Rc82zgx2pZ3jc2ozKRLOxIA0Nloq?=
 =?us-ascii?Q?fj4DRijneF/1Gw5Au2wWHCil7hVfHvYtPMssvQGNDsupiAjJGfZ1VIIxo9y0?=
 =?us-ascii?Q?tIfBSbsSzCA0/kf9UabErlAhnLfrynH3ho+46mPwDSplkUuDQHtNmpktuSRS?=
 =?us-ascii?Q?TY6Zbj+trSzrPX4o8aQC0ua5/SXuBDfULMuG9ObpkxCIFUVIYlVSVzD58hOM?=
 =?us-ascii?Q?IFiJWz9hgwUkWXyrsOGnXwVYU/tRFqE3hUJ5bCuxiYukPnPrA0KKRYqFPbek?=
 =?us-ascii?Q?wKqUok40bjFnCV5eap0vRXx+44gUt7+njSsOiMV5fKFxNED/jw+lJ7AJ+t+9?=
 =?us-ascii?Q?CwUSb4oe6W8MiLlEuEWD8m89nxJo1IU8ISJt/bhlz7mP0z8wLGySUZ9/VNAN?=
 =?us-ascii?Q?8Owni/ViytDJeptqh9HjnbL8HPGbcbZoGJyZkHyBvLYLgrYSK/kZdcujQPiY?=
 =?us-ascii?Q?zRLCOcKuzqGyp+IsFc+SM8APBBgH5Yiabe6riKi5f4SrROgzr/5BazmmQ+WL?=
 =?us-ascii?Q?X3DjzIIJEGz8B8CxsA9mJg3RMTTVkIEAGqkIQK4D4gE8u8Z427Tovq007OfO?=
 =?us-ascii?Q?PW8+eSUyKZ4zMuzhQTSlc1XKgvHCNh56UZANg1ofcA7VM30LNJWbo4FQpmCl?=
 =?us-ascii?Q?f1LKdgIxwO1dLSHDdBsxqN5oGoB1kAY2iozOPwi1u23FGJCduPZo6e1kmXqy?=
 =?us-ascii?Q?pXx+nBY4rr0D4Zb57ghSJLtwpMwQzfHj+4Vcpypkr0u303+A6jF9imzMTz00?=
 =?us-ascii?Q?QwZELJqTa7L7Q2nP/aW3Tz+xIhhwKeTXp9kberqpMScfIItQDycRBgsDvPDP?=
 =?us-ascii?Q?uoap8fAQ4PiRqPtZDqxGMgGeBnbRwSONJr3l2JwTeSyBjbWCjWBnSLpvaFYS?=
 =?us-ascii?Q?w8lvA0iKM/WpkrBhtU5lKyCZi4rxS+TGZ1+uGazcc8ptiWmh7/jyNMAiWFFR?=
 =?us-ascii?Q?fxgur3YezMf34Be0q6AcOKa0hXH7FTkKysAJAUkBUKubl/YFDFVM3fnneCwj?=
 =?us-ascii?Q?M7e28uX754CiRW218RiRcWyGyBu4D2bOAUe63p5+0cT/ly1+HnqxgF+RjrVl?=
 =?us-ascii?Q?PTOxkCAyz2wWvaiUf1b7YuRwD9GfvRVKyx8tpxkZG5sP5JxqYdsbcTowEFoD?=
 =?us-ascii?Q?Y3wi1ZHz61ndRUgfyxujpny+B4K31o5veKlzbGShIfkbe9v9fFhb9wZpldx5?=
 =?us-ascii?Q?YXVBYCn5Xba+1+simG1VLIxSx4lPBHTB9RXmLF4f9geP6x1J6VgqBSHWghcm?=
 =?us-ascii?Q?i79pCD98YAHaDFKVWeQmPx5cKrmffruNl+Di8ZI1UocTSyIcwdgEcK/xV9fu?=
 =?us-ascii?Q?GBB7mXpDt24QqHapZ1rT3qcSEBn8RneFMpkXS9BgolTzwFt2hh+C6K/E4hI7?=
 =?us-ascii?Q?VGTGPE90DQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2967390-9809-40d9-ee60-08de63f030e4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:20:39.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orBXoy6ccheTnarV3304upI4uC8saQm6UPOaCX6fFiJWdLR6iLACXzFCN6jy6Blu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113

On Wed, Feb 04, 2026 at 12:18:15PM +0000, Robin Murphy wrote:
> > I strongly suspect the answer is that RMR has to be ignored in this
> > more secure mode.
> 
> Yes, I think the only valid case for having an RMR and expecting it to work
> in combination with these other things is if the device has some firmware or
> preloaded configuration in memory which it will still need to access at that
> address once an OS driver starts using it, but does not need to access
> *during* the boot-time handover. 

Splash screens are the most obvious case here where the framebuffer
may be in DMA'able memory and must go through the iommu..

At least we are already shipping products where the GPU has DRAM based
framebuffer, the GPU requires ATS for alot of functions, but the
framebuffer scan out does not use ATS.

Sigh. So that will be exciting to make work at some point.

> Thus it seems fair to still honour the
> reserved regions upon attaching to a default domain, but not worry too much
> about being in a transient blocking state in the interim if it's unavoidable
> for other reasons (at worst maybe just log a warning that we're
> doing so).

The interest in the blocking state was to disable ATS.

Maybe another approach would be to have a "RMR blocking" domain which is a
paging domain that tells the driver explicitly not to enable ATS for
it.

Then we could validate the RMR range is OK and install this special
domain and still have security against translated TLPs..

> > > However I think there would be no point exposing the ATS details to
> > > the VM to begin with. It's the host's decision to trust the device
> > > to play in the translated PA space and system cache coherency
> > > protocol, and no guest would be allowed to mess with those aspects
> > > either way, so there seems no obvious good reason for them to know
> > > at all.
> > 
> > If the vSMMU is presented then the guest must be aware of the ATS
> > because only the guest can generate the ATC invalidations for changes
> > in the S1.
> 
> Only if you assume DVM or some other mechanism for the guest to issue S1
> invalidations directly to the hardware - with an emulated CMDQ we can do
> whatever we like.

With alot of work yes, but that is not the model that is implemented
today.

If the hypervisor has to generate a ATC invalidation from an IOTLB
invalidation then it also needs a map of ASID to RID&PASID, which it
can only build by inspecting all the CD tables. The VMMs in nesting
mode don't read the CD tables at all today, so they don't implement
this option.

> And in fact, I think we actually *have* to if the host has enabled ATS
> itself, since we cannot assume that a guest is going to choose to use it,
> thus we cannot rely on the guest issuing ATCIs in order to get the correct
> behaviour it expects unless and until we've seen it set EATS appropriately
> in all the corresponding vSTEs. 

Due to the above we've done the reverse, the host does not get to
unilaterally decide ATS policy, it follows the guest's vEATS setting
so that we never have a situation where the hypervisor has to generate
ATC invalidations.

The kernel offers the VMM the freedom to do it either way, but today
all the VMMs I'm aware of choose the above path.

Jason
