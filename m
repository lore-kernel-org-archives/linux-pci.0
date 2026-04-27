Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7A259C80;
	Mon, 27 Apr 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315671; cv=none; b=B395l1MTPlscZeZk0Yh1c/99kdy+ht8CE+eE0C2Cc1+U4ViLuxKaHYdjLu/Drld8XeXaq/BUK5VtqsJ5XRazxm2CQnfzyH7HTfQg9xclcIp/2lJyIoE+tUHnI8V2lgotJwPFWw4oaqq0flEwPHLgtJeuq8CG5SlEdwIlzbt3V38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315671; c=relaxed/simple;
	bh=Lg+jFWtt8pEZR/KkohQlS7XqKx6QyZnHruBwrYXyz10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntQkcs7R+tFkbS70dpaxgvopbkwfNlpRo7zA/jrKx11myONTiry0fojzkKv1LqdGDrS4FBHSgoTSdUDbxeKq0OFTbqe9hZi4NIIQCwQinpVGXGIm4zDaqODhXfeqiBEETGUNF4Bh08zCwtg9SQusHzqRxp+X/6j79PAtSVC8/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cmjEZol5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cmjEZol5"
Received: from localhost (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id E249A20B716A;
	Mon, 27 Apr 2026 11:47:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E249A20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777315668;
	bh=S4tzZTHVVwx4dE5q55trjuPou8rUVW9NKtUsR+YVAxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmjEZol5n8EEvl93N6WXvZ/B3Z6d2+Hp0UmiD/Ox5Af+pe8fIxtkwd1dvkRKkWOUa
	 5abA7q+8En19G5GEOu5St1WIegpcN4MQ5bqVKnj0Vprr5Ue7paKmos8vQ89Zu+BJ0v
	 SgTFjCNrDtKoq0bcX9wEqEP8qZW/2b479wPNxwgw=
Date: Mon, 27 Apr 2026 11:47:45 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex
 Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris
 Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet
 <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky
 <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport
 <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja
 <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Will Deacon
 <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu
 <yi.l.liu@intel.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during
 Live Update
Message-ID: <20260427114745.00000656@linux.microsoft.com>
In-Reply-To: <20260423212316.3431746-6-dmatlack@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
	<20260423212316.3431746-6-dmatlack@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi David,

On Thu, 23 Apr 2026 21:23:09 +0000
David Matlack <dmatlack@google.com> wrote:

> Inherit bus numbers from the previous kernel during a Live Update when
> one or more PCI devices are being preserved.
> 
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling
> and flushing any memory transactions first.
> 
> To keep things simple, inherit the secondary and subordinate bus
> numbers on all bridges if any PCI devices were preserved (i.e. even
> bridges without any downstream endpoints that were preserved). This
> avoids accidentally assigning a bridge a new window that overlaps
> with a preserved device that is downstream of a different bridge.
> 
> If a bridge is enumerated with a broken topology or has no bus numbers
> set during a Live Update, refuse to assign it new bus numbers and
> refuse to enumerate devices below it. This is a safety measure to
> prevent topology conflicts.
> 
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++-
>  drivers/pci/Kconfig                           |  2 +-
>  drivers/pci/liveupdate.c                      | 28
> +++++++++++++++++++ drivers/pci/probe.c                           |
> 21 +++++++++++--- include/linux/pci.h                           |  1 +
>  5 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt index
> cf3807641d89..f412a4b77fb7 100644 ---
> a/Documentation/admin-guide/kernel-parameters.txt +++
> b/Documentation/admin-guide/kernel-parameters.txt @@ -5156,7 +5156,11
> @@ Kernel parameters explicitly which ones they are.
>  		assign-busses	[X86] Always assign all PCI bus
>  				numbers ourselves, overriding
> -				whatever the firmware may have done.
> +				whatever the firmware may have done.
> Ignored
> +				during a Live Update, where the
> kernel must
> +				inherit the PCI topology (including
> bus numbers)
> +				to avoid interrupting ongoing memory
> +				transactions of preserved devices.
>  		usepirqmask	[X86] Honor the possible IRQ mask
> stored in the BIOS $PIR table. This is needed on
>  				some systems with broken BIOSes,
> notably diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 08398cbe970c..6ef457ff9d08 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
>  
>  config PCI_LIVEUPDATE
>  	bool "PCI Live Update Support (EXPERIMENTAL)"
> -	depends on PCI && LIVEUPDATE
> +	depends on PCI && LIVEUPDATE && !CARDBUS
>  	help
>  	  Enable PCI core support for preserving PCI devices across
> Live Update. This, in combination with support in a device's driver,
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index c0a30d16d9b8..cf8cff134a75 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -93,6 +93,19 @@
>   * bound to the correct driver. i.e. The PCI core does not protect
> against a
>   * device getting preserved by driver A in the outgoing kernel and
> then getting
>   * bound to driver B in the incoming kernel.
> + *
> + * BDF Stability
> + * =============
> + *
> + * The PCI core guarantees that incoming preserved devices can be
> identified by
> + * the same bus, device, and function numbers as prior to kexec. To
> accomplish
> + * this, the PCI core always inherits the secondary and subordinate
> bus numbers
> + * assigned to bridges during enumeration, rather than assigning new
> ones (the
> + * PCI core assumes that the previous kernel established a sane
> topology).
> + *
> + * If a misconfigured or unconfigured bridge is encountered during
> enumeration
> + * while there are incoming preserved devices, it's secondary and
> subordinate
> + * bus numbers will be cleared and devices below it will not be
> enumerated. */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -354,6 +367,21 @@ void pci_liveupdate_setup_device(struct pci_dev
> *dev) if (!xa)
>  		return;
>  
> +	/*
> +	 * During a Live Update, preserved devices are allowed to
> continue
> +	 * performing memory transactions. The kernel must not
> change the fabric
> +	 * topology, including bus numbers, since that would require
> disabling
> +	 * and flushing any memory transactions first.
> +	 *
> +	 * To keep things simple, inherit the secondary and
> subordinate bus
> +	 * numbers on _all_ bridges if _any_ PCI devices were
> preserved (i.e.
> +	 * even bridges without any downstream endpoints that were
> preserved).
> +	 * This avoids accidentally assigning a bridge a new window
> that
> +	 * overlaps with a preserved device that is downstream of a
> different
> +	 * bridge.
> +	 */
> +	dev->liveupdate_inherit_buses = true;
> +
This flag never gets cleared after the incoming kernel boot up, what if
the user does a manual rescan via sysfs? i.e.
# echo 1 > /sys/bus/pci/rescan
pcibios_assign_all_busses() will never gets called for this device, and
may hit this
	if (dev->liveupdate_inherit_buses) {
		pci_err(dev, "Cannot reconfigure bridge during
		Live Update!\n");

So, maybe clear it in pci_liveupdate_finish()?

>  	key = pci_ser_xa_key(pci_domain_nr(dev->bus),
> pci_dev_id(dev)); dev_ser = xa_load(xa, key);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 938a28e4a7a0..fa26f4170add 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1374,6 +1374,14 @@ bool pci_ea_fixed_busnrs(struct pci_dev *dev,
> u8 *sec, u8 *sub) return true;
>  }
>  
> +static bool pci_should_assign_new_buses(struct pci_dev *dev)
> +{
> +	if (dev->liveupdate_inherit_buses)
> +		return false;
> +
> +	return pcibios_assign_all_busses();
> +}
> +
>  /*
>   * pci_scan_bridge_extend() - Scan buses behind a bridge
>   * @bus: Parent bus the bridge is on
> @@ -1401,6 +1409,7 @@ static int pci_scan_bridge_extend(struct
> pci_bus *bus, struct pci_dev *dev, int max, unsigned int
> available_buses, int pass)
>  {
> +	const bool assign_new_buses =
> pci_should_assign_new_buses(dev); struct pci_bus *child;
>  	u32 buses;
>  	u16 bctl;
> @@ -1453,8 +1462,7 @@ static int pci_scan_bridge_extend(struct
> pci_bus *bus, struct pci_dev *dev, goto out;
>  	}
>  
> -	if ((secondary || subordinate) &&
> -	    !pcibios_assign_all_busses() && !broken) {
> +	if ((secondary || subordinate) && !assign_new_buses &&
> !broken) { unsigned int cmax, buses;
>  
>  		/*
> @@ -1496,8 +1504,7 @@ static int pci_scan_bridge_extend(struct
> pci_bus *bus, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> -			if (pcibios_assign_all_busses() || broken)
> -
> +			if (assign_new_buses || broken)
>  				/*
>  				 * Temporarily disable forwarding of
> the
>  				 * configuration cycles on all
> bridges in @@ -1511,6 +1518,12 @@ static int
> pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev, goto
> out; }
>  
> +		if (dev->liveupdate_inherit_buses) {
> +			pci_err(dev, "Cannot reconfigure bridge
> during Live Update!\n");
> +			pci_err(dev, "Downstream devices will not be
> enumerated!\n");
> +			goto out;
> +		}
> +
>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index dd6b26ca9462..9a602b322e3c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -511,6 +511,7 @@ struct pci_dev {
>  	unsigned int	rom_bar_overlap:1;	/* ROM BAR
> disable broken */ unsigned int	rom_attr_enabled:1;	/*
> Display of ROM attribute enabled? */ unsigned int
> non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
> +	unsigned int	liveupdate_inherit_buses:1; /* Inherit
> bus numbers due to Live Update */ pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has
> been called */ 

