Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC342589D;
	Mon,  5 Oct 2026 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240022; cv=none; b=sjGwp+OoE3gxsnoCjqGaGAqpA39gTyVokiFJurfWCFP7LRPJtyef76aEGejAx0D1Zy3fLECYat0AF7M93Kdru1MvPmpFZxSbpUINInjEcyovqp0TVfxC+f98cAxLeguFzWxnQN2Jfu4QxpAqBCAhjDWco3woyhuhqanzC7RxsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240022; c=relaxed/simple;
	bh=UM0Xi/JZd4N2y5und5uHDw0FoxFZgGSZxQcAIEPVTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=snp7p4T3F/SwRCOna0WZTxuXddQkkMbL1gO6t17Rv6G4i9zZ/zmWutEjuZ3dI0R99DBuYcRq5YDgdOPa89c0d0wKd/XiB5HSFzFDjd4W6iRgPVs8z67pSEIfDBol9526TGN1FX6jx78Kuu8gZwGP6g6GMTfYXIxegOiRxwgEkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rro2lZur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rro2lZur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E87A1F000FF;
	Mon,  5 Oct 2026 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240018;
	bh=52nVtOT3G96Gyj6QO/uH5eYOSdEZZOHfDTfAvP2bxYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Rro2lZurrQcJdOyMQc20jesiEhuFoPZb6BQ6qKb7uEoct654EueJMu0TykAZHB60+
	 viHM9cri9eWZiV46OhTFZryolsYxfLrm1r/vGivNIS2Qpu3+Wb5utX3k0QlCvlxDo/
	 J7Olx5SgznrUowN0vHNgYta7p46YElTV/y20UTQFLV7T/Q6fz9s7sEzpnEaND1lNke
	 eotAHlFErkIjV6ZrwS99Rh3BOI4hV3pKY/kQuoiQSKS06cubh5kQZluu8Svp0eg3xS
	 lFIKPbHuCezxam+NSidQIEPAgOfyg0C3Q0BD4fCF0BwZzxMp1N4F0b0pJU/OrtwjQo
	 lP2JV7NDr107w==
Date: Mon, 5 Oct 2026 17:40:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, terry.bowman@amd.com, kanie@linux.alibaba.com,
	olof@lixom.net, Koichiro Den <den@valinux.co.jp>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v15 4/4] PCI: Centralize pci_aer_available() checking
Message-ID: <20261005224016.GA630371@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a4a8f1-f2c6-46d2-ba5f-370f12b73afd@linux.intel.com>

[cc->to: Rafael, insight on f1a7bfaf6bb9 ("PCI: PCIe AER: Introduce pci_aer_available()")]
[+cc Koichiro, Mani, Frank, Brian]

On Mon, Oct 05, 2026 at 11:04:25AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 10/2/2026 2:18 PM, Kuppuswamy Sathyanarayanan wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > "pci=noaer" tells us not to use AER.  pci_aer_available() reports that,
> > and it also reports the other cases where the OS cannot use AER at all,
> > namely CONFIG_PCIEAER=n and MSI being unavailable.
> > 
> > Set host_bridge->native_aer from pci_aer_available() when we initialize
> > the host bridge, so callers only have to look at native_aer and we do not
> > have to test pci_aer_available() separately in each of them.
> > 
> > Do this in pci_init_host_bridge() rather than in acpi_pci_root_create()
> > so it also covers host bridges that are not described by ACPI and never
> > reach acpi_pci_root_create().
> > 
> > This subsumes the CONFIG_PCIEPORTBUS check for native_aer, since
> > pci_aer_available() is false when CONFIG_PCIEAER=n and PCIEAER depends on
> > PCIEPORTBUS.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > ---
> 
> Sashiko's comment [1] looks valid to me. quirk_disable_all_msi() calls
> pci_no_msi() during pci_bus_add_devices(), after native_aer has been
> set. That leaves native_aer stale. At boot, pcie_aer_init() checks
> pci_aer_available() again, so the AER driver still won't register. But
> other native_aer users see the stale value.
> 
> The patch below clears native_aer in pci_no_msi(). Would you like a v16
> with it before this patch, or would you rather fold it in?

I agree that looks like an issue.

But I'm not sure it's legit for pci_aer_available() to depend on MSI
being available in the first place.  I think AER should work with
INTx, and I think there are systems where we should use AER with INTx,
e.g.,

  https://lore.kernel.org/linux-pci/20260928165230.3397664-14-den@valinux.co.jp/
  https://lore.kernel.org/linux-pci/20250702223841.GA1905230@bhelgaas/t/#u

I'm not sure if anything would break if we just removed the
pci_msi_enabled() check from pci_aer_available().

If it wouldn't break anything, I'd rather remove that test than try to
fix the issue by adding pci_aer_no_msi() as below.

pci_aer_available() was added by f1a7bfaf6bb9 ("PCI: PCIe AER:
Introduce pci_aer_available()"), and the MSI check was there from the
beginning.

> [1] https://lore.kernel.org/linux-pci/20261003013359.A38F61F00898@smtp.kernel.org/
> 
> Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Date:   Mon Oct 5 10:29:19 2026 -0700
> 
>     PCI/AER: Clear native_aer when MSI is disabled after host bridge init
> 
>     pci_aer_available() reports that AER is unusable when MSI is disabled.
>     A quirk such as quirk_disable_all_msi() can call pci_no_msi() during
>     enumeration, after pci_init_host_bridge() and the _OSC negotiation have
>     already set host_bridge->native_aer. In that case native_aer stays set
>     even though the OS can no longer use AER.
> 
>     Clear native_aer on all registered host bridges when MSI is disabled.
>     Host bridges added later start with native_aer cleared because
>     pci_aer_available() is already false. _OSC negotiation and
>     "pcie_ports=native" can only clear native_aer, so they cannot set it
>     again.
> 
>     This keeps native_aer accurate so callers can rely on it instead of
>     checking pci_aer_available() separately.
> 
>     Reported-by: sashiko-bot@kernel.org
>     Closes: https://lore.kernel.org/linux-pci/20261003013359.A38F61F00898@smtp.kernel.org/
>     Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 80a9db417dc8..911e61fbda31 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -995,4 +995,5 @@ EXPORT_SYMBOL(msi_desc_to_pci_dev);
>  void pci_no_msi(void)
>  {
>         pci_msi_enable = false;
> +       pci_aer_no_msi();
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..11f47d5fda21 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1331,6 +1331,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
> 
>  #ifdef CONFIG_PCIEAER
>  void pci_no_aer(void);
> +void pci_aer_no_msi(void);
>  void pci_aer_init(struct pci_dev *dev);
>  void pci_aer_exit(struct pci_dev *dev);
>  extern const struct attribute_group aer_stats_attr_group;
> @@ -1342,6 +1343,7 @@ void pci_save_aer_state(struct pci_dev *dev);
>  void pci_restore_aer_state(struct pci_dev *dev);
>  #else
>  static inline void pci_no_aer(void) { }
> +static inline void pci_aer_no_msi(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e84dd686582a..494fdd20798d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -154,6 +154,19 @@ bool pci_aer_available(void)
>         return !pcie_aer_disable && pci_msi_enabled();
>  }
> 
> +/*
> + * AER depends on MSI (see pci_aer_available()).  If MSI is disabled after
> + * host bridges have been initialized, e.g., by a quirk, the OS can no
> + * longer use AER on them.
> + */
> +void pci_aer_no_msi(void)
> +{
> +       struct pci_bus *bus = NULL;
> +
> +       while ((bus = pci_find_next_bus(bus)))
> +               pci_find_host_bridge(bus)->native_aer = 0;
> +}
> +
>  #ifdef CONFIG_PCIE_ECRC
> 
>  #define ECRC_POLICY_DEFAULT 0          /* ECRC set by BIOS */
> 
> 
> > Changes since v14
> > 
> >  * No change.
> > 
> > v14 posting
> > https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com
> > 
> > Changes since v13
> > 
> >  * No change.
> > 
> > v13 posting
> > https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com
> > 
> >  drivers/pci/pcie/portdrv.c | 3 +--
> >  drivers/pci/probe.c        | 2 +-
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 32fc623dd410..9f8c6dd434c5 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -239,8 +239,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  #ifdef CONFIG_PCIEAER
> >  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> > -	    dev->aer_cap && pci_aer_available() &&
> > -	    host->native_aer)
> > +	    dev->aer_cap && host->native_aer)
> >  		services |= PCIE_PORT_SERVICE_AER;
> >  #endif
> >  
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 1e487a213eb0..e1ca8096bcd5 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -670,7 +670,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> >  	 * may implement its own AER handling and use _OSC to prevent the
> >  	 * OS from interfering.
> >  	 */
> > -	bridge->native_aer = port_services;
> > +	bridge->native_aer = pci_aer_available();
> >  	bridge->native_pcie_hotplug = port_services;
> >  	bridge->native_shpc_hotplug = 1;
> >  	bridge->native_pme = port_services;
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 
