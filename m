Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7B2D7DF1;
	Thu, 23 Jul 2026 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822355; cv=none; b=kNgYnWGs9n0qWpGsKvwl57uLRKoK5NnJFU2s5yPj5mgkWAXBmi33vwlHRtEwn5PapTazu//h6M3YMt3aKccGzHseYUw2ndQGuo6BGRub8r5F3TltlXJptFG8tj2Y2bRzZ5qP4tk3XBbfJgBJy6zSrMYujLK2MSnM8y7GjQQxK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822355; c=relaxed/simple;
	bh=vyz7bv/S+V5mFdMgM/ew5tn62gZ5RGRMqO0eG5n941s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA5qNj86iBPEEb3etZ77eQVCDqwfyiOuwEEvt4hBCILtgQjDxnLz+UJWrwvSBX6z9OCxjl8/CTnTTEzGtGbULZ7F6PRCDr4i7MQuz+srLAubRC70UrJ7HaEuDb9ajr8H056AXWhSm3Ak6oZVSnMN7zxrEq27M80J1qJe7OvxRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rif8zLxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rif8zLxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133981F000E9;
	Thu, 23 Jul 2026 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784822354;
	bh=gGLVbBTZ/WqliFHvmKwagmiygNTRBXYlF3rnLkYpgRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rif8zLxQYMb/KlUrfmF1OQPjiG1O2yfZM+gIfI1g2gz5cXj/28Y3fBDga46/L5zHY
	 SKOY4SdL+z2PJTgn0ef5d+mYjTf6e8NoxXP7QZNKxGJuO8SPiVoqj0GlvChXKBA0kK
	 lzqZcpQrA9BJqpE0iMIxw/1Qt9ymY7UGjHL9Ni9T6B/pWO9XxuhkmLmh6pPM8ZCyly
	 66qpH7kmlW0woWcin6p3t6Yx6zu5r6jgFhlG9tjY1/d+DRNvanRpqFp4NvdpuUuSgA
	 VH5BaTnrk9s3X1EqGZEtYzB6R9der6vBNSBWF6BZkucnKsKOS5pKMet/d8BWoFdEHd
	 EaMZDKdKYiorA==
Date: Thu, 23 Jul 2026 10:59:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	alexander.deucher@amd.com, mario.limonciello@amd.com, jgg@ziepe.ca,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260723155912.GB836122@bhelgaas>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723061548.10187-3-vasant.hegde@amd.com>

On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
> Certain AMD GPU's must always be in identity mode. Currently its enforced
> using PASID check. It worked fine as most GPU's has PASID feature. But
> this means, identity mode enforcement is done for all PASID capable devices.

I think it would be useful to know something about *why* these devices
require identity mode.  And what happens without identity mode, i.e., is
there a user-visible symptom that happens when the wrong mode is used?

Since the code doesn't test any feature bits, I assume it's because these
devices have some hardware defect?

s/GPU's/GPUs/ (twice)
s/Currently its/Currently it's/
s/has PASID/have PASID/

> Previously it made sense as domain allocation API
> (iommu_ops->domain_alloc()) was just passing domain type. So it couldn't
> check device capability and decide best suited page table type (v1 or
> v2). With recent enhancement to driver code, it uses
> domain_alloc_paging_flags() ops for all paging mode domain allocation.
> This can check device/flags and allocate best suited page table (v1 or v2).
> Hence fix amd_iommu_def_domain_type() to force identity mapping for selected
> GPUs only.
> 
> With this change system booted with DMA translation mode will select:
>  * Guest (v2) page table for PASID capable device
>  * Host (v1) page table for non-PASID capable device
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c2672d5..fe642e33c87d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
>  	return dev_data->defer_attach;
>  }
>  
> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> +{
> +	struct pci_dev *root_port;
> +	int class = pdev->class >> 8;
> +
> +	/* AMD GPU vendor ID */
> +	if (pdev->vendor != PCI_VENDOR_ID_ATI)
> +		return false;
> +
> +	/* GPU class */
> +	if (class != PCI_CLASS_DISPLAY_VGA &&
> +	    class != PCI_CLASS_DISPLAY_OTHER)
> +		return false;
> +
> +	root_port = pcie_find_root_port(pdev);
> +	if (!root_port)
> +		return false;
> +
> +	/* If bridge vendor is not ATI then its APU and force IDENTITY mode */

s/its/it's/  "it's" == "it is"; "its" shows ownership

> +	if (root_port->vendor != PCI_VENDOR_ID_ATI)
> +		return true;
> +
> +	/* Rest all are dGPUs and works fine with DMA mode */
> +	return false;
> +}
> +
>  static int amd_iommu_def_domain_type(struct device *dev)
>  {
>  	struct iommu_dev_data *dev_data;
> @@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	if (!dev_data)
>  		return 0;
>  
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
>  	/* Always use DMA domain for untrusted device */
> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +	if (to_pci_dev(dev)->untrusted)
>  		return IOMMU_DOMAIN_DMA;

This seems to apply a different rule to untrusted (e.g., removable) devices
based on the topology, not the device itself.  What if one of these devices
is used as an eGPU and thus uses IOMMU_DOMAIN_DMA when it really needs
IOMMU_DOMAIN_IDENTITY?

> -	/*
> -	 * Do not identity map IOMMUv2 capable devices when:
> -	 *  - memory encryption is active, because some of those devices
> -	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
> -	 *    and require remapping.
> -	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
> -	 */
> -	if (pdev_pasid_supported(dev_data) &&
> -	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> -	    !amd_iommu_snp_en) {
> +	/* Apply device specific quirks */
> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
> +
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;
> +
> +		/* DTE[Mode]=0 is prohibited when SNP is enabled */
> +		if (amd_iommu_snp_en)
> +			return 0;
> +
>  		return IOMMU_DOMAIN_IDENTITY;
>  	}
>  
> -- 
> 2.31.1
> 
