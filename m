Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865102D9ECD;
	Fri,  1 May 2026 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673041; cv=none; b=GlhDUIm2c8DNK06ap1mmxYqnV7KEL8PaD6uF78wGXWhGTvqStwQ2mg141+pVqS/1Qavc0dK28ewobjNwNYFs0qB0F9WA2cwAkReZP+xUPCsYM53++nl1boQpAzFK/2t3A5zmh2TUpjIRUChJLEkSlqqCwUPeMTHWlkIR26iQ8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673041; c=relaxed/simple;
	bh=HKVDY3YeNH8AZP6qEwAmEqYoxJ5WPVlsvJuzoKf9Vk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EJ8Ymcna28LyBU68AT3SAQhsURetp2P62j5o3AYWVuvF0Z6KrIMBH/E18AT9I4QtYFseccnH7qDSozcT2ZmFySuBONGPrEqbDUO7t65JN/JsSebZADCZk+nTMEs4+oOTK07OR+quaRMEpXQLCa5Rk+IkosUZ1uNfx9MGi5E1YgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCGJRs/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCGJRs/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BC8C2BCB4;
	Fri,  1 May 2026 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777673041;
	bh=HKVDY3YeNH8AZP6qEwAmEqYoxJ5WPVlsvJuzoKf9Vk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NCGJRs/cGzIKN9rsmSBDs5PTJvhYXE+WvOWqUlR0bsfZSjtxPYIfYfT62C8ZHNWYq
	 ClSRidEbvJjyXtUehEm70BKzW/Bt1I4X3L877ewRPNrT0I/nI5NJ+/lQ/U8AEM+t2L
	 Xsf7mHGvQIOFBfJCuN6JrmWi70PUs9eL1O3y58ZxBpT84+BckUcjQcSYin9fkseApi
	 qObiWeXe9yLhxklJROn+Swl7u30/xNtszmgNiWn/gjYJYVvlVj3B4JXXzuwvZ5vSpi
	 DHND5usVcsaa67o0/RYNdejkiYwC9rIfXlpOyOuhqrts0iRerRAslhxpH5S4ZwWA40
	 CsIM1jxQ4r/9A==
Date: Fri, 1 May 2026 17:03:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pci@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Hans Zhang <18255117159@163.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
Message-ID: <20260501220359.GA522578@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501202438.376033-1-florian.fainelli@broadcom.com>

On Fri, May 01, 2026 at 01:24:38PM -0700, Florian Fainelli wrote:
> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
> pcie->gen stopped being assigned and as a result the established PCIe
> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
> 
> Link: https://github.com/raspberrypi/linux/issues/7343
> Reported-by: Dom Cobley <popcornmix@gmail.com>
> Reported-by: Phil Elwell <phil@raspberrypi.com>
> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to pci/for-linus for v7.1, thanks, and sorry for the breakage.

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 714bcab97b60..6138fc4bc064 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->clk);
>  
>  	ret = of_pci_get_max_link_speed(np);
> -	if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
> -		pcie->gen = 0;
> +	pcie->gen = pcie_get_link_speed(ret);
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -- 
> 2.43.0
> 
