Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986469;
	b=lBxVxGrUqPgrDWimdE7auc9ggyCi95rgF9LzYkGnKiWg8wm5LqsVLwwsNRqxfrZD0Tvo
	 xAWxyDJtpATryl2xdl3gRijlV/70itgAW4l3i4nQbbHEyQZvnALTN6v8tbLTz7DcV750D
	 HOjBMKCk2OD+TE5Zx1JD0HP3a0yw/8LBc1X5QxLNFgP5E78uwnBsHFB3XYNfzTcoQ4SLG
	 vi09m6E7iP/r+R2+jX3gD7RMC3h+K04WtOSxx6yBEuAiGX3gAu9xNkVU1xu/Jxzhl1QLq
	 ESJgNi3CS5rsMpCodvFJArl1OYU+iVQPXjdO8bYij9EgwlVj+oDeCw3dVXgXS7XyiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986469;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gA4D1pJiwhc9kkEYDEd+V8rUmsSUvkvpMFSeoQRuBtw=;
	b=PasGU/u7HnN0R7JPlcQER5YdWHclcdv6rsoM/eXVl9GgV9GJpyfTJAV+NOPju94B5PNY
	 BmZUMnLnvJ3KBiVARlDAWoV186tqDmG6tPgsVZ3ZzE09PbkC+oh03kulxTv5xTtWIpo09
	 V4p46l1/qiOakJ98eFu6Gw7+UiXlTLA4HWlyw8ls3fx7IaSYBYBoPPB7xK0Ru4oFVxiue
	 ggb695GslSzIm0ZEzqY2JNKXGdyp33aEqzA7jiJg30NR1tzTvAY0SkasL+wUDB4Lnv5UR
	 8vG+WaX1PHopTyaiJgDTyZg4D/xH/2jY/Ch21TtgvEf1OSnuAu1mmdMI47vCXvXzVAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5RYYI4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC76606D81D;
	Fri,  6 Nov 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5RYYI4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB691F008AB;
	Fri,  6 Nov 2026 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986468;
	bh=gA4D1pJiwhc9kkEYDEd+V8rUmsSUvkvpMFSeoQRuBtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=N5RYYI4OSz3IGpbPyU3Mv3dayinVOZr37Iudk263zXtChhY8u9IXbj5UJKU/ZiuBw
	 EjSGvAAfc5LfRp8KUfRMAA4tDBEeDRCLR4s68oMRCd8u5Em0KGdLU5R3QgVWD5b6Cd
	 unSENQe000AwVfssC7mlr8TAP0wa62eRHRKIsDrXBW9Yz+ZpND4JjVlDojJl/7CrM0
	 UyV5ODhVmngegb4aT00BIRmZa+YV6zRBvRTJLrLxUUQ+pVKxWcRhofEx1I4H6ZW7IS
	 2fvvlT2l/qdPzcUBtpkLx0xoQqz1kjSBlIP/n2/wR2FKP/py4PUqLSgv10x1Z1FyW2
	 mEyLiKKYjd43g==
Date: Fri, 6 Nov 2026 11:34:27 -0600
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
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
Message-ID: <20261106173427.GA1633106@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013162529.1928093-6-dmatlack@google.com>

On Tue, Oct 13, 2026 at 04:25:21PM +0000, David Matlack wrote:
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
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 125 +++++++++++++++++++++++++++++----------
>  include/linux/pci.h      |   3 +
>  2 files changed, 96 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index d6b659b346bb..bffb3e1d8b2d 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -122,7 +122,6 @@
>   * preserved. These may be relaxed in the future:
>   *
>   *  * The device cannot be a Virtual Function (VF).
> - *  * The device cannot be behind a PCI-to-PCI bridge.
>   *
>   * Driver Binding
>   * ==============
> @@ -137,6 +136,18 @@
>   * bound to the correct driver. The PCI core does not protect against a device
>   * getting preserved by driver A in the outgoing kernel and then getting bound
>   * to driver B in the incoming kernel.
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
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -425,55 +436,84 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
>  	return dev_ser;
>  }
>  
> -static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> -					     struct pci_dev *dev)
> +static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> +					    struct pci_dev *dev)
>  {
>  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
>  
>  	if (!dev_ser) {
>  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> -		return;
> +		return -EINVAL;
>  	}
>  
> +	if (!dev_ser->refcount) {
> +		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (--dev_ser->refcount)
> +		return 0;
> +
>  	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
>  	outgoing->ser->nr_devices--;
>  	memset(dev_ser, 0, sizeof(*dev_ser));
>  	dev->liveupdate.outgoing = NULL;
> +	return 0;
> +}
> +
> +static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
> +					   struct pci_dev *dev,
> +					   struct pci_dev *end)
> +{
> +	for_each_pci_dev_in_path(dev) {
> +		if (dev == end)
> +			break;
> +
> +		if (pci_liveupdate_unpreserve_device(outgoing, dev))
> +			return;
> +	}
>  }
>  
>  static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
>  					  struct pci_dev *dev)
>  {
> -	struct pci_dev_ser *dev_ser;
> -
>  	if (dev->is_virtfn) {
>  		pci_warn(dev, "Cannot preserve Virtual Functions\n");
>  		return -EINVAL;
>  	}
>  
> -	if (dev->liveupdate.outgoing) {
> +	/*
> +	 * Endpoint devices should not be preserved more than once.
> +	 * Bridges are preserved once for every downstream device that
> +	 * is preserved.
> +	 */
> +	if (dev->liveupdate.outgoing && !dev->subordinate) {
>  		pci_warn(dev, "Device is already preserved\n");
>  		return -EBUSY;
>  	}
>  
> -	if (!pci_is_root_bus(dev->bus)) {
> -		pci_warn(dev, "Cannot preserve devices behind bridges\n");
> +	if (dev->liveupdate.outgoing && !dev->liveupdate.outgoing->refcount) {
> +		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
>  		return -EINVAL;
>  	}
>  
> -	dev_ser = pci_flb_alloc_dev_ser(outgoing);
> -	if (IS_ERR(dev_ser))
> -		return PTR_ERR(dev_ser);
> +	if (!dev->liveupdate.outgoing) {
> +		struct pci_dev_ser *dev_ser;
>  
> -	pci_info(dev, "Device will be preserved across next Live Update\n");
> -	outgoing->ser->nr_devices++;
> -	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
> +		dev_ser = pci_flb_alloc_dev_ser(outgoing);
> +		if (IS_ERR(dev_ser))
> +			return PTR_ERR(dev_ser);
>  
> -	dev_ser->domain = pci_domain_nr(dev->bus);
> -	dev_ser->bdf = pci_dev_id(dev);
> -	dev_ser->refcount++;
> +		pci_info(dev, "Device will be preserved across next Live Update\n");
> +		outgoing->ser->nr_devices++;

This looks a little funny because prior to this patch, nr_devices was
always incremented in pci_liveupdate_preserve_device() and always
decremented in pci_liveupdate_unpreserve_device().  Now it's only
incremented once (per device) in pci_liveupdate_preserve_device(), so
it looks unbalanced.

My guess is this is because previously we didn't expect to preserve
bridges at all, and now pci_liveupdate_preserve_device() might be
called several times for a bridge, and it's all just fine, but it's a
little subtle.

I suppose the "(dev->liveupdate.outgoing && !dev->subordinate)" test
above is what allows us to just increment refcount each time a bridge
is preserved.  And the test around pci_flb_alloc_dev_ser() is doing
basically the same thing.  I wonder if there's a way to connect them
more explicitly.

> +		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
> +
> +		dev_ser->domain = pci_domain_nr(dev->bus);
> +		dev_ser->bdf = pci_dev_id(dev);
> +		dev->liveupdate.outgoing = dev_ser;
> +	}
>  
> -	dev->liveupdate.outgoing = dev_ser;
> +	dev->liveupdate.outgoing->refcount++;
>  	return 0;
>  }
>  
> @@ -486,12 +526,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
>   * pci_liveupdate_preserve() from their struct liveupdate_file_handler
>   * preserve() callback to ensure the outgoing struct pci_ser is already set up.
>   *
> + * pci_liveupdate_preserve() automatically preserves all bridges upstream of
> + * @dev.
> + *
>   * Returns: 0 on success, <0 on failure.
>   */
>  int pci_liveupdate_preserve(struct pci_dev *dev)
>  {
>  	struct pci_flb_outgoing *outgoing = NULL;
> -	int ret;
> +	struct pci_dev *start = dev;
> +	int ret = -ENODEV;
>  
>  	guard(rwsem_write)(&pci_liveupdate.rwsem);
>  
> @@ -499,7 +543,13 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
>  	if (IS_ERR(outgoing))
>  		return PTR_ERR(outgoing);
>  
> -	ret = pci_liveupdate_preserve_device(outgoing, dev);
> +	for_each_pci_dev_in_path(dev) {
> +		ret = pci_liveupdate_preserve_device(outgoing, dev);
> +		if (ret) {
> +			pci_liveupdate_unpreserve_path(outgoing, start, dev);
> +			break;
> +		}
> +	}
>  
>  	pci_liveupdate_flb_put_outgoing();
>  	return ret;
> @@ -515,6 +565,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
>   * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
>   * unpreserve() callback to ensure the outgoing struct pci_ser is already set
>   * up.
> + *
> + * pci_liveupdate_unpreserve() automatically unpreserves all bridges upstream of
> + * @dev.
>   */
>  void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  {
> @@ -528,7 +581,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	pci_liveupdate_unpreserve_device(outgoing, dev);
> +	pci_liveupdate_unpreserve_path(outgoing, dev, /*end=*/NULL);
>  	pci_liveupdate_flb_put_outgoing();
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> @@ -618,28 +671,30 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>  		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
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
> +	return 0;
>  }
>  
>  /**
> @@ -651,6 +706,8 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
>   * Update. Drivers must call pci_liveupdate_finish() from their struct
>   * liveupdate_file_handler finish() callback to ensure the incoming struct
>   * pci_ser is allocated.
> + *
> + * pci_liveupdate_finish() automatically finishes all bridges upstream of @dev.
>   */
>  void pci_liveupdate_finish(struct pci_dev *dev)
>  {
> @@ -664,7 +721,11 @@ void pci_liveupdate_finish(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	pci_liveupdate_finish_device(incoming->ser, dev);
> +	for_each_pci_dev_in_path(dev) {
> +		if (pci_liveupdate_finish_device(incoming->ser, dev))
> +			break;
> +	}
> +
>  	pci_liveupdate_flb_put_incoming();
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 76abe884e3dc..b35ac263c451 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -836,6 +836,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
>  	return dev->bus->self;
>  }
>  
> +#define for_each_pci_dev_in_path(dev) \
> +	for (; dev; dev = pci_upstream_bridge(dev))
> +
>  #ifdef CONFIG_PCI_MSI
>  static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
>  {
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 
