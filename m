Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA2414A2A;
	Mon, 24 Aug 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577522; cv=none; b=f8HYzBhrNVz/GalUNvAJEAWV3htgBS01B0c0KYZYaO2UWCncMuCTzK5FFqLyDNcgkERT28mJmcoyC5vktUaW17FPLn2m6K6XEWvunKpPcgJJTOEjRcIplwaAJGykZGnO8dJnnTlBsjKoG7HCq7/8O7Yq/5RgIgE/wR7wX9R4/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577522; c=relaxed/simple;
	bh=RaqWv4sdKtg9Q3FZzE5iObYvjNivT1+7Vq8G2WtzWio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYrExkC439SjgSNOQJSQcA3h+Kmet28mcfSlNLL8mOaPT56zHDd/OYnbjfRdr2KIAw3657+ixatE2I6YNXjjggoeE1824d4Z0hZbp0RNrUUEDEJLoZFNcdNbMVZSIDrW59YSxc2yQAbdAVxWNwbRNv/kRpq5aGl2Ql+txSomw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtBnfeHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtBnfeHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D6F1F000E9;
	Mon, 24 Aug 2026 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577520;
	bh=2IgTliCBEsxoRkWaJ+7cQfG5+XmFVKCBOQc7JnQ9X5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WtBnfeHa6q0Ge+TozwySnv15XYNhGwozXp2NSFNiasl1r3GBtaFGS2d0nM25KBNsD
	 I1QPXOxMHpQOAgaHmSUJmV47luhioE9wGYACB7fJXdfzHyPXFIWafyA2QQIcznCtn5
	 GOf/IP/lD9ZLo/o1OJjmNYHKFhvUlm7IcGtQnFCYsF5hQpMjlFY5Xejo8puXzYE4ni
	 jSQzPS2kS7VxUGdCcwn/jUqH3p//WfgUn2tc2UfD5k3BGOFY6T23tnoB9/A3j8CIkj
	 vus26x4omePWeVCCrW3gpblarFPrW+AuvQiIOYBKh3qNFNkXPb/5FpiIYVF7ZU7zQI
	 bYOZYE9ux4omQ==
Message-ID: <54938b27-7f97-4027-b7b7-1b6efad8c72a@kernel.org>
Date: Mon, 24 Aug 2026 08:18:38 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, linux-pci@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, felix.kuehling@amd.com,
 jgg@ziepe.ca
References: <20260824085821.5422-1-vasant.hegde@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260824085821.5422-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/26 03:58, Vasant Hegde wrote:
> Certain AMD GPUs must always operate in IOMMU identity mode. This was
> previously enforced using a PASID check, which happened to work because
> these specific GPUs are PASID-capable. However, this approach incorrectly
> applies identity mode enforcement to all PASID-capable devices, not just
> the GPUs that require it.
> 
> This made sense in the past because the domain allocation API
> (iommu_ops->domain_alloc()) only received the domain type, so the
> driver had no way to inspect device capabilities and pick the most
> suitable page table format (v1 or v2). With the recent driver
> enhancement to use domain_alloc_paging_flags() for all paging
> domain allocations, the driver can now inspect the device and flags
> directly and choose the appropriate page table type per device.
> 
> Update amd_iommu_def_domain_type() to force identity mapping only for
> the specific GPUs that require it, via a new quirks_force_identity_mapping().
> 
> With this change, a system booting in DMA translation mode will now
> select:
>   * Guest (v2) page table for PASID-capable devices
>   * Host (v1) page table for non-PASID-capable devices
> 
> Also drop the amd_iommu_snp_en check, as SNP enforces paging domain,
> which doesn't work with the identity requirement of these GPUs.
> 
> Link: https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
> Link: https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.hegde@amd.com/
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
> Changes in v2:
>    - Dropped disabling ATS for "Radeon Pro WX 4100"
>    - Addressed review comments
> 
> @Jason,
>    Once this patch settles, I will send separate patch to drop
>    'untrusted' check inside amd_iommu_def_domain_type().
> 
>    Regarding SME check, I have retained SME chek inside
>    quirks_force_identity_mapping(). If everyone is fine to drop then I
>    will do follow up patch later.
> 
> -Vasant
> 
>   drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++++++++++++----------
>   1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 29dc18d3d22e..fc7819f57521 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3122,6 +3122,26 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
>   	return dev_data->defer_attach;
>   }
>   
> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> +{
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
> +	if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
> +		return false;
> +
> +	/* It is the GPU in an APU, force identity domain */
> +	return true;
> +}
> +
>   static int amd_iommu_def_domain_type(struct device *dev)
>   {
>   	struct iommu_dev_data *dev_data;
> @@ -3130,20 +3150,23 @@ static int amd_iommu_def_domain_type(struct device *dev)
>   	if (!dev_data)
>   		return 0;
>   
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
>   	/* Always use DMA domain for untrusted device */
> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +	if (to_pci_dev(dev)->untrusted)
>   		return IOMMU_DOMAIN_DMA;
>   
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
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;
> +
>   		return IOMMU_DOMAIN_IDENTITY;
>   	}
>   

