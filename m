Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0C34A3D2;
	Fri, 27 Feb 2026 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210844; cv=none; b=O1eoKJE8KLMMvIJV6HjMo6ehcgp7ldhaoEfki5yLU/YnomCR8HtDitbJj6bMSZGNEiwSI4IN6Bc303xyjK9oYajMeRPm6BdM5nqq4v/QxMJn2Akr+jOUoNEAO0vqzBdtK7HKSq05F9foS+HGJVTccVEzGVxpwXfAUoHCyI5C9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210844; c=relaxed/simple;
	bh=Z+1TU3kJZMkZ4RM9rNBomIZGlqsz9DAH94NAcTheQRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ac3vo1yo3M9VcrUiB/+MMAPMyY88r2orrJ3PutWp5PY2FnLY7kMwdwhzPoharNy/2KDwCkKPi4sQLMkhCUDW8KibjWP2JTk9aS6fttKnusaAUCfdTxS6KqLSyMjoun6PqWrXqJTbh89U+nAbfYSMiRXQBoAJYvs14ROFiUinXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWM5xHLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWM5xHLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72CEC2BCB2;
	Fri, 27 Feb 2026 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772210844;
	bh=Z+1TU3kJZMkZ4RM9rNBomIZGlqsz9DAH94NAcTheQRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HWM5xHLT6ykgykdrx0PfdIurq6Agiwllvz2hZ4lGmTRO9PiZ5CHTbWQuvl5a0PB55
	 u/IY2MFv1C7+wvmck/6RdDn0em4v0yxoTkSTy9bAoaWrBLWdK943JwJ5pmB+PyVdgs
	 DGUAIntAkm5pH+SOv8GJRg+/95dVN/o7Dom9+HX6Ddaad/BtW1/Y5fWIL9tmmIJdY5
	 0RaPHacYztYLiA0r+n0rI0ZVElFhP/9If1m3rUzUJlsUKko/lsrpYFBKUB6h+hP2Kc
	 /2C0TzcP699aEWYIm0d/vQbjLhPPObEmRvl0BbsC3Q7H5UYFLHhQRYBw4MoWTVZAtT
	 Li4Njmwwlob+A==
Date: Fri, 27 Feb 2026 10:47:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Baruch Siach <baruch@tkos.co.il>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Correct PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 value
Message-ID: <20260227164722.GA3897909@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227123653.3891008-1-bhelgaas@google.com>

On Fri, Feb 27, 2026 at 06:36:53AM -0600, Bjorn Helgaas wrote:
> fb82437fdd8c ("PCI: Change capability register offsets to hex") incorrectly
> converted the PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 value from decimal 52 to hex
> 0x32:
> 
>   -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 52      /* v2 endpoints with link end here */
>   +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 0x32    /* end of v2 EPs w/ link */
> 
> Change PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 to the correct value of 0x34.
> 
> fb82437fdd8c was from Baruch Siach <baruch@tkos.co.il>, but this was not
> Baruch's fault; it's a mistake I made when applying the patch.
> 
> Fixes: fb82437fdd8c ("PCI: Change capability register offsets to hex")
> Reported-by: David Woodhouse <dwmw2@infradead.org>
> Closes: https://lore.kernel.org/all/3ae392a0158e9d9ab09a1d42150429dd8ca42791.camel@infradead.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this to pci/for-linus for v7.0.

Per David, it fixes a VMM issue with PCI capabilities.

> ---
>  include/uapi/linux/pci_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ec1c54b5a310..14f634ab9350 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -712,7 +712,7 @@
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>  #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
>  #define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
> -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
> +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x34	/* end of v2 EPs w/ link */
>  #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>  #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
>  #define PCI_EXP_SLTCTL2		0x38	/* Slot Control 2 */
> -- 
> 2.51.0
> 
