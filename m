Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 2 Dec 2016 15:38:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Mark Salter <msalter@redhat.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v9 07/16] drivers: acpi: implement acpi_dma_configure
Message-ID: <20161202153816.GA18290@red-moon>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-8-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20161121100148.24769-8-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, Eric Auger <eric.auger@redhat.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dennis Chen <dennis.chen@arm.com>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Rafael, Mark, Suravee,

On Mon, Nov 21, 2016 at 10:01:39AM +0000, Lorenzo Pieralisi wrote:
> On DT based systems, the of_dma_configure() API implements DMA
> configuration for a given device. On ACPI systems an API equivalent to
> of_dma_configure() is missing which implies that it is currently not
> possible to set-up DMA operations for devices through the ACPI generic
> kernel layer.
> 
> This patch fills the gap by introducing acpi_dma_configure/deconfigure()
> calls that for now are just wrappers around arch_setup_dma_ops() and
> arch_teardown_dma_ops() and also updates ACPI and PCI core code to use
> the newly introduced acpi_dma_configure/acpi_dma_deconfigure functions.
> 
> Since acpi_dma_configure() is used to configure DMA operations, the
> function initializes the dma/coherent_dma masks to sane default values
> if the current masks are uninitialized (also to keep the default values
> consistent with DT systems) to make sure the device has a complete
> default DMA set-up.

I spotted a niggle that unfortunately was hard to spot (and should not
be a problem per se but better safe than sorry) and I am not comfortable
with it.

Following commit d0562674838c ("ACPI / scan: Parse _CCA and setup
device coherency") in acpi_bind_one() we check if the acpi_device
associated with a device just added supports DMA, first it was
done with acpi_check_dma() and then commit 1831eff876bd ("device
property: ACPI: Make use of the new DMA Attribute APIs") changed
it to acpi_get_dma_attr().

The subsequent check (attr != DEV_DMA_NOT_SUPPORTED) is always true
on _any_ acpi device we pass to acpi_bind_one() on x86, which was
fine because we used it to call arch_setup_dma_ops(), which is a nop
on x86. On ARM64 a _CCA method is required to define if a device
supports DMA so (attr != DEV_DMA_NOT_SUPPORTED) may well be false.

Now, acpi_bind_one() is used to bind an acpi_device to its physical
node also for pseudo-devices like cpus and memory nodes. For those
objects, on x86, attr will always be != DEV_DMA_NOT_SUPPORTED.

So far so good, because on x86 arch_setup_dma_ops() is empty code.

With this patch, I use the (attr != DEV_DMA_NOT_SUPPORTED) check
to call acpi_dma_configure() which is basically a nop on x86 except
that it sets up the dma_mask/coherent_dma_mask to a sane default value
(after all we are setting up DMA for the device so it makes sense to
initialize the masks there if they were unset since we are configuring
DMA for the device in question) for the given device.

Problem is, as per the explanation above, we are also setting the
default dma masks for pseudo-devices (eg CPUs) that were previously
untouched, it should not be a problem per-se but I am not comfortable
with that, honestly it does not make much sense.

An easy "fix" would be to move the default dma masks initialization out
of acpi_dma_configure() (as it was in previous patch versions of this
series - I moved it to acpi_dma_configure() just a consolidation point
for initializing the masks instead of scattering them in every
acpi_dma_configure caller) I can send this as a fix-up patch to Joerg if
we think that's the right thing to do (or I can send it to Rafael later
when the code is in the merged depending on the timing) just let me
know please.

Thanks !
Lorenzo

> The DMA range size passed to arch_setup_dma_ops() is sized according
> to the device coherent_dma_mask (starting at address 0x0), mirroring the
> DT probing path behaviour when a dma-ranges property is not provided
> for the device being probed; this changes the current arch_setup_dma_ops()
> call parameters in the ACPI probing case, but since arch_setup_dma_ops()
> is a NOP on all architectures but ARM/ARM64 this patch does not change
> the current kernel behaviour on them.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> [pci]
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/glue.c     |  4 ++--
>  drivers/acpi/scan.c     | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c     |  3 +--
>  include/acpi/acpi_bus.h |  2 ++
>  include/linux/acpi.h    |  5 +++++
>  5 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 5ea5dc2..f8d6564 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -227,8 +227,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  
>  	attr = acpi_get_dma_attr(acpi_dev);
>  	if (attr != DEV_DMA_NOT_SUPPORTED)
> -		arch_setup_dma_ops(dev, 0, 0, NULL,
> -				   attr == DEV_DMA_COHERENT);
> +		acpi_dma_configure(dev, attr);
>  
>  	acpi_physnode_link_name(physical_node_name, node_id);
>  	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
> @@ -251,6 +250,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	return 0;
>  
>   err:
> +	acpi_dma_deconfigure(dev);
>  	ACPI_COMPANION_SET(dev, NULL);
>  	put_device(dev);
>  	put_device(&acpi_dev->dev);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 3d1856f..45b5710 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1370,6 +1370,46 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>  		return DEV_DMA_NON_COHERENT;
>  }
>  
> +/**
> + * acpi_dma_configure - Set-up DMA configuration for the device.
> + * @dev: The pointer to the device
> + * @attr: device dma attributes
> + */
> +void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> +{
> +	/*
> +	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> +	 * setup the correct supported mask.
> +	 */
> +	if (!dev->coherent_dma_mask)
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +	/*
> +	 * Set it to coherent_dma_mask by default if the architecture
> +	 * code has not set it.
> +	 */
> +	if (!dev->dma_mask)
> +		dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/*
> +	 * Assume dma valid range starts at 0 and covers the whole
> +	 * coherent_dma_mask.
> +	 */
> +	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, NULL,
> +			   attr == DEV_DMA_COHERENT);
> +}
> +EXPORT_SYMBOL_GPL(acpi_dma_configure);
> +
> +/**
> + * acpi_dma_deconfigure - Tear-down DMA configuration for the device.
> + * @dev: The pointer to the device
> + */
> +void acpi_dma_deconfigure(struct device *dev)
> +{
> +	arch_teardown_dma_ops(dev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_dma_deconfigure);
> +
>  static void acpi_init_coherency(struct acpi_device *adev)
>  {
>  	unsigned long long cca = 0;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ab00267..c29e07a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1738,8 +1738,7 @@ static void pci_dma_configure(struct pci_dev *dev)
>  		if (attr == DEV_DMA_NOT_SUPPORTED)
>  			dev_warn(&dev->dev, "DMA not supported.\n");
>  		else
> -			arch_setup_dma_ops(&dev->dev, 0, 0, NULL,
> -					   attr == DEV_DMA_COHERENT);
> +			acpi_dma_configure(&dev->dev, attr);
>  	}
>  
>  	pci_put_host_bridge_device(bridge);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index c1a524d..4242c31 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -573,6 +573,8 @@ struct acpi_pci_root {
>  
>  bool acpi_dma_supported(struct acpi_device *adev);
>  enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> +void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
> +void acpi_dma_deconfigure(struct device *dev);
>  
>  struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
>  					   u64 address, bool check_children);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 996a29c..8d15fc5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -765,6 +765,11 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>  	return DEV_DMA_NOT_SUPPORTED;
>  }
>  
> +static inline void acpi_dma_configure(struct device *dev,
> +				      enum dev_dma_attr attr) { }
> +
> +static inline void acpi_dma_deconfigure(struct device *dev) { }
> +
>  #define ACPI_PTR(_ptr)	(NULL)
>  
>  static inline void acpi_device_set_enumerated(struct acpi_device *adev)
> -- 
> 2.10.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
