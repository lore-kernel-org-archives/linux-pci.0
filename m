Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A8484226;
	Thu, 23 Jul 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821383; cv=none; b=oqFget+Rp23AOcWFX5HoRrPVo4YAZEKhTLR8UmLQJeI6mOczoMeOF1/W5TxnpPZkwx9rasM12hbbEfOTDmGwESQUOHJWzlIqaaBqQo2tS7jYpXlwPEfuIynbCrTzTDLY+q9hMnIEMms5fjgtj1eiZdil7U/zIXzRtCLrwvlnpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821383; c=relaxed/simple;
	bh=TbXFmKnPNo5liikiI4EUCChJabUDizkRWYhMw0C6YUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/sW+ck+ekaVjT3z5N/EVEPfB9nZicHv8ZEX6QzAbNW3eK+msZMNb0jd4GZl9Ibw97rIJKvRMna+F6NtIL1vCdCafbotrdF2FKA2ld9qZhbShPq8G6IhNiNF5ZZecZWWhZWV7EIwjKVHDuW9eZW5tDyZJzJpZOJmsjKoTsfydNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbrEjISG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbrEjISG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AB61F00A3A;
	Thu, 23 Jul 2026 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784821381;
	bh=K1AUQhkmXgUeaGNZXdQbMe6bRsXKyMwD1ceV8FwR7z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QbrEjISGP0XyZIWNp9dnUd1EKp2YmUvdpYfZzQSoaKb0F8McodDFtTx07WvB6HF+h
	 pkN8DOUzIXbk+6/dYDBnxRkEVbV4yao7e2BcHSNiaOJeT7EbkjRE9aM1b3Qkl46wvs
	 aHR/cIJU+bHLB4icNmrzuvwatyCnfpJ04s8Bbd2Ze8sqRcYBS9p8N6Opi/Y3oaLSE6
	 uf4/nVeYCuhfKYDecpYgXYUKyR6+woiZPIYCcGqXWRRgBnCepc6fU+K1geUnFeHzgC
	 DO9c7+ph6mahC/7dCnPehpQoMN0h7sDT/mY+qLJ+fzIpaHhR31vL/y3Qe0aQr96Cgb
	 ijH83RQg8yNJw==
Date: Thu, 23 Jul 2026 10:42:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
	will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, bhelgaas@google.com,
	alexander.deucher@amd.com, mario.limonciello@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH 1/2] PCI: Mark Radeon Pro WX 4100 ATS as broken
Message-ID: <20260723154259.GA836122@bhelgaas>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723061548.10187-2-vasant.hegde@amd.com>

On Thu, Jul 23, 2026 at 06:15:47AM +0000, Vasant Hegde wrote:
> If ATS is enabled then IOMMU logs below error and GPU fails to
> initialize.
> 
> [  103.687137] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=0000:c4:00.0 address=0x1080006060]

Is this a published erratum?

Is there enough benefit to using ATS to make it worthwhile?  It would have
to be a pretty substantial benefit to outweigh the end-user frustration of 
defects like this.

If ATS isn't going to be validated by vendors, maybe we should disable it
on all AMD/ATI devices?  Or maybe only the GPUs?

> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..d55657347d88 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5686,6 +5686,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
> +/* Radeon Pro WX 4100 */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x67e3, quirk_amd_harvest_no_ats);
>  /* AMD Raven platform iGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
>  
> -- 
> 2.31.1
> 
