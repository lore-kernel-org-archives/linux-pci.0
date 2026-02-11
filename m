Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B232863D
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833320; cv=none; b=IUEwFwwi+lmupX0cHpl2+OGccFKtvmz1HsydINtQgbqh8TcsAj85KLuz6tafTIunjgXg0ja0Y5kRPMKnJ9gCRdLGb8MHZQ5Wm5ZYaHbQC6TCuY+E6S5hwUYgpJ3umuG+Q5YJXrAkv1VNroVxbdOP4R+HNC/DcJe7qsjOxlwNftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833320; c=relaxed/simple;
	bh=R50+/yIvBbuDFA1m/jwoZqI8jarqc21DxsnKhc7AXa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JhaETE6Zxx8qs0RPcmig7RFenV8Pe3oOrD1Pl3hoySmvVZUy3uFzKzTZBh/k+y9kn57CQ9J7qWSGAIQJXHctxD5ODdH3eIqlKW+RLJDBOCsw8kv7/mdW4qZa+uE0RSUosCwrqwa809lElFx4LGZrta8+nl5l5ulqyHSaDyI6/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXmJ2cNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXmJ2cNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25463C4CEF7;
	Wed, 11 Feb 2026 18:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770833320;
	bh=R50+/yIvBbuDFA1m/jwoZqI8jarqc21DxsnKhc7AXa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lXmJ2cNidZNBXd79iOt+aNggLhwGXtgabdq0zOFfWuwmKJJIrBBvnz8ls8sudLWHj
	 7rizhskQG48JqB/kB5deLQfnTwHaJVbdUHSbOX8zI1edz4c/RecZEKbCz8rP5p3TBe
	 Gj7tLfr9ulRad6oegdmWYL7wB9J6oPybKNForfb9WZnpLcO36aGTi8/4nM2vMvQuUc
	 nkLWCIrKENfBFpHgnvHp/oEc2OSk4BFWXFB6ZZuGlgOFmnWRUQBd1I9TF9qfv6NXvo
	 l1zQBMNpk/YN03xyzJe5lktWHgEj0hG2gouz6VShIQbnOcNssxJoN8IIyrNEyRLOZ+
	 dLLYts/TVxvhQ==
Date: Wed, 11 Feb 2026 12:08:38 -0600
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
Message-ID: <20260211180838.GA116930@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYxDUoPWLTz774f9@ryzen>

On Wed, Feb 11, 2026 at 09:52:34AM +0100, Niklas Cassel wrote:
> On Tue, Feb 10, 2026 at 02:39:49PM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 10, 2026 at 09:22:58PM +0100, Niklas Cassel wrote:
> > > On Tue, Feb 10, 2026 at 01:32:05PM -0600, Bjorn Helgaas wrote:
> > 
> > The scenario I'm asking about is the following, where the single
> > change of MSI target as the host boots is concurrent with
> > dw_pcie_ep_raise_msi_irq()::
> > 
> >   - host writes PCI_MSI_ADDRESS_LO
> > 
> >   - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_LO and
> >     PCI_MSI_ADDRESS_HI
> > 
> >   - dw_pcie_ep_raise_msi_irq() maps msg_addr built from an old
> >     PCI_MSI_ADDRESS_HI and a new PCI_MSI_ADDRESS_LO
> > 
> >   - host writes PCI_MSI_ADDRESS_HI
> > 
> > This could be mitigated by re-reading PCI_MSI_ADDRESS_* to detect the
> > tearing.
> 
> Ok, now I understand.
> 
> This must be extremely unlikely to happen.
> 
> Since the host writes the MSI target address very early, before even
> enumerating the bus.
> 
> So the EP reading a half updated 64-bit MSI address, seems very
> unlikely.

Very unlikely for sure, and the patch is OK with me as-is, although
writing to the wrong address would be very difficult to debug.

I think it's probably more important to pay attention to the MSI and
MSI-X enable bits to make sure we don't generate MSIs when disabled.
