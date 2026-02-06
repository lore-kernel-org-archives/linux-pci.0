Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD7309EE9;
	Fri,  6 Feb 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418746; cv=none; b=Fj94aGGtE8mCxs3MVI0nooLuTAerFPZoQKewClSXih5EgOPkZ0EE9cQPbpkQMOHv5nrE+MGDPVB4KYCq/GNKp8hRn8W4UNCcFI6P7cQqGyOVExtm7n9/NjxU7PC4ZYBiMRw3N1Jv4KXO1mOsoUPWYKyQD7w18DF8Bde+QOrSnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418746; c=relaxed/simple;
	bh=79gUol5oeNcxMoawxQyWlDCHIdz7vTlXoRbNh+iyTJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=td/hJyDNdWzfovzisGy/ArPwTcDUPux/wHcnIhtJUNj8o36C/R0/UV6qANVtLCOkAXarDxtNmpZz0RIGRFFZ1BdBOSe/0uPsaie8d8fpRU+cIqfalu3n1SWHUpt8vxECLglY0u727aNJ2mZLOEZQUe/6Wvrz3RSvDzpemFOeruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnOBHWi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnOBHWi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E8C116C6;
	Fri,  6 Feb 2026 22:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770418746;
	bh=79gUol5oeNcxMoawxQyWlDCHIdz7vTlXoRbNh+iyTJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pnOBHWi+IDzNqmI/qp00vvOe6AI6lggVmBRXUNbnd2La57yxpUNP07QwHXETHodEJ
	 fIK1WQdhqAsunekuF0cZJzwOTahENbnhejycYhaAIblS+cMGRsoWYc28gyI56cJltL
	 0VZ8fSmNYs1//eCHPHsHjMjGUOG4MboLUTInlMFto59Du53LAWgw23EkxDeCjqUDTH
	 l8ZxXujfoClyZmVRHNxxEJqYPO9bqwMM5nfJQvh5ZNVGJO/P8WwkCQzjsNrVMfb2aP
	 fBE2FSiRziwmqkGnYvPfpAWbUal+l0tJ/hFOvYl+PzrNUkgcBLY+WHXTuueJHM8Iq6
	 EM1ze3qK+XNSQ==
Date: Fri, 6 Feb 2026 16:59:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adam Stylinski <kungfujesus06@gmail.com>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable BW controller on Intel P45 using
 a quirk
Message-ID: <20260206225905.GA103793@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116131513.2359-1-ilpo.jarvinen@linux.intel.com>

On Fri, Jan 16, 2026 at 03:15:12PM +0200, Ilpo Järvinen wrote:
> The commit 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as
> PCIe BW controller") was found to lead to a boot hang on a Intel P45
> system. Testing without setting Link Bandwidth Management Interrupt
> Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable (LABIE)
> (PCIe r7.0, sec. 7.5.3.7) in bwctrl allowed system to come up.
> 
> P45 is very old chipset and supports only up to gen2 PCIe, so not
> having bwctrl does not seem a huge defiancy.
> 
> Add no_bw_notif into the struct pci_dev and quirk Intel P45 Root Port
> with it.
> 
> Reported-by: Adam Stylinski <kungfujesus06@gmail.com>
> Link: https://lore.kernel.org/linux-pci/aUCt1tHhm_-XIVvi@eggsbenedict/
> Tested-by: Adam Stylinski <kungfujesus06@gmail.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/bwctrl for v6.20, thanks!

> ---
>  drivers/pci/pcie/bwctrl.c |  3 +++
>  drivers/pci/quirks.c      | 10 ++++++++++
>  include/linux/pci.h       |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 36f939f23d34..4ae92c9f912a 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -250,6 +250,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	struct pci_dev *port = srv->port;
>  	int ret;
>  
> +	if (port->no_bw_notif)
> +		return -ENODEV;
> +
>  	/* Can happen if we run out of bus numbers during enumeration. */
>  	if (!port->subordinate)
>  		return -ENODEV;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..6ef42a2c4831 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1359,6 +1359,16 @@ static void quirk_transparent_bridge(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
>  
> +/*
> + * Enabling Link Bandwidth Management Interrupts (BW notifications) can cause
> + * boot hangs on P45.
> + */
> +static void quirk_p45_bw_notifications(struct pci_dev *dev)
> +{
> +	dev->no_bw_notif = 1;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notifications);
> +
>  /*
>   * Common misconfiguration of the MediaGX/Geode PCI master that will reduce
>   * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..3a556cd749e3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -406,6 +406,7 @@ struct pci_dev {
>  						      user sysfs */
>  	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
>  						   bit manually */
> +	unsigned int	no_bw_notif:1;	/* BW notifications may cause issues */
>  	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>  
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.39.5
> 
