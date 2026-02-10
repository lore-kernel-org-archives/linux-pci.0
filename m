Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3F1FB1
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751927; cv=none; b=uQEIodX8wx9wEiumVSnu46hco48CDe6o01t8eWCqIine6HcsoYWya2sy21upngK6mFnANIn6UDwF65flwx4IC5j8pYD6CtVXP3XAMGFR77FdXjtvMzOnpvKhqC0ewOFJPPUVNxJdMTOVMvhTMOE4EKiNgnLin0VgnvQUltwoA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751927; c=relaxed/simple;
	bh=to0kA8rvkPFIPK9BB+FnaQqbr0Cyl8GuKaz/Mc/RnBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qg4pXVt1TaE2w2UvRNFn2/xnm8Q+IbJLcOhFmumt7Py/prJugZrk6pLPzpdHDuNIpjP87AzhvOnz0t+AyAVtHu6Y89XdKSvuqmHcQL+uh6RF009G7hbNX0Z2X2mah/MYoRXYco1vdeLWD6ZGIUE6/S8nPp5W78I3ActVbQ4y5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0A/sFek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0A/sFek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C25C116C6;
	Tue, 10 Feb 2026 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770751926;
	bh=to0kA8rvkPFIPK9BB+FnaQqbr0Cyl8GuKaz/Mc/RnBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X0A/sFekvEJlpVkIlHig3N6A2WnEpPu2ourazq5wd8WVEQNQOE0G8+p8n7gY4UPhf
	 MadHMS9Gwy2z7M0nGwxyifj6fYOld+2GSfoc4IiCsS7xp70iYDf4qpPxyWQ5gY0rLr
	 Y4Viohh6YDgYUAG8rXfpQAM3F5b0MxuPeXOlufSqEu5f+nKQmZNq2UvBbILNvQAQPC
	 c0oHKJ3qnHcK8cAvlMCSltub+iC7J8rs6INn/p/hX7hU6LUe+asFs/3NItc/goK5Ra
	 bcN98mVEBOe9D3D4My+tFT1XI9fJvKK2uYBPZTbmBguTcT8/QmJ5eGGPan5pN24tmO
	 iGmOz1DCs2Axg==
Date: Tue, 10 Feb 2026 13:32:05 -0600
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
Message-ID: <20260210193205.GA41950@bhelgaas>
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
> 
> Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

IIUC, the sequence is like this:

  - nvmet-pci-epf calls pci_epc_raise_irq() leading to
    dw_pcie_ep_raise_msi_irq()

  - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_*, maps msg_addr,
    and saves it in ep->msi_msg_addr

  - host updates PCI_MSI_ADDRESS_*

  - nvmet-pci-epf calls pci_epc_raise_irq() again

  - dw_pcie_ep_raise_msi_irq() reads PCI_MSI_ADDRESS_*, notices that
    msg_addr has changed, and WARNs and returns -EINVAL

and this patch makes it so the second time through
dw_pcie_ep_raise_msi_irq(), we notice the msg_addr change, remove the
old mapping, and map it again with the new address.

Isn't there still a race between host updates of PCI_MSI_ADDRESS_* and
endpoint reads of those registers?  We can't prevent the host from
updating PCI_MSI_ADDRESS_* between dw_pcie_ep_map_addr() and the
writel(), so maybe it's impossible to prevent the theoretical race
there, and all we can really do is mitigate what we expect to be a
single change at boot time of the host?

Even for that single change, it looks like the host could update
PCI_MSI_ADDRESS_* simultaneously with dw_pcie_ep_raise_msi_irq(), 
leading to mapping a half-updated msg_addr.  This part we *could*
prevent by re-reading PCI_MSI_ADDRESS_* to detect a partial update.

Probably unrelated question: the pci_epc_raise_irq() path doesn't seem
to check PCI_MSI_FLAGS_ENABLE or PCI_MSIX_FLAGS_ENABLE.  Is that
intended?

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..5d8024d5e5c6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -896,6 +896,19 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	 * supported, so we avoid reprogramming the region on every MSI,
>  	 * specifically unmapping immediately after writel().
>  	 */
> +	if (ep->msi_iatu_mapped && (ep->msi_msg_addr != msg_addr ||
> +				    ep->msi_map_size != map_size)) {
> +		/*
> +		 * The host changed the MSI target address or the required
> +		 * mapping size changed. Reprogramming the iATU when there are
> +		 * operations in flight is unsafe on this controller. However,
> +		 * there is no unified way to check if we have operations in
> +		 * flight, thus we don't know if we should WARN() or not.
> +		 */
> +		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = false;
> +	}
> +
>  	if (!ep->msi_iatu_mapped) {
>  		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
>  					  ep->msi_mem_phys, msg_addr,
> @@ -906,15 +919,6 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		ep->msi_iatu_mapped = true;
>  		ep->msi_msg_addr = msg_addr;
>  		ep->msi_map_size = map_size;
> -	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> -				ep->msi_map_size != map_size)) {
> -		/*
> -		 * The host changed the MSI target address or the required
> -		 * mapping size changed. Reprogramming the iATU at runtime is
> -		 * unsafe on this controller, so bail out instead of trying to
> -		 * update the existing region.
> -		 */
> -		return -EINVAL;
>  	}
>  
>  	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> 
> base-commit: 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c
> -- 
> 2.53.0
> 
