Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990A37C11E;
	Fri,  8 May 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281680; cv=none; b=cttlnRZf8o3LlC1k5zvbIeiKTlULPPjvp31GQ3gA6OOXtK9/jaceGVdNyCulxgizqkcGqM/zofpvM9S1x0YPlCElpuCmhawhxNXzFzsmljfbwLXIJSkpCIANEOIWY/rLITZCLLDE3ElrFvs+Fp2ianNCJqT0OFlBpp3GkSKjtYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281680; c=relaxed/simple;
	bh=kKuPOJ7nUnOEEIojrtLQ9x3wl9iYtJYU7Rqb3o04EvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GKQg+tPUXs5a3h851HxfL1rTkQSC/1mS6yavREc7puJDre/GjpvBpi5Qsc4QyDV+QRoP/99gQ8vkBviNLXhsvD594uJOuNrJpjnO4QqpscA8of4Hom5r/LRccH2hN6g14whhiMJLok1GKMI9OliI9r0YZr6a5IgG/ByS30ihPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYaEi4xY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYaEi4xY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36128C2BCB0;
	Fri,  8 May 2026 23:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281680;
	bh=kKuPOJ7nUnOEEIojrtLQ9x3wl9iYtJYU7Rqb3o04EvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RYaEi4xYBEOuA5uXAcvKDv4TWKj8NrjAz0k6r0Mw572P7enUeZpAfzxmRTXV1/ouL
	 TpOzgYxSKj0CwZ6GKw16/vZQHxNRtqCmzOpD3OmO8ACim9jJGp2g2u4N05lyAUhL3h
	 QHNj9wzK2QNAKK2orCBHfTiqHlJ3p5s+0NBjkDhfHAJC7xUpSqaftL2qfoY7tdU8Yb
	 z3Afej5m4AXAM/a4F5iT5j5cFmgwm7UwcDH1ySOarsvdlpwylfvWWAPxoUXzMb1+tZ
	 1Sx2Xj8p14sCTeW61Rx+4wvK1gJMMvi4N6ZkCYkpkQPAYlPkNbRvWsu7T2z9kVpDYy
	 4wGKLPHvXbR+w==
Date: Fri, 8 May 2026 18:07:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: sashiko@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 15/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
 and __legacy_mmap_fits()
Message-ID: <20260508230758.GA30814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508045824.GA3160093@rocinante>

On Fri, May 08, 2026 at 02:04:57PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > >  static int __legacy_mmap_fits(struct pci_controller *hose,
> > >  			      struct vm_area_struct *vma,
> > > -			      unsigned long res_size, int sparse)
> > > +			      unsigned long res_size)
> > 
> > This isn't a bug, but since the WARN() statement that used hose->index was
> > removed below, is the hose parameter still needed? It appears to be completely
> > unused in the function body now.
> 
> Ah, yes, darn.  Forgot to remove this one, too.  A quick fix:

I squashed this in, but you should double-check it because it didn't
apply cleanly.

> diff --git i/arch/alpha/kernel/pci-sysfs.c w/arch/alpha/kernel/pci-sysfs.c
> index 7dae4999c5e3..94dbc470cd6c 100644
> --- i/arch/alpha/kernel/pci-sysfs.c
> +++ w/arch/alpha/kernel/pci-sysfs.c
> @@ -143,8 +143,7 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev, int num)
>  
>  /* Legacy I/O bus mapping stuff. */
>  
> -static int __legacy_mmap_fits(struct pci_controller *hose,
> -			      struct vm_area_struct *vma,
> +static int __legacy_mmap_fits(struct vm_area_struct *vma,
>  			      unsigned long res_size)
>  {
>  	unsigned long nr, start, size;
> @@ -179,7 +178,7 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
>  	if (sparse)
>  		res_size <<= 5;
>  
> -	if (!__legacy_mmap_fits(hose, vma, res_size))
> +	if (!__legacy_mmap_fits(vma, res_size))
>  		return -EINVAL;
>  
>  	return hose_mmap_page_range(hose, vma, mmap_type, sparse);
> 
> Which can be applied/squashed later.
> 
> Thank you!
> 
> 	Krzysztof
