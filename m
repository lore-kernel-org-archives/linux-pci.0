Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0D30E0E7
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056604; cv=none; b=XghMcWFaDX3eZCfLkzsyeycCnzTbyGnwn3nC9VpDkCny/tUkV+arQbzMtp+W+k15Y4Y0u5gI+aBVaBd3B2oHjL1SQyWWt+Prp5pzsR5PHzT1e+0UGe5JTjMvqZsfgup+elWssiDmwXohAZasS/7xtqQVkVlUAGzGvUdtT0twUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056604; c=relaxed/simple;
	bh=NHh9OpSSuByp7xqowupGfzKG4TnWpyX/06hzPwUWYFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJI+5RUkEcF1EqyiJNW4hj/0jlLqzDQ0qz4iv3cQfoMJikqve9Tb4YKozojqQDtOPc1fBbb+QRPRB6Lerg04iONSq4vhbbeNYCJiBVnqaBAIe4AvHwBk0iOl1aA3G9nKZwqyW6+G3o3cPVBlLHNdwBHj0+TKcbRt26XSr9GyHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE1E1ZEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE1E1ZEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9455C116D0;
	Wed, 25 Feb 2026 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772056604;
	bh=NHh9OpSSuByp7xqowupGfzKG4TnWpyX/06hzPwUWYFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dE1E1ZExResSs4ZAxS9JoAivZYnwz8KltLl7GEL9ATq7xRnDDishbKBWN9oLFsO3J
	 oouZaeL3uY6Ec47Sr9DUmW2OggzapU6EWKQ0fN9dWUcHx89MgY8Kx+o66FduijEbub
	 kBlcbhcH6bAlXI9Xj95LvZCOw9q0uv6pTJtSZ3yIIe1TJZeJRdnrjr8k8fS7ZnaD0n
	 JOWXfd8pU/zK3YhwRFQ4oghun6PBETo6Hn061hDOjkHszve4yR9c8hYLQJQGpdgGIN
	 dTStVhGcBDDbUx+8NSgrTlWsGCKfX+ZQjBos0Bmr+ks2HRciZtHCGrkuQQUAoJ+QZf
	 CETpjziGZR8Pw==
Date: Wed, 25 Feb 2026 22:56:39 +0100
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
Message-ID: <aZ9wF5QjHTtbBc2d@fedora>
References: <20260210181225.3926165-2-cassel@kernel.org>
 <20260225200553.GA3783348@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225200553.GA3783348@bhelgaas>

On Wed, Feb 25, 2026 at 02:05:53PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 10, 2026 at 07:12:25PM +0100, Niklas Cassel wrote:
> 
> I put this on pci/for-linus for v7.0, thanks!
> 
> I'd like to make the commit log a little more general, since the issue
> affects any endpoint driver.  Here's my proposal; I'll update it based
> on your feedback:
> 
>   PCI: dwc: ep: Fix dw_pcie_ep_raise_msi_irq() Message Address cache
> 
>   Endpoint drivers use dw_pcie_ep_raise_msi_irq() to raise MSI interrupts to
>   the host.  After 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU
>   mapping"), dw_pcie_ep_raise_msi_irq() caches the Message Address from the
>   MSI Capability in ep->msi_msg_addr.  But that Message Address is controlled
>   by the host, and it may change.  For example, if:
> 
>     - firmware on the host configures the Message Address and triggers an
>       MSI,
> 
>     - a driver on the Endpoint raises the MSI via dw_pcie_ep_raise_msi_irq(),
>       which caches the Message Address,
> 
>     - a kernel on the host reconfigures the Message Address and the host
>       kernel driver triggers another MSI,
> 
>   dw_pcie_ep_raise_msi_irq() notices that the Message Address no longer
>   matches the cached ep->msi_msg_addr, warns about it, and returns error
>   instead of raising the MSI.  The host kernel may hang because it never
>   receives the MSI.
> 
>   This was seen with the nvmet_pci_epf_driver: the host UEFI performs NVMe
>   commands, e.g. Identify Controller to get the name of the controller,
>   nvmet-pci-epf posts the completion queue entry and raises an IRQ using
>   dw_pcie_ep_raise_msi_irq().  When the host boots Linux, we see a
>   WARN_ON_ONCE() from dw_pcie_ep_raise_msi_irq(), and the host kernel hangs
>   because the nvme driver never gets an IRQ.
> 
>   Remove the warning when dw_pcie_ep_raise_msi_irq() notices that Message
>   Address has changed, remap using the new address, and update the
>   ep->msi_msg_addr cache.

Looks good to me!

You've been reviewing/discussing the patch already, so you were already
very familiar with the problem. Thank you for picking it up!


Kind regards,
Niklas
