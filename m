Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:12236 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbCPDYX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Mar 2015 23:24:23 -0400
Message-ID: <55064CD5.1010508@huawei.com>
Date: Mon, 16 Mar 2015 11:24:05 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>, <bhelgaas@google.com>
CC: <liviu@dudau.co.uk>, Rob Herring <robh@kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [Update PATCH] PCI: Assign resources before drivers claim devices
 (pci_scan_root_bus())
References: <1426475936-13017-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1426475936-13017-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
   This patch only update the changes for pci-versatile.c, add the pci_bus_add_devices()
after pci_assign_unassigned_bus_resources(bus). This patch won't conflict with others in
your branch. So you could only update this one.

Thanks!
Yijing.

On 2015/3/16 11:18, Yijing Wang wrote:
> Previously, pci_scan_root_bus() created a root PCI bus, enumerated the
> devices on it, and called pci_bus_add_devices(), which made the devices
> available for drivers to claim them.
> 
> Most callers assigned resources to devices after pci_scan_root_bus()
> returns, which may be after drivers have claimed the devices.  This is
> incorrect; the PCI core should not change device resources while a driver
> is managing the device.
> 
> Remove pci_bus_add_devices() from pci_scan_root_bus() and do it after any
> resource assignment in the callers.
> 
> Note that ARM's pci_common_init_dev() already called pci_bus_add_devices()
> after pci_scan_root_bus(), so we only need to remove the first call:
> 
>   pci_common_init_dev
>     pcibios_init_hw
>       pci_scan_root_bus
>         pci_bus_add_devices        # first call
>     pci_bus_assign_resources
>     pci_bus_add_devices            # second call
> 
> [bhelgaas: changelog, drop "root_bus" var in alpha common_init_pci(),
> return failure earlier in mn10300, add "return" in x86 pcibios_scan_root(),
> return early if xtensa platform_pcibios_fixup() fails]
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> CC: Matt Turner <mattst88@gmail.com>
> CC: David Howells <dhowells@redhat.com>
> CC: Tony Luck <tony.luck@intel.com>
> CC: Michal Simek <monstr@monstr.eu>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
> CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Chris Metcalf <cmetcalf@ezchip.com>
> CC: Chris Zankel <chris@zankel.net>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/alpha/kernel/pci.c          |    7 +++++++
>  arch/frv/mb93090-mb00/pci-vdk.c  |    6 +++++-
>  arch/ia64/sn/kernel/io_init.c    |    2 ++
>  arch/microblaze/pci/pci-common.c |    4 ++++
>  arch/mips/pci/pci.c              |    1 +
>  arch/mn10300/unit-asb2305/pci.c  |    6 +++++-
>  arch/s390/pci/pci.c              |    2 +-
>  arch/sh/drivers/pci/pci.c        |    1 +
>  arch/sparc/kernel/leon_pci.c     |    1 +
>  arch/tile/kernel/pci.c           |    2 ++
>  arch/tile/kernel/pci_gx.c        |    2 ++
>  arch/x86/pci/common.c            |    2 ++
>  arch/xtensa/kernel/pci.c         |   15 +++++++++++++--
>  drivers/pci/host/pci-versatile.c |    1 +
>  drivers/pci/probe.c              |    1 -
>  15 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> index 98a1525..82f738e 100644
> --- a/arch/alpha/kernel/pci.c
> +++ b/arch/alpha/kernel/pci.c
> @@ -338,6 +338,8 @@ common_init_pci(void)
>  
>  		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
>  					hose, &resources);
> +		if (!bus)
> +			continue;
>  		hose->bus = bus;
>  		hose->need_domain_info = need_domain_info;
>  		next_busno = bus->busn_res.end + 1;
> @@ -353,6 +355,11 @@ common_init_pci(void)
>  
>  	pci_assign_unassigned_resources();
>  	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
> +	for (hose = hose_head; hose; hose = hose->next) {
> +		bus = hose->bus;
> +		if (bus)
> +			pci_bus_add_devices(bus);
> +	}
>  }
>  
>  
> diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
> index b073f4d..f211839 100644
> --- a/arch/frv/mb93090-mb00/pci-vdk.c
> +++ b/arch/frv/mb93090-mb00/pci-vdk.c
> @@ -316,6 +316,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  
>  int __init pcibios_init(void)
>  {
> +	struct pci_bus *bus;
>  	struct pci_ops *dir = NULL;
>  	LIST_HEAD(resources);
>  
> @@ -383,12 +384,15 @@ int __init pcibios_init(void)
>  	printk("PCI: Probing PCI hardware\n");
>  	pci_add_resource(&resources, &pci_ioport_resource);
>  	pci_add_resource(&resources, &pci_iomem_resource);
> -	pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
> +	bus = pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
>  
>  	pcibios_irq_init();
>  	pcibios_fixup_irqs();
>  	pcibios_resource_survey();
> +	if (!bus)
> +		return 0;
>  
> +	pci_bus_add_devices(bus);
>  	return 0;
>  }
>  
> diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
> index 0b5ce82..1be65eb 100644
> --- a/arch/ia64/sn/kernel/io_init.c
> +++ b/arch/ia64/sn/kernel/io_init.c
> @@ -271,7 +271,9 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
>   	if (bus == NULL) {
>  		kfree(res);
>  		kfree(controller);
> +		return;
>  	}
> +	pci_bus_add_devices(bus);
>  }
>  
>  /*
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index 48528fb..ae838ed 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -1382,6 +1382,10 @@ static int __init pcibios_init(void)
>  
>  	/* Call common code to handle resource allocation */
>  	pcibios_resource_survey();
> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +		if (hose->bus)
> +			pci_bus_add_devices(hose->bus);
> +	}
>  
>  	return 0;
>  }
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 1bf60b1..9eb54b5 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -114,6 +114,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>  			pci_bus_size_bridges(bus);
>  			pci_bus_assign_resources(bus);
>  		}
> +		pci_bus_add_devices(bus);
>  	}
>  }
>  
> diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
> index 613ca1e..3dfe2d3 100644
> --- a/arch/mn10300/unit-asb2305/pci.c
> +++ b/arch/mn10300/unit-asb2305/pci.c
> @@ -342,6 +342,7 @@ static int __init pcibios_init(void)
>  {
>  	resource_size_t io_offset, mem_offset;
>  	LIST_HEAD(resources);
> +	struct pci_bus *bus;
>  
>  	ioport_resource.start	= 0xA0000000;
>  	ioport_resource.end	= 0xDFFFFFFF;
> @@ -371,11 +372,14 @@ static int __init pcibios_init(void)
>  
>  	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
>  	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
> -	pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
> +	bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
> +	if (!bus)
> +		return 0;
>  
>  	pcibios_irq_init();
>  	pcibios_fixup_irqs();
>  	pcibios_resource_survey();
> +	pci_bus_add_devices(bus);
>  	return 0;
>  }
>  
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 753a567..a2a7391 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -776,8 +776,8 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
>  		zpci_cleanup_bus_resources(zdev);
>  		return -EIO;
>  	}
> -
>  	zdev->bus->max_bus_speed = zdev->max_bus_speed;
> +	pci_bus_add_devices(zdev->bus);
>  	return 0;
>  }
>  
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index 1bc09ee..efc1051 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -69,6 +69,7 @@ static void pcibios_scanbus(struct pci_channel *hose)
>  
>  		pci_bus_size_bridges(bus);
>  		pci_bus_assign_resources(bus);
> +		pci_bus_add_devices(bus);
>  	} else {
>  		pci_free_resource_list(&resources);
>  	}
> diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
> index 899b720..2971076 100644
> --- a/arch/sparc/kernel/leon_pci.c
> +++ b/arch/sparc/kernel/leon_pci.c
> @@ -40,6 +40,7 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
>  
>  		/* Assign devices with resources */
>  		pci_assign_unassigned_resources();
> +		pci_bus_add_devices(root_bus);
>  	} else {
>  		pci_free_resource_list(&resources);
>  	}
> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
> index 325df47..9475a74 100644
> --- a/arch/tile/kernel/pci.c
> +++ b/arch/tile/kernel/pci.c
> @@ -339,6 +339,8 @@ int __init pcibios_init(void)
>  			struct pci_bus *next_bus;
>  			struct pci_dev *dev;
>  
> +			pci_bus_add_devices(root_bus);
> +
>  			list_for_each_entry(dev, &root_bus->devices, bus_list) {
>  				/*
>  				 * Find the PCI host controller, ie. the 1st
> diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
> index 2c95f37..b1df847 100644
> --- a/arch/tile/kernel/pci_gx.c
> +++ b/arch/tile/kernel/pci_gx.c
> @@ -1030,6 +1030,8 @@ int __init pcibios_init(void)
>  alloc_mem_map_failed:
>  			break;
>  		}
> +
> +		pci_bus_add_devices(root_bus);
>  	}
>  
>  	return 0;
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 3d2612b..95a0ba7 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -490,7 +490,9 @@ void pcibios_scan_root(int busnum)
>  	if (!bus) {
>  		pci_free_resource_list(&resources);
>  		kfree(sd);
> +		return;
>  	}
> +	pci_bus_add_devices(bus);
>  }
>  
>  void __init pcibios_set_cache_line_size(void)
> diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
> index 5b34033..b848cc3 100644
> --- a/arch/xtensa/kernel/pci.c
> +++ b/arch/xtensa/kernel/pci.c
> @@ -174,7 +174,7 @@ static int __init pcibios_init(void)
>  	struct pci_controller *pci_ctrl;
>  	struct list_head resources;
>  	struct pci_bus *bus;
> -	int next_busno = 0;
> +	int next_busno = 0, ret;
>  
>  	printk("PCI: Probing PCI hardware\n");
>  
> @@ -185,14 +185,25 @@ static int __init pcibios_init(void)
>  		pci_controller_apertures(pci_ctrl, &resources);
>  		bus = pci_scan_root_bus(NULL, pci_ctrl->first_busno,
>  					pci_ctrl->ops, pci_ctrl, &resources);
> +		if (!bus)
> +			continue;
> +
>  		pci_ctrl->bus = bus;
>  		pci_ctrl->last_busno = bus->busn_res.end;
>  		if (next_busno <= pci_ctrl->last_busno)
>  			next_busno = pci_ctrl->last_busno+1;
>  	}
>  	pci_bus_count = next_busno;
> +	ret = platform_pcibios_fixup();
> +	if (ret)
> +		return ret;
>  
> -	return platform_pcibios_fixup();
> +	for (pci_ctrl = pci_ctrl_head; pci_ctrl; pci_ctrl = pci_ctrl->next) {
> +		if (pci_ctrl->bus)
> +			pci_bus_add_devices(pci_ctrl->bus);
> +	}
> +
> +	return 0;
>  }
>  
>  subsys_initcall(pcibios_init);
> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
> index 4e68482..4352ee9 100644
> --- a/drivers/pci/host/pci-versatile.c
> +++ b/drivers/pci/host/pci-versatile.c
> @@ -215,6 +215,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  	pci_assign_unassigned_bus_resources(bus);
> +	pci_bus_add_devices(bus);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 88604f2..8ef0375 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2087,7 +2087,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>  	if (!found)
>  		pci_bus_update_busn_res_end(b, max);
>  
> -	pci_bus_add_devices(b);
>  	return b;
>  }
>  EXPORT_SYMBOL(pci_scan_root_bus);
> 


-- 
Thanks!
Yijing

