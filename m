Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9F3DB65A;
	Mon, 27 Jul 2026 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192843; cv=none; b=A4t1AlbpSGECZKK+QKd3bEB9u2BqKMsmTbLbhRIi3Gb2rJ8S9YquvWkzErAXA/l1KoOendsMUjHwJUhT3XEv6zFSwioKwW45qk8POJjQLjCyu+6kEcxjrPZBHLcxZrKgHPnVrEBo8wjzwIecOHkhhLgOEMKYex0QN/c/ad1DqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192843; c=relaxed/simple;
	bh=8lAX4u4qBuEyC0piJ4XOh83+KCAtXo79d2zZDhFkK+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NlsbLGmh5Y460gu3NUg2061St53oBt94lC/uyqeRhkCx9JG9Dq5QrH59so919v3Ck0607zlp3m5tsO+BNhtF4DwNw8yg+XnplfXBWXkmT7nOE+NdhLRvqA2Plwwu09AkYyvc/e2S07UaPjs5BCXkuPvW3aC9y6Unw5o/Jpi3uCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdhHZ6vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdhHZ6vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFE51F000E9;
	Mon, 27 Jul 2026 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192842;
	bh=wzEADzszazudvM+mpqKAM13o7pzH0H70PQ6nFm/sYJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fdhHZ6vvNE6r0xko/6hmPrLINTRlpo1xuEGDUDuMUchRa9mtRfUsEw59kodiLfLbv
	 N4+ogqJwuxIOuWqkFLHo/D+525REdcUDA1jPeb1uvGKNS0SAs+kznLYIkNFApI/beq
	 L28aIRtO9mCudctoE1EoaYLtXa7uCIWrIn7SyMb4yYvsrtJ6Yl0Soh9tNQFlYAHASE
	 EiXCh8HQ3qvF8WYi3Lb+kfffzGwRFq6mKQTxBEf7k0TsRvdIrh/5wdgudbAVV8s3EU
	 +WztCjkBcWR6N0NBh5/Ai0oHmFiDPYOxotmrKXw9OW5AIGMjSWJF0sfZFB2GMXuG93
	 Ux1qQEFUM8yEg==
Date: Mon, 27 Jul 2026 17:54:00 -0500
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
Subject: Re: [PATCH v7 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <20260727225400.GA1268182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-9-dmatlack@google.com>

On Fri, Jul 10, 2026 at 09:26:11PM +0000, David Matlack wrote:
> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
> 
> Cache the inherited ACS controls established by the previous kernel in
> struct pci_dev so that ACS controls do not change after a reset
> (pci_restore_state() calls pci_enable_acs()).
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h       | 11 ++++++
>  drivers/pci/pci.c              |  6 +++
>  drivers/pci/pci.h              |  5 +++
>  drivers/pci/quirks.c           |  7 ++++
>  include/linux/pci_liveupdate.h |  6 +++
>  6 files changed, 103 insertions(+)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 7f7710cb1da0..a95bfe5eff77 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -71,6 +71,9 @@
>   *
>   *  * The device cannot be a Virtual Function (VF).
>   *
> + *  * The device cannot require device-specific quirks to enable Access
> + *    Control Services (ACS).
> + *
>   * Driver Binding
>   * ==============
>   *
> @@ -113,6 +116,18 @@
>   * This enables the PCI core and any drivers bound to the bridge to participate
>   * in the Live Update so that preserved endpoints can continue issuing memory
>   * transactions during the Live Update.
> + *
> + * Handling Preserved Devices
> + * ==========================
> + *
> + * The PCI core treats preserved devices differently than non-preserved devices.
> + * This section enumerates those differences.
> + *
> + *  * The PCI core inherits all ACS flags enabled on incoming preserved devices
> + *    rather than assigning new ones. This ensures that TLPs are routed the same
> + *    way after Live Update and ensures that IOMMU groups do not change. Note
> + *    that a device will use its inherited ACS flags for the lifetime of its
> + *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
>   */
>  
>  #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> @@ -128,6 +143,7 @@
>  #include <linux/slab.h>
>  
>  #include "liveupdate.h"
> +#include "pci.h"
>  
>  /**
>   * struct pci_liveupdate_global - Global state for PCI Live Update support
> @@ -374,6 +390,16 @@ static int __pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, s
>  {
>  	struct pci_dev_ser *dev_ser;
>  
> +	/*
> +	 * Do not preserve devices that rely on device-specific ACS equivalents
> +	 * (for now) since that would complicate keeping ACS constant across
> +	 * Live Update.
> +	 */
> +	if (pci_need_dev_specific_enable_acs(dev)) {
> +		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n");
> +		return -EINVAL;
> +	}
> +
>  	dev_ser = pci_get_empty_or_append(outgoing);
>  	if (IS_ERR(dev_ser))
>  		return PTR_ERR(dev_ser);
> @@ -655,6 +681,7 @@ void pci_liveupdate_setup_device(struct pci_dev *dev)
>  
>  	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
>  	dev->liveupdate.incoming = dev_ser;
> +	dev->liveupdate.was_preserved = true;
>  
>  	/*
>  	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> @@ -748,6 +775,47 @@ void pci_liveupdate_finish(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
>  
> +void pci_liveupdate_init_acs(struct pci_dev *dev)
> +{
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> +		return;
> +
> +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);

This is called from pci_acs_init(), which is called from
pci_init_capabilities() when we first enumerate a device, so it
captures PCI_ACS_CTRL at boot-time, which is before any
pci_enable_acs() calls.  I don't think it will include the effect of
pci_std_enable_acs() (if an IOMMU driver called pci_request_acs() and
there was no device-specific quirk) or any command-line parameters
("pci=config_acs=").

I thought you would want to save the
PCI_ACS_CTRL value at the time of the liveupdate?

I'm having a hard time parsing pci_enable_acs(), so I'm sure I'm
missing something here.  

> +}
> +
> +int pci_liveupdate_enable_acs(struct pci_dev *dev)
> +{
> +	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
> +	u16 acs_cap = dev->acs_cap;
> +
> +	/*
> +	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
> +	 * device's ACS controls should not change even after the device is
> +	 * finished participating in the Live Update.
> +	 */
> +	if (!dev->liveupdate.was_preserved)
> +		return -EINVAL;

I don't quite understand what's going on here.

Partly it's because the function name and return values don't seem
obvious to me.  I guess returning 0 means "this device was preserved
across a liveupdate and we restored its previous ACS CTRL value, so
pci_enable_acs() doesn't need to do anything else."

Anything else means "device has not been preserved across a liveupdate
(or it was preserved but the new kernel added a device-specific ACS
quirk for it)."

But more fundamentally, after a liveupdate has completed, why does
pci_enable_acs() need to work differently than it would if there had
never been a liveupdate?

Maybe it's the comment that's confusing me.  Returning -EINVAL means
pci_enable_acs() will continue on and potentially update ACS CTRL.
The comment suggests "ACS controls shouldn't change even after
liveupdate completes", but if we don't want pci_enable_acs() to do
anything, wouldn't we return 0 here?

I guess this part will be exercised by pci_restore_state(), e.g.,
during resume after suspend.  I can't remember why we use
pci_enable_acs() there instead of saving ACS state in pci_save_state()
and then restoring it.

> +	/*
> +	 * The previous kernel should not have preserved any devices that
> +	 * require device-specific quirks to enable ACS, but if such a device is
> +	 * detected (e.g. new device-specific ACS quirk in the current kernel),
> +	 * log a big warning and fall back to the normal enable ACS path.
> +	 */
> +	if (pci_need_dev_specific_enable_acs(dev)) {
> +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
> +		WARN_ON_ONCE(true);
> +		return -EINVAL;
> +	}
> +
> +	if (acs_cap)
> +		pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ctrl);
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index c763255a8de4..4e8a01bcb4bb 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -16,6 +16,8 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev);
>  bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
>  				      int pass);
>  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
> +void pci_liveupdate_init_acs(struct pci_dev *dev);
> +int pci_liveupdate_enable_acs(struct pci_dev *dev);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>  {
> @@ -35,6 +37,15 @@ static inline bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus,
>  static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass)
>  {
>  }
> +
> +static inline void pci_liveupdate_init_acs(struct pci_dev *dev)
> +{
> +}
> +
> +static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..739ecaab2e76 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -34,6 +34,8 @@
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
>  #include <linux/suspend.h>
> +
> +#include "liveupdate.h"
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -1008,6 +1010,9 @@ void pci_enable_acs(struct pci_dev *dev)
>  	bool enable_acs = false;
>  	int pos;
>  
> +	if (!pci_liveupdate_enable_acs(dev))
> +		return;
> +
>  	/* If an iommu is present we start with kernel default caps */
>  	if (pci_acs_enable) {
>  		if (pci_dev_specific_enable_acs(dev))
> @@ -3689,6 +3694,7 @@ void pci_acs_init(struct pci_dev *dev)
>  
>  	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
>  	pci_disable_broken_acs_cap(dev);
> +	pci_liveupdate_init_acs(dev);
>  }
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4469e1a77f3c..988a18b3204a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1047,6 +1047,7 @@ void pci_acs_init(struct pci_dev *dev);
>  void pci_enable_acs(struct pci_dev *dev);
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
> +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
>  void pci_disable_broken_acs_cap(struct pci_dev *pdev);
> @@ -1057,6 +1058,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
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
> index 7ac39ec2843e..99b819f38e49 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5473,6 +5473,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
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
> diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> index 2be98819e313..2446c6d237ca 100644
> --- a/include/linux/pci_liveupdate.h
> +++ b/include/linux/pci_liveupdate.h
> @@ -17,14 +17,20 @@
>   * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
>   * @outgoing: State preserved for the next kernel.
>   * @incoming: State preserved by the previous kernel.
> + * @acs_ctrl: ACS features established by the previous kernel.
>   * @inherit_buses: True if the PCI core should inherit the secondary and
>   *                 subordinate bus numbers assigned to this device due to
>   *                 an ongoing Live Update.
> + * @was_preserved: True if this struct pci_dev was preserved by the previous
> + *                 kernel. Unlike @incoming, this field is not cleared after
> + *                 the device is finished participating in Live Update.
>   */
>  struct pci_liveupdate {
>  	struct pci_dev_ser *outgoing;
>  	struct pci_dev_ser *incoming;
> +	u16 acs_ctrl;
>  	bool inherit_buses;
> +	bool was_preserved;
>  };
>  
>  struct pci_dev;
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
