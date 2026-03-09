Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F054231A3B
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075539; cv=none; b=BVK7W7guz7QuAdo0mQG40Wk+t7x5SkRyB6l4VSIXI1iD6oBJMAyoI8TqH1FaTdNxsz1IKKjmVqFoLF3jIBwuvhn1g6c55BXz8lbY6AfHWqo86PJgUIil0xZZ6Gd0aoTv556bqk/NZa75FUOikyAVp1+2V7yVleaEA4sIRcDcBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075539; c=relaxed/simple;
	bh=Qukwj4bL1lp2i67pMMLn2seb1cfpSqXBfTSA7i7LhGk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmUXETFDZRvr0ukRr/1SmF4mx+r/m7zDhFk9v0AlCNPpqwNcX/q3tLwyLQ83FAHhnDFkB4ZufLzvfHV+ck2xzCRN0ioVt02bpMbUZfQcktqj5HYgh/hGvwVXVsnwpBpx8jGZZO7Gl/E9GVYZw/N/cDm2zIBO+CVxoBPORHcGb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV3BK3csRzHnGf1;
	Tue, 10 Mar 2026 00:58:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9301140585;
	Tue, 10 Mar 2026 00:58:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 16:58:52 +0000
Date: Mon, 9 Mar 2026 16:58:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 05/19] device core: Autoprobe considered harmful?
Message-ID: <20260309165851.00001308@huawei.com>
In-Reply-To: <20260303000207.1836586-6-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
	<20260303000207.1836586-6-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon,  2 Mar 2026 16:01:53 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The threat model of PCI Trusted Execution Environment Device Interface
> Security Protocol (TDISP), is that an adversary may be impersonating the
> device's identity, redirecting the device's MMIO interface, and/or
> snooping/manipulating the physical link. Outside of PCI TDISP, PCI ATS
> (that allows IOMMU bypass) comes to mind as another threat vector that
> warrants additional device verification beyond whether ACPI enumerates the
> device as "internal" [1].
> 
> The process of verifying a device ranges from the traditional default
> "accept everything" to gathering signed evidence from a locked device,
> shipping it to a relying party and acting on that disposition. That policy
> belongs in userspace. A natural way for userspace to get a control point
> for verifying a device before use is when the driver for the device comes
> from a module.
> 
> For deployments that are concerned about adversarial devices, introduce a
> mechanism to disable autoprobe. When a driver originates from a module,
> consult that driver's autoprobe policy at initial device or driver attach.
> 
> Note that with TDISP, unaccepted devices do not have access to private
> memory (so called "T=0" mode). However, a deployment may still not want to
> operate more than a handful of boot devices until confirming the system
> device topology with a verifier.
> 
> Yes, this is a security vs convenience tradeoff. Yes, devices with
> non-modular drivers are out of scope. Yes, there are known regression cases
> for subsystems where device objects are expected to auto-attach outside of
> fatal probe failure. For navigating regressions, a per-module "autoprobe"
> option is included to allow fine grained policy.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
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
> Link: http://lore.kernel.org/6971b9406d069_1d33100df@dwillia2-mobl4.notmuch [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Approach seems reasonable to me.
A few trivial things inline.

Jonathan

> ---
>  drivers/base/Kconfig                  | 24 ++++++++++++++++++++++++
>  Documentation/ABI/stable/sysfs-module | 10 ++++++++++
>  drivers/base/base.h                   |  1 +
>  include/linux/module.h                | 14 ++++++++++++++
>  drivers/base/bus.c                    |  7 ++++++-
>  drivers/base/dd.c                     | 26 +++++++++++++++++++++++---
>  kernel/module/main.c                  | 13 +++++++++++++
>  7 files changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index d4743bf978ec..7c1da5df9745 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -253,4 +253,28 @@ config CONFIDENTIAL_DEVICES
>  	depends on ARCH_HAS_CC_PLATFORM
>  	bool
>  
> +config MODULES_AUTOPROBE
> +	bool "Automatic probe of drivers from modules"
> +	default y
> +	help
> +	  Say Y for the typical and traditional Linux behavior of automatically
> +	  attaching devices to drivers when a module is loaded.
> +
> +	  Say N to opt into a threat model where userspace verification of a
> +	  device is required before driver attach. This includes Confidential
> +	  Computing use cases where the device needs to have its configuration
> +	  locked and verified by a relying party. It also includes use cases
> +	  like leaving devices with Address Translation (IOMMU protection
> +	  bypass) capability disabled until userspace attests the device and
> +	  binds a driver.
> +
> +	  This default value can be overridden by the "autoprobe" module option.
> +	  Note that some subsystems may not be prepared for autoprobe to be
> +	  disabled, take care to test your selected drivers.  Built-in drivers are

Stray extra space.

> +	  unaffected by this policy and will autoprobe unless the bus itself has
> +	  disabled autoprobe.
> +
> +	  If in doubt, say Y. The N case is only for expert configurations, and
> +	  selective "autoprobe=0" in modprobe policy is the common expectation.
> +
>  endmenu


> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 349f31bedfa1..926e120b3cc4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -917,6 +917,12 @@ struct device_attach_data {
>  	 * driver, we'll encounter one that requests asynchronous probing.
>  	 */
>  	bool have_async;
> +
> +	/*
> +	 * On initial device arrival driver attach is subject to
> +	 * driver_autoprobe() policy.
> +	 */
> +	bool initial_probe;

I'm not sure 'initial' naming works.  How does that work with drivers that
have not autobound anyway?  E.g. VFIO.
Seems they'll be fine even if it is their initial probe.  Also the
deferred cases remain 'initial' for repeated probing.

Why not stick to the auto probing terminology here?

There is clearly history of this naming though in device_initial_probe()
So maybe that name is fine...


>  };
>  
>
