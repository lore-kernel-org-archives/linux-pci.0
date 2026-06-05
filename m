Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C93CFF69;
	Fri,  5 Jun 2026 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780700605; cv=fail; b=n4Gt901/o8yWxJQPAfDykFPh2iisprNqvUv2HbLodaRPUJ45R9Hi6daZFiGwMRTfH7MXl0SwdH7CnQiPSI8nTMuKsS7uDMbwZDe9obPLVRq/YGSrUDUMcJSEy+PBy5g0UorOl3k8TJaROSGzlkORrXcVVSWVnlJr71AVCR3A+mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780700605; c=relaxed/simple;
	bh=uaomvVnKPACTsnbewZlbIOwmISUhXwKVgGuKCSNCl9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y23E8kRpjrV0wNIprfJGtmzuErk/ncSiAbRGfqdVK96VGlcWEJJKm8VF2/suy6ZbQG3xRL7FwjkfsXbY8Kq6vv4O35f49csKRdWAA9F3dmdEq5XpxENgwmbC62c+JkBgJuX9uQljpqkd+dJH71TahlmPbOmywytP2a5GAXca4FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I79br5XY; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I79br5XY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfPPtl9Dn7Msk/heGEyB6giz+VhMxAQxDTsdXAI6RMq87zsECsGmHbGywcY2IZbl8EUZrViiuwQI97iTcvsO1Dww/8bbLxRYYwxMlhJF5u5fa2kuC1AoAvzU1zgJAnhc2GJf7x4FVSZM2FocmWrNUzy50Tc56OTWOQlpgUhflYU5t5IphiMVNWcvL0Go+8UFJgmrKrXCsgS86XtJdPb8XFf2fH1IWpyb265FyNNurPJ3dmTYd35u7QcYS0nXNl8CJAxD5EXvL16fkFho0Is6X+1p8enQMEcF3N3dumPaODvPxaj88BgteTwFvw7i+ipxgEaYyUwgG0BIqf+3pJdKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJXBtCaiiZlydeySBJ0Sh8PMzpq2y3Y8HSAq3152oo4=;
 b=D/fuSI5NPkfTktIaOpogomqYIUBxkG0HxxplpwjURyYGa0dHZZ12N3+0NEwr8MC0TghSzZ5In5w+IBhf/g1XnZAa9+WgMu1eiaT8Y2jqUrJScRJ0NJFF6czWreiZv1o8PBBjMy140/jRIz2TYEZFiCQqNcrkbYZBsOttKFOO9+5n1pBSz09R3yJ83aiAWQ2v/66eI02sDWs8hKcpkL1H1wWzic0iWoE0d7XFPdL7zpiCmErwDbV6xyplqsXXRTQflSfVzjeRxwzfNhx8bL6l1grLrzTA3wAYfp1ytn11aaqCexVBaFnCctBOHWqNmnc0tCgqPGkUIP6COHXAkvH8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJXBtCaiiZlydeySBJ0Sh8PMzpq2y3Y8HSAq3152oo4=;
 b=I79br5XYuPK5e4KOJzzVoA+OCFT3cAbRCBi2XjSCJ6KN6r6ska2TLPJn1JSB8qcC8ttXhegRSSWat3WXdn4BqdnXWCodMP7VwyCsrLi2gxelmCA/myDBbD1VD4CTzIjnSG0ReyYYnqPOL4aprejumx64VnTjkjESEc47w4T8pmggdOGZ7/xPM+AxshDg+ipT02C4tAQTTfZx+lqFW7X0tFELB7lwvbYOwq4rr1NWBo77V7ub4JbEP1fL+9C598RoUgPLYjt4ogLf/WmGw8Vi3kNQSyOeyvXviSyTFL48EmLbB7PmmF/auXnxvTgX6u26gKRcU52lwwi1H4FPHDHRhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 5 Jun 2026
 23:03:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 23:03:17 +0000
Date: Fri, 5 Jun 2026 20:03:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 18/24] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Message-ID: <20260605230315.GF1962447@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
 <aho9DB6it2R5O5Nm@Asurada-Nvidia>
 <20260601123231.GG3195266@nvidia.com>
 <ah3udmX5SIO9lAXR@Asurada-Nvidia>
 <20260602001547.GR3195266@nvidia.com>
 <ah5txKCvspL8zMeG@Asurada-Nvidia>
 <20260605194259.GE1962447@nvidia.com>
 <aiNF9kzjzDY/u1NG@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiNF9kzjzDY/u1NG@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d646a1-7480-4246-d124-08dec356a11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099006|4143699003|5023799004|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H6PAANQSch6H12G36TPVcgUzTqjvE7YYIHxR77c2nHP1c7ultVaHTKRJRIwLJwLIUMFMfUbVAGe6rBKbQtW3jUhA/sqgw5wHDkEJDoVfP9YT3Y06apCtlzZ1Xl27FZ1I7wQKN0uj/AzAPPZugHNL9+LORX3JZkMv1qjsTYG5dtIJRj1RfcBj+i8QKVjhPHdtjBTqTiMbe8P9q29Y7J3dvZtiaIUEMvo+4wZsW5aWND/IzpPD13GdHy+JP98KiJrNPt0c3sknBHZd7kmi/tFZOeWuLxzvqZ4VJhyB1K4mHbPtANcvAtmnrJRzD8XhoztLQp9Y5px6CroW2+u5fqfdCAAsSUf6D2XfMGCEct0J/onNc2dXxj6uA9PreGFBpVouBk7aBFnTlY00wDuBVMgq/yHj0Z3/e+U9X4CHzgwjdo3XPYk5Ap341MTazjSJ558jIHclimYAhVtUpTsrA9pjckR8HRVvuQdJEj6f0uKVEeAK5TrVr1LdumZcga0SDxTMfYQZ9u0LWBQw5Oq2T9GReNeSxZRFRoPRFyZHS+7NLu4CMqXWgC8KE6Ypzwpgw2sTLQlfzKKbfAp1YOxKGNhY7RvquTrwgFPF1jm0+Ex1LC8Hv0qluXZXo+GexuupARZyJwjc+Zekp0NYlIVxquCbtGSkMeIqG+9Q2ri3M6LxlJVN4KBU6+YYTqkNRHYUVN2C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LiVeC43xLZ9q9lFn02mDLV5Htl+oHV2bDdMu8R0f+Sn4+eTqwVkHWSV4qQkM?=
 =?us-ascii?Q?qoK22wT47OZPVeSiB6sCEvwFV/PC+qvTMnmvw2etZPohtGTKE1LmedLXhZVQ?=
 =?us-ascii?Q?DJb2UXQRGlkkivJM/6CKACIt6484DWY49PZBeDZ4sy9Rd66fAvWR1HnCOlac?=
 =?us-ascii?Q?KqqxwPm6eoWFD5fAEQXp684XZRA1HKns7BfYj/Vf9laX33CNJM+5Gdg4EWqE?=
 =?us-ascii?Q?q7YUyP0rVE9ABtCurIT0sceDYdR8+AbTLcohier3Dyu1lER53Qum5VYKBrkS?=
 =?us-ascii?Q?p4qEf4U2jS+Cxnwk/St3uw2tuFMAoOsh++8cwMspj56SSO8yUZOVG+xqROQG?=
 =?us-ascii?Q?exKZL3ObAbgTzW4ZHu3L5XAYK+EFn7Etl0X2DjTPYrljPHd/YJTKDjb7HC8x?=
 =?us-ascii?Q?Vop4AOTQWIQD/BdqvpsjGFJTNyhpej5mrQyobqWxhA+l0iGE5756xoZWGxfT?=
 =?us-ascii?Q?udtrHYBsitWFqPbuAEzBZ46pWD/Ju+hyVsJ5BVSBQ0h8i457yY5X0EO2lk/7?=
 =?us-ascii?Q?ux9sGYauPE0fy8ct93i59BZDfsFxYxJu+txz38SaNh0X0pxq2g+unynqM7Q5?=
 =?us-ascii?Q?ispVqqz6hkAh57ocTnSDBVuLkNhsGgqb1vxmzVTel/9hWoqhdhSvL3ziPsjd?=
 =?us-ascii?Q?m70kdeIhVsJAJ6AE7i4X8rupfFUNOP9dAqx+jju7W7BGQFZaBrlw6E72xEu5?=
 =?us-ascii?Q?005IRYYTmY665ClW1DTZuaAmKW2BtLlUEHdTCJGp44naa2JJ8eg4ZUANe6K2?=
 =?us-ascii?Q?TSDAp/xsT5lxvb+/6nMNL9/ArTZNcvDgw8l9WAwha9rZZxAC5z8UcGqcnRgU?=
 =?us-ascii?Q?7GkwtscGGYQHCnWKy4RpCYVB+gcTm05yuhqhWYmQh36khwb8IHApJunGdfww?=
 =?us-ascii?Q?XQNwwJpXHgTkaGL9b0OTYu3HubURa+3EzZr6YW31IzYnEYrpivAunem0Ivpy?=
 =?us-ascii?Q?iClUwXyTxebeRzS22nwH4msqYAOfCJqX7bPY+5/o3KWL4lYgSWaaDiFUWKXk?=
 =?us-ascii?Q?RMndByMbIg3uwel5cZEdQ7DL3FMOjJG2xR0fu5/+nvSPHvji3/mGlGDN5YoB?=
 =?us-ascii?Q?A8ijaHce89MDCKWNgwtevPvE71hUijOBeviQxsGJs9DoWAPMhrW40lpapaHG?=
 =?us-ascii?Q?ASHvJ5PYsVCELadjoRxcMWhj3bk0Nhb+aqVRX7Kw6gApVpYKoQEFM07aEhyX?=
 =?us-ascii?Q?ndLnZ1h2Nv5OCdGwDTS3Hli9uycazrgzvZL6DD+2zI+NVQzP1o066Fdnbdco?=
 =?us-ascii?Q?OkRSIFvwegUx5rnz8zjEJT1kfqD9Bzio3GCIpdSdecrKdTP5+v26h5cTi0rn?=
 =?us-ascii?Q?eaChEcloZiRogRYhrfPFeSEjAhBfMQjjOblKiqUYQRLYHUly77x9T60ZrU6X?=
 =?us-ascii?Q?hm11Eat/HNGzmCvG0Pn/1W+dwJaGUvt7mzcye7s4EyN/E8DglQOL2l1fTYd0?=
 =?us-ascii?Q?GWFTFT9bjVbueNnMvI2Mt2pm54vw4LZirvaWIXD+Ybhe7ERoP2PlTMVf72OM?=
 =?us-ascii?Q?YITHNG8A3JYAUvsWe8ica0GROqQktOyBfksmXkP8v2Rse9swbCKSmWyanN1H?=
 =?us-ascii?Q?EWg36j6gcrjD3bcQd5jXmH/7UB2GYL5KYqBNg3VIcdtWHZLCkBtB7QklcyqD?=
 =?us-ascii?Q?unGxH7p/VmORzPkx0NceGRFT5WSbRpR2ndA/GUjUjUpfgNGLrLO0Z+OmYYwR?=
 =?us-ascii?Q?+XbTv4+W8rY0Hu+sHH0Pv+ghmpegVQt9Oj/q91zB3qXuVvyX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d646a1-7480-4246-d124-08dec356a11a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 23:03:17.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP0T6J6QuBrrIhla0lUrxHYv52E3mAZX8bkeP9OBPOWNeeI8qIcpQ3HXFOQOtviZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

On Fri, Jun 05, 2026 at 02:56:06PM -0700, Nicolin Chen wrote:
> On Fri, Jun 05, 2026 at 04:42:59PM -0300, Jason Gunthorpe wrote:
> > I don't see any of these options as appealing. We have to maintain a
> > few key invariants, and I think it cannot be done without a way to
> > find all the domains that are using the STE.
> > 
> > One way or another you have to be using the invs list rw locks to
> > synchronize the EATS state changes.
> > 
> > It is okayish to be sloppy when turning EATS off, but when turning it
> > back on we do need to cycle through every invs list and toggle its
> > lock to ensure that the invalidations are synchronized before
> > EATS=enable happens.
> 
> I think the core guarantees that "cycle through every invs list"
> happens: a PCI reset calls reset_prepare() blocking all the RID
> and PASID domains and removing ATS entries from every invs list,
> and then calls reset_done() that re-attach RID/PASID domains so
> freshly new ATS entries will be installed before EATS=enable.

I think this whole thing is so async and racy this is not something we
can truely rely on. The driver is going to have to make sure it
doesn't get turned on accidentally while the CD is still populated.

> > Given you must have a way to go from STE -> master -> all invs lists
> > I'm not sure either option really makes such a large difference.
> > 
> > If so then adjusting the invs to disable the ATS is pretty simple, run
> > over the xarray and set them all off. Yes you could find the master
> > through a SID lookup with some locking adjustment.
> > > 
> > > (1) Per-invs marker: INV_TYPE_ATS_BROKEN + master_domains
> > >     disable_ats() in the timeout path walks master->master_domains
> > >     and flips matching ATS invs entries to the BROKEN type.
> > > 
> > >   + invs walker is free (one case label in the existing type switch).
> > >   + No lock or pointer deref in the invs walker.
> > >   + No master pointer stored in invs; no lifetime concern.
> > > 
> > >   - disable_ats() walks every (master, domain) and marks each invs
> > >     set; the list needs locking usable from atomic.
> > 
> > This doesn't seem so bad
> 
> Yea, the only thing is that the disable path has to deal with a
> complexity from going through a per-device domain list. Maybe it
> can reuse iommu_group->pasid_array by taking xa_lock?

Maybe the locking seems tricky as the locks might end up nesting in
weird ways.

The streams rb tree and existing master domains linked list seems
appealing if the locking can nest acceptably.

> > > (3) Per-master flag + inv->master pointer (v4)
> > >     invs entry carries a master pointer; the invs walker reads
> > >     cur->master->ats_broken directly.
> > > 
> > >   + invs walker is one READ_ONCE through a cached pointer.
> > >   + disable_ats is one WRITE_ONCE.
> > >   + atc_inv_master early-skip via one READ_ONCE.
> > >   + attach gate + post-attach re-check, same as (2).
> > > 
> > >   - invs holds a master ptr, so release_device must synchronize_rcu()
> > >     before freeing the master to drain walkers under rcu_read_lock().
> > >     We dropped this from v4 for that reason.
> > 
> > synchronize_rcu is not right because you have to have gone through the
> > rwlock so there can be no readers.
> 
> Ah, I think you are right! When release_device() is invoked, the
> device must be already in the release (blocked) domain. So there
> should be no domain->invs in the system holding its ATS entries.
> And the enable part would work as (2).
> 
> In this case, (3) seems the best? It's fast on every aspect.

I don't like it mainly because of the sketch enable side, and if we
tighten that then you can just do 1 which doesn't have a perf impact..

But still, I'm not sure how all the asyncess and races will resolve in
any of these cases.

Jason
