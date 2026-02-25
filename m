Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121B26ED2A
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049955; cv=none; b=t6at0HpxqTDzPhBlXV+HJQsarViRAU5DCfui6u+rn9W6RJCuaRC56LymV4QnBr+2rw/yCtOngVIRhjHCg72+2RfECVrp7+AITVV0UmrL6jI+F3t7DBA9W/2PVVMLYhMVbePndXRJjnVk7GxhopARC18AwsRry2tthwrx0jN1QMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049955; c=relaxed/simple;
	bh=G+13jD3aEdDflz2E3Io8a00YH1qTgwDWphN2CdkI4X4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PW0HNMWBY3SEYfG+OXFe7o/oJW7y1BzAxydme0pIgPWW4XD1Cpo3MSrOYxZ9rppQaI8WybnmJ2Ekoh4Of5JPnkxIF2rKsw5TJvfSGvjRkux/JY4b7nqoTYy+8x5neJI7XxEqG/9kRJ14s7EP5SB4wJ5DEY0kc0+9R3Yca7g010w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3n9TKeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3n9TKeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B28DC116D0;
	Wed, 25 Feb 2026 20:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772049955;
	bh=G+13jD3aEdDflz2E3Io8a00YH1qTgwDWphN2CdkI4X4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c3n9TKeb/GvnFuJ0ynX8pCbrjPqO7nQaaf/QkSZUnh7efNSto6Clu8adV6wlESeAS
	 chc2acsQyySeiQRPpQaUiSmeCcYxD302yOQ7hyLV9MXZfawFT1Hk/6l6LU5DHR1yW5
	 B+hJF5V4BBIR3VbvWxIcfWSUjtbPiQPXOzg4X79cD3/uBMhWikZ5mLAKfPrf29mekP
	 pGEWJGoPYjlpLfdQVtmpD+KAbMdYDlLqAkESaPCvHzUhpOMACA6/C7auubLmgRhpvZ
	 Lyii+NQDgaKkRT6wKmpgZAB2yX9vkfjyQFrS1+CtAu1G12YOM6IADMszWQssHyj+hI
	 ayMJcEDXBKQpA==
Date: Wed, 25 Feb 2026 14:05:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <20260225200553.GA3783348@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210181225.3926165-2-cassel@kernel.org>

On Tue, Feb 10, 2026 at 07:12:25PM +0100, Niklas Cassel wrote:
> When using the nvmet-pci-epf EPF driver, and starting the EP before
> starting a host with UEFI, the UEFI performs NVMe commands e.g.
> Identify Controller, to get the name of the controller.
> 
> nvmet-pci-epf will post the CQE (completion queue entry) to the Admin
> Completion Queue, and then raise an IRQ (using
> dw_pcie_ep_raise_msi_irq()).
> 
> Once the host boots Linux, we will see a WARN_ON_ONCE() from
> dw_pcie_ep_raise_msi_irq(), and then the booting of the host hangs,
> because it never gets an IRQ when loading the nvme driver.
> 
> The reason is that the MSI target address used by UEFI and Linux might
> be different, which will cause dw_pcie_ep_raise_msi_irq() to simply
> return -EINVAL.
> 
> This was working before commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
> outbound iATU mapping"), so this is a regression.
> 
> Also, remove the warning, as we cannot know if there are operations in
> flight or not, so it seems wrong to print this warning unconditionally
> at every boot when e.g. nvmet-pci-epf is used with a host with UEFI.

I put this on pci/for-linus for v7.0, thanks!

I'd like to make the commit log a little more general, since the issue
affects any endpoint driver.  Here's my proposal; I'll update it based
on your feedback:

  PCI: dwc: ep: Fix dw_pcie_ep_raise_msi_irq() Message Address cache

  Endpoint drivers use dw_pcie_ep_raise_msi_irq() to raise MSI interrupts to
  the host.  After 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU
  mapping"), dw_pcie_ep_raise_msi_irq() caches the Message Address from the
  MSI Capability in ep->msi_msg_addr.  But that Message Address is controlled
  by the host, and it may change.  For example, if:

    - firmware on the host configures the Message Address and triggers an
      MSI,

    - a driver on the Endpoint raises the MSI via dw_pcie_ep_raise_msi_irq(),
      which caches the Message Address,

    - a kernel on the host reconfigures the Message Address and the host
      kernel driver triggers another MSI,

  dw_pcie_ep_raise_msi_irq() notices that the Message Address no longer
  matches the cached ep->msi_msg_addr, warns about it, and returns error
  instead of raising the MSI.  The host kernel may hang because it never
  receives the MSI.

  This was seen with the nvmet_pci_epf_driver: the host UEFI performs NVMe
  commands, e.g. Identify Controller to get the name of the controller,
  nvmet-pci-epf posts the completion queue entry and raises an IRQ using
  dw_pcie_ep_raise_msi_irq().  When the host boots Linux, we see a
  WARN_ON_ONCE() from dw_pcie_ep_raise_msi_irq(), and the host kernel hangs
  because the nvme driver never gets an IRQ.

  Remove the warning when dw_pcie_ep_raise_msi_irq() notices that Message
  Address has changed, remap using the new address, and update the
  ep->msi_msg_addr cache.

