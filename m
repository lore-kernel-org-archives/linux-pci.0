Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172E4334BC;
	Fri, 21 Aug 2026 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353582; cv=none; b=Zujjejprw/G6IgfmMIzYOUdgvz0ZmolNDdXBBJszAApEUx2P8yFpgtQqs47dbdtnEZ1gDaQ/vqwkTKJ91Eu9DGyPpxjmLoghnrXkLOL1ZDyYG0oE17UFPk6kV1FTfDvfOJNhuPyYhgTdp+0Fk+K3zLk8jc4oEbBJtAry8xjYm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353582; c=relaxed/simple;
	bh=qG3n9vKkNSRL8eeNqJq13NMXAZZjoKvhqnHjgh2JWbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbeojzfBmL5PEgyWt7lthUgE2aa/2qrEx7iv8UnY5xGWXoJBUSZQPSgNqrhJ0xR/EI/6gFs1B/0kbdXC0zGfZPwkoNQRc8K4LdkiWlgo6HnoB1cBYwTMU7wBL9FwDTUUQilz6IcVzAHGVCF8P+DXPj75vowIlR9hTfaV9V29fuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxMjWPQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxMjWPQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387881F000E9;
	Fri, 21 Aug 2026 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787353580;
	bh=Os5bRR0gm6+JdhtuPgirxhf4CoPDXI815ZjhWldT69U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FxMjWPQftpxtxledm14EiDSRFPIQ4PUpuzdMrEtHr5HGqzt7tr6eMiggkZdaXV5xh
	 75lbawTKQXW4hKnWhl0o6IjQKwRAiMaI3ytAU3Z/zM+7DKEhXXxPshk2U0BSUJmPdz
	 ncBYIsFcg4k51OGwlV3kJP0LfCh4j4FbOHcBNhRqnjqhXq59GT66WLuP5Yhw6GB3Ee
	 GHBBpiTx73mZy++QoftzqwUTkUDFbeWnJqZosHi2ZVQopqmS37JQ5xfOCjmEdlwbMs
	 tnTaOk0+JEMZsfuNf3G9zqUsAeYWHVJWOjT2NiD6+W1h0lQdpdsemOwVa68eEXLgpK
	 k+OdpOR/5MXvQ==
Received: by pali.im (Postfix)
	id 1EA1E89E; Sat, 22 Aug 2026 01:06:20 +0200 (CEST)
Date: Sat, 22 Aug 2026 01:06:20 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pciutils PATCH v2] lspci: Determine bridge window address size
 from bridge_flags
Message-ID: <20260821230620.fcpmn7radmwnfnh2@pali>
References: <20260821221610.3570722-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821221610.3570722-1-dmatlack@google.com>
User-Agent: NeoMutt/20180716

Hello! Thank you for taking this issue. I briefly checked the change and
I think that this is the right way how to address that issue.

Anyway, it would be nice to provide some example of config space of PCI
Bridge (lspci -x) which is affected by this issue and have it in
pciutils/tests/ directory.

On Friday 21 August 2026 22:15:59 David Matlack wrote:
> Use bridge_flags to determine address size bits (16- vs 32-bit for I/O,
> 32- vs 64-bit for prefetchable memory) when displaying bridge ranges
> populated via PCI_FILL_BRIDGE_BASES.
> 
> Commit ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if
> range behind bridge is disabled or unsupported") introduced code in
> show_htype1() that reads PCI_IO_RANGE_TYPE_MASK and
> PCI_MEMORY_RANGE_TYPE_MASK from bridge_base_addr[]. However,
> bridge_base_addr[] holds base addresses without flags, as documented in
> lib/pci.h and implemented across backends like sysfs.c and
> win32-cfgmgr32.c.
> 
> Because bridge_base_addr[] does not contain configuration register flag
> bits, masking the lower bits evaluates to zero. As a result, 32-bit I/O
> windows are mislabeled as "[16-bit]" and 64-bit prefetchable memory
> windows are mislabeled as "[32-bit]" when using PCI_FILL_BRIDGE_BASES.
> 
> Fixes: ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if range behind bridge is disabled or unsupported")
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> v2:
>  - Fix lspci.c to use bridge_flags[], per lib/pci.h, rather than
>    changing the behavior of just the sysfs backend (Pali Rohár)
> 
> v1: https://lore.kernel.org/linux-pci/20260626213047.189951-1-bhelgaas@google.com/
> 
>  lspci.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/lspci.c b/lspci.c
> index 2a14303e74f6..52fd9247aefb 100644
> --- a/lspci.c
> +++ b/lspci.c
> @@ -571,10 +571,9 @@ show_htype1(struct device *d)
>  
>    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !io_disabled)
>      {
> -      io_base = p->bridge_base_addr[0] & PCI_IO_RANGE_MASK;
> +      io_base = p->bridge_base_addr[0];
>        io_limit = io_base + p->bridge_size[0] - 1;
> -      io_type = p->bridge_base_addr[0] & PCI_IO_RANGE_TYPE_MASK;
> -      io_bits = (io_type == PCI_IO_RANGE_TYPE_32) ? 32 : 16;
> +      io_bits = (p->bridge_flags[0] & PCI_IORESOURCE_IO_16BIT_ADDR) ? 16 : 32;
>        show_range("\tI/O behind bridge", io_base, io_limit, io_bits, io_disabled);
>      }
>    else if (io_type != (io_limit & PCI_IO_RANGE_TYPE_MASK) ||
> @@ -600,7 +599,7 @@ show_htype1(struct device *d)
>  
>    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !mem_disabled)
>      {
> -      mem_base = p->bridge_base_addr[1] & PCI_MEMORY_RANGE_MASK;
> +      mem_base = p->bridge_base_addr[1];
>        mem_limit = mem_base + p->bridge_size[1] - 1;
>        show_range("\tMemory behind bridge", mem_base, mem_limit, 32, mem_disabled);
>      }
> @@ -616,10 +615,9 @@ show_htype1(struct device *d)
>  
>    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !pref_disabled)
>      {
> -      u64 pref_base_64 = p->bridge_base_addr[2] & PCI_MEMORY_RANGE_MASK;
> +      u64 pref_base_64 = p->bridge_base_addr[2];
>        u64 pref_limit_64 = pref_base_64 + p->bridge_size[2] - 1;
> -      pref_type = p->bridge_base_addr[2] & PCI_MEMORY_RANGE_TYPE_MASK;
> -      pref_bits = (pref_type == PCI_PREF_RANGE_TYPE_64) ? 64 : 32;
> +      pref_bits = (p->bridge_flags[2] & PCI_IORESOURCE_MEM_64) ? 64 : 32;
>        show_range("\tPrefetchable memory behind bridge", pref_base_64, pref_limit_64, pref_bits, pref_disabled);
>      }
>    else if (pref_type != (pref_limit & PCI_PREF_RANGE_TYPE_MASK) ||
> 
> base-commit: b41ce14da749fb44ca7940ba9797027bfa62c23e
> -- 
> 2.55.0.766.g2966f0265a-goog
> 
