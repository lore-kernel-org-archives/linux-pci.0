Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <56977992.7060808@citrix.com>
Date: Thu, 14 Jan 2016 10:33:54 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Jayachandran C <jchandra@broadcom.com>,
	<linux-pci@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	<xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v6 1/5] APCI: MCFG: Move mmcfg_list management
 to drivers/acpi
References: <1452756761-29584-1-git-send-email-jchandra@broadcom.com>
 <1452756761-29584-2-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1452756761-29584-2-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/01/16 07:32, Jayachandran C wrote:
> Move pci_mmcfg_list handling to a drivers/acpi/pci_mcfg.c. This is
> to share the API and code with ARM64 later. The corresponding
> declarations are moved from asm/pci_x86.h to linux/pci-acpi.h
[...]
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -27,9 +27,6 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/xen/hypercall.h>
>  #include "../pci/pci.h"
> -#ifdef CONFIG_PCI_MMCONFIG
> -#include <asm/pci_x86.h>
> -#endif
>  
>  static bool __read_mostly pci_seg_supported = true;
>  
> @@ -221,7 +218,7 @@ static int __init xen_mcfg_late(void)
>  	if (!xen_initial_domain())
>  		return 0;
>  
> -	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
> +	if (!pci_mmconfig_enabled())
>  		return 0;
>  
>  	if (list_empty(&pci_mmcfg_list))

Xen parts:

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
