Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0129.outbound.protection.outlook.com ([65.55.169.129]:30336
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933492AbbLORgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2015 12:36:16 -0500
From: KY Srinivasan <kys@microsoft.com>
To: Jake Oshins <jakeo@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
CC: Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH v9 0/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
Date: Tue, 15 Dec 2015 17:36:12 +0000
Message-ID: <BY2PR0301MB16545331BCB31D708A74C583A0EE0@BY2PR0301MB1654.namprd03.prod.outlook.com>
References: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449701697-6366-1-git-send-email-jakeo@microsoft.com>
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
> Subject: [PATCH v9 0/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
> VMs
> 
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This version of the patch series removes warning when compiling x86
> 32-bit.
> 
> First, export functions that allow correlating Hyper-V virtual processors
> and Linux cpus, along with the means for invoking a hypercall that targets
> interrupts at chosen vectors on specific cpus.
> 
> Second, mark various parts of IRQ domain related code as exported, so that
> this PCI front-end can implement an IRQ domain as part of a module.  (The
> alternative would be to pull all tyhis into the kernel, which would pull
> in a lot of other Hyper-V related code, as this IRQ domain depends on
> vmbus.ko.)
> 
> Third, modify PCI so that new root PCI buses can be marked with an
> associated
> fwnode_handle, and so that root PCI buses can look up their associated IRQ
> domain by that handle.
> 
> Fourth, introduce a new driver, hv_pcifront, which exposes root PCI buses in
> a Hyper-V VM.  These root PCI buses expose real PCIe device, or PCI Virtual
> Functions.
> 
> 
> Jake Oshins (7):
>   drivers:hv: Export a function that maps Linux CPU num onto Hyper-V
>     proc num
>   drivers:hv: Export hv_do_hypercall()
>   PCI: Make it possible to implement a PCI MSI IRQ Domain in a module.
>   PCI: Add fwnode_handle to pci_sysdata
>   PCI: irqdomain: Look up IRQ domain by fwnode_handle
>   drivers:hv: Define the channel type of Hyper-V PCI Express
>     pass-through
>   PCI: hv: New paravirtual PCI front-end for Hyper-V VMs
> 
>  MAINTAINERS                    |    1 +
>  arch/x86/include/asm/msi.h     |    6 +
>  arch/x86/include/asm/pci.h     |   15 +
>  arch/x86/kernel/apic/msi.c     |    8 +-
>  arch/x86/kernel/apic/vector.c  |    2 +
>  drivers/hv/hv.c                |   20 +-
>  drivers/hv/hyperv_vmbus.h      |    2 +-
>  drivers/hv/vmbus_drv.c         |   17 +
>  drivers/pci/Kconfig            |    7 +
>  drivers/pci/host/Makefile      |    1 +
>  drivers/pci/host/hv_pcifront.c | 2250
> ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/msi.c              |    4 +
>  drivers/pci/probe.c            |   15 +
>  include/linux/hyperv.h         |   14 +
>  include/linux/pci.h            |    4 +
>  kernel/irq/chip.c              |    1 +
>  kernel/irq/irqdomain.c         |    4 +
>  17 files changed, 2357 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/pci/host/hv_pcifront.c
> 
> --
> 1.9.1

Of these 7 patches, Greg has committed all of the VMBUS
related supporting patches (3 patches). Thomas, can you 
take the IRQ related patches through your tree.

Regards,

K. Y

