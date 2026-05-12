Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FC3672B9
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590683; cv=none; b=nYNpd2txJziRB1ID4NggRVoGrHKdQyZ/SZz2RkMuC7SlabV2iXy90huDAHM1RgSYPUNy0aRIIk9046STXV6lyGRZ3g4aYwYZ7vpilY0dW4749L6+7sf5YSCAcaq+7G0WZSEMKdV8yRIvXPybEHAmS0WG14xPIM0MoNbcF0DY81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590683; c=relaxed/simple;
	bh=5bWaVVBc4qz0lgeFG+CvhrffOUhq7nziLUWowWvD7b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtdCPRutqAqc2ygmFOQChytcnAVZqQpYVVEaSHBIe3T4eBkVTZezEc7T43fDHI6eptUsioOmDaAwQ85mXrB7jHyAC4XH81Av2BA57zhKS60vFTdEn0dDkPc/XxMkam3ItNbVD8TNiui2jKJbj5qP0Lsc8aqmlCrX6SyT4LvXUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7I3XcRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7I3XcRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53625C2BCB0;
	Tue, 12 May 2026 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778590683;
	bh=5bWaVVBc4qz0lgeFG+CvhrffOUhq7nziLUWowWvD7b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7I3XcRai1GgCYtcEiFZB2eloWb2rgFKvYcSLguN6Q6U2Jszj5PRGir9zrPMuWZNd
	 lHLxn1G5iXm2wR1SPgzB8zn8pZ+IEgqFIh7xOyahAd/dV1tWoRdVkDHHSXcVg4DGEF
	 MsOeTjG+7jsUuPtMlSqEGMzg8yO2c18ztv5+VSMnbKbG8npl9SD01m2/Nbxuu2yakb
	 I1ItCoMd7qNbbzH8obPcap4WbCtGFit7fBP8g1QezdpN7Jr5PUW5u1n5KQVQvLbWBU
	 yaj/MhmNSINpv/MR/WpDwLN7dTN1x6E3lUwx2ttnjb79I3S0jp3dHCuWCG9TFyPNJi
	 yxJVD9L28x40g==
Date: Tue, 12 May 2026 18:27:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 7/7] PCI: vmd: Replace pci_alloc_irq_vectors() with
 pcim_alloc_irq_vectors()
Message-ID: <hivymkgzg7dl7rj6dkstgo4ejgdby5rb3c2ndiy7eipk5hcqai@bjmke2xzs2u2>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
 <1777017460-243543-8-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1777017460-243543-8-git-send-email-shawn.lin@rock-chips.com>

On Fri, Apr 24, 2026 at 03:57:40PM +0800, Shawn Lin wrote:
> Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors() to
> explicitly request devres-managed interrupt vectors. This makes the
> driver's intention clear and avoids the ambiguous implicit management
> previously provided by pcim_enable_device().
> 
> The change prepares the driver for the eventual removal of the hybrid
> IRQ management pattern from pcim_enable_device(), ensuring consistent
> resource management through devres.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pci/controller/vmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250..d8de63a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -684,8 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
>  
> -	vmd->msix_count = pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
> -						vmd->msix_count, PCI_IRQ_MSIX);
> +	vmd->msix_count = pcim_alloc_irq_vectors(dev, vmd->first_vec + 1,
> +						 vmd->msix_count, PCI_IRQ_MSIX);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>  
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
