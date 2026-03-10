Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC33E2759
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173240; cv=none; b=UiTICBpLkL5dgSbJ4zEXCb3HU5AaBM+pMYbxmIgDAqrHqfhWKiTlOt1DRWUFxKUaFNYIGXX7AtNY2MQDgkJMfOQ7PExVHhPRXhM0bxE2rsqCYggVhSw38xGbyPtGQJNdvta8mGbjtt26xLtKvUhdLuebEgeYPxEnSNWrMa9/OIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173240; c=relaxed/simple;
	bh=3grtquKDdZWWCx3aDnSQIONQko9WXUQegcv7957x660=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SKIumzlVCQ5MEvFFDOMIjoj1mNR2vXoh4V+WqGqz2+htmQ9gSSTuRoFOe2aIdKQYnp5u4Dj3GsvOzpkQiErvPUt+D8LjDCDL/K7tdGSzxmKbvDUdPfMeU1lNs/X2Co4r8fKmD8uCyqqgeE7h0bgGgIF/ayy1X5T1qdied5AbXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMrnfkPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMrnfkPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A94C19423;
	Tue, 10 Mar 2026 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173239;
	bh=3grtquKDdZWWCx3aDnSQIONQko9WXUQegcv7957x660=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SMrnfkPem/Epb3iD7VL5D02tKlVhb43cxVZQoFSDlhe6gJfC0IzoQMPT1SnjpNyqZ
	 Cxr2phPN2wJZzG40AyOgu872iGBfCqc9n381QRZ4qBwBb5KMY840vRfr9/uFRoK1Qj
	 GS7LioEXI8NMHH/qqtJQ8nA4BX5bAOgiPI+XUsmMco2moaz7ftPpcs+efYSjz4tOJY
	 RzvfQwfnvNzSy9aGnJ3SJdWLPb6fiPp9PuGl4ce9+1nX8rLzVZG/Hmetiuy0+49KSx
	 ZF4+K8OXv6N24pOmaVHFt0g+cqgZeb9ZXXkGtc1UbSGJPdqWUaFL+RPsAmR4l4qtO2
	 7f/M4hnH107Aw==
Date: Tue, 10 Mar 2026 15:07:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/5] vgaarb: mark vga_get() and wrappers as
 __must_check
Message-ID: <20260310200718.GA786702@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307173538.763188-4-Simon.Richter@hogyros.de>

On Sun, Mar 08, 2026 at 02:35:36AM +0900, Simon Richter wrote:
> The vga_get() function and the two wrappers vga_get_interruptible() and
> vga_get_uninterruptible() can return errors. As these are paired with
> vga_put(), which must only be called after vga_get() returned success, all
> callers need to check the return code.
> 
> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> ---
>  include/linux/vgaarb.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 97129a1bbb7d..eed524c67c22 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -27,7 +27,8 @@ struct pci_dev;
>  
>  #ifdef CONFIG_VGA_ARB
>  void vga_set_legacy_decoding(struct pci_dev *pdev, unsigned int decodes);
> -int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible);
> +int __must_check vga_get(struct pci_dev *pdev, unsigned int rsrc,
> +			 int interruptible);

vga_get() is implemented in vgaarb.c and is only used there.  Can we
drop this declaration and the stub below, make it static and
__must_check in vgaarb.c?

>  void vga_put(struct pci_dev *pdev, unsigned int rsrc);
>  struct pci_dev *vga_default_device(void);
>  void vga_set_default_device(struct pci_dev *pdev);
> @@ -39,8 +40,8 @@ static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
>  		unsigned int decodes)
>  {
>  };
> -static inline int vga_get(struct pci_dev *pdev, unsigned int rsrc,
> -		int interruptible)
> +static inline int __must_check vga_get(struct pci_dev *pdev, unsigned int rsrc,
> +				       int interruptible)
>  {
>  	return 0;
>  }
