Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837342;
	b=b9ck64JvecCU7pWWWt6SQ6BBWNMkxMeDk7bc1EqsTPRoAaMqgvB71uj4jEfK1yN95UX0
	 XGzRFqj/HF6LiBWduKJpGw0nwTr/qu3/ksEHdUwIGsjEfvXc5uTR+1GTHy7ItZ0cs4A1n
	 o/c7prz/FrrxZYm6mIeyIdOIWp+cFUYABZKoA1fbbOmK3XCk0CqkEYLWEH/2MLefnHBuZ
	 ma9YO/BJGu5llvw/tfJKUamqcXmjj8luCglbJWC68IHzvWl1UO97WarnU+iSl1kSHH2VD
	 YOwPuSAoSVQWKlY2x3olPhi8cre0viW7rvnjReMbEahuhkk2hBNISkArUXENwh0UlBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837342;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GAAwRGt2+3+uGm9D6tR4/Rt28cF+N0XGv4LHLOYDrTE=;
	b=cz6NMb6p+CU8reQvPseEpbMvVe3W05WrsYmYoImPhGIcmZ49ZzcxKvbnWKhesMiu6wDQ
	 RB8GXKRsSNFsicmaD2oMBeEcrQfs9hVxTjdXc3mK7QshdUhbFq4521cK/YqWrRJ2x8f6l
	 nTKsUu+gpmy//xoULgoiZ4zNKv2BRy0/RZ/LHYDwzfxNvdtL4DAmsu6bzQeEf+1jM/ont
	 j6M2asCIGBaBDVy6rR8hoj7Qp+pVl0K9DvCQHjdTWg2H8slvIJxd1u1KkwcPJYvXu4bKF
	 1a1M50/1mxMQOSbAZHECRFcIdCx7swgwhPjP1LdoS92zw3KJ6fXQrw9Hwsu1SzVKHIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R3x/WLEt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BE606A331;
	Thu,  5 Nov 2026 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3x/WLEt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020DA1F000C1;
	Thu,  5 Nov 2026 00:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837342;
	bh=GAAwRGt2+3+uGm9D6tR4/Rt28cF+N0XGv4LHLOYDrTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=R3x/WLEtSoOwbF9qI3uMGHnL7DvHiaXdQuFi+Mhuaq1MHKt0BbNba5Z8Kpp/vkskc
	 uoq4cSBDpPb4bAHuNQOdeWe6Xv+ZMwNHC6AqWuXAMnRM6hF6GVGhh/QQ3uBjc8I6OE
	 FnE3K9eWUqjpojIZZ3c+KqDnouWs8QyzFDMR7UIkV6yt2bWI1OmHyvEAtFAiFGh5v3
	 RJQyGcouemtJyalYFg/sqfRCFvAAh+/tTg9mftQRmqvtGkR+I/46xKJauUyAu15Sop
	 TBdOIGdmVCvyVZSXH4Jtz407Ka0yFAQBFFLnRrod5sbo0hPg0L9uIDqNvU6WFLfeO7
	 z/iq58sTiGtLA==
Date: Wed, 4 Nov 2026 18:09:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org,
	Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/5] PCI: Don't suspend IOMMU when probing reset
 capability
Message-ID: <20261105000900.GA1478190@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66d5221a8e4356316d4f614c8584a80dc9d71b6.1793729707.git.nicolinc@nvidia.com>

On Tue, Nov 03, 2026 at 10:33:42AM -0800, Nicolin Chen wrote:
> reset_method_store() in drivers/pci/pci-sysfs.c discovers supported reset
> methods by calling reset_fn(pdev, PCI_RESET_PROBE, ...) without holding a
> device_lock, since the probe path is expected to query the device's reset
> capability without changing device state.
> 
> However, pci_reset_bus_function() and __pci_dev_specific_reset() violate
> that contract after pci_dev_reset_iommu_prepare/done() were added, which
> moves the device into a blocking domain and abruptly aborts any in-flight
> DMA. Doing this for a probe -- a state-query call that does not even hold
> device_lock -- can cause driver timeouts and data loss on a DMAing device.
> 
> The peer reset helpers all handle this correctly: they short-circuit on a
> probe input before touching the IOMMU.
> 
> Skip pci_dev_reset_iommu_prepare()/_done() entirely when probe is set. The
> inner reset routines already implement their own probe semantics, and they
> perform the capability checks and return without changing device state.
> 
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c    | 13 ++++++++-----
>  drivers/pci/quirks.c | 13 ++++++++-----
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..38b680e7c3d60 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5042,10 +5042,12 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge))
>  		return -ENOTTY;
>  
> -	rc = pci_dev_reset_iommu_prepare(dev);
> -	if (rc) {
> -		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> -		return rc;
> +	if (!probe) {
> +		rc = pci_dev_reset_iommu_prepare(dev);
> +		if (rc) {
> +			pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> +			return rc;
> +		}
>  	}
>  
>  	rc = pci_dev_reset_slot_function(dev, probe);
> @@ -5054,7 +5056,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  
>  	rc = pci_parent_bus_reset(dev, probe);
>  done:
> -	pci_dev_reset_iommu_done(dev);
> +	if (!probe)
> +		pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee41..3d3e95cb9f7dc 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4406,14 +4406,17 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
>  {
>  	int ret;
>  
> -	ret = pci_dev_reset_iommu_prepare(dev);
> -	if (ret) {
> -		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> -		return ret;
> +	if (!probe) {
> +		ret = pci_dev_reset_iommu_prepare(dev);
> +		if (ret) {
> +			pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = i->reset(dev, probe);
> -	pci_dev_reset_iommu_done(dev);
> +	if (!probe)
> +		pci_dev_reset_iommu_done(dev);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 
