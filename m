Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B03C3F58;
	Wed,  7 Oct 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382041; cv=none; b=leWEzqI4BzrbgvR+bIuN0m1BICEzlaRvTTt+gGNb/7fZ0bi41fp4J6ZfJ9zXCxOy9Q8NXPfmgyVUDwtsFqNOMqjJXoSu+yXwa8A3gyZEXGs0Wji1Q1uJuvjXrySnyR20tLbnMRQa0wTq+MixaskyWHtXyA2Gz6eDd4XQ16flrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382041; c=relaxed/simple;
	bh=nynvWucpNvCx8cK80CGSkS4p6Pnmud11dnBI9Rgcqv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTIrn3N2LODZKOsRdE1wvICZJwGsgKwNreIh+mk7UrPNbkVTmPiBp+lbUlJrYAx/9vXRelTu49K2zVKqbYZT9qMWbol1IGHG8MGEMMueRkYVqtmZ+f5V4pgAAkpyFAiXUV6EiX9z9qD8bKs4Lv6qvCtKTS/Mxbv5CM8nVRt26Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB2l6kiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB2l6kiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9F21F0089B;
	Wed,  7 Oct 2026 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382034;
	bh=xTgYbgF6UFHSOJDcNP/wCN8RzXCVJ9ITuwbb2IjoIGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZB2l6kiV8XGXAUPBhLGz1SEtJPO17Av5Uo8TSCRxN1HLyL+9D7TNV3t1OKwhUa4M0
	 K32VRRowwnpGQ1ulwbOwTdqVkzCkhNcKvavBTvzv+wKRAHLzy8x7wVMBEruUjnT+we
	 N1ij5qq9Xd974+pTO1vg7wx65XaqA4EVR8TibpDPNVW2G5AA+tSixvrgXzmjVaSliF
	 KFi4WxQ5tO4YNt7kd1DUjGUkY86tQOHx8tEljH5SM3iUkAveZgBSkwy+g4M8q+wt7Z
	 kIVGfGWAmUPe1LiDjo3j8pyq7fop7aTaBDkEvxELUKchvTrp1utmHlbIRRycQvT2ez
	 ukDUqcyvcOo3A==
Date: Wed, 7 Oct 2026 15:07:08 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 09/16] iommu/arm-smmu-v3: Restore MSI config on resume
Message-ID: <asZSDFkTby9Dj__C@willie-the-truck>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-10-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-10-praan@google.com>

On Tue, Sep 29, 2026 at 03:45:03AM +0000, Pranjal Shrivastava wrote:
> The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
> address, data and memory attributes lose their state when the SMMU is
> powered down.
> 
> Introduce arm_smmu_resume_msis() to zero the *_IRQ_CFG0 registers (which
> reset to unknown values) and restore the cached MSI messages across the
> device's MSI domain via msi_device_domain_restore_msi_msgs().
> 
> In addition, clear ARM_SMMU_FEAT_MSI if MSI setup fails and the driver
> falls back to wired IRQs, preventing spurious MSI resume attempts.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index dc2fc02b5163..7347d3ecdae8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4779,6 +4779,19 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>  }
>  
> +static void __maybe_unused arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> +{
> +	/* Clear the MSI address regs as they reset to unknown value */
> +	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
> +	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);

Please can you factor this out into a separate function (e.g.
arm_smmu_reset_msis()) that can also be called from setup_msis()?

Will
