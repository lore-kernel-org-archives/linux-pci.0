Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40A353EC6
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799960; cv=none; b=R6dVhNiIQyDo09OwmMjaIYAZJlyX5oM0VDLuOpQpwBChRaZWEH074ZJV6Om3BMpRoT77iEM0NfSvUh/9Zt+HmDb8+ES5J4ueqZBogVLMVON6AzNhv6rTD9wPejl+3ZSKFHjNb6FbeGgNiLUO25jBQzzevyTlXcVLgvClB7dQi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799960; c=relaxed/simple;
	bh=5i6gaOJwSsjGN4XLXaN8jWxCkEqtwJKpU6gwAEO8XI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjgypIBBSwHVC0ZAZh6zgPTR2uSioek/BY0M7amaEcKvfaz5Jf08AuzbU553Vw02bI/N+LSIEkZkwnuDpdIknDKloLVldHCpCs4ysdryVtOtWYMZ+4UbuKVT/bFFv6XOU7xu2J9PuW79c8UCaV3xjyDiYIbtnZdWWE3zJp5R1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTnJL4qA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTnJL4qA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B94C4CEF7;
	Wed, 11 Feb 2026 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770799959;
	bh=5i6gaOJwSsjGN4XLXaN8jWxCkEqtwJKpU6gwAEO8XI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTnJL4qA3MWTE5gT6HzyMTNjGl3PlZtPFztcx//H+vP/XlV/RpMgb37M5wcw0TaRP
	 FUbhhixQU+8wqx+xdZOITtT809mnnFY67qyTqtv3WLyIQx8cgMQmyPdfU3+D9Hyeoy
	 5Bu5iGag8SdsryD9vSZ0hWK028FojaqESa39gOc9XVwQ5hdtKrI9ON0Cgb6S6pPgFj
	 /49SFsqSt6MH3o5Z+W2QbIfztkPqN3nWacpeqytV8Lef9X8vU8xlGyR+2EqkDJ3XOF
	 stendHLDHZ2lywi0g2Ac+Az9nVR4X/IbJ1zymsCaFCf2YnvlucHh8aeiyLi1XD5oQ2
	 a73dMME2kRNvA==
Date: Wed, 11 Feb 2026 09:52:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <aYxDUoPWLTz774f9@ryzen>
References: <aYuToukP3STMF6Tj@ryzen>
 <20260210203949.GA47027@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210203949.GA47027@bhelgaas>

On Tue, Feb 10, 2026 at 02:39:49PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 10, 2026 at 09:22:58PM +0100, Niklas Cassel wrote:
> > On Tue, Feb 10, 2026 at 01:32:05PM -0600, Bjorn Helgaas wrote:
> 
> The scenario I'm asking about is the following, where the single
> change of MSI target as the host boots is concurrent with
> dw_pcie_ep_raise_msi_irq()::
> 
>   - host writes PCI_MSI_ADDRESS_LO
> 
>   - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_LO and
>     PCI_MSI_ADDRESS_HI
> 
>   - dw_pcie_ep_raise_msi_irq() maps msg_addr built from an old
>     PCI_MSI_ADDRESS_HI and a new PCI_MSI_ADDRESS_LO
> 
>   - host writes PCI_MSI_ADDRESS_HI
> 
> This could be mitigated by re-reading PCI_MSI_ADDRESS_* to detect the
> tearing.

Ok, now I understand.

This must be extremely unlikely to happen.

Since the host writes the MSI target address very early, before even
enumerating the bus.

So the EP reading a half updated 64-bit MSI address, seems very
unlikely.

Even in the NVMe EPF case, after UEFI loads Linux, there will be no one
posting new Submission Queue Entries, so the EP will not be raising any
interrupts.

If you want to create a misbehaving device that does an interrupt storm
during boot, it might be possible to hit the half updated 64-bit MSI
address race.

If anyone wants to write a patch that avoids that theoretical race,
fine with me, but I don't think we should do anything to avoid it in
this patch, as this theoretical race could happen even before we did
any caching of the MSI target address.


Kind regards,
Niklas
