Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DEE27FB05
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153504; cv=none; b=dOSVw4lJBZUPwg18NaQNJvjcZJWC/k1qd1bBUg5qo50pYq13zru4ng0zHPEI9m3Bc4hVepX3UKPl73zzBPJiQdsdOWg0fUOYouINgotUDUXD6bah1RADZAjdlNYTpde/v/IM3FSZfgW0uMmvuvHK8qQgCrZXRvLqV7R6pw575J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153504; c=relaxed/simple;
	bh=NQyOctLZTPFTOh6KiN8jGUkbmNJbnruqVAal+w6/O7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9ANRM1jEt0tA1SQG+ssW+aciHLX23PAWA63MYEMVCnxk/24ANpHX7R78jeyfGxUfEXvuirnHsEoZ+9dN8i4KPJKiD8RW51mUP9NdgdaMCfxewVwnWnwj1az3KBGWENRgjyG4aH1oDUbmlqVNyJ85N0rZkpSg8Sl6qQuFZI67MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4ofJnAu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4ofJnAu"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so11815464a91.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153502; x=1773758302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS0FTNKBrzFEJV1YS7pTTyBPE0vMh5MC/QzSyOZemmw=;
        b=B4ofJnAugkHhqMmru4ypFZbY8gW0sqQWASPZQgWwSMrvKCs3JqV/xxyKWIdxktHVCh
         T25KLE8TK9O/+ITq2hPBFHZrqsVoEQ9tkzFU2KdTU89GX5K5GR+snjmO7RzIjfOHCqyA
         hDenDqyiCh6x3grd/KI3tL/2tWOHwfgw13T59TwyDulptUR9E3vs/vGvXlg2zRN5UUmn
         1pgGG3y/r7Bd+gV4m9pp+d+trXL1BeYhYvh2r9esCOyUziRHNlXpvxZTRo2rrv/Ld9Xl
         B4X29SP8XAxFSMss4IRZTQIluq32RFUwcO1tzKssEKpG6+LZ3ZiOZ5PEdRbJwD1HxGkK
         r9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153502; x=1773758302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NS0FTNKBrzFEJV1YS7pTTyBPE0vMh5MC/QzSyOZemmw=;
        b=vDxJ37evAWWNZBxOmKGF+E8Z92qQqp1gRbRvPhBqOtTwpl4BuwbxphktkDsiNET7Iy
         Zk9L3srNEXk2dqGvyn8uIvNB+DvZWqYntrheSsLEnW/4ApBuURZz5t3/FoYQuDyqUJgD
         JdakuR2RGUfnFqCILmfW8TKmxEHmpogRhqEgRs/i8TcdspO9MJu14oDubXax5bXTMyJu
         uH68MfG8GYUjfhQXi2vF78XJcM1gPEwaGGDZLNOcSsCSUt84tm6iS9WpTYYp/iVATVjq
         UY/AOb9b0BJsrkiqGnZL15NSzuaSJmMfcAEliw/yr/ZZrGvXlZmOPTUo95LIlyNTnBti
         W4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbv9ooO/yfsSPoOSZMtHdZeWt7viFZEL9KsqQLf1+WRxFGKsnmMbyrJHaAqgyk3/XwMvFtqJcdzNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqW6W3NgP+S4rAyIkaLSEA0q24XUG5RADc5M8TRhaI/SaRiXc
	f1OWcpMKZxpXusEEvifo14y7RO1j1Pml15Q5uJ9DYVRMEBL3ZLDTUFNS
X-Gm-Gg: ATEYQzzoJ7C7ie1X+34mSipPGFyqAJwWkb8rT1f0pjYXsjB0HWPyc1YkaIrIpQ4Q91c
	R0bx6z28P7CDxR1jSih8s4kTjix1X7kX91h+wpbeC47pvbqGFPTB2URBdjkMdsm1BKA7RP5HJSm
	pAORFYaFqi/25wSPaH5LSumWiiMQY75xCGvehuNbCbrHspNwk5AqHUQQt14Ux9uJsGVlehUfwJ1
	M+fAeX/AyQcXB0j0RABkGNWsEAyhNxodn/UZxUr2tk2e1GSOEkLk2cgOzFr5BM0/gHhAF6a8mCU
	HM+amAQgB0PaOklNSevNyrcqPZB7BXXnoME34ewrW3lKlZxRwch4nAH37Iu43x1kwcdK28EttAx
	ffGnv2wJcAjznEuK9waNmbmomtBZQlCfoN6lmQRlwEP6LJJ8f2u+bqqeL+34g311Q0YA+V4Rkwl
	Ylgsx+I4DU2Cy7QCDmbzhr+5AW3oN2L8X+qo1W
X-Received: by 2002:a17:902:e881:b0:2ae:5b52:3818 with SMTP id d9443c01a7336-2ae82367372mr161702475ad.8.1773153502352;
        Tue, 10 Mar 2026 07:38:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm200916045ad.92.2026.03.10.07.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:38:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 10 Mar 2026 07:38:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: bhelgaas@google.com, tglx@linutronix.de, jgross@suse.com,
	hans.zhang@cixtech.com, himanshu.madhani@oracle.com,
	roger.pau@citrix.com, chrisl@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: add iounmap in msix_capability_init()
Message-ID: <4fc6208d-513b-4f41-a13a-4a0829ab50ad@roeck-us.net>
References: <20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn>

Hi,

On Sun, Jan 25, 2026 at 10:44:52PM +0800, Haoxiang Li wrote:
> In msix_capability_init(), if msix_setup_interrupts()
> fails, call iounmap() to release the memory allocated
> by msix_map_region().
> 

AI review has the following feedback:

  In __msix_setup_interrupts(), `dev` is declared with the
  `__free(free_msi_irqs)` cleanup attribute. If an error is returned,
  pci_free_msi_irqs() is automatically called.

  pci_free_msi_irqs() already unmaps dev->msix_base and sets it to NULL:

  void pci_free_msi_irqs(struct pci_dev *dev)
  {
	...
	if (dev->msix_base) {
		iounmap(dev->msix_base);
		dev->msix_base = NULL;
	}
  }

  So if msix_setup_interrupts() fails, dev->msix_base has already been
  unmapped and is NULL by the time we reach this new error path.
  Is this extra iounmap() necessary?

I checked the code, and agree.

Thanks,
Guenter

> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/pci/msi/msi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 34d664139f48..e010ecd9f90d 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -737,7 +737,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  
>  	ret = msix_setup_interrupts(dev, entries, nvec, affd);
>  	if (ret)
> -		goto out_disable;
> +		goto out_unmap;
>  
>  	/* Disable INTX */
>  	pci_intx_for_msi(dev, 0);
> @@ -758,6 +758,8 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  	pcibios_free_irq(dev);
>  	return 0;
>  
> +out_unmap:
> +	iounmap(dev->msix_base);
>  out_disable:
>  	dev->msix_enabled = 0;
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
> -- 
> 2.25.1
> 
