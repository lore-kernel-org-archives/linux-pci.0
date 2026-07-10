Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C844998C;
	Fri, 10 Jul 2026 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714622; cv=none; b=TObX/DvXXONytiX5ps94HWjumdfNBwjJZl3tlNyQZj87o7FuwNBgx9jJ+SpZh3ireglvSdV2sUSdP7FJuWfdzip/2SgRCECfs0esHyoF8Tx6lc28gdl1/USrACjZnGmnqHc7dWjXv+1i0aZ+/Rb0NyEBM4dTaBi10dCIcz94/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714622; c=relaxed/simple;
	bh=rPw/IkGqGaYkMuAevdkQZCf6BQBHZ21v0QoQekUZ1No=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D12kyZBcqKva9gyZ2uw3ogMzVbLgwv3HvMXnv53HcR5HKPyqIjDGV6UHWoK4M4WHP0EbD1me2mbA/s0E11hujs9/iRsepXoFlrNEuumQtaxbxBoMQEsFTBFecdiMxjXOXYFQish6VbHZkSv/6WqHEbi54O+3SU5gGpABjgxb7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCkcNxfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCkcNxfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129521F000E9;
	Fri, 10 Jul 2026 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714620;
	bh=uoBuMRQokdCMiPDOQJWOMhvJEOG9FT6vXTuL6pjzzyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FCkcNxfUveeXJaKJmpNVZoqwu+ptX77LARYkL/Mzh+xboIvTLwNi2lsuVbJFus5/G
	 U1VL7IjaeuCLwRGMq9TyHw1Qx0CCaRghagTxjZdr5zl2YuUfK6VYTyzUSEo0J61xw3
	 lAztaJn/SVumD3sr6stj8fdoCoYahw5EMLJALq3jcWOpDjslm2XHVA2GFIBzyyZZtA
	 npXokxBPnaeQu0WSccVBaFje/Pc+qv//uMDNnOUb7gK+ie0D57CZH5FIKIlHjn6C9j
	 AkPPa/3twDDDGiON26p419g/z7/HwWiK10NlzUTr/rTs061Whu1uGKP8/hbZXMG089
	 HNXPG+5adoHXw==
Date: Fri, 10 Jul 2026 15:16:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	mrh@frame.work, stern@rowland.harvard.edu, hannes@vonhaugwitz.com,
	jase_harley@protonmail.com, superveridical@gmail.com,
	david.c.hubbard@gmail.com, bugzilla@logical.ink,
	michal.pecio@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: Apply mandatory recovery delay on return from D3cold
Message-ID: <20260710201658.GA987633@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708152650.536604-2-mario.limonciello@amd.com>

[+cc Rafael, linux-pm]

On Wed, Jul 08, 2026 at 10:26:50AM -0500, Mario Limonciello wrote:
> Per the "PCI Bus Power Management Interface Specification", rev. 1.2,
> sec. 5.4, there is a minimum recovery time between programming a function
> from D3 to D0 and accessing it.  The spec does not limit this to D3hot; it
> applies to the D3cold to D0 transition as well.
> 
> pci_power_up() only honors this delay on the D3hot branch.  When a device
> returns from D3cold, platform_pci_set_power_state() has already restored
> main power before PCI_PM_CTRL is read, so the state read from the register
> is D0 and the transition delay block is skipped by the
> 
> 	if (state == PCI_D0)
> 		goto end;
> 
> early return.  The register value is masked with PCI_PM_CTRL_STATE_MASK
> and cannot represent D3cold, so only dev->current_state still reflects the
> D3cold origin at this point.
> 
> Apply the delay based on dev->current_state, ahead of the early return, so
> it takes effect on the D3cold to D0 path before the device is accessed.
> Use the device's d3cold_delay, which the platform may tune via _DSM and
> quirks may raise, rather than the D3hot delay.
> 
> To keep the existing D3hot callers unchanged, pci_dev_d3_sleep() now takes
> the delay in milliseconds and a pci_dev_d3hot_sleep() wrapper supplies the
> D3hot delay as before.
> 
> Reported-by: mrh@frame.work
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221073
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: mrh@frame.work
> Cc: stern@rowland.harvard.edu
> Cc: hannes@vonhaugwitz.com
> Cc: jase_harley@protonmail.com
> Cc: superveridical@gmail.com
> Cc: david.c.hubbard@gmail.com
> Cc: bugzilla@logical.ink
> Cc: michal.pecio@gmail.com
> ---
>  drivers/pci/pci.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..e09cfb28fe61c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -81,9 +81,8 @@ struct pci_pme_device {
>   */
>  #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
>  
> -static void pci_dev_d3_sleep(struct pci_dev *dev)
> +static void pci_dev_d3_sleep(unsigned int delay_ms)
>  {
> -	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
>  	unsigned int upper;
>  
>  	if (delay_ms) {
> @@ -94,6 +93,11 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  	}
>  }
>  
> +static void pci_dev_d3hot_sleep(struct pci_dev *dev)
> +{
> +	pci_dev_d3_sleep(max(dev->d3hot_delay, pci_pm_d3hot_delay));
> +}
> +
>  bool pci_reset_supported(struct pci_dev *dev)
>  {
>  	return dev->reset_methods[0] != 0;
> @@ -1333,6 +1337,16 @@ int pci_power_up(struct pci_dev *dev)
>  	need_restore = (state == PCI_D3hot || dev->current_state >= PCI_D3hot) &&
>  			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
>  
> +	/*
> +	 * A device returning from D3cold has already been powered back on by
> +	 * platform_pci_set_power_state() above, so PCI_PM_CTRL now reads back
> +	 * as D0 and the transition delays below are skipped.  PCI PM 1.2 still
> +	 * requires a minimum recovery time on the D3 to D0 transition, so apply
> +	 * the device's D3cold recovery delay here before it is accessed.
> +	 */
> +	if (dev->current_state == PCI_D3cold)
> +		pci_dev_d3_sleep(dev->d3cold_delay);

My understanding is that the "mandatory transition delays" below only
cover a transition caused by the write to PCI_PM_CTRL, which would be
from D1, D2, or D3hot to D0.

If the device started in D3cold, platform_pci_set_power_state(PCI_D0)
should transition it to D0uninitialized *and* take care of any
required delays [1].  The device should be Configuration-Ready upon
return (and we've already read PCI_PM_CTRL above, and the read
returned something other than PCI_ERROR_RESPONSE).

But evidently adding more delay does make a difference, even though
the config read of PCI_PM_CTRL seemed successful.  I guess it's
conceivable that platform AML doesn't wait quite long enough, although
it does seem to affect more than one platform (AMD Strix Halo,
Framework Desktop/AMD Ryzen AI Max 300, Lenovo ThinkPad T14 Gen 6 AMD
Ryzen AI 7 Pro 350), and I *assume* the issue doesn't happen under
Windows?

[1] https://lore.kernel.org/linux-pci/CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com/

>  	if (state == PCI_D0)
>  		goto end;
>  
> @@ -1344,7 +1358,7 @@ int pci_power_up(struct pci_dev *dev)
>  
>  	/* Mandatory transition delays; see PCI PM 1.2. */
>  	if (state == PCI_D3hot) {
> -		pci_dev_d3_sleep(dev);
> +		pci_dev_d3hot_sleep(dev);
>  		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>  			ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
>  					   PCIE_RESET_READY_POLL_MS);
> @@ -1514,7 +1528,7 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>  
>  	/* Mandatory power management transition delays; see PCI PM 1.2. */
>  	if (state == PCI_D3hot)
> -		pci_dev_d3_sleep(dev);
> +		pci_dev_d3hot_sleep(dev);
>  	else if (state == PCI_D2)
>  		udelay(PCI_PM_D2_DELAY);
>  
> @@ -4511,12 +4525,12 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	csr &= ~PCI_PM_CTRL_STATE_MASK;
>  	csr |= PCI_D3hot;
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> -	pci_dev_d3_sleep(dev);
> +	pci_dev_d3hot_sleep(dev);
>  
>  	csr &= ~PCI_PM_CTRL_STATE_MASK;
>  	csr |= PCI_D0;
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> -	pci_dev_d3_sleep(dev);
> +	pci_dev_d3hot_sleep(dev);
>  
>  	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
>  	pci_dev_reset_iommu_done(dev);
> -- 
> 2.43.0
> 
