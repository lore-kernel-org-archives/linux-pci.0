Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093E48B37E;
	Mon, 12 Oct 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810323; cv=fail; b=t0uyjSjX+DFP5ptxwh/DUGE8nG3slUHHkEPxiZywm418eNRiz1+Y1N5mwLXbiaqAVKUGRHE2w7A1GWThASabaqjROSTyMxcf6T0lEZZpv+1B2VLYoWlVBPERe0LrH6SuloS0D6IhAdpzt+BTHnJa2NzOqOIktQ2Q8Pv8uLD2+rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810323; c=relaxed/simple;
	bh=cszf6frc71hiatPs7fKFGyjHoP99qbldPu+1gIyQ3FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axyC6L7y1uVH3SlbwpiPBquPS39XZrYS+Fb1QMyP95ejM4EfUQkz2Znmp04TsJ4Mc1EjYXAqSetCjcLKaF6CjuPB8eft9qlCfS5iDIKZO90kcq94fFCgOiU925PXrLd773Loo2cfU/xwnT82dbtwvknPDx7cDiSCj+RWV8qjEnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7LKHQUx; arc=fail smtp.client-ip=40.107.208.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7LKHQUx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZXdbEPYXQ8lsCbapJdSKTaLUGjKBaT4eGEgMIJmiqiBsdc7elU0TO4AqhkLJLhlAZC9qxtsdOo3+Um7uG5lETGjH2oqvFHpTnflKW0W9wU7lJLwmMMQc0rJgaughuALIZOw0SzMYeAoCn09mPR0Lkn6BYiiPFgUDKt9/4ezE35mapXAhov0B7xTIhmse9QdcIxd7ex9Qe476Ww1qYcEVAz/VIKdtfk9a6JON2dF2IwauR1UBzif0KyEi9XaY+81Bj8mB/5TZUYNYiZXXp6MhM4vvqkhcQ/nriSzHAyQsy33v6L2wzyEA1GjDTZGgSEwLckeCkO0OfR1p/FppXMASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jazRilVlMt1bs7tP+uSEcdvmYm6cZTHS3MHNGYKKo1Q=;
 b=yebwHSdriJoKAFvEx2mJ/ZjqQ63+7BRZ8otbaOCctyDDMA128TJWpKfYqyKf9N3PRbVy0/U+Ldo9WADdbHbQYK74hdPhCBP8JekVtDXHUDJH29mrf1ecLQCspZ0KTtvsgcoSLc8iOhy3Clpp36si9fSPQ4StsyNjTa6sCbC44X2uWf7+7LhJUS4ralJAZ1GyrZYznfvgUXebGcr9VBRIEUFetk8T9Y0jh+ptzZY8GDy/VxaP+VzZTpqZRuAlRSqOv1VNvoGESPMIpywIe45FIAVrS9M0lfFV0+LYzrfTgcEM8Sqp49nfTTBlOPi0miijl6rYbqDWf+4FFKU6+CWreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jazRilVlMt1bs7tP+uSEcdvmYm6cZTHS3MHNGYKKo1Q=;
 b=h7LKHQUxHD+SXbGWIlfNiYpmNNecpCP7UIpaITnFjZQKt80W98LGZdm71wcIGLySbiWttSxPpMHMaEz3pWN09j/erWCcjDiOtahptQ5twDyAaO+i5LQ9hezqu/eU5pVYNiGwbMXtbpxu3WNTtv3/EnynAhfEgMF1XU/3scv2dqGBBXKALqtyVV1klazNuJQmgeKnZs0ll/hD8o5svtTCCwc+8OgRSvqI2Gp/lDjW/ksm/trFAF1+npFsj9Y1qwJm9gHcdlDRrcshaAGhSgP/kdBQqlPY77X6vGqlbwL+8Rw7lR6iAyaF+sMmsL0pv+zYuOhcsIdp1graX7FStD3kKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB5709.namprd12.prod.outlook.com
 (2603:10b6:510:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 13:05:17 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 13:05:16 +0000
Date: Mon, 12 Oct 2026 10:05:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <20261012130516.GL13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
 <sashiko-outbox-163690@kernel.org>
 <yq5azewj45u2.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azewj45u2.fsf@kernel.org>
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: ca84407d-f036-47ce-f273-08df2861761e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|261009223027099003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ld1IYjoj92ipLuRMULO+MRyU9xFzrkANABQ2GtQF3Z5mUbnP9EOE0AgIet6bP88UtVpC3tGk1jOv79U84kNyT1gMmgk6wgnBoLBRV7zMeUFs3G2+fbRE4lQ+hApxSPxElLaLmekhivXy9kaat+83KgjAF0HJFNnV7Pi5MfS4lK+cYAzMRJrT0704haFcdRCu5gHal1L18OE3XpUeI6bnsvQj5XcvkH/B1u2EJGc+EBY9bTRwwTb3/YlwfcZh51vv9miGHmPZl8vRUf1v3L5rTi9WgS0t8gc3lcj+2lahWN98ltJ5D6GwWFUsk6e3JlfK9hL8NXQc1i14qYtbBgguFcPaLU0Ft/F+luCDzOG7DLatQrYhrLyx9gv5o96FbhcbqSCvDMfcaOevePLd5CGoWix7/hZhkzbXJW0dHam7WGr3XjTrpViiY5cxSKeI90Xhj4gRNboAaQuD7rF+Rt49+v3T+k/c+za7IScQ22/W4G5Ko2zTIFw3//l4Y7cTF6UdGFYEFmQYSb8guM8A7q/xbpQUxhp+egpM4L3lv5nlrCj6ZeVBntI8yjFM7jk+JbE3V+Bn0C0jxe29PvwHBW5qLq0c7z0cYG250+mXjfXgqQfP4yD7GuE6FxPCfWYH6OuQiFjuX0MP/5wrybXRz3p261XXmceewemIcNDGF5pshaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(261009223027099003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eol9OdgX1PFv73Vj48rWyehElRdvNl72VyXb8HiaDaxpzYibKv3x1oaF1IhT?=
 =?us-ascii?Q?oktgmf20fkbhmFQ9ukFvqle8ytcBVieEJLKG+EOcjjzgiVw8VcgVlU+E7vDf?=
 =?us-ascii?Q?xBohkBHPJ8mS21uynOGAMXReFi9Z+pJFxC6F8OIGdRagkD/0ngZiidxp/OT9?=
 =?us-ascii?Q?tRcQKgBTTeitGH+sD0R3Mxdf3ly2RWanrcF0N2X+Djb0xqQgGCp81InKmnZd?=
 =?us-ascii?Q?mvq2XEkIiYG2QPRi11r3fwKZBGgU44jXp5Tyx0DbJtHBaCRpVStQbQwBy3Y4?=
 =?us-ascii?Q?4Nlj9364krMqlGeacBdV/6e7AybF/whEo3WJiQhPacqZJFEtyYliS6/pnEGI?=
 =?us-ascii?Q?kcSfubVTUhD23+dd1VqaDxwiRJxgvkfZlDQYK0jOeTKQn6EG5ZFH/7opdS4y?=
 =?us-ascii?Q?g5ObvpGwNVRTcDRwFpfnxz6z50ohI/r05IdMvqHF0n1t1CZIMuuHo/MCXy3n?=
 =?us-ascii?Q?+uoJtkSzPmcu4WUQRvY6xI5PIQ+T+AbcetknKLAIC+D55suLKgkgNmQHmHRL?=
 =?us-ascii?Q?g34umHQnnTQk1xRFF8vF1ZhtVbyj5GpKb00w+R16dAXFm/g0roNzMxenad+m?=
 =?us-ascii?Q?72IHbomboUB26IQH218R4PzVOxULIMenCi0khYujRZDZRaOWXcI86Ou5Hr+9?=
 =?us-ascii?Q?hYC583hQ2mXVHkwefsREepxW04lDrjjkB14aMIz1DP0i6QSO7VcDiB6m9DOd?=
 =?us-ascii?Q?s2xYJKSR0Edc1jZA1xeqsRiebn2fAXkXGiHrz9QjSHM+cZGkZH5Y90/EaDW4?=
 =?us-ascii?Q?NRqLDdyxVgarieZ8aKzrB8VLYaKWbX+sI31v6c8WWZVQmol/KSCJEh9Xy6J6?=
 =?us-ascii?Q?0FIycr1UIYrAQZFM48A/Qy3BGZCEzN7OV9lSpX3Id8J+T1jPRdnOrDK/Alm/?=
 =?us-ascii?Q?reGGk0WGDIJfdY1sHmMgQB5s3OsRUxNkcH4mrDumnaz6/XFNUEdZ/PQLxMz2?=
 =?us-ascii?Q?qTP0P6XIGHMG47e6B5Q9trfvH/o69Xfs/BHhwXK2PQcU+G+SZSBfNGXLEQTm?=
 =?us-ascii?Q?uG1eEoFeF7ZeGCVO5QZxsHE2hkKOkx0jOZSxlyRweDG6RR5wU7zA6zHBUeS8?=
 =?us-ascii?Q?PV2/wtjwfvXBzjf0Usr5mhj44H5pCaXRS30eq3aPOO+Xve6t+16UR/FK9fhE?=
 =?us-ascii?Q?aExmyRRumyfAjBxf/m8w5IYGndYvtwvPl+kzKnEHHyVT5za5KedSgDsC99Nf?=
 =?us-ascii?Q?AnY8JvndcR87QW5DbaDT5wmjyIXuG0qfp8hT8C6aLVt3pMRADfY+iTZY9KZL?=
 =?us-ascii?Q?ORgQLBtvw6+hWLjMOjwRJHl745y2pwGinXTVettPinENk6gz9N8cYQD5sTV8?=
 =?us-ascii?Q?5Bx6NB0q2un1k4SIRIgngIfAttBNj3dbaguDw1hpl9M6BLZqQ06j3rb7vrfP?=
 =?us-ascii?Q?IQXZd4VSMFAjSOK2P9ximRh5zTLkoLXTyLw9INgh2gg4LuccqX8hFolh0Skn?=
 =?us-ascii?Q?ZaG1FcpXoHgbwrq53Xst1omBx1oTXm5v/0PyPWNIF5NY6tvwEMYm8FzQyrGG?=
 =?us-ascii?Q?ruSKhet6OjAQ6al2lln78lbGe2cD1rr4uQ7qYgLjGjVTJBdphYJRdnQyOqdP?=
 =?us-ascii?Q?plelQXCYDLkdkcuUSXDVy/PK0o7LHNZAzESdklLts8Sdg1//vPV13VxdsiDc?=
 =?us-ascii?Q?CQWBW1BeEucp+IsxlPzuZyedbgE9+M164HT21GZTZwPpv2TFqa5Em0fpTU01?=
 =?us-ascii?Q?a6q6AyZa3GTmXPpsUmbXz8O3eADUH3b1gKdd1u0YslzSLuZ2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca84407d-f036-47ce-f273-08df2861761e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:05:16.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ONHjXoG/uJt4ZMhDVIupOIVaWdBePG4qjPimudwigoOD0zGUFFM/sOTwF6EU7fj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

On Mon, Oct 12, 2026 at 03:07:57PM +0530, Aneesh Kumar K.V wrote:
> > Currently, amd_iommufd_get_viommu_ops() unconditionally returns the ops
> > structure without checking the type argument. If a user requests an arbitrary
> > type like IOMMU_VIOMMU_TYPE_ARM_SMMUV3 on an AMD device, the core iommufd
> > framework might track the vIOMMU under a mismatched architectural type
> > identifier.
> >
> > The ARM and selftest backends appear to validate this argument against their
> > supported hardware types before returning the operations.
> >
> 
> No vIOMMU type has been added for any IOMMU other than Arm. The
> documentation also considers IOMMU_VIOMMU_TYPE_DEFAULT reserved.

This is a bug in the AMD driver we need to fix, send a patch? It
should only accept DEFAULT, not every type.

> >> @@ -73,5 +79,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
> >>   * struct iommufd_viommu_ops - vIOMMU specific operations
> >>   */
> >>  static const struct iommufd_viommu_ops amd_viommu_ops = {
> >> +	.get_viommu_size = amd_iommufd_get_viommu_size,
> >> +	.viommu_init = amd_iommufd_viommu_init,
> >>  	.destroy = amd_iommufd_viommu_destroy,
> >>  };
> >
> > [Severity: High]
> > Is the alloc_domain_nested callback missing from this operations structure?
> >
> > The commit message and comments in amd_iommu_alloc_domain_nested() indicate
> > it should be assigned to the viommu operations. However, it is omitted here.
> >
> > If a user attempts to allocate an AMD nested domain using IOMMU_HWPT_ALLOC,
> > won't the core framework reject it with -EOPNOTSUPP because
> > viommu->ops->alloc_domain_nested is NULL?
> >
> 
> It is unclear whether nested domain support is fully integrated for AMD.
> I see amd_iommu_alloc_domain_nested(), but cannot find any callers.

There is a series on the list to complete more of this, it is fine the
way you have it.


> >> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> >> index f3d5b5a7eb4a4..e95138ae71d5b 100644
> >> --- a/drivers/iommu/iommufd/viommu.c
> >> +++ b/drivers/iommu/iommufd/viommu.c
> > [ ... ]
> >> @@ -103,16 +105,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >>  	 */
> >>  	viommu->iommu_dev = iommu_dev;
> >>  
> >> -	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
> >> +	rc = ops->viommu_init(viommu, idev->dev,
> >> +			      hwpt_paging->common.domain,
> >>  			      user_data.len ? &user_data : NULL);
> >
> > [Severity: Critical]
> > Is there a missing check to ensure the domain is owned by the same driver
> > before passing it to viommu_init?
> 
> The viommu_init callback needs to perform this check. For example, the
> Arm implementation does:

No, the check is missing. If a domain is being used then the core code
needs to check it, not the driver.

When the ops is first obtained it should be checked along with the
domain to be sure it is compatible.

The NULL parent domain on the TSM path should be enforced in the core
code since there is nothing to check there.

Jason
