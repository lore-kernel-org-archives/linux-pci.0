Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3B3E762F;
	Wed, 29 Jul 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336038; cv=none; b=jpUr9F1iyAo6llvMBn8xtqnY+8iuRTurbRcuPh4J3LcRouZ95phHahCXLwV5zVJD8F3pUFxoqo8fC2PWtT24R1zY5iptVabE7lrGhQ/428Pa8O2ZRXo6GN7KEutEH/SlaIcNm7UpSvu9ozhcZxTiMYVqhAiJ+wnPsM60bFIWbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336038; c=relaxed/simple;
	bh=YMR6eDXQiiiWnxu+pSROFWZ8FUV1YDjbvoxMz2LocYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8mMVmegFnBISZrAlsQogM0KjT8cheroMzNlxR0Hg/f4z93j5OOKtxwHLX9J2yazGE4ER+g3nzLcyb+Jk1l5k3cF4Oziyu4EQCsjQPffkm/4kRQxeK+cKv0Hs/vy34xp21GSWws+Tmi7ogt5x0ACFmMP8qLi1A96lTcQX/NlSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id C6A1010616;
	Wed, 29 Jul 2026 16:40:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AB6E8602E834; Wed, 29 Jul 2026 16:40:29 +0200 (CEST)
Date: Wed, 29 Jul 2026 16:40:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org
Subject: Re: [PATCH] PCI: Allow D3 for native Hotplug capable Root Ports on
 DT platforms
Message-ID: <amoQ3SNpnLr3zb37@wunner.de>
References: <20260729071514.859778-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729071514.859778-1-manivannan.sadhasivam@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 09:15:14AM +0200, Manivannan Sadhasivam wrote:
> Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
> prevented native Hotplug capable Root Ports from entering D3 citing issues
> on old Intel SkyLake Xeon-SP platform.
> 
> But there is no reason to restrict D3 for native Hotplug capable Root
> Ports on DT platforms. We recently enabled D3 on non-Hotplug capable
> Root Ports on non-x86 platforms (specifically for DT platforms) in commit
> a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
> do the same for native Hotplug capable Root Ports as well.
> 
> To honor the above platform_pci_bridge_d3() check, allow passing this check
> only for DT platforms, unlike a5fb3ff63287, which used !CONFIG_X86 check.

platform_pci_bridge_d3() acts as a "whitelist check":  If it returns true,
the port is allowed to go to D3hot/D3cold.  If it returns false, the
subsequent checks in pci_bridge_d3_possible() are free to decide the
port's fate as far as D3hot/D3cold allowance is concerned.

Thus, I don't think you need to worry about "honoring" a "false" return
value of platform_pci_bridge_d3().  (If I understand your commit message
correctly.)

> +++ b/drivers/pci/pci.c
> @@ -3020,11 +3020,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return true;
>  
>  		/*
> -		 * Hotplug ports handled natively by the OS were not validated
> -		 * by vendors for runtime D3 at least until 2018 because there
> -		 * was no OS support.
> +		 * Do not allow D3 for native Hotplug ports on non-DT platforms
> +		 * as they were not validated by vendors for runtime D3 at least
> +		 * until 2018 because there was no OS support.
>  		 */
> -		if (bridge->is_pciehp)
> +		if (bridge->is_pciehp && !of_have_populated_dt())
>  			return false;

And so I'm wondering whether:

+		if (IS_ENABLED(CONFIG_X86) && bridge->is_pciehp)
 			return false;

would be more appropriate and more consistent with the subsequent check in
pci_bridge_d3_possible() that also uses IS_ENABLED(CONFIG_X86).  Basically
this would mean that we only special-case legacy x86 hardware, but assume
that anything else supports D3hot/D3cold for native hotplug bridges just
fine.  In particular, arm64 systems using ACPI.

Thanks,

Lukas
