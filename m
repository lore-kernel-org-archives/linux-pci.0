Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD69266581
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894848; cv=fail; b=RJinp3QB5H9vEAFG5fdDGbQkIraUl8U9KUC8sgaL7/c7h69mzmzADdUNaNpjFr/loe+Zjqp4ZPU0p6CeTFyXB9w0Nz9tlNgyCMY/k2xVY4kDooItoa/vr0/rtCegwAN7FqicH2kRpfNKddYMtaHNdK8BJNM3GJrqUX6+3vcK3rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894848; c=relaxed/simple;
	bh=f6PdXYxA42HukQxCy0L35Q8ZQd1CC+z5XrW77+NuHHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nXFGuhQQ9Xm83NYTBO8adI2tX/api0tkaAuXTa+OB6SpgvJfEyNZfzTwa6sU2jucdnhZYcfqUd6AYZMelztpoHxOljSRZ+gnF7UEoYa/7l2Iynpa2b4IQ6D8yhIgclf/pkeM6mY1G2vBGyh4rXj6QJbRatpMDYs3HcTlEkwF0tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRrBwVKj; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRrBwVKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0jamWA95iUtg31PJ2Dovt+X4bxYyLs7CM2GF9yN7PXN94j1aIPK15hO3mZQj7RgOc0e5f0U3465lI9sh/ceWIF3cPUjJDgUdJI9RC/mwhKpUvALuPmGT81deXW4ZDAyQw011iE3x1sXzB/6Km2UGsV/rkd2ZIIbgAK1LrKKmRG4fIN83XzjzmYcOTh5Aq5+NCcmpL+SyBK6bn1JhbTDGrEXMbbrtC8mYPsGaPnNGDe9btALkdoN0ukTjRPxEQRxdb6Ilga+l+mAN9Ec3PKvZ+RjhuU987SkKj7hApDPeS6xhewNdk1SV29H2muS2CGpbzA0ZRhGTHtKdYENYLOvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1ISaJRBGux7dCiPX/pe5gquu6HvwI8hzN1v3JjFgwc=;
 b=jHSHsCWYmn7jkqLK9LVRc5Mrc/Fy8PQWcX7+RBm2cvzEOJe38BglU3W7PTr3gPiFyzx6AOUnrPP5u+czebxriKeqZsRf1xfrpMOycvewgYWesjYsArt5SJO0nFqVGnWh1eHu2j6KmINi/LVOP26p67YxpD1oWUBUb99Pu07yEM8tvYS0Sgx0+aPZqdzKijCVvJ96xywsoqDjrb8ECkPXpJd6/XhgYRH1eerda8Fa69Re0X9FV3xn1jx86OJoUHIQSikbNNwa9JEA11Y4ZcXtH263jsCLFk+bcBRYdXudTRr5U7Hl/o4CXLvN+WclW/QclWhs1vLTrGqtjTsj6LbikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1ISaJRBGux7dCiPX/pe5gquu6HvwI8hzN1v3JjFgwc=;
 b=qRrBwVKjrEqnd6m3jEacxkrfmM9FsTvsJeq62d6//jGg/wpvtpyXYB9KII8sTQJDrSeobwCb5pXORyfe1oPz0ENx3efpFlMuIKLmRrkQX2EMG8egHKRhKVTksRkXLQAny0X10FtEENkrVRLsr3G3IkjzZTg7YH0bfCMw6sO30cPHQMPENnS7A7MGg9HXFdf37eFcxYPT+ptkaOLhdW2sfUyvhVGwkPsBWSjoXOwADKBY/KjoL6wZPQniJ4sGB9c2djhs+DUW9S8dkFy5eOqkIZi/ucCbTF/s1HHrkuWIHIrzbg4q+zAJA+VGJ/aZ/0ZNTuqKRGaFaujxj90rP2LgOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS2PR12MB9590.namprd12.prod.outlook.com
 (2603:10b6:8:279::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 12:34:01 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 12:34:01 +0000
Date: Tue, 13 Oct 2026 09:33:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <20261013123359.GS13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
 <sashiko-outbox-163690@kernel.org>
 <yq5azewj45u2.fsf@kernel.org>
 <20261012130516.GL13920@nvidia.com>
 <yq5aik36q819.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aik36q819.fsf@kernel.org>
X-ClientProxiedBy: BN9PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:408:fe::13) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS2PR12MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6472240e-7821-4c1f-5c6d-08df29264264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009223027099003|5023799004|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KWDeLWOIgDAToTljb/uUwmqgM0peWEaQCpZWkLIwALzv1gT/5EM2v7PAWOmtfVHeObbrn0pdXY7IAMAoOhAVjpFdBbWReObDFaMSwMih/LXbJ6ywvHWcVs+zkfpGMm1H5aPn/TaWbgw5fdAJ7FN3tUFNWTDzs5KeviE6Rv01u8S3u1UFZmCJcxezY71m2wooEC7wEIE39uZab7kQp0zvXZHgOfE7T2mMHloCDAGuwvQci4JhZNhAeiIuLwXqsqjB3mq7L0D5v73udQqpeIp4qWlPyGju8OBG2dEdH/dHJFWb2qoUYvdC1ElSIhHaFdBfAur0m2vxXypkUZpXHywtI3V7XljGnkdn5o58I6Igqmcl+6TbMJYmBWTsHEMn629zgNS59zJFQqgGxg5NbSBfTs048jAd7z07GJLrRnEUc/q+rR6K/kmPVIxge7FZxeRv46atH2el163KatyddoqtUY1mKQPW8bois82XYUpb4xzExDX4KrFQ8tiOK+12Q+f4Ylmd1xgN7vv5g1CUZ9BW3OX9N1Rj3bQ34X9eaAuVMmzJ8HDLmLmYEN8uePS9ptmB8RS7MoFQF7wGhDl3gDaGnFV5E0tsa5PveVDKV0PqBhtdtY/y/iR8UXdZ7okCrrB6U8rcDoroM+FNo+llfNywOJSsUwJ5DY/lK4nt5jdXBPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009223027099003)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ihFJCsMEyiaqDxxHI0m09r20NRDxlf+y6c2bWto+j92Dr9KVlFRoUALwp1R?=
 =?us-ascii?Q?wuTrbbgePORbZqZxn3qBQYpWx3i/w4p00ugaahldosR6Py+Qg44VQOxIF4XS?=
 =?us-ascii?Q?jdXNGtrkSdWsW5Gt8CR3+jtn3zjms026F2gR37YdFWyFma/6lc6FuPvm382v?=
 =?us-ascii?Q?e2Rl3U3h7+XnBBmdXI0dSm0bjMJljjfnocPJUJju0Ce/r0FAIqQ0Qn2uQ/1x?=
 =?us-ascii?Q?gux7Xw+jiPH6+zXZd6tkmxAvK4UjELDUtrX0gA64kDn6uEqXiUcGoFUgRKIa?=
 =?us-ascii?Q?1vXQYRm+JGFjh7b9bHlz2mwSRUfiiGc40biE20tkWfm0G5dJhGtiXWo3tvrt?=
 =?us-ascii?Q?Q294qxs2L3eM97kV0+zNRpIZ1d7antG/BMx7pE8ttwoS8elmXzmsHem3dvPg?=
 =?us-ascii?Q?9Q5X2MM5I4YFsalxWTTGXOqdo18BUuOCun5ODb/ln+Nuz8aQuGM8gpQcnoVB?=
 =?us-ascii?Q?1qnCW3csR4VSxLhEi9QYpOi6UHTnoQhay23KMnGNuX9hLLsz2xidnvVtYSWf?=
 =?us-ascii?Q?2Ql+cr1XVCmzkccar2dv6UgW5iWXOLjCIMb6RaA8+xeAJ23OmHSN2tnx5uPP?=
 =?us-ascii?Q?hAUChb36d/0IkYy5JS6qqLErTzNH456hcZEfwqHPTi0Vj9gqBKOY5avptHkj?=
 =?us-ascii?Q?7evS80vXXDASZ87E/wHh5O9GZ28Sy8ztOFu2qKtXidNEvmGyvI7lIQHYwysM?=
 =?us-ascii?Q?gSM2oHphBJwmR5iChFaEgwSD3Dhr7/PiMcFVDNO5SPhWHT8Kld3IgxJbzRBc?=
 =?us-ascii?Q?mwcPpWGdTNwnwKkTa24Yg1eB4a8eGPIogxioyxDDzZfoP8r/p7yoQSEjwOgT?=
 =?us-ascii?Q?ivsQP23s4sJNxdzmj1HmXw9wud/0mcWbB9PlxWJZs19x39vWl3UqrRrvRp3K?=
 =?us-ascii?Q?nRPog1N0cJh/2pQwUCumASr9r1dNKEYA6MaGxMVEATJbIYOH3H6uYZz+jcvP?=
 =?us-ascii?Q?zejTsF0ozL/bR0eFZuCAJKjEgnVzw8izIcw8FpXospmSIu5EQR9fjrqYsOd8?=
 =?us-ascii?Q?980ikPv/z0+P4pRzX+3GZwHLWnbBWiDTA+xewlagLlLhY0m7kV2kDGnlk4bf?=
 =?us-ascii?Q?NSF068qLoQEuuP7xsZUnjusjawdSdyLpIvwN2i8MB9rRtP6BoRYUhUrIiOSJ?=
 =?us-ascii?Q?M/uUv0eYQnI8lRAbIseET/kkk5gX3yrA/8O7D1zF8+GwX0DMKWe+f9mkV9Aq?=
 =?us-ascii?Q?YD7dNZCq8/JbyL7JOXo88ni6Ok7XORCQfU7w3YBlA/Ui8JVqQcE4DvQ3agGB?=
 =?us-ascii?Q?0e4zEt/MZ3mrh0fW8kn0YVYsHgProEL5KEs0sQ/gFP8Ny/vJTe+8j8tyeDR1?=
 =?us-ascii?Q?A8qoOpyEsmrhx95VJ38dxC0BOAEfE8i/fpAJ/YpDlFe3x6vXzwIDIJ84bsbe?=
 =?us-ascii?Q?DxV+CnWu42D8Kw17MPJKvtJfwe5g8ESANTan74/k6vON2x2sjplSvnYQPVLA?=
 =?us-ascii?Q?57nGm0JNLaf3QLwBy70M4gZWCKrcW6H59pcTcKuemL2TrYG6VmN1xKLqoinu?=
 =?us-ascii?Q?7Fat6sNsyj0uEKdTLra0eZ9f4/19JkaFFWQnHr7nTXAEDUruJk36eR2fBDQu?=
 =?us-ascii?Q?S/X0uvUguws7aBurPdG8k+46thTJXSBk1bBK7WRJaEmhWjV4aMQRvulLesHw?=
 =?us-ascii?Q?a7kiffNlQdIPKX1TKnNde7xnYmx+FLYa1LSrWmJSxaXJbnQ398WSihEle1nQ?=
 =?us-ascii?Q?q2gD6k677UJuwdCReAO0l+XuYnzHJvGxkZcZlfyXDK4p8A6p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6472240e-7821-4c1f-5c6d-08df29264264
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:34:01.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beMcRkeTyI6jCoadDr0PPDLuyRMJ5fMtjPqQWTv39PLNwCQfB2lSYGn/rgpOcUlo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590

On Tue, Oct 13, 2026 at 02:41:46PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Mon, Oct 12, 2026 at 03:07:57PM +0530, Aneesh Kumar K.V wrote:
> >> > Currently, amd_iommufd_get_viommu_ops() unconditionally returns the ops
> >> > structure without checking the type argument. If a user requests an arbitrary
> >> > type like IOMMU_VIOMMU_TYPE_ARM_SMMUV3 on an AMD device, the core iommufd
> >> > framework might track the vIOMMU under a mismatched architectural type
> >> > identifier.
> >> >
> >> > The ARM and selftest backends appear to validate this argument against their
> >> > supported hardware types before returning the operations.
> >> >
> >> 
> >> No vIOMMU type has been added for any IOMMU other than Arm. The
> >> documentation also considers IOMMU_VIOMMU_TYPE_DEFAULT reserved.
> >
> > This is a bug in the AMD driver we need to fix, send a patch? It
> > should only accept DEFAULT, not every type.
> >
> 
> But the comment says "Reserved"
> 
>  * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
> 
> What is unclear is what using that type on Arm means. Does it imply
> IOMMU_VIOMMU_TYPE_ARM_SMMUV3?.

It fails

Probably thats the better answer, AMD should just always fail until
they get their type added.
> >> >> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> >> >> index f3d5b5a7eb4a4..e95138ae71d5b 100644
> >> >> --- a/drivers/iommu/iommufd/viommu.c
> >> >> +++ b/drivers/iommu/iommufd/viommu.c
> >> > [ ... ]
> >> >> @@ -103,16 +105,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >> >>  	 */
> >> >>  	viommu->iommu_dev = iommu_dev;
> >> >>  
> >> >> -	rc = ops->viommu_init(viommu, hwpt_paging->common.domain,
> >> >> +	rc = ops->viommu_init(viommu, idev->dev,
> >> >> +			      hwpt_paging->common.domain,
> >> >>  			      user_data.len ? &user_data : NULL);
> >> >
> >> > [Severity: Critical]
> >> > Is there a missing check to ensure the domain is owned by the same driver
> >> > before passing it to viommu_init?
> >> 
> >> The viommu_init callback needs to perform this check. For example, the
> >> Arm implementation does:
> >
> > No, the check is missing. If a domain is being used then the core code
> > needs to check it, not the driver.
> >
> > When the ops is first obtained it should be checked along with the
> > domain to be sure it is compatible.
> >
> > The NULL parent domain on the TSM path should be enforced in the core
> > code since there is nothing to check there.
> >
> 
> So, if IOMMUFD_VIOMMU_NO_HWPT is not set, the HWPT must have been
> created with IOMMU_HWPT_ALLOC_NEST_PARENT, and its domain owner must
> match iommu_dev->ops?

And the tsm flow must have IOMMUFD_VIOMMU_NO_HWPT

> Something like:
> 
> 	idev = iommufd_get_device(ucmd, cmd->dev_id);
> 	iommu_dev = iommufd_device_get_iommu_dev(idev);
> 
> 	if (ops->flags & IOMMUFD_VIOMMU_NO_HWPT) {
> 		if (cmd->hwpt_id) {
> 			rc = -EINVAL;
> 			goto out_put_idev;
> 		}
> 	} else {
> 		hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> 		if (IS_ERR(hwpt_paging)) {
> 			rc = PTR_ERR(hwpt_paging);
> 			goto out_put_idev;
> 		}
> 		if (!hwpt_paging->nest_parent || !iommu_dev ||
> 		    hwpt_paging->common.domain->owner != iommu_dev->ops) {
> 			rc = -EINVAL;
> 			goto out_put_hwpt;

This only works if the ops came from a real iommu driver.

Jason
