Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5422FFF88;
	Fri,  6 Feb 2026 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417461; cv=none; b=is5Rw7N1C6Ct+1fxX2Yu5h1bDZ49JMs+WI9tP/IBgWyWRXH1nA6Xgm2MWzz/DoWmbciOFW9Wce0Uuuk/FMw/ep7iH6qeykC3UsEQaIQ2QC1p14XC56YpEQrSRSSYTqWBLBaqt1NaU2hh5kUHhN/pqDGZqV59MFDcJkuyqy3CTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417461; c=relaxed/simple;
	bh=o6/vR8WiCaoccXmYQyVh9hsWgYf4wtIKhgtQoJBeMgo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ay/Q972ZSsu6ykSdOcasNK8VrXyO72u+MrgTlix/KIxRCJOweaiPiiIO1KCPV8ay+VsPZuRdiJztaKizkKy04e1CeuMd3ROS/LBL7KlGZhgp/cxqdb7N+PhRP3Fc7Z3MZX4pZ0DzPwp94eeJpPq1AkHz2DB9Npw5uWkC8qplOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6AuHYtw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6AuHYtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD28C116C6;
	Fri,  6 Feb 2026 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770417461;
	bh=o6/vR8WiCaoccXmYQyVh9hsWgYf4wtIKhgtQoJBeMgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q6AuHYtws7xgK4yC/XVd8U58qM0YYWsOnj47zvRvVM++bfwCUlCQqElMSVHe5lJHz
	 HZjZlFG8rbZlAKa6dM2ZR9xq6zeOQ5UAFZ4zdT+OJHhygtNu0snTD0V/ALwOC6Nkjf
	 IHi7+bEtKVj6SgnRsC6Wd7ADmyfVcaM6rehRDEvk/yRMXlyBUQ2r1WPwO2sTkYj7a6
	 N+MmdJ1gtNE5TUQQMaONR0wvg2X+Acpowb8u1qJQAY7htJL4gdymdeqY2E+mHwLEGC
	 dBmz9pZLquxNiAH89hXdllc5tYdZSj1NGIcGGh+LLoLyC65SM1t5TtxLlYtnGWoqbQ
	 5DEKQRk9XoA1w==
Date: Fri, 6 Feb 2026 16:37:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: bhelgaas@google.com, tglx@linutronix.de, jgross@suse.com,
	hans.zhang@cixtech.com, himanshu.madhani@oracle.com,
	roger.pau@citrix.com, chrisl@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: add iounmap in msix_capability_init()
Message-ID: <20260206223739.GA99172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn>

On Sun, Jan 25, 2026 at 10:44:52PM +0800, Haoxiang Li wrote:
> In msix_capability_init(), if msix_setup_interrupts()
> fails, call iounmap() to release the memory allocated
> by msix_map_region().
> 
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

Maybe Thomas has already applied this, and if not, he should chime in.

Personally, I would prefer if msix_map_region() were renamed and made
to return the phys_addr instead of returning the ioremapped address.
That way both the ioremap() and the iounmap() on failure would be in
msix_capability_init() so it's easier to review.

>  out_disable:
>  	dev->msix_enabled = 0;
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
> -- 
> 2.25.1
> 
