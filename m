Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0102.outbound.protection.outlook.com ([65.55.169.102]:54401
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755758AbcAHV5L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jan 2016 16:57:11 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Haiyang Zhang" <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v9 4/7] PCI: Add fwnode_handle to pci_sysdata
Date: Fri, 8 Jan 2016 21:57:04 +0000
Message-ID: <DM2PR0301MB123288BC5BEBC322BE98E870ABF60@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
 <1449701697-6366-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449701697-6366-5-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: jakeo@microsoft.com [mailto:jakeo@microsoft.com]
> Sent: Wednesday, December 9, 2015 2:55 PM
> To: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; tglx@linutronix.de; Haiyang
> Zhang <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Cc: Jake Oshins <jakeo@microsoft.com>
> Subject: [PATCH v9 4/7] PCI: Add fwnode_handle to pci_sysdata
> 
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch adds an fwnode_handle to struct pci_sysdata, which is
> used by the next patch in the series when trying to locate an
> IRQ domain associated with a root PCI bus.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  arch/x86/include/asm/pci.h | 15 +++++++++++++++
>  drivers/pci/probe.c        |  1 +
>  include/linux/pci.h        |  4 ++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 4625943..6fc3c7c 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -20,6 +20,9 @@ struct pci_sysdata {
>  #ifdef CONFIG_X86_64
>  	void		*iommu;		/* IOMMU private data */
>  #endif
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +	void		*fwnode;	/* IRQ domain for MSI assignment */
> +#endif
>  };
> 
>  extern int pci_routeirq;
> @@ -32,6 +35,7 @@ extern int noioapicreroute;
>  static inline int pci_domain_nr(struct pci_bus *bus)
>  {
>  	struct pci_sysdata *sd = bus->sysdata;
> +
>  	return sd->domain;
>  }
> 
> @@ -41,6 +45,17 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  }
>  #endif
> 
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
> +{
> +	struct pci_sysdata *sd = bus->sysdata;
> +
> +	return sd->fwnode;
> +}
> +
> +#define pci_root_bus_fwnode	_pci_root_bus_fwnode
> +#endif
> +
>  /* Can be used to override the logic in pci_scan_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index edb1984..750f907 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -15,6 +15,7 @@
>  #include <linux/pci-aspm.h>
>  #include <linux/aer.h>
>  #include <linux/acpi.h>
> +#include <linux/irqdomain.h>
>  #include <asm-generic/pci-bridge.h>
>  #include "pci.h"
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6ae25aa..b414422 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1517,6 +1517,10 @@ static inline int pci_get_new_domain_nr(void) {
> return -ENOSYS; }
> 
>  #include <asm/pci.h>
> 
> +#ifndef pci_root_bus_fwnode
> +#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
> +#endif
> +
>  /* these helpers provide future and backwards compatibility
>   * for accessing popular PCI BAR info */
>  #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
> --
> 1.9.1


Bjorn, are you willing to take this patch and the next one in the series through your tree?  The other patches in this series have already been taken into linux-next by either Greg K-H or Thomas Gleixner, or they're dependent on these two.  Thomas has suggested that the PCI tree would be the right one to incorporate them.

Thanks,
Jake Oshins

