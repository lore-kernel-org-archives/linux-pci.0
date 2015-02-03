Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Patch v2 21/23] x86/PCI: Refine the way to release PCI IRQ resources
Date: Tue, 03 Feb 2015 22:57:53 +0100
Message-ID: <1432434.BPb1XrlA2r@vostro.rjw.lan>
In-Reply-To: <1422844988-13854-22-git-send-email-jiang.liu@linux.intel.com>
References: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com> <1422844988-13854-22-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, February 02, 2015 10:43:06 AM Jiang Liu wrote:
> Some PCI device drivers assume that pci_dev->irq won't change after
> calling pci_disable_device() and pci_enable_device() during suspend and
> resume.
> 
> Commit c03b3b0738a5 ("x86, irq, mpparse: Release IOAPIC pin when
> PCI device is disabled") frees PCI IRQ resources when pci_disable_device()
> is called and reallocate IRQ resources when pci_enable_device() is
> called again. This breaks above assumption. So commit 3eec595235c1
> ("x86, irq, PCI: Keep IRQ assignment for PCI devices during
> suspend/hibernation") and 9eabc99a635a ("x86, irq, PCI: Keep IRQ
> assignment for runtime power management") fix the issue by avoiding
> freeing/reallocating IRQ resources during PCI device suspend/resume.
> They achieve this by checking dev.power.is_prepared and
> dev.power.runtime_status.  PM maintainer, Rafael, then pointed out that
> it's really an ugly fix which leaking PM internal state information to
> IRQ subsystem.
> 
> Recently David Vrabel <david.vrabel@citrix.com> also reports an
> regression in pciback driver caused by commit cffe0a2b5a34 ("x86, irq:
> Keep balance of IOAPIC pin reference count"). Please refer to:
> http://lkml.org/lkml/2015/1/14/546
> 
> So this patch refine the way to release PCI IRQ resources. Instead of
> releasing PCI IRQ resources in pci_disable_device()/
> pcibios_disable_device(), we now release it at driver unbinding
> notification BUS_NOTIFY_UNBOUND_DRIVER. In other word, we only release
> PCI IRQ resources when there's no driver bound to the PCI device, and
> it keeps the assumption that pci_dev->irq won't through multiple
> invocation of pci_enable_device()/pci_disable_device().

The code after the patch looks better to me than before it, but ->

> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    2 --
>  arch/x86/pci/common.c          |   30 ++++++++++++++++++++++++++++--
>  arch/x86/pci/intel_mid_pci.c   |    4 ++--
>  arch/x86/pci/irq.c             |   15 +--------------
>  drivers/acpi/pci_irq.c         |    9 +--------
>  5 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 164e3f8d3c3d..fa1195dae425 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -93,8 +93,6 @@ extern raw_spinlock_t pci_config_lock;
>  extern int (*pcibios_enable_irq)(struct pci_dev *dev);
>  extern void (*pcibios_disable_irq)(struct pci_dev *dev);
>  
> -extern bool mp_should_keep_irq(struct device *dev);
> -
>  struct pci_raw_ops {
>  	int (*read)(unsigned int domain, unsigned int bus, unsigned int devfn,
>  						int reg, int len, u32 *val);
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 7b20bccf3648..99f15ed19f38 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -497,6 +497,25 @@ void __init pcibios_set_cache_line_size(void)
>  	}
>  }
>  
> +static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,
> +			    void *data)
> +{
> +	struct pci_dev *dev = to_pci_dev(data);
> +
> +	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
> +		return NOTIFY_DONE;
> +
> +	if (pcibios_disable_irq)
> +		pcibios_disable_irq(dev);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block pci_irq_nb = {
> +	.notifier_call = pci_irq_notifier,
> +	.priority = INT_MIN,
> +};
> +
>  int __init pcibios_init(void)
>  {
>  	if (!raw_pci_ops) {
> @@ -509,6 +528,9 @@ int __init pcibios_init(void)
>  
>  	if (pci_bf_sort >= pci_force_bf)
>  		pci_sort_breadthfirst();
> +
> +	bus_register_notifier(&pci_bus_type, &pci_irq_nb);
> +
>  	return 0;
>  }
>  
> @@ -669,8 +691,12 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  
>  void pcibios_disable_device (struct pci_dev *dev)

-> Since the default __weak implementation of this is an empty function, do
we still need this one here?

>  {
> -	if (!pci_dev_msi_enabled(dev) && pcibios_disable_irq)
> -		pcibios_disable_irq(dev);
> +	/*
> +	 * Some device drivers assume dev->irq won't change after calling
> +	 * pci_disable_device(). So delay releasing of IRQ resource to driver
> +	 * unbinding time. Otherwise it will break PM subsystem and drivers
> +	 * like xen-pciback etc.
> +	 */

And perhaps you can put a comment like this one into the notifier routine instead?

>  }
>  
>  int pci_ext_cfg_avail(void)
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index 44b9271580b5..95c2471f6819 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -234,10 +234,10 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
>  
>  static void intel_mid_pci_irq_disable(struct pci_dev *dev)
>  {
> -	if (!mp_should_keep_irq(&dev->dev) && dev->irq_managed &&
> -	    dev->irq > 0) {
> +	if (dev->irq_managed && dev->irq > 0) {
>  		mp_unmap_irq(dev->irq);
>  		dev->irq_managed = 0;
> +		dev->irq = 0;
>  	}
>  }
>  
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index 5dc6ca5e1741..e71b3dbd87b8 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -1256,22 +1256,9 @@ static int pirq_enable_irq(struct pci_dev *dev)
>  	return 0;
>  }
>  
> -bool mp_should_keep_irq(struct device *dev)
> -{
> -	if (dev->power.is_prepared)
> -		return true;
> -#ifdef CONFIG_PM
> -	if (dev->power.runtime_status == RPM_SUSPENDING)
> -		return true;
> -#endif
> -
> -	return false;
> -}
> -
>  static void pirq_disable_irq(struct pci_dev *dev)
>  {
> -	if (io_apic_assign_pci_irqs && !mp_should_keep_irq(&dev->dev) &&
> -	    dev->irq_managed && dev->irq) {
> +	if (io_apic_assign_pci_irqs && dev->irq_managed && dev->irq) {
>  		mp_unmap_irq(dev->irq);
>  		dev->irq = 0;
>  		dev->irq_managed = 0;
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index b1def411c0b8..e7f718d6918a 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -485,14 +485,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
>  	if (!pin || !dev->irq_managed || dev->irq <= 0)
>  		return;
>  
> -	/* Keep IOAPIC pin configuration when suspending */
> -	if (dev->dev.power.is_prepared)
> -		return;
> -#ifdef	CONFIG_PM
> -	if (dev->dev.power.runtime_status == RPM_SUSPENDING)
> -		return;
> -#endif
> -
>  	entry = acpi_pci_irq_lookup(dev, pin);
>  	if (!entry)
>  		return;
> @@ -513,5 +505,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
>  	if (gsi >= 0) {
>  		acpi_unregister_gsi(gsi);
>  		dev->irq_managed = 0;
> +		dev->irq = 0;
>  	}
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
