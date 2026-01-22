Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78727FD5B;
	Thu, 22 Jan 2026 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087725; cv=fail; b=mBh5u6sSgusYHcJR5+zGUnsuF0CxbKG+quIJRWeMvomGGKlSSYt0gtSJIPgaj8uXm7tp59U96jLB63G/Fmtxfz3/5YBp52y4f/Uz469g57BJIbkdzilM+iccrvau9itvjkiRRW3SxiFU8+1uqzIh+ErlAiA0C2hgyOxqLuQ1hn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087725; c=relaxed/simple;
	bh=lXR2Qse3BuGfxbhoamN3G9Pp9GS3rT8Z/jNKB01Atxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XV60ACrocaGUtVK/93O7vMyD2nznclitBlnmCbBLQffUdtwyxfRJWvGpqyzwYjqvB1StX94AL+HFz6ogvlWwZgJwFCIKQRX7gNazlZjSEElg/oMBZMB3rS/pfmZP9ZfrJue5vWrQIWC1HuV6FwZGUXcoFHhrFVU+HJrw+W3bdB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kjGqEFJ/; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kjGqEFJ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDaN8m9aVjVQIwxOa+KiwDX9f77prhjcCK6E4gZzwpQbBi1t+wYxbjkIx5oWFbSdatrf1Rk6OFkP3/ZNQ+DHhndHD2YJyzMZwMDNVm4Mvs4JVAC0CahDn0xORDnZWewr8oKldi+SEfQcDJ3RgGeKbAl6LIGgV9LBECzH7hdSG8Hg5qDkOpnqgH0eSddKtr7hVDmkhFAAPGf+pZKixoTi/OmdxZtQJmf9BVxJQIIdlNbOL5tjDkehqvH40I9mL/5AO9I+YdAevcjwxxzfYk2LueWD4+WYDiqwTJFLYaMJRMB4nnaTaBXMo6sfiHQdAU/vn+QTyWB08hnSr08EpGvJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/vRGL//8GR92XWYhPnuG4DJzKHcQ/4KivMC2IqL6/k=;
 b=PcFHqPY4Rs2GJA5pAgu46P8NacDBtO0CpsS0O6dQ2yl0mXZCSGHSNss55vw4zuWRB60Z3rvIcRGAgmzqUQbDwV976jN6gj+Pi9/iyVJvy2BLztESJsMmT2FRMwtEy0nJzjl1LDNTPkmlRN5WwREtwvmCW8UAtYHT+8AY6MGVDfRqH7UMMpoOyYmVSedBInoyMMQjQBszRyB1DO4Ffk1kGC/VT8Ggrbpngch1RqgivuGa+XfamwVCHhsHwu4U9WToSjL7p2yO6tyE9TKJCrdhn/8XwV0jSMWgojKYvg4M+Gby5LUeX1vXLBP7Zeeq9/iQTsxpGRWd0KnSZzv/A+Sfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/vRGL//8GR92XWYhPnuG4DJzKHcQ/4KivMC2IqL6/k=;
 b=kjGqEFJ/8m0J7FeWZiet9F3P95LligNR/oio7Bf0jyXAkCUKq9hqSPVT3RZ1BXtWrHAzSMcyREAO7vt0l7Sq0CuYUQeZd/IFXbuhFHhGv3AiTPz5IMKh6t/nBVJ/9H+jI0LyE0JHniFz3tmZ6tj6pikTi3EunaJbLhJaMX3HQm06hLG1PcVZXCrdgXq0iugSkJGWB5QRlQEVrVgKkT0699EugtjkoXrC3pv6r0FytDFm1sAX2N2RSr5Zjn7z4FOlPxDnZZN96xPm9DmErVb+hsQe3Wwp8pAYppCo+5z77sT6R8lYzDt1jJxNpyZ2tMjqWcnRtCix+SyeVTJVkRC2SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 13:15:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 13:15:20 +0000
Date: Thu, 22 Jan 2026 09:15:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260122131519.GK1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <fa3e55e1-3cf4-4b73-8b5e-192a19a18f3b@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3e55e1-3cf4-4b73-8b5e-192a19a18f3b@linux.intel.com>
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2f2008-708b-4cad-7722-08de59b84b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4F8WlaOA6VwJCNL5lB59+ldhWCxyojee88FkNzO3y1I9JdTzz2zzqhEHwlsI?=
 =?us-ascii?Q?zOGaPhH6UrhIKWNnQaCtrOu+6h3o9hFh08IpM4LbbW7lFWWFQa3PHs8WjVYj?=
 =?us-ascii?Q?Yy9lXAiwliDevW26wqn4kSyjhuXAmPIyaVbwNUmkSSmIE8nkXfULmGtX2F4G?=
 =?us-ascii?Q?xo/WFtiVOm1J2g0ByVjEZv/q+b9XTVhUd5/9Mz0Yyk99hEthLU3n9/S51yRK?=
 =?us-ascii?Q?yA+TSOHqre/cQhH/xIeoRvaf15KNhAiwK7Dw8E94HoDrayU0PIBQFw9MW5dT?=
 =?us-ascii?Q?4nqQLABNeQbguE05e98OdnKhiWNzK9M3pLCjPtDQQx+HuVvN192MRFu2YMoU?=
 =?us-ascii?Q?dU8xcaVEIQUj0fHdgRpkw/cc/blb/4Bp+joYzXvB0SiCRb6cXzXUZ5jJ37fk?=
 =?us-ascii?Q?g8LHxzIzvFCgkGjFGtf1ykYBRHXGrK8EQGvD6ycNHzlZJfW1rLDLyPbldPqt?=
 =?us-ascii?Q?wc40DjgYklZiw3LQ+Z1GBzCgIdicxPB4XWJoFx+4T/pokAHMnE8qZx0rq2a9?=
 =?us-ascii?Q?zAKs22QBzdLuNXmtOypuLYd1v1Rp2NT6plud078wmrUYswI4wedm3tMijzq6?=
 =?us-ascii?Q?Jpz261NzjHrwWj9NZHDQS0dAN9qxnmporc7H//Ey9DjwMD1YX92syq7fA+GG?=
 =?us-ascii?Q?c7WoauHiCzwIvYfrgmyv4YzdIhm0+HEfo/T49s14ovDgUDxQJor7qvm3Zfc/?=
 =?us-ascii?Q?UA/jJ6Dir/zuyYRQJt1bRyK4SUjAIo4AR26hd/dtPlLmVKa135TJl1xqSM5/?=
 =?us-ascii?Q?L7BPuADYqCKmc8fHYuNKTwDV/AQfXib6QSsiTZDiDmncYZSc++j0ABa8ttpl?=
 =?us-ascii?Q?g2MU57Pla+j5Sl0Fjo2HkgwsKxsxzc9XtCUxDlnZ9B8/pcGAJ3Ts213mU+fw?=
 =?us-ascii?Q?oRw9JSVLi03xmzTz3I15CByZ8Ilm0ppNR5FHweZVbyX1EbkgUweCpQOqAA4n?=
 =?us-ascii?Q?jVx+77JxhHFLQd8Neu0prTR6SLogYY83gHgOLewQtLG9dX+fgWanqhYLFbnh?=
 =?us-ascii?Q?4EDxwnnyWaO6YBLgQFJsK6xNYfmImxpFol6vfaPgksNeKn3RJjfFv4BdqQSU?=
 =?us-ascii?Q?gtbxlWaTuWJ4VQaRTCj7RJJJT//Q2EYxKC+I2CB3Bslgj4Iy3C+t51GBlLgZ?=
 =?us-ascii?Q?0/QafXigOZCTqe/CGo3sSPxukke3t5adlmRaGvfSNVrv4GlgbAHcWOBI7HNl?=
 =?us-ascii?Q?m1ugl30pqaheka7eJxnOjjNm+GeVFqnOmh6J8/sLvykeD14L3Lp9TYfpuMPg?=
 =?us-ascii?Q?0Jq4CjZh2ck3wwWSGlx489m2XACLueL2Iz0fbUdgEgNojAlPAM4GCKLUWzai?=
 =?us-ascii?Q?D7Hpf+E3b3gE+s8bLp8px/8+O6KWfFQn6+XK7FG7GvsTS2ss9uW2zKrBmFfa?=
 =?us-ascii?Q?1/64NTXxRDh2SDeUirg2KCRT094b5gPslovNoGf9rvncBC+hBSz8+ZOZ/b1L?=
 =?us-ascii?Q?eXQHV53LFlNigoXRQlnYhkzFZA+Y75CVAqjoh3tbvA5ngi0DpXMh2/NPovKa?=
 =?us-ascii?Q?m4mHJbF3N7U0zs6J1FkPOzSiIWZCAajHSfA6QicqbAPriNMUE/GFtvexjTGM?=
 =?us-ascii?Q?w7DIxOGAVPjpvwPuNuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDXZ69YsVKWATR+MaTnqjZ3LWzeDqE+hsq9vT/uWMcCh0dfNyAbaonBOMDgj?=
 =?us-ascii?Q?a1AmRfE/6RMW6DWcOns4013OLD388bHtIHvxUomHf3T7ZXvhGqkSBP4Xodt3?=
 =?us-ascii?Q?Xpuw/6WnYK4CX9bEdNN6pPs2t1K6RLHr2WKoUyws9rstcPb+EmqJ5SbaRby4?=
 =?us-ascii?Q?y4XSiuTyLVlwT4jyiYKUptr2cc3AGInOiKXia3ngIm69X/4sBUpakLli3AkX?=
 =?us-ascii?Q?W1r12og0Hqr2DcG/RNuRxoEePy67EmPAJPm4/c0VgoBkdVy+yCsdAjSL4rUf?=
 =?us-ascii?Q?q+WqD3bye7Y5K73rgmFOujLCqFYeRqPby5hBZ9uQqPIYvRk+kZGGpyNI34Mw?=
 =?us-ascii?Q?CvSd01oplYWBH2jXK92h6sL1i5/h3Jdf54HhidT47bpqfKLG7KOaGXpnQsMD?=
 =?us-ascii?Q?xXOjz1g0Ok3riOJYvhATylKUgJlaEvbV/fXhPSqg71JuCznqEss8w83ZKcAU?=
 =?us-ascii?Q?cJ/kmLH/hnVZQ0RMsbYahS3eCdCA28awNn+ALsDBS+GBwOG7IJ29bzJCaWK0?=
 =?us-ascii?Q?HEORohhs5Kz4+W9JwozcocMiQvtZic+idBtLyPCK5eWlxhj5kNstxMx+ViuK?=
 =?us-ascii?Q?4On44fipPJiwrcux3RaDZN+yIzhhHSoKbyxJveCpl12bYlk9IQdrP3O5gwGn?=
 =?us-ascii?Q?ZWpgtrPiCqCSEsiHn4CsxQ+g9B+gpKSsSVjjncvSTlKcgqpUVzCnS2RmsKjO?=
 =?us-ascii?Q?CTrcfgkZo3SNrAGTrW8HGTnjPYakXDsUvAwUq9Xe/CwZpgEzPvL2YLAzXs+V?=
 =?us-ascii?Q?aMbu9tH8ZZxsbYi0pcfIhqkNGzG3VfKJLNRlVuiv5nxueY/hKHyaCCu+CUDX?=
 =?us-ascii?Q?vec/f7PJdHdm3m/OPef3WOKk6tbSqTDbayWODwo34F7UcBR+WBy3jcjhnlIx?=
 =?us-ascii?Q?hzbnbH/RFQszp3zO1cibB4KBOLVTVR8IyBxuzfiOElIN/VnXub7/qCoYe5eS?=
 =?us-ascii?Q?EpZ+YHNMa9996ilGa8ZIyuPtOIrTNpPgwH7WpG3+IdlrLNho/+qX2+9wGCUI?=
 =?us-ascii?Q?XvSLsbsi32FWWuKOJbyKyo2R5t/vg6IM9g0sjKhvEN4RYd6+YaCwwveiY9Dl?=
 =?us-ascii?Q?X4RVFBnkGC5aJwXollUXd02xrDgoI7MF2hXoW9hYtwJn1ORwBar6+OTY57V/?=
 =?us-ascii?Q?Xp0aoXy2DSLrxO6g3hOU1/rxjuwz7teF0pVrOSM4+CJt8HbEWj9GKauMWeqQ?=
 =?us-ascii?Q?zJth5pqUSj9+B9w8al7abWtvqPB7xqkcko34Fh18zrp4SSb1i4+ows5NXU9d?=
 =?us-ascii?Q?+zr3zNg2KRQPOpWvejXcBOtKMpEiHPvz7nuBr+zrD57NKMcftBh0sS79xj16?=
 =?us-ascii?Q?qMy5/DKO0VJCeWZmEW6iWUyxXGzg8p0OdUegPokmKp4n8BLsEUOGyTL0op1k?=
 =?us-ascii?Q?VCD8p1Ij/Zo0HiUF71Hkk3RG6C4pCLSYczkjb+eboxbW5DXbEn264XU8/1Qh?=
 =?us-ascii?Q?Nsgyd1P1kk5O6cgecxD+7Ybn7je6vxk8Ts0V2GO1iHneE2atdNki3MEclB3Q?=
 =?us-ascii?Q?jaQANGOu8Mh5ZiEbwPg9ADB8RaWHPaV+EHWHDP1jOKuFCQzK6d2QGHW1SGQU?=
 =?us-ascii?Q?ntSa9E984/UchIyavtvE9sk67nDdUy5iN9RcgAalO5wn1h9qknqyeatmBzpn?=
 =?us-ascii?Q?v52R+9h1TsY5cosbkY+nC7j4BsiXj2Izex8xXjgKOIC9RgQofzwTjS2VviO/?=
 =?us-ascii?Q?zSbvK1NEE/UTcwp+6DSUc3vEalF5fIxcAsa4qug/6RinujS9F858YdhoB7Tu?=
 =?us-ascii?Q?DnxwpuIU7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2f2008-708b-4cad-7722-08de59b84b21
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:15:20.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyqemZ606Fv7o7HhRLI++3Zho4irAT9dJny+K5vP6efrq/rWqp3Yjt0EanfiZnxQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

On Thu, Jan 22, 2026 at 09:17:27AM +0800, Baolu Lu wrote:
> On 1/21/26 21:03, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
> > > On Wed, 21 Jan 2026 08:01:36 +0000
> > > "Tian, Kevin"<kevin.tian@intel.com> wrote:
> > > 
> > > > +Dan. I recalled an offline discussion in which he raised concern on
> > > > having the kernel blindly enable ATS for cxl.cache device instead of
> > > > creating a knob for admin to configure from userspace (in case
> > > > security is viewed more important than functionality, upon allowing
> > > > DMA to read data out of CPU caches)...
> > > > 
> > > +CC Linux-cxl
> > A cxl.cache device supporting ATS will automatically enable ATS today
> > if the kernel option to enable translation is set.
> > 
> > Even if the device is marked untrusted by the PCI layer (eg an
> > external port).
> 
> I don't follow here. The untrusted check is now in pci_ats_supported():
> 
> /**
>  * pci_ats_supported - check if the device can use ATS
>  * @dev: the PCI device
>  *
>  * Returns true if the device supports ATS and is allowed to use it, false
>  * otherwise.
>  */
> bool pci_ats_supported(struct pci_dev *dev)
> {
>         if (!dev->ats_cap)
>                 return false;
> 
>         return (dev->untrusted == 0);
> }
> EXPORT_SYMBOL_GPL(pci_ats_supported);
> 
> The iommu drivers (intel/amd/arm-smmuv3) all call pci_ats_supported()
> before enabling ATS on a device. Anything I missed?

No, not at all, I forgot about this!

Jason
