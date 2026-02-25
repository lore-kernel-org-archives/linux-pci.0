Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD33D666A
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037053; cv=none; b=aRyFoy59Xb4YkkrkWnRNzgfQ2rFdXlqcTz0/sprMkAzBjnrYDFztOmejSh7MsckUgXYTz0qEwuM6gVboy/cMJ+pbBDa9dHrs1ZxhhG0Ekks1ipF2bcsHsN78pr19sOkgCXElRbZDtY82VJcXW59Qg+7BeTtXOB7l0LcjX9xlC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037053; c=relaxed/simple;
	bh=HbgliABWRB27ZxWGlVdnILh+nPE6hNzoc0yZWDsBgLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdDn+xsB1UyLCb5l9T06913ZC6EGNQ0ZoOnDJbc+Og5EC0ldf/QknLXGELmwTPQXfixulu03lcS2/SIjUe2tAmibIShByJzhAZhoseW+TEOXBG/PJlz7UJHMI2jSLTwGr4cIGr9tMAops41PZ2T9lyRkSMtojNEC8N20G/SDXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRNbAqg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRNbAqg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A44C19421;
	Wed, 25 Feb 2026 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037053;
	bh=HbgliABWRB27ZxWGlVdnILh+nPE6hNzoc0yZWDsBgLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRNbAqg3cT/m8XkCiyJsV1uKz6x+DAEK83vPpdCgi/oYWN5oLY1Lz+TIOOPIiC0Yz
	 9V66sphNjgahGejeXHgoV7PFPzFLhp+t8khhbLQ6W/hhvtRDSdvNaOQmbXLc4IdtPb
	 tXqAQJevVc1DlbZuWcbywce/tES7+VlldnxABBzRREhTu45pEe645Xed0Y9iymXRZ0
	 YHvwhEftTm1ib43pXCaQGo1jdFi/Ms4Vxa02JGpNdcrS644eXu3TM+52IPlPVCsBdV
	 Q6rO0JG0/qvONwCaNmDHMYE8WDUEiqMgss2R40x+jNG5a3vuJh6bG9ndL8SydHx4WU
	 IGTgddYDifTcw==
Date: Wed, 25 Feb 2026 22:00:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Koichiro Den <den@valinux.co.jp>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <j5f3kvvxwf6ixcgqn234caowpckwve76ltydsdkaxp24tkphkr@fzszv644hvx6>
References: <20260210181225.3926165-2-cassel@kernel.org>
 <qxcf4idjsbscd5tlgsbt3yg6xyngkn3wgaubaedgr24dx3pcsx@ejbrdqpryipe>
 <aZ8an10tlBmWOKE6@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ8an10tlBmWOKE6@ryzen>

On Wed, Feb 25, 2026 at 04:51:59PM +0100, Niklas Cassel wrote:
> On Wed, Feb 25, 2026 at 08:31:24PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 10, 2026 at 07:12:25PM +0100, Niklas Cassel wrote:
> > > When using the nvmet-pci-epf EPF driver, and starting the EP before
> > > starting a host with UEFI, the UEFI performs NVMe commands e.g.
> > > Identify Controller, to get the name of the controller.
> > > 
> > > nvmet-pci-epf will post the CQE (completion queue entry) to the Admin
> > > Completion Queue, and then raise an IRQ (using
> > > dw_pcie_ep_raise_msi_irq()).
> > > 
> > > Once the host boots Linux, we will see a WARN_ON_ONCE() from
> > > dw_pcie_ep_raise_msi_irq(), and then the booting of the host hangs,
> > > because it never gets an IRQ when loading the nvme driver.
> > > 
> > > The reason is that the MSI target address used by UEFI and Linux might
> > > be different, which will cause dw_pcie_ep_raise_msi_irq() to simply
> > > return -EINVAL.
> > > 
> > > This was working before commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
> > > outbound iATU mapping"), so this is a regression.
> > > 
> > > Also, remove the warning, as we cannot know if there are operations in
> > > flight or not, so it seems wrong to print this warning unconditionally
> > > at every boot when e.g. nvmet-pci-epf is used with a host with UEFI.
> > > 
> > > Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > 
> > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Bjorn, since this patch fixes a regression introduced in v7.0, could you please
> > take it for current -rc?
> 
> 
> While not introduced in v7.0, it would be nice if you could also consider:
> https://patchwork.kernel.org/project/linux-pci/patch/20260211175540.105677-2-cassel@kernel.org/
> 
> (Such that v7.0 could have both working dw_pcie_ep_raise_msix_irq() and
> dw_pcie_ep_raise_msi_irq())
> 

That's upto Bjorn actually. I'd also prefer to get the fixes in ASAP.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
