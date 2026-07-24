Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E913C2B8D;
	Fri, 24 Jul 2026 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926510; cv=none; b=ldQ+TmTGt3pGWQBgp54SvzgUnC3bEtpxASr0Gnx4v7QymTTGewC5m/Kb2NYgypZml3t0pHRAnwlL13CS+kSejsUVHkL7N+F8e1j26aY/vVCHnXwLXHOJY/OUu2fBjWqgXPrFliXtWQkD6pMzfYGY5PGaD3xdIzxDutyNN4Yiw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926510; c=relaxed/simple;
	bh=uoq1B/BkzjWpPxDNSlaTOsjuHgN0ttXXWauNrtDyTew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l3qAJPAJP03b6eiAagqGUoadndIsLLBRtW4krPqJD4mOW5iZwQIsMZLL0anGqEO6Zz5XVpNdwisiLNGHCJ8JYSWquQbaoSOkBTJXlKc847aq1sKGxNvz9+N+aj7CRK4RPlAIegNjHK/9haigMicbPAFYyEC4pLl+FmqvWtA3eAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPsO4F40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPsO4F40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC9A1F000E9;
	Fri, 24 Jul 2026 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784926508;
	bh=Rats3+uLlkKdYpRmDANFsMR8vfU9QiGYu7LLlmwp1U4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PPsO4F40UmciD6/goxygKCj0jjauWWjsloRfZU7YFZhQouG91hdWwPU8+9OOxQBpY
	 SvBIzR+AyP/ZtBl37B+AiwoXZ0gZQlALq/H82AMgGFVfCG0uTUXZPI3kSh9pF93cWj
	 zPiv/0TFkDQstMdB9TyA3fsXZh6EAqM2B8B8KM+oL+IkFCo+ooh8b63RM9ZdKAk8jJ
	 TMAoylSMAqQaxnA+6tnYKJhSuu6r2vxnn8PWbLz6oOIPBZDnsP1ZivqmBJRVL8Mp2I
	 QCUYto3jCrjYJzhruoAd/Id4AJD46zHFlYAPAkuwq7xHWWseLgZ0E4g4FwN9sPG4eI
	 /uKQdVW2IwMGw==
Date: Fri, 24 Jul 2026 15:55:06 -0500
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
Subject: Re: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <20260724205506.GA1012423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-7-dmatlack@google.com>

On Fri, Jul 10, 2026 at 09:26:09PM +0000, David Matlack wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
>  include/linux/kho/abi/pci.h |   5 +-
>  2 files changed, 122 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index b2b950d71657..7f7710cb1da0 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -101,6 +101,18 @@
>   * If a misconfigured or unconfigured bridge is encountered during enumeration
>   * while there are preserved devices, its secondary and subordinate bus numbers
>   * will be cleared and devices below it will not be enumerated.
> + *
> + * PCI-to-PCI Bridges
> + * ==================
> + *
> + * Any PCI-to-PCI bridges upstream of a preserved device are automatically
> + * preserved when the device is preserved. The PCI core keeps track of the
> + * number of downstream devices that are preserved under a bridge so that the
> + * bridge is only unpreserved once all downstream devices are unpreserved.
> + *
> + * This enables the PCI core and any drivers bound to the bridge to participate
> + * in the Live Update so that preserved endpoints can continue issuing memory
> + * transactions during the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> @@ -316,28 +328,52 @@ static struct pci_dev_ser *pci_get_empty_or_append(struct pci_flb_outgoing *outg
>  	return dev_ser;
>  }
>  
> -static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
> +static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
>  {
>  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
>  
>  	if (!dev_ser) {
>  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> -		return;
> +		return -EINVAL;
> +	}
> +
> +	if (!dev_ser->refcount) {
> +		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
> +		return -EINVAL;
>  	}
>  
> +	if (--dev_ser->refcount)
> +		return 0;
> +
>  	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
>  	outgoing->ser->nr_devices--;
>  	memset(dev_ser, 0, sizeof(*dev_ser));
>  	dev->liveupdate.outgoing = NULL;
> +	return 0;
>  }
>  
> -static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
> +static int pci_liveupdate_preserve_device_again(struct pci_dev *dev)

Could pci_liveupdate_preserve_device_again() be folded into
pci_liveupdate_preserve_device()?  That's the only caller, and having
so many *liveupdate_preserve*() functions gets to be a bit of a maze
of small functions:

  __pci_liveupdate_preserve_device
  pci_liveupdate_preserve_device_again
  pci_liveupdate_preserve_device
  pci_liveupdate_preserve_path
  pci_liveupdate_preserve

Maybe even more could be squashed; pci_liveupdate_preserve() is the
only caller of pci_liveupdate_preserve_path(), which is itself the
only caller of pci_liveupdate_preserve_device().

As a reader, I think there's some advantage in collecting the whole
"preserve" flow in one place, but maybe nesting depth would be an
issue, especially for the unpreserve cleanup in the failure path.
Maybe a "goto" error path could mitigate part of that.

If there's any squashing, I guess the place to start would be in
earlier patches, e.g., "PCI: liveupdate: Track outgoing preserved PCI
devices" and "PCI: liveupdate: Track incoming preserved PCI devices".

>  {
> -	struct pci_dev_ser *dev_ser;
> +	if (!dev->liveupdate.outgoing->refcount) {
> +		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> +		return -EINVAL;
> +	}
>  
> -	if (dev->liveupdate.outgoing)
> +	/*
> +	 * Endpoint devices should not be preserved more than once. Bridges are
> +	 * preserved once for every downstream device that is preserved.
> +	 */
> +	if (!dev->subordinate)
>  		return -EBUSY;
>  
> +	dev->liveupdate.outgoing->refcount++;
> +	return 0;
> +}
> +
> +static int __pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
> +{
> +	struct pci_dev_ser *dev_ser;
> +
>  	dev_ser = pci_get_empty_or_append(outgoing);
>  	if (IS_ERR(dev_ser))
>  		return PTR_ERR(dev_ser);
> @@ -354,6 +390,52 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, str
>  	return 0;
>  }
>  
> +static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
> +{
> +	if (dev->liveupdate.outgoing)
> +		return pci_liveupdate_preserve_device_again(dev);
> +
> +	return __pci_liveupdate_preserve_device(outgoing, dev);
> +}
> +
> +#define for_each_pci_dev_in_path(_d, _start, _end) \
> +	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)

I think you might want pci_upstream_bridge() instead of (_d)->bus->self;
see https://git.kernel.org/linus/c6bde215acfd ("PCI: Add
pci_upstream_bridge()").  I think VFs are currently out of scope, but 
no harm in making this future-proof.

Other than "_end", this looks fairly generic and might be a candidate
for putting in include/linux/pci.h.  I think there might be other
potential users, e.g., calc_map_type_and_dist(),
pci_enable_atomic_ops_to_root(), pcie_bandwidth_available(),
get_upstream_port(), pcie_find_root_port(),
pci_is_thunderbolt_attached().

The "_end" termination case could perhaps be done in the body instead
of the macro since it depends on the use case and several of the other
loops that iterate over the path already include terminations in the
body.

> +static void __pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
> +					     struct pci_dev *start,
> +					     struct pci_dev *end)
> +{
> +	struct pci_dev *dev;
> +
> +	for_each_pci_dev_in_path(dev, start, end) {
> +		if (pci_liveupdate_unpreserve_device(outgoing, dev))
> +			return;
> +	}
> +}
> +
> +static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
> +					   struct pci_dev *start)
> +{
> +	__pci_liveupdate_unpreserve_path(outgoing, start, /*end=*/NULL);
> +}
> +
> +static int pci_liveupdate_preserve_path(struct pci_flb_outgoing *outgoing,
> +					struct pci_dev *start)
> +{
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	for_each_pci_dev_in_path(dev, start, NULL) {
> +		ret = pci_liveupdate_preserve_device(outgoing, dev);
> +		if (ret) {
> +			__pci_liveupdate_unpreserve_path(outgoing, start, dev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
>   * @dev: The PCI device to preserve.
> @@ -363,6 +445,9 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing, str
>   * pci_liveupdate_preserve() from their struct liveupdate_file_handler
>   * preserve() callback to ensure the outgoing struct pci_ser is already set up.
>   *
> + * pci_liveupdate_preserve() automatically preserves all bridges upstream of
> + * @dev.
> + *
>   * Returns: 0 on success, <0 on failure.
>   */
>  int pci_liveupdate_preserve(struct pci_dev *dev)
> @@ -378,7 +463,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
>  	if (IS_ERR(outgoing))
>  		return PTR_ERR(outgoing);
>  
> -	return pci_liveupdate_preserve_device(outgoing, dev);
> +	return pci_liveupdate_preserve_path(outgoing, dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
>  
> @@ -391,6 +476,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
>   * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
>   * unpreserve() callback to ensure the outgoing struct pci_ser is already set
>   * up.
> + *
> + * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
> + * @dev.
>   */
>  void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  {
> @@ -404,7 +492,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	pci_liveupdate_unpreserve_device(outgoing, dev);
> +	pci_liveupdate_unpreserve_path(outgoing, dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>  
> @@ -594,29 +682,41 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>  	}
>  }
>  
> -static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
> +static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
>  {
>  	if (!dev->liveupdate.incoming) {
>  		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> -		return;
> +		return -EINVAL;
>  	}
>  
> -	if (dev->liveupdate.incoming->refcount != 1) {
> -		pci_WARN(dev, 1, "Preserved device has a corrupted refcount!\n");
> -		return;
> +	if (!dev->liveupdate.incoming->refcount) {
> +		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
> +		return -EINVAL;
>  	}
>  
>  	/*
> -	 * Drop the refcount so this device does not get treated as an incoming
> -	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> -	 * again because the device is hot-plugged.
> +	 * Decrement the refcount so this device does not get treated as an
> +	 * incoming device again, e.g. in case pci_liveupdate_setup_device()
> +	 * gets called again because the device is hot-plugged.
>  	 */
> -	dev->liveupdate.incoming->refcount = 0;
> +	if (--dev->liveupdate.incoming->refcount)
> +		return 0;
>  
>  	pci_info(dev, "Device is finished participating in Live Update\n");
>  	dev->liveupdate.incoming = NULL;
>  	ser->nr_devices--;
>  	pci_liveupdate_flb_put_incoming();
> +	return 0;
> +}
> +
> +static void pci_liveupdate_finish_path(struct pci_ser *ser, struct pci_dev *start)
> +{
> +	struct pci_dev *dev;
> +
> +	for_each_pci_dev_in_path(dev, start, NULL) {
> +		if (pci_liveupdate_finish_device(ser, dev))
> +			return;
> +	}
>  }
>  
>  /**
> @@ -628,6 +728,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
>   * Update. Drivers must call pci_liveupdate_finish() from their struct
>   * liveupdate_file_handler finish() callback to ensure the incoming struct
>   * pci_ser is allocated.
> + *
> + * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
>   */
>  void pci_liveupdate_finish(struct pci_dev *dev)
>  {
> @@ -641,7 +743,7 @@ void pci_liveupdate_finish(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	pci_liveupdate_finish_device(incoming->ser, dev);
> +	pci_liveupdate_finish_path(incoming->ser, dev);
>  	pci_liveupdate_flb_put_incoming();
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> index de549016807a..acf1b38dff02 100644
> --- a/include/linux/kho/abi/pci.h
> +++ b/include/linux/kho/abi/pci.h
> @@ -23,7 +23,7 @@
>   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>   */
>  
> -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>  
>  /**
>   * struct pci_dev_ser - Serialized state about a single PCI device.
> @@ -32,7 +32,8 @@
>   * @bdf: The device's PCI bus, device, and function number.
>   * @refcount: Reference count used by the PCI core to keep track of whether it
>   *            is done using a device's struct pci_dev_ser. The value of the
> - *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
> + *            refcount is equal to the number of preserved devices at or below
> + *            it in the PCI hierarchy when the struct pci_dev_ser is in use, and
>   *            0 otherwise.
>   */
>  struct pci_dev_ser {
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
