Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3AD3D093F
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681738; cv=none; b=lcx3gckn66KJwD27uypM0ZdnU7UtoEq9jSnfYpTFWYl+AIeHGI6wKss+lbM8qaNXrR+KIDfsexL2TQWytkyMtuXwkmI/4XoUy1mQ6UhtbGcfbpcBcxhkmXYlaU+KpbsBd2Omdx9/SRrsvAi9bYfz7b6xPztXDa6hxE96nu9i2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681738; c=relaxed/simple;
	bh=H8t5YEnICOpSsT2ERpsq3rX2bQWH81XTh0Q4JzBgHVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+6LpItRJvbIS0GL93v1NeWmAjMTmB6FYe/QK8w5gzTgjH1Nekv6x9jK9J5e4KXgcAhXYXY3k5XQTh+h7lQ2+X2/XJGhDVWwZtliBOPofj7QuyZegVbJRBw3TioRRw0XDK0e3UGGZfAko3PdecQa1JS9OAb2B4tQHu5wfui3jvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/fgp7ZU; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/fgp7ZU"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-127380532eeso6818796c88.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681736; x=1774286536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OX1FONaTc0mJuFdOB10CRw5D/qrtlfT+txQDt48t6yQ=;
        b=P/fgp7ZUeNRV4Cj+ea4tpSrEiGW8IBqbaMnQXs4JjLOPxunV5nDpP7dZ+f2oj+evFh
         TxQDjvoQQQUXnLUDGrpb8vTidWM41l0DvT7kVMn1u5adX2ow2byjOVvU0ZcVugtAth/i
         pj3vil+Rd3zmtV3caPaI5UbFiLYhSUPQxrW6uFYMLCcWWyvpmYrytjjojL0gg4G2b2iy
         A+1MDLSBiWeDorXGog1Buz8YxNQ40xFxCXQxEt4bUy/5BSF2gigYQxiQRxb2lEMjNh9W
         ORcqRqhqpng7QezsXiUgzHWi2EcoaT/MX5PjDUie95xzrM/+5fQ0dNsfB8gJ/ZAsnvrd
         x+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681736; x=1774286536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OX1FONaTc0mJuFdOB10CRw5D/qrtlfT+txQDt48t6yQ=;
        b=AIIqqxZUXoX4EVOMK2nfbChqlnbdM7AcJNaGfnraAYCJSMIInk2cMGgS41cW/EFNC4
         Xs36j8/lVLWm64Lp4uRq8keNPV7Oj8PvpO2C5qjWPP5N1DMx7iDbToHePcWoh2Tbo6f5
         xFpPiAixsugCGwAi+oPaa6PbWhRsul47P8P7bwJ1jTg5kZYvammCPigKt3eaK2PFqK8u
         JuqdXt1qCo1P0FERhd88sfKcxdMf+Rq4bIB326xL6TmgsFmktWqpKtdCoGPXaLEe48ca
         Te/jHR+f1PEP1P8VGcWB/IkU3iS/4CFZkMO78TIQuhsYi9wkOAJ7L373TS61TO5iUiWg
         aFYA==
X-Forwarded-Encrypted: i=1; AJvYcCXi/+l39cFNwa5JtH3Adz/o6yeW0p6V1DQuQKaUDGARt4/cpkXNzAm+gq+XRlUEq6llhdNvGbrzNSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3HlDtOohG8Ux3R1MaGYap+cRaXN9QB/NuBYvGoSUk7BEyztn
	ut1e8OE/BBEJzj4o2hkSheNh6kRmEQtkrVUBEyHHfviyyQQb1Sh5RpWo
X-Gm-Gg: ATEYQzyBqOV6ysUse3HYsgsZlazyeTwKZuNyka8zbvznFwSSxv34a6nIIkbrBIzOyvq
	lJJUy5H3Q70XnpiwI7/wyR3KLdUyUPfOuCRDZNQp0z4DOtqnJVN/zTmm9K9XQuWOuxgR0yUOmHT
	WKI3+bwAU2ARamdBeN9/g7XvFAO6jzh8Fmmw4aIh1M3bcviaPJyuOoS0POR4eaR1nI1wePwL0tK
	N7OmsBt9dG1407B4nekTtmxyKRJJvHkJQ8ZV4Gsy/02Vj8DgPyhiMV/Ve1ha0HAsJ9miBhCYTBv
	VrDQqhwvKNq4wtYSZ0E8rfWLojK4QGlNA26Yq18GnygQ2undrt79pAD6SwhWw66l+0H6q44cS/m
	CI40uI9unB4ppAj9QF+N37kuwWxUQX3xKifFlRh/cEyRgDP4/wj2TbAUw7LXcoqlFyjwPuMJYJQ
	KIxR21I1u7U+QqaPu4Gh7QFHfqHilu26grFRjSmHsqQMvglD8=
X-Received: by 2002:a05:7022:41a6:b0:11f:3483:bba6 with SMTP id a92af1059eb24-128f3d4aaa4mr5869223c88.13.1773681735077;
        Mon, 16 Mar 2026 10:22:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab57588asm16144029eec.31.2026.03.16.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:22:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Mar 2026 10:22:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: bhelgaas@google.com, tglx@linutronix.de, jgross@suse.com,
	hans.zhang@cixtech.com, himanshu.madhani@oracle.com,
	roger.pau@citrix.com, chrisl@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: add iounmap in msix_capability_init()
Message-ID: <b9705904-401b-4698-b0df-c84ef2b1e948@roeck-us.net>
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
Really ? AI review provided the following feedback. Looking into the code,
I think it has a point.

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

Does msix_setup_interrupts() already unmap this region? If it fails,
msix_setup_interrupts() calls pci_free_msi_irqs(), which appears to already
call iounmap(dev->msix_base) and sets dev->msix_base to NULL.

>  
>  	/* Disable INTX */
>  	pci_intx_for_msi(dev, 0);
> @@ -758,6 +758,8 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  	pcibios_free_irq(dev);
>  	return 0;
>  
> +out_unmap:
> +	iounmap(dev->msix_base);

If dev->msix_base was already set to NULL by pci_free_msi_irqs() during the
msix_setup_interrupts() error path, does this result in iounmap(NULL)?

>  out_disable:
>  	dev->msix_enabled = 0;
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
> -- 
> 2.25.1
> 
