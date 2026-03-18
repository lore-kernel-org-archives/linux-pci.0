Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B114D719;
	Wed, 18 Mar 2026 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865683; cv=fail; b=GAg/JuXRLPlRPct3lrHgalevSG7wGYzIbKhWqzYTSS/0mXVMcPRZZ1wac01FCMmFfbEtPqEGYFYn+YKFib3bFxjfsTlbpks8/orlu4ibu4kFyRZotn1S2SJnZPeHQXUi4G85crNAZnOPsXVOdBka5UTCOgqomvmw1hN/sTJ/TIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865683; c=relaxed/simple;
	bh=8B5NtCjdUG1+ktHNOH0is8TFilfv+3cpCsxAPCHfCTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZjA6ZhG8sbsVNpTxRDdb/pZoDPZGIER0/0EHibLqwqXYdG8YGQdBrs7+O2a9LQ6pbDpKLh/9qlekYM/MNfZTpd8A8m+aet96Q9cMsjOReUkQi3mApQBAxcU6lel7DDLG/1CqN+fS3xr7RZRfZkJRFQsqxyb0UGzl4EIODIT/P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ul2Xvb4T; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ul2Xvb4T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAhtdIReQzM10WEavwBsya8cg8jK3MUCdLFIIII9i2OV8dYCGVilAbM0TJnNiK5DI3tDTZJ2Iq1o8lA60Hb8C+ctgXT/twLD3TqU9OxFB1z+hh162FSu1+PBdzqjJoqyrnfnWVWFmOgFTINKyUQ6p2hctRrWDcx3oz6lB34i85PPr6iMQJlePKFnUSatp2d0StsNhOslM50ApNcVCw69kQQ+q+WIrD5M1iikIiu6FJYNqlSMNGkqfVdo3hR3TJ9itX8RTv95w4UqxxOeN+mqTRLGOo+rZICkBl+qxDtR+w87lgi+uxmDXRjgE4XQWKMBlQB8sZwr4X2faf8cPXT65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow67b7y5mAv0wGYhQo/ymevkVDjcCzlQ7smpV5U0UOE=;
 b=BL/lHxCeg+yIxXVrvgga/HR2KSEzZCgTDXCd0dcTlTtseTwfHR1NdUkgYV5o+14EvZwQkjq85pBLVJiKGCRKLHRqzhIpzW+MpT2CS6a7410eGqpX4aZdm+burhvG1ulQ6wnlWVDAUOCwktueAU85fBeq8oWlhnfPRRfIX9I1UDtvUMQIXhkKefp4G4nctdlQBY0mnSTbVnjYxZQRSLQk4fFg4lNDyth19OnScwF/Srvl+jziKWVFv1LY+EBVpiLP4ksQAF5pMp4Cprhz9DPx9vOtKrdeh9VCYDL9U/lYuYGg2UzQX0v2WyzYl/7+bATsE6imClzkrPLd8A5hf/6w9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow67b7y5mAv0wGYhQo/ymevkVDjcCzlQ7smpV5U0UOE=;
 b=Ul2Xvb4TW5MXNLypITvvz1A12xiyFfwPMNbIn+xUdF9DrBmpLnQuw+V2LLx/mKDeYlYRO4ORORDUTHgHMQEwrnImaie5rhk2TOUBmxvLYxSXo9RXmGGZ0FV6AC6+Cy7eKI0yfD7doDZf862BxxtYLvEotVlCG9YYCKaNaySkgJtuzXPu2i0a9Sc9mICQt/WpH+QsfcTn9Zc73LyH0RYWf/Z3voeUcbMWanrj6a8VGxphsFh+g1B6+kdJdtcUaFtu2VEpSuXpYzjsHOTNBM1vy+CeAfmsV7hFjKvB/n32+HoSmjczuVo4ty/CSEpZoBVC8D6CRJGenXez8MKMyAC0LQ==
Received: from SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 20:27:55 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::9a) by SJ0PR05CA0035.outlook.office365.com
 (2603:10b6:a03:33f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 20:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 20:27:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:27:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 13:27:32 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 13:27:31 -0700
Date: Wed, 18 Mar 2026 13:27:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: Re: [PATCH v2 1/7] iommu: Do not call pci_dev_reset_iommu_done()
 unless reset succeeds
Message-ID: <absKsk7qQOwzhpzv@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <21fa71d59c8ab787c0f3d8cf3e9fc725330fd0d5.1773774441.git.nicolinc@nvidia.com>
 <8c799be2-1525-4c84-b0ae-389cd0751e4a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c799be2-1525-4c84-b0ae-389cd0751e4a@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: a69b87cf-7b8a-466f-1df2-08de852cd5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oIDGyXyJ1vnRM2dx6SNn062pMXqHmHX23BXrM41UADGWdbaa9InU/b3RnQC6nV8COvUZnLgccHnoHNUv4yxrQCH1olI1kMji9dXAUzkHK3233NbwtcoTaP9c1mEQBeZv+BMsqBlmEqEL6pU8X4vWni4tRspk0Wd4BFiIxXtR9/ZihLQD/aMPzHpp84uMBXxeZF+DICjYkqUGOrC3HT3WjAppqsg2kmUsFIzcM1x4y5OSWlkXd3csU8RBw7/fHHO1TSFI5Z0TxLPbFK4ezweO5LMV7Vrl1z5UQQPLHS7LABi08WtkNwp8Bd5zXx/47POCbFLu/mUz390ElFkdGdmaxaDGr2K3PAuiE9we7Fd58TroQ+IjMmdX8fxt0nB1EODT0A0Wp0xinDw2oDkqQyQkMwW2dXyBA120JNsaeGsmkbWvdG+oxXqMn0GVFoKfCXegsUgXWYuMM3O3oSb927+4TuNo+g+S4gCVblK0TjqsOSEFOTHriWVkerCGTcw9gZ27H3DGaqVz7oFQ457e20vwQntZqFf2797Zsc5vxgW+1UnH7AHSfZuXaEwV4WUqY+39jrImKyARUgDqEciVjb9s3Ilo2qO2JYjM8euL3/tVeoskVpna7lkQKrpuSHitQ8R/CSaPNSUUSt2FVP/oFemhTiYpNYdJwjC7KJ0OcHG3aCmP4scN0W54m9YmvL94UksRkLwFkoCuxQ4d5usUGVLbtG8qPHq8M84WVaKt4q6l6dTToGg1P7N3GfDgdcEMw3aFyKNOqE6R0evd/C2wjMZhtA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+/w1K2pBpulr2Ec285bHYFvzeh0AX9CKR7Lk/nvgHaptDkLOqTeeUO3KqcyWNu270uSgZ21Z9wTR3wZE6Nod4MwXj+jIsIycjF6yqvckaWmXvDhTQ4hNBlUWNZWcrLF59Gl7mZROA2MtSrkn9rnhhBId9pu/kkNesl8jRPxxcYkd/nYVmDeYT6O68DQjQJTtQEzDXyHLdiERbOzbA7zsrjfbnj/a31Rw8FQFH5FszBzTs11xfJUNSibYHMfhBQSMmINXsJfGMLN6MEdbJzo7PnyY1N3sgaWV99uKvUhx/2g16NguLW/MS+MxwWvZIJlLE7/jtznS9/lijHvLLzepwQKIFJwX34KNe7SkqnbgNjDkcVkoWBK7Ek3r3PHACGQ5KoeF0J/V0e3qiZE2I8Zbkzp6lWd0u5VBUrdNHKftuJ/69E5aICe1apFse9ZiUIMv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:27:54.3580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69b87cf-7b8a-466f-1df2-08de852cd5c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

On Wed, Mar 18, 2026 at 04:02:01PM +0800, Shuai Xue wrote:
> On 3/18/26 3:15 AM, Nicolin Chen wrote:
> > - * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
> > - * before/after the core-level reset routine, to unset the resetting_domain.
> > + * Caller must use pci_dev_reset_iommu_done() after a successful PCI-level reset
> > + * to unset the resetting_domain. If the reset fails, caller can choose to keep
> > + * the device in the resetting_domain to protect system memory using IOMMU from
> > + * any bad ATS.
> 
> I think you mean ...to protect system memory from DMA via stale ATC entries.

"the DMA via stale ATC entries" sounds too specific to this issue.

I intended to generalize the message in the kdocs. Maybe should've
drop "from any bad ATS" as well?

> >    *
> >    * Return: 0 on success or negative error code if the preparation failed.
> >    *
> > @@ -3961,9 +3963,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
> >   	guard(mutex)(&group->mutex);
> > -	/* Re-entry is not allowed */
> > -	if (WARN_ON(group->resetting_domain))
> > -		return -EBUSY;
> > +	/* Already prepared */
> > +	if (group->resetting_domain)
> > +		return 0;
> 
> Could you elaborate more on why Re-entry is allowed now? For example:
> 
> /*
>  * Allow re-entry: if a previous reset failed, the device remains in
>  * resetting_domain. A subsequent reset attempt must be able to call
>  * prepare() again without failing.
>  */

Sure. I will add this.

> > @@ -977,7 +978,15 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
> >   		ret = -ENOTTY;
> >   	}
> > -	pci_dev_reset_iommu_done(dev);
> > +	/*
> > +	 * The reset might be invoked to recover a serious error. E.g. when the
> > +	 * ATC failed to invalidate its stale entries, which can result in data
> > +	 * corruption. Thus, do not unblock ATS until a successful reset.
> > +	 */
> > +	if (!ret || !pci_ats_supported(dev))
> > +		pci_dev_reset_iommu_done(dev);
> 
> pci_dev_reset_iommu_prepare() already does an early return for non-ATS
> devices, and pci_dev_reset_iommu_done() also early-returns
> when !pci_ats_supported(). So for non-ATS devices, done()
> is always a no-op regardless of whether it's called or not.
> 
> Do we really need check pci_ats_supported(dev) here?

You are right. It was for a precaution as pci_dev_reset_iommu_done()
isn't maintained in the pci.c file.

Kevin suggested to move this part into pci_dev_reset_iommu_done() so
these conditions can be merged. And pci callers will be simply:
	pci_dev_reset_iommu_done(dev, !ret);

> > @@ -4978,7 +5010,15 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> >   		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> >   				      reg);
> > -	pci_dev_reset_iommu_done(dev);
> > +	/*
> > +	 * The reset might be invoked to recover a serious error. E.g. when the
> > +	 * ATC failed to invalidate its stale entries, which can result in data
> > +	 * corruption. Thus, do not unblock ATS until a successful reset.
> > +	 */
> > +	if (!rc || !pci_ats_supported(dev))
> > +		pci_dev_reset_iommu_done(dev);
> > +	else
> > +		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
> >   	return rc;
> >   }
> 
> cxl_reset_bus_function() calls pci_reset_bus_function() which already
> contains the conditional pci_dev_reset_iommu_done() logic. Then the
> outer function calls done() again. The second call is a no-op because
> resetting_domain has already been cleared, but this is confusing.
> 
> Additionally, cxl_reset_bus_function() does its own
> pci_dev_reset_iommu_prepare(), while pci_reset_bus_function() also
> calls prepare() internally. With the re-entry change in this patch,
> the nested prepare() silently succeeds.
> 
> Is it a expected behavior?

No.. This is a bug prior to this patch. The nested prepare/done()
is wrong. I will submit a patch fixing this.

Thanks!
Nicolin
