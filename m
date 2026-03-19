Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39AD376483
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934510; cv=none; b=qh9G6/ceVTfKsfVuox7u6ulSewUOlwe2fmP6wovhP8deOSr9oQdBkM7CBrHMBnFnWt9KF4WJETT/5I4r6/X2HLP53sBOdRraHTAnhxiweKKMR+cuSJR0OsRInrJSD9kQh50SjqrwEAHJzw+bhYot9zzV/89UZry7pkJ2/GoM6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934510; c=relaxed/simple;
	bh=GpRwsC+66JVFUE4Jzuo9pIPJ1uSAVJ1xxRIa4+V+jHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSma/TQSBGdp6lrYCAorj8ymTinVpaxjtjxCizSmaPeAlIFMKAYbhRgdIg52fqRm/3XINfqGN0gplxLLdvCKzKxmY6dVdY2VGUClm2y6H/V03VUptm2OTv6J/10Pmd/AqC8pywR0JljXZIF2sbw7wycY+fohNf6Bxy4HQeRnCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C8itvgcO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C8itvgcO"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E188C40E0213;
	Thu, 19 Mar 2026 15:35:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FFr-ULL3GbO0; Thu, 19 Mar 2026 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773934497; bh=85/6ZPlc66BwoOzLj+Ef2UIrPcY8h6y+5Q7xovIDhiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8itvgcOC/9YK0oylJsq4E3C326U94rEOU+2jhSdvFiZAoL7HfJ4HjKsE2JyR6SqE
	 MEJbN+X6rUwkVRMh/su2/o+RLP3m1khQAigIk1p1dym8LeeAqzimRTK3lQYJappQH1
	 TA5LF7ILl3ETV3cMnGgdVd0T0rWIsk3b2PwbOP31v18AJSAtdFnN7H/VcAcrpi3KGL
	 lehlGcmwqDuasEKoIdwCvrSCZujYSxI2tjavO6DqVK5flLr5dJCSiDhig09ZG5A+kf
	 ObdFF83pC42ZvUaa/PZqp85DEqUNtPgUFwCuYNExOa+17nCD0rxo08SzuXV+jxFkjj
	 sihN1hJQrBGEXtpwT7kixyi+gzSsSsPz/hzROHGfGE7mcs3e5/kGHUKw54ure9VgIz
	 A4I+lHAT5fW3L0raZc86KL0dYf+Jehp+7K9gCwWTHpKQyyhZNb1UgxJb91BwUKTTy0
	 2FSF1iQfYuUh2yL5VTZEkJHGoXzLAgwxGnsNz0glcN+9dYYIS0gXXJtwmEdlEzZTz4
	 8jmRs0wzfP9VIkU2e4/QuOhXbYPN8nN9+zWXCOgH8WwYDcargwhpGbfKUoxdohbpRM
	 r0anEaHPnp4wYqBSTQS155RfsZzWQcRRDj3ijyi7Sjr21QdZocWCN4G0I3RiDD6nca
	 3aiZo9g3BOG7LnA6e5B1agPI=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5FAC040E0220;
	Thu, 19 Mar 2026 15:34:39 +0000 (UTC)
Date: Thu, 19 Mar 2026 16:34:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, jgg@nvidia.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 12/19] x86, ioremap, resource: Support
 IORES_DESC_ENCRYPTED for encrypted PCI MMIO
Message-ID: <20260319153432.GWabwXiCXePN7G8wz8@fat_crate.local>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-13-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-13-dan.j.williams@intel.com>

On Mon, Mar 02, 2026 at 04:02:00PM -0800, Dan Williams wrote:
> PCIe Trusted Execution Environment Device Interface Security Protocol
> (TDISP) arranges for a PCI device to support encrypted MMIO. In support of
> that capability, ioremap() needs a mechanism to detect when a PCI device
> has been dynamically transitioned into this secure state and enforce
> encrypted MMIO mappings.
> 
> Teach ioremap() about a new IORES_DESC_ENCRYPTED type that supplements the
> existing PCI Memory Space (MMIO) BAR resources. The proposal is that a
> resource, "PCI MMIO Encrypted", with this description type is injected by
> the PCI/TSM core for each PCI device BAR that is to be protected.
> 
> Unlike the existing encryption determination which is "implied with a
> silent fallback to an unencrypted mapping", this indication is "explicit
> with an expectation that the request fails instead of fallback".
> IORES_MUST_ENCRYPT is added to manage this expectation.

"Add IORES_MUST_ENCRYPT to manage... "

Pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details. Especially the
part about ordering the code to do stuff.

> Given that "PCI MMIO Encrypted" is an additional resource in the tree, the
> IORESOURCE_BUSY flag will only be set on a descendant/child of that
> resource. That means it cannot share the same walk as the check for "System
> RAM". Add walk_iomem_res_desc() to check if any IORES_DESC_ENCRYPTED
> intersects the ioremap() range and set IORES_MUST_ENCRYPT accordingly. When
> IORES_MUST_ENCRYPT is set, the entire ioremap() range must be covered by
> IORES_DESC_ENCRYPTED.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/ioport.h |  1 +
>  arch/x86/mm/ioremap.c  | 49 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 1c106608c514..3efd07443c47 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -152,6 +152,7 @@ enum {
>  enum {
>  	IORES_MAP_SYSTEM_RAM		= BIT(0),
>  	IORES_MAP_ENCRYPTED		= BIT(1),
> +	IORES_MUST_ENCRYPT		= BIT(2), /* disable transparent fallback */
>  };
>  
>  /* helpers to define resources */
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 12c8180ca1ba..0f300e226a9f 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -36,6 +36,7 @@
>   */
>  struct ioremap_desc {
>  	unsigned int flags;
> +	u64 encrypt_size;
>  };
>  
>  /*
> @@ -88,23 +89,35 @@ static unsigned int __ioremap_check_ram(struct resource *res)
>  }
>  
>  /*
> - * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
> - * there the whole memory is already encrypted.
> + * In a encrypted guest, NONE and RESERVED should not be mapped encrypted

"In an encrypted... "

> + * because there the whole memory is already encrypted.
> + *
> + * For the encrypted case the entire range must agree with being mapped
> + * encrypted.
>   */
> -static unsigned int __ioremap_check_encrypted(struct resource *res)
> +static unsigned int __ioremap_check_encrypted(struct ioremap_desc *desc,
> +					      struct resource *res)
>  {
> +	u32 flags = 0;
> +
> +	if (res->desc == IORES_DESC_ENCRYPTED)
> +		flags |= IORES_MUST_ENCRYPT;
> +
>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return 0;
> +		return flags;
>  
>  	switch (res->desc) {
>  	case IORES_DESC_NONE:
>  	case IORES_DESC_RESERVED:
>  		break;
> +	case IORES_DESC_ENCRYPTED:
> +		desc->encrypt_size += resource_size(res);
> +		fallthrough;
>  	default:
> -		return IORES_MAP_ENCRYPTED;
> +		flags |= IORES_MAP_ENCRYPTED;
>  	}
>  
> -	return 0;
> +	return flags;
>  }

This looks too convoluted. I'm sure we can state the rules for encrypted
ranges first and then can simplify it into something more understandable.

>  
>  /*
> @@ -134,14 +147,10 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
>  {
>  	struct ioremap_desc *desc = arg;
>  
> -	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
> -		desc->flags |= __ioremap_check_ram(res);
> -
> -	if (!(desc->flags & IORES_MAP_ENCRYPTED))
> -		desc->flags |= __ioremap_check_encrypted(res);
> +	desc->flags |= __ioremap_check_ram(res);
> +	desc->flags |= __ioremap_check_encrypted(desc, res);
>  
> -	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
> -			       (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
> +	return 0;
>  }

This change I don't grok. Perhaps it needs to be a separate patch.

>  /*
> @@ -162,6 +171,13 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>  	memset(desc, 0, sizeof(struct ioremap_desc));
>  
>  	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);

<---- newline here.

> +	/*
> +	 * Encrypted MMIO may parent a driver's requested region, so it needs a
> +	 * separate search
> +	 */
> +	desc->encrypt_size = 0;
> +	walk_iomem_res_desc(IORES_DESC_ENCRYPTED, IORESOURCE_MEM, start, end,
> +			    desc, __ioremap_collect_map_flags);

Why is this here and executed unconditionally regardless of coco guest or not?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
