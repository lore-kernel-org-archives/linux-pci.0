Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536A3DC87D;
	Fri, 15 May 2026 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868873; cv=none; b=Y7SmRBDoO3p+FvWq/uT/pCRExozupZxAr3Crzuk+OmE9RDoMU+bPbftif2jJg7lLWDvG53Js3DaqXxjshFIX/PTQzEGcfayZch7BYubC6DmA/AIPjPSHFm6vtZDTfZXqV0O6JD5rM7wiFTOvtU96L9gAjwNoKEgkB2MBQJTkRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868873; c=relaxed/simple;
	bh=s/joay8SWXDw6yqU8I34kjBc3z3fFJJ+aAAgSOP8Uj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uDPH6tw3xBb/W4lhqNi++z9r2NL1ILZAjwCDdOlfDnmNnhq3MBOwKybVgMiYXLiJ2aI6mz2YH7HeuKG+xVuQThCOFA0fcT5+wLqUnzTsFvqEQOrzX1HNxih3uDx3cJ5rarP+BDDgFhSY3S5mqloW+7LVp1RJG+cpUiUwBt402GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p71fEosA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p71fEosA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1072C2BCB0;
	Fri, 15 May 2026 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868872;
	bh=s/joay8SWXDw6yqU8I34kjBc3z3fFJJ+aAAgSOP8Uj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p71fEosAwm4sa42reA6Ycd/eE63vRXoa7txtMBRP1VFKeeDqUzCs4g9/HbDEkuCpT
	 DUapKMiyCA2gZXO2Gqg2cKGbxhn/1AK/DM9XmCqgiU1NAqvcxJGxrriVHCFhcdYmnf
	 EZsQpiMmyS8ZxBr474vAZ+dDEXahUaRx4CBDKSNDr70Hcm4dyd0b285ihsZWV8f3dT
	 f18V4u7Iq1U15rocD4iVQaJHrAoMSC2UxVINZ36Oc5V5j6LW9sEvSxjzBtdpYwk9l7
	 a0hAfrjfTSvruuVkIl5LhyM6r6tEWjXkYRIZmp+3D7qkjBzGYKPS2g2KVWRSwCGmvN
	 j44S0+P85PbiA==
Date: Fri, 15 May 2026 13:14:31 -0500
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
Subject: Re: [PATCH v2] PCI: brcmstb: Assign pcie->gen from
 of_pci_get_max_link_speed()
Message-ID: <20260515181431.GA505137@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506164537.103196-1-florian.fainelli@broadcom.com>

On Wed, May 06, 2026 at 09:45:37AM -0700, Florian Fainelli wrote:
> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
> pcie->gen stopped being assigned and as a result the established PCIe
> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
> 
> Whether the 'max-link-speed' property is not specified, or it exceeds
> Gen3, resort to the HW defaults.
> 
> Link: https://github.com/raspberrypi/linux/issues/7343
> Reported-by: Dom Cobley <popcornmix@gmail.com>
> Reported-by: Phil Elwell <phil@raspberrypi.com>
> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: Ic5431469dd7a6c8b391f84f27119dad876256880

Applied to pci/for-linus for v7.1, thanks!

Sashiko pointed out a couple issues, but they're unrelated to this
patch, so I'll watch for future patches to address them.

> ---
> Changes in v2:
> 
> - utilize of_pci_get_max_link_speed() directly
> - also validate against exceeding Gen3
> 
>  drivers/pci/controller/pcie-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 714bcab97b60..08a0e7091ced 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -2072,8 +2072,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->clk);
>  
>  	ret = of_pci_get_max_link_speed(np);
> -	if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
> +	if (ret < 0 || ret > 3)
>  		pcie->gen = 0;
> +	else
> +		pcie->gen = ret;
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -- 
> 2.34.1
> 
