Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FA33A6E4
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034724; cv=none; b=Iax/9SpP8h3Tc2EY2VbjIPJGeUXakg5IlrSEGICIXRrWNYB4nacnwkkO3rPrwdDqsldu3qxIn8orEwEARA9bPS1iuIo/HjOb3Z0PccYTBYh4MBTUPoKQFicU1fGaL9uXYrSfiCpqx+YRUeAgfmNLwNYp6w2smj8Q9Ijifx4pU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034724; c=relaxed/simple;
	bh=RVPqK6tx5QFUHNn9gh7z+cym5nVowbmQLKUL0qUMuQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIVrs9nr79VpbDM56t5zJpByPRapA+XS8ukBQ9hTksxSJtFG7axrl0hCmynXhwGU1Ihd7ps1hxRsY6lsjEABcqXh5bkETB2PyF/bUHMloVtLqeUxGKailsb4OM9m9xm+pJQP6HzEVd0GzMIVePEcv+AIY7MrBVsz+u8t8/4eN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THMU8QHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THMU8QHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B56C116D0;
	Wed, 25 Feb 2026 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034724;
	bh=RVPqK6tx5QFUHNn9gh7z+cym5nVowbmQLKUL0qUMuQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THMU8QHOajaiYGhfHPbMJjQDxL0YiDT216IM8y9oAslCB7mF8k7rmjSD5Fiy3ykcc
	 4qG+igDxWQ2DpSJ93i75QDhIy3mjfsn+y3qN6m4seWZR8yS+LEXukoieXkBHay5VwT
	 K0t5PoWSIV6i8yQlhpthNhnRgDAh04ctJpEQpf40OtDqx7B8f43I9X7DY7mujXlm7M
	 sNbp2ywfFbS8IFwIAb1dqat0qXzj6AwQ8sl2IU7k0IZDsLEzQ4eGYGVPq6oJGEfi+2
	 3TwPnGVNiNSsfrFnW4g4h32e2D6VGJb6yMwwzmHCBSMkE92ljAl0G3iQwCDwFkIhzu
	 nB2A/JGLMVCBw==
Date: Wed, 25 Feb 2026 16:51:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Koichiro Den <den@valinux.co.jp>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <aZ8an10tlBmWOKE6@ryzen>
References: <20260210181225.3926165-2-cassel@kernel.org>
 <qxcf4idjsbscd5tlgsbt3yg6xyngkn3wgaubaedgr24dx3pcsx@ejbrdqpryipe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qxcf4idjsbscd5tlgsbt3yg6xyngkn3wgaubaedgr24dx3pcsx@ejbrdqpryipe>

On Wed, Feb 25, 2026 at 08:31:24PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 10, 2026 at 07:12:25PM +0100, Niklas Cassel wrote:
> > When using the nvmet-pci-epf EPF driver, and starting the EP before
> > starting a host with UEFI, the UEFI performs NVMe commands e.g.
> > Identify Controller, to get the name of the controller.
> > 
> > nvmet-pci-epf will post the CQE (completion queue entry) to the Admin
> > Completion Queue, and then raise an IRQ (using
> > dw_pcie_ep_raise_msi_irq()).
> > 
> > Once the host boots Linux, we will see a WARN_ON_ONCE() from
> > dw_pcie_ep_raise_msi_irq(), and then the booting of the host hangs,
> > because it never gets an IRQ when loading the nvme driver.
> > 
> > The reason is that the MSI target address used by UEFI and Linux might
> > be different, which will cause dw_pcie_ep_raise_msi_irq() to simply
> > return -EINVAL.
> > 
> > This was working before commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
> > outbound iATU mapping"), so this is a regression.
> > 
> > Also, remove the warning, as we cannot know if there are operations in
> > flight or not, so it seems wrong to print this warning unconditionally
> > at every boot when e.g. nvmet-pci-epf is used with a host with UEFI.
> > 
> > Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Bjorn, since this patch fixes a regression introduced in v7.0, could you please
> take it for current -rc?


While not introduced in v7.0, it would be nice if you could also consider:
https://patchwork.kernel.org/project/linux-pci/patch/20260211175540.105677-2-cassel@kernel.org/

(Such that v7.0 could have both working dw_pcie_ep_raise_msix_irq() and
dw_pcie_ep_raise_msi_irq())


Kind regards,
Niklas
