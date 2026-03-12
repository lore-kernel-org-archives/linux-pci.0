Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41717361657;
	Thu, 12 Mar 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326690; cv=none; b=P86xE/gYCUJrDE4/DT7kShZ7a8IIb5j/ta/ZbA7yUbyZJABxKTaxx3O5Qbg0QgdmxLlj2NbRjUbO6veAWm0hUZKthukDrfvlPZD3yVShu1KJXUCUadesLMKYFtmmitVcWSGyhf5L0tN9YQB9BKV3IOSrE7l6ko1xFT0Gzda4YJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326690; c=relaxed/simple;
	bh=MGBoiYYaw+RRG/gQGoH0DEApEdUYh+4tDhrR9OV4BRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHFz1AL81YBQDxQXP5/STVQY32csvEMuSmu1DdCTA6VOtRdihVVV+3CN1IeQy7G9g2xor8EvpMZfAoaMj/8PXRMeTONODxfiNHmRL7jWPxu6sP+Xp/PX6VhLOWVkMO9KC6hISRwPZXzV1BSS94Fl9FbtW5wh0GdYmO+7SjDDbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HnMKOBQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HnMKOBQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E455C4CEF7;
	Thu, 12 Mar 2026 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773326689;
	bh=MGBoiYYaw+RRG/gQGoH0DEApEdUYh+4tDhrR9OV4BRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnMKOBQ4cLbV+9WsqQ/U7UCJOb9T+p5WdNn5BTFE30IA7OCIIKZ1827Zok4hCkSob
	 tHWLYicCZPhyvr/ZOsBVrQug4OJQa2rZzQZH6W1iIClNF4jsEkuP2Ct0+pJhWs7m8Z
	 ucuy1NDipCBmojgDiVh9NTR8aa/3b7B5vBqrRGzU=
Date: Thu, 12 Mar 2026 15:44:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, aik@amd.com,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <2026031230-mastiff-create-7593@gregkh>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-4-dan.j.williams@intel.com>

On Mon, Mar 02, 2026 at 04:01:51PM -0800, Dan Williams wrote:
> An "accepted" device is one that is allowed to access private memory within
> a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
> from other device properties like usb_device::authorized, or
> tb_switch::authorized. The entry to the accepted state is a violent
> operation in which the device will reject MMIO requests that are not
> encrypted, and the device enters a new IOMMU protection domain to allow it
> to access addresses that were previously off-limits.

Trying to mix/match "acceptance" with "authorized" is going to be a
nightmare, what's the combination that can happen here over time?

We need to either "trust" or "not trust" the device, and the bus can
decide what to do with that value (if anything).  The DMA layer can then
use that value to do:

> Subsystems like the DMA mapping layer, that need to modify their behavior
> based on the accept state, may only have access to the base 'struct
> device'.

^this.

> It is also likely that the concept of TCB acceptance grows beyond
> PCI devices over time. For these reasons, introduce the concept of
> acceptance in 'struct device_private' which is device common, but only
> suitable for buses and built-in infrastructure to consume.

Busses are what can control this, but please, let's not make this a
cc-only type thing.  We have the idea of trust starting to propagate
through a number of different busses, let's get it right here, so we
don't have to have all of these different bus-specific hacks like we do
today.

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Roman Kisel <romank@linux.microsoft.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/base/Kconfig   |  4 +++
>  drivers/base/Makefile  |  1 +
>  drivers/base/base.h    |  9 +++++++
>  include/linux/device.h | 22 ++++++++++++++++
>  drivers/base/coco.c    | 58 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 94 insertions(+)
>  create mode 100644 drivers/base/coco.c
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 1786d87b29e2..d4743bf978ec 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -249,4 +249,8 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
>  	  command line option on every system/board your kernel is expected to
>  	  work on.
>  
> +config CONFIDENTIAL_DEVICES
> +	depends on ARCH_HAS_CC_PLATFORM
> +	bool
> +
>  endmenu
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8074a10183dc..e11052cd5253 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
>  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
>  obj-$(CONFIG_ACPI) += physical_location.o
> +obj-$(CONFIG_CONFIDENTIAL_DEVICES) += coco.o
>  
>  obj-y			+= test/
>  
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index b68355f5d6e3..1ae9a1679504 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -119,8 +119,13 @@ struct driver_type {
>   * @dead: This device is currently either in the process of or has been
>   *	  removed from the system. Any asynchronous events scheduled for this
>   *	  device should exit without taking any action.
> + * @cc_accepted: track the TEE acceptance state of the device for deferred
> + *		 probing, MMIO mapping type, and SWIOTLB bypass for private memory DMA.
>   *
>   * Nothing outside of the driver core should ever touch these fields.
> + *
> + * All bitfield flags are manipulated under device_lock() to avoid
> + * read-modify-write collisions.
>   */
>  struct device_private {
>  	struct klist klist_children;
> @@ -136,6 +141,10 @@ struct device_private {
>  	struct driver_type driver_type;
>  #endif
>  	u8 dead:1;
> +#ifdef CONFIG_CONFIDENTIAL_DEVICES
> +	u8 cc_accepted:1;
> +#endif

Just make this:
	u8 trusted:1;

no need for an #ifdef.


> +
>  };
>  #define to_device_private_parent(obj)	\
>  	container_of(obj, struct device_private, knode_parent)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0be95294b6e6..4470365d772b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1191,6 +1191,28 @@ static inline bool device_link_test(const struct device_link *link, u32 flags)
>  	return !!(link->flags & flags);
>  }
>  
> +/* Confidential Device state helpers */
> +#ifdef CONFIG_CONFIDENTIAL_DEVICES
> +int device_cc_accept(struct device *dev);
> +int device_cc_reject(struct device *dev);
> +bool device_cc_accepted(struct device *dev);
> +#else
> +static inline int device_cc_accept(struct device *dev)

No __must_hold() usage?  That's best to check this at build time, not
just relying on:

> +{
> +	lockdep_assert_held(&dev->mutex);

runtime checks.

Same for all the calls here.

> +/**
> + * device_cc_accept(): Mark a device as able to access private memory
> + * @dev: device to accept
> + *
> + * Confidential bus drivers use this helper to accept devices. For example, PCI
> + * has a sysfs ABI to accept devices after relying party attestation.
> + *
> + * Given that moving a device into confidential / private operation implicates
> + * changes to MMIO mapping attributes and DMA mappings, the transition must be
> + * done while the device is idle (driver detached).
> + */
> +int device_cc_accept(struct device *dev)
> +{
> +	lockdep_assert_held(&dev->mutex);
> +
> +	if (dev->driver)
> +		return -EBUSY;

So you are saying that once a driver is bound, it is "trusted"?  That's
fine, but maybe you don't want to do that in the core, shouldn't that be
a bus-specific thing?

this could then be:
int device_trust(struct device *dev);
int device_untrust(struct device *dev);  /* ugh, bad name, pick something else? */
bool device_trusted(struct device *dev);

but note, do you ever want to move a device from trusted to untrusted?
What would cause that?

thanks,

greg k-h
