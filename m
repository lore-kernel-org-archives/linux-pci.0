Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89047AF4D;
	Tue, 30 Jun 2026 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852240; cv=none; b=SGLdKXGKs8wRNoZ1GmOCZ8ZmxEHXWpjm4VPhBY0l40CGo7H76Vx0oPWNtJEt74+GILhbDoYfXdlYbRE+mrDeSUlkfqGbdcWi71/+nuvUvxO6LQ/wGMzo89rHPd8ZwUsevogvZtGCHxLqhA7ydE55W3zU1sSkAh1ls9FcuPinRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852240; c=relaxed/simple;
	bh=Y/mQNBBL9ekkO0NSwMOK/ItMT+NyqTIFkINJHs9a1FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwLZt2QSfpTqwAfnTTMdvwvSSXZEjUjw5ecyY7BNrNsrDSnbq+WK5Dsxv6/1GscXbR4U31Nyc0MmHx9IY28sTyiEGe4UQJHd9d0JCnC/BZV9aoD+2sPlwPJucI/I2/yZXIXZ8+ebGsLmzeC+RFLDit9ejo4/7zPgxNbhSWn/CCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYRL/gV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYRL/gV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC91F000E9;
	Tue, 30 Jun 2026 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782852238;
	bh=qJctOZYSocb2Bl3ajpsiYrPprlPzhus3FVE7HaYQr/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VYRL/gV6jzD0Tvv8iNjh3s2W73aT2ccsP9BRigaZra7/EMHSME5u3DQLVo+IPThDt
	 Fx7WpP7ef2J6Jp+rzOFqS93OC+eYUrCI4dNH1XDWBd9SnEXoHgmcwwmi0FZQeTwGkF
	 +4jlOVqMnI3mO8o5ymLlPSjkw3V4SAorJ5TERM66jM0NBdA5ye++POBPXP9WXQfYPg
	 0q+5Y6BZibxI7qdNR71FqdPzw/A1g3kP0GDBmkKnF985fig4ix5l14D08EDrfh1moz
	 3SUV5wX29WbITpf6/aCRcUG3IKAQw2CdrB6xv1boQATXfcbkpzsnM0pAAnZfE3fYQk
	 2L24yBO5KoKFQ==
Received: by pali.im (Postfix)
	id D6D63A1B; Tue, 30 Jun 2026 22:43:54 +0200 (CEST)
Date: Tue, 30 Jun 2026 22:43:54 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Martin Mares <mj@ucw.cz>, David Matlack <dmatlack@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] sysfs: Include bridge window address size flags
Message-ID: <20260630204354.64yldlle37b6k462@pali>
References: <20260626213047.189951-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626213047.189951-1-bhelgaas@google.com>
User-Agent: NeoMutt/20180716

On Friday 26 June 2026 16:30:47 Bjorn Helgaas wrote:
> sysfs_get_resources() fills d->base_addr[] with CPU addresses of PCI BARs
> (the CPU addresses in sysfs 'resource' differ from the BARs when a host
> bridge applies an offset between CPU and PCI addresses).
> 
> 119c1376f9ca ("libpci: Add support for filling bridge resources") fills
> d->bridge_base_addr[] for bridge windows, but unlike for d->base_addr[], it
> did not include the low-order four bits of 'flags'.  For I/O windows, those
> bits indicate 16- or 32-bit addressing; for prefetchable memory windows,
> they indicate 32- or 64-bit addressing.
> 
> ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if range behind
> bridge is disabled or unsupported") tests the d->bridge_base_addr[] flag
> bits to learn those properties, but since they weren't included by
> 119c1376f9ca, 32-bit I/O windows were labeled as "[16-bit]" and 64-bit
> prefetchable windows were labeled as "[32-bit]".

Is not an issue that lspci.c is looking for flags in ->bridge_base_addr[] ?
For me it seems to be better to look for flags in ->bridge_flags[] member.

> Previous output of "lspci -v" on a bridge:
> 
>   I/O behind bridge: 2000-2fff [size=4K] [16-bit]
>   Prefetchable memory behind bridge: 48030000000-480401fffff [size=258M] [32-bit]
> 
> Similar output after this commit:
> 
>   I/O behind bridge: 00002000-00002fff [size=4K] [32-bit]
>   Prefetchable memory behind bridge: 0000048030000000-00000480401fffff [size=258M] [64-bit]
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  lib/sysfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/sysfs.c b/lib/sysfs.c
> index 55ac7a6f0699..77ab99e2d5d2 100644
> --- a/lib/sysfs.c
> +++ b/lib/sysfs.c
> @@ -219,11 +219,14 @@ sysfs_get_resources(struct pci_dev *d)
>  	}
>        if (i == 7+4 || i == 7+6+4)
>  	{
> +	  unsigned long long flags;
>  	  int offset = (i == 7+6+4) ? 6 : 0;
>  	  for (i = 0; i < 4; i++)
>  	    {
> -	      d->bridge_flags[i] = lines[offset+i].flags;
> -	      d->bridge_base_addr[i] = lines[offset+i].base_addr;
> +	      flags = lines[offset+i].flags;
> +	      d->bridge_flags[i] = flags;
> +	      flags &= PCI_ADDR_FLAG_MASK;
> +	      d->bridge_base_addr[i] = lines[offset+i].base_addr | flags;
>  	      d->bridge_size[i] = lines[offset+i].size;
>  	    }
>  	  have_bridge_bases = 1;
> -- 
> 2.53.0
> 

lib/pci.h says:

  pciaddr_t bridge_base_addr[4];	/* Bridge base addresses (without flags) */
  pciaddr_t bridge_size[4];		/* Bridge sizes */
  pciaddr_t bridge_flags[4];		/* PCI_IORESOURCE_* flags for bridge addresses */

And at least two backends (sysfs.c and win32-cfgmgr32.c) are filling the
bridge_base_addr[] without flags.

So I would prefer to change lspci.c code instead to look for flags into
the flags field. Otherwise other backends and documentation in pci.h
would be inconsistent with sysfs.
