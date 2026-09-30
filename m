Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA27485CE6;
	Wed, 30 Sep 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810541; cv=none; b=U7RKq+p2KpXYm4CDXm0OfqzO3qcuwsoN6QvrKGx+lIu9ZKVcgU4/oPDkqcnOg19dgGBgqlyjFxKNAUuHvSfMz+MbDF8jqxUpg2PTlRSJjZDmmd62EubaPBvdgL5aql9LvHi88xtAGB03bkJGzivgJtEl/OXtIDxTH5HIStkzSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810541; c=relaxed/simple;
	bh=U8RDGfOn+t68iG0Wq66H3y3WLPr+1Hc4Ul2owVTW1go=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ggsa7Ps+jblAGqUHH0tBHKJoCN24erW9ddHIlLLgtx6B3/VfcIcXzoq8XHbgIJBWZgQhUES41fNjTP365G2qewMcb3i4Ep3LB+RWjeHIhPfRCY5ns1st3EYbpg7ZjCdMsL/GY0M9GUvXOJhRH7QBPhhiW1zUTGL90e8I2KzeYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV07zrBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV07zrBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8826E1F000FF;
	Wed, 30 Sep 2026 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810535;
	bh=K3u0kJIZ8utzgpR3jmBh/sLWmgc71QGkAzChJQvdqJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZV07zrBPGpAyBiXEQxi3wfcaDA0wC76apsZpOWavdrGkNOULKisKjHB7/xvy7dNxm
	 mDjqoEfB6Wnbis6LUchAC8NLfE3ogG1bWLIoU0dKLOkdi7rMooGhqQ1Q+bVggvXGS7
	 /dY1OUtJaW8n0OiOLzd3GDFSZv/ovUoOGwLH6ZHFFnGE0GFdSkiQV9cpZwOPvgiiKM
	 hdhXz7M7aWWZnRAXT6rkR8wkt8cUG8fw0yXcJBja3+wi6k56kJi4IkS7j6Khu4kCh9
	 iXVtv4bKCnK6E0rp+jlNRPMDXmf8tQTCuXyVmQR5hPhIWzb20qQPzKa6UIsnIYnaOY
	 aN1k1EJlu+h8g==
Date: Wed, 30 Sep 2026 18:22:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] PCI: Write RCB only when it changes
Message-ID: <20260930232214.GA2654517@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930144650.3701516-2-stefan.roese@mailbox.org>

On Wed, Sep 30, 2026 at 04:46:49PM +0200, Stefan Roese wrote:
> pci_configure_rcb() does a read-modify-write of the Link Control
> register of every endpoint at enumeration, even when RCB already has
> the right value. Some devices react to any write of this register.
> 
> The Renesas uPD720201 xHCI (1912:0014) comes out of reset with ASPM L0s
> and L1 enabled in Link Control. On a link whose Root Port supports no
> ASPM, nothing else writes that register before the driver loads, and
> the chip clears ASPM Control itself during the firmware download. After
> a host write, even of the unchanged value 0x0003, it no longer does
> so. ASPM stays enabled, and the first access to the xHCI BAR runs into
> PCIe completion timeouts that hang the system.

In "After a host write, even of the unchanged value 0x0003, it no
longer does so", what are you saying it no longer does?

Are you saying the chip no longer clears ASPM Control during firmware
download?

The PCIe Mini Card CEM and M.2 specs both say L0s and L1 should be
enabled by default, so I guess it makes sense that they're set when
coming out of reset.

But PCIe r7.0, sec 5.4.1.4, says the result is undefined if software
enables L0s when the other end of the link doesn't support it, and I
guess writing 0x0003 (ASPM L0s and L1 enabled) counts as enabling L0s,
and we certainly got undefined results.

> Seen on an AMD Versal board (CPM Root Port without ASPM support): the
> hang bisects to this commit, reverting it fixes it, and on a kernel
> without it a single setpci write of the unchanged value reproduces it.
> 
> Read Link Control first and write it only when RCB has to change.
> 
> Fixes: 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
> ---
>  drivers/pci/probe.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 721daf5c5184..35e794df3be4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2426,7 +2426,7 @@ static void pci_configure_serr(struct pci_dev *dev)
>  static void pci_configure_rcb(struct pci_dev *dev)
>  {
>  	struct pci_dev *rp;
> -	u16 rp_lnkctl;
> +	u16 rp_lnkctl, lnkctl, rcb;
>  
>  	/*
>  	 * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root Ports
> @@ -2448,10 +2448,17 @@ static void pci_configure_rcb(struct pci_dev *dev)
>  		return;
>  
>  	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &rp_lnkctl);
> -	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> -					   PCI_EXP_LNKCTL_RCB,
> -					   (rp_lnkctl & PCI_EXP_LNKCTL_RCB) ?
> -					   PCI_EXP_LNKCTL_RCB : 0);
> +	rcb = rp_lnkctl & PCI_EXP_LNKCTL_RCB;
> +
> +	/*
> +	 * Write Link Control only when RCB actually changes. Some devices
> +	 * react to any write of this register, even one with an unchanged
> +	 * value.
> +	 */
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +	if ((lnkctl & PCI_EXP_LNKCTL_RCB) != rcb)
> +		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_RCB, rcb);

What if we just did this:

  if (rp_lnkctl & PCI_EXP_LNKCTL_RCB)
    pcie_capability_set_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);

I don't know if it's ever necessary to *clear* RCB.  If RCB is set in
an Endpoint when it's not set in the Root Port, that would be a
firmware configuration error.

Either way, it's ugly magic to avoid the ASPM Control write here based
on the unrelated RCB settings.  But avoiding the read/modify/write is
probably worth doing just from a performance point of view.
