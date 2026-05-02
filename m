Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFF3101CD;
	Sat,  2 May 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777722021; cv=none; b=r5mnYeQ0e0fXF8b9Io8ByaNQjgfkAfanYRdhtXbMKHglPGoU4kDssan5NqZDRUbGquJ7ZBh12s0MDLjCvMqQIYuwbF7UNPzvWYh1d2kCLUJNoW2DY2QHOeP6/Svqws5rRqfDtswpCSs3dJvmUwWQpScHptHoWB8Yc3Xh580lqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777722021; c=relaxed/simple;
	bh=Ba1wqX2SN8Flrod7t3UMQ92yqgaLJRZILMs4KGu8JaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pZS+w4wRilBYexw4eFgOgTWS/fpu0YcPcIFqfdQNR0OIIno/bn489mCtwO1GPYo3hsk841zzYYguZboHKIxizDIMmslpIulavd9HK1IidZsYvYBPdjJH4bmyXDEadzqHsJaOuSvRsB2For3SqEqPlQuk0ijvpuMydfGo3kKHPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvN+ekgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvN+ekgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE86C19425;
	Sat,  2 May 2026 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777722020;
	bh=Ba1wqX2SN8Flrod7t3UMQ92yqgaLJRZILMs4KGu8JaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UvN+ekgwd8BBWJbXT5QkMKUdTwzEYPmQV8Tt0MSw65R2LjEfKccGzIwXqIU6oPC8Z
	 m6W5N1A3NE2WurVH3eQOX3EnBf33MxsYsE/X6erNCChhShy3oX5rAmA9ewQvl5a7TI
	 DfiaUl87B+rIOvviedQ0uG4n17Lc3/DXrqdD5SZPrBNSwqb4r2qX5W2mhsoZ0a1EEr
	 2ABXYDWxmLLZUhuWxo33Bb7bIJGAZnl2Xet65XNqcNUokSWw6ey/f9y2UOj5y/w1OC
	 Eca1fVzlOAG0AnMMxBs862CJOQ2Gg20OOVnPQXU9U5gO95VSylI25bJzyJ7eAdozs9
	 BO6KYoiyee5qw==
Date: Sat, 2 May 2026 06:40:19 -0500
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
Message-ID: <20260502114019.GA551304@bhelgaas>
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

Take a look at https://sashiko.dev/#/patchset/20260501202438.376033-1-florian.fainelli%40broadcom.com

The notes at https://github.com/raspberrypi/linux/issues/7343 assumed
PCI_SPEED_UNKNOWN was 0, but in fact it is 0xff, which means you might
want the more defensive patch instead.

I'll be happy to replace what's on pci/for-linus if so.

>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -- 
> 2.43.0
> 
