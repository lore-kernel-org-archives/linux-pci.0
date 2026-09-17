Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08F22A4E9;
	Thu, 17 Sep 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604611; cv=none; b=sigyNMKU6K4tjH8TUeIosoAiWvSXmJ7XQSe2V2oFOZgBD+7IGfyJL3/Lwhgo6yLxFTL21yQkRgKM7UI5PrQbm+1VD7Em5+LwtMGerADF3ZM6SSZ8oLT77lNHfXfMXSeibXkyp5HPCPQkQx0CVM6SQnfI+dQQ7Dqqn2BF0DYtMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604611; c=relaxed/simple;
	bh=45Qi8DXYwJHObfTQpek2UWQI/FH3xeNUZtUwrfo2/Co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TlNi42ZPzFX6N466rFS38qaAkPyaoPJjo6dkAjDVBHTsXdTqt9dnTbzTSVStZWLlrNLRtlA0lBR9MSC5dyCyG5m7YfGiPyQP5QnCkESUwsynmSFh/SQFVGq2vJcUMlqLXnIfAL3b2jbKAnd5InWVENxjP9L9v/NGV1gy8ks+O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uaczt0oD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uaczt0oD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D801F000FF;
	Thu, 17 Sep 2026 00:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604609;
	bh=BYq4fZIoFhLtPEIgNGcHeKoYgNlbKrrDbCQCa193GqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Uaczt0oDsYk8FN3ojEgKvdY1DeqU6zoNXXMnQqPOTDXF6YL5rRKYv3Opo0gGEC4tc
	 ir6Y2Ji9QCmt4oSSQIwBhL1kkVNOlPZFg4QXH70AOPpVZTMjLzyLWxoTVyEolXKFoM
	 dvB/2CMnvKoj1QsigbEHWuBF9URuMwekTo1t2ZWpF2goI6+SrnjB+E2oxr8zfHcqnW
	 LuBDyk9pdcpOmU1ah6P4J2DqtTZz08Dke/63uQa7m8a5begeSsMWIQAhwQcg0s66lB
	 05Kvt1jFEMK08+vkOdoeScR7/E7PaagQWYerR3lQChifp0sTXGzb9eujUnyELudeB/
	 9G3xVW7/lYrOg==
Date: Wed, 16 Sep 2026 19:23:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <20260917002328.GA994546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqgkxmXlhfqsdfAa@google.com>

On Mon, Sep 14, 2026 at 04:45:58PM +0000, David Matlack wrote:
> On 2026-09-11 06:31 PM, David Matlack wrote:
> > On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> > 
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 77b17b13ee61..22001bdf4c97 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -34,6 +34,8 @@
> > > >  #include <linux/aer.h>
> > > >  #include <linux/bitfield.h>
> > > >  #include <linux/suspend.h>
> > > > +
> > > > +#include "liveupdate.h"
> > > >  #include "pci.h"
> > > >  
> > > >  DEFINE_MUTEX(pci_slot_mutex);
> > > > @@ -1008,6 +1010,9 @@ void pci_enable_acs(struct pci_dev *dev)
> > > >  	bool enable_acs = false;
> > > >  	int pos;
> > > >  
> > > > +	if (!pci_liveupdate_enable_adopted_acs_controls(dev))
> > > > +		return;
> > > 
> > > Ugh.  The asymmetry between pci_save_state(), which does nothing
> > > ACS-related, and pci_restore_state(), which enables it, is sort of
> > > sketchy to begin with.
> > > 
> > > The command-line parsing in this path feels like kind of a wart (not
> > > that you're touching it).
> > > 
> > > It just seems like this path is already hard to analyze, and
> > > liveupdate is making it harder.
> > > 
> > > If we could save/restore the ACS state around the reset, wouldn't that
> > > solve this without any liveupdate specials here?
> > 
> > Yeah that would simplify the liveupdate support greatly. Let me work on
> > that for v9.
> 
> Here's the patch I have prepped for v9 to save/restore ACS controls
> around reset:
> 
> From 0c69424454de0c569aca67bc69f496db915a9bcf Mon Sep 17 00:00:00 2001
> From: David Matlack <dmatlack@google.com>
> Date: Fri, 11 Sep 2026 20:05:04 +0000
> Subject: [PATCH] PCI: Save and restore the ACS Control register
> 
> Save the ACS Control register in pci_save_state() and write it back
> in pci_restore_state(), instead of recomputing the ACS controls from
> scratch with pci_enable_acs().
> 
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
> 
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS Control register there as
> well, otherwise a subsequent reset would revert ACS back to the
> configuration left behind by firmware.
> 
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so keep
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Matlack <dmatlack@google.com>

I like this a lot, thanks!  It would be good to get Alex W's ack, too.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.h    |  5 ++++
>  drivers/pci/quirks.c |  7 +++++
>  3 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..dd25c01736b4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1021,6 +1021,55 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>  		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
>  }
>  
> +/**
> + * pci_save_acs_state - save the ACS Control register
> + * @dev: the PCI device
> + *
> + * Record the ACS controls currently programmed in hardware so that
> + * pci_restore_acs_state() can reapply them after a reset.
> + */
> +static void pci_save_acs_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +
> +	if (!dev->acs_cap)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!save_state)
> +		return;
> +
> +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL,
> +			     (u16 *)&save_state->cap.data[0]);
> +}
> +
> +/**
> + * pci_restore_acs_state - restore the ACS Control register
> + * @dev: the PCI device
> + */
> +static void pci_restore_acs_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state = NULL;
> +
> +	if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
> +		save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
> +
> +	/*
> +	 * Devices that rely on device-specific quirks to enable an ACS
> +	 * equivalent keep that configuration outside of the ACS Control
> +	 * register, so there is nothing useful to restore for them. Configure
> +	 * ACS from scratch instead, which also covers devices that have no
> +	 * saved ACS state at all.
> +	 */
> +	if (!save_state) {
> +		pci_enable_acs(dev);
> +		return;
> +	}
> +
> +	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL,
> +			      *(u16 *)&save_state->cap.data[0]);
> +}
> +
>  /**
>   * pci_enable_acs - enable ACS if hardware support it
>   * @dev: the PCI device
> @@ -1057,6 +1106,15 @@ void pci_enable_acs(struct pci_dev *dev)
>  	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
>  
>  	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
> +
> +	/*
> +	 * pci_enable_acs() runs when a driver binds to the device, i.e. after
> +	 * pci_bus_add_device() has already saved the device's state. Refresh
> +	 * the saved ACS Control register so that a subsequent reset restores
> +	 * the controls programmed here rather than the ones left behind by
> +	 * firmware.
> +	 */
> +	pci_save_acs_state(dev);
>  }
>  
>  /**
> @@ -1800,6 +1858,7 @@ int pci_save_state(struct pci_dev *dev)
>  	pci_save_aer_state(dev);
>  	pci_save_ptm_state(dev);
>  	pci_save_tph_state(dev);
> +	pci_save_acs_state(dev);
>  	return pci_save_vc_state(dev);
>  }
>  EXPORT_SYMBOL(pci_save_state);
> @@ -1877,7 +1936,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_msi_state(dev);
>  
>  	/* Restore ACS and IOV configuration state */
> -	pci_enable_acs(dev);
> +	pci_restore_acs_state(dev);
>  	pci_restore_iov_state(dev);
>  
>  	dev->state_saved = false;
> @@ -3532,6 +3591,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>  	if (error)
>  		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>  
> +	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS,
> +					    sizeof(u16));
> +	if (error)
> +		pci_err(dev, "unable to allocate suspend buffer for ACS\n");
> +
>  	pci_allocate_vc_save_buffers(dev);
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..037c1674f164 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1095,6 +1095,7 @@ void pci_acs_init(struct pci_dev *dev);
>  void pci_enable_acs(struct pci_dev *dev);
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
> +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
>  void pci_disable_broken_acs_cap(struct pci_dev *pdev);
> @@ -1105,6 +1106,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
>  {
>  	return -ENOTTY;
>  }
> +static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
> +{
> +	return false;
> +}
>  static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  {
>  	return -ENOTTY;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7aee30734303..e500c202d2ec 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5476,6 +5476,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
>  	return NULL;
>  }
>  
> +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
> +{
> +	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
> +
> +	return p && p->enable_acs;
> +}
> +
>  int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  {
>  	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
