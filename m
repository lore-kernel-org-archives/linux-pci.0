Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0131.outbound.protection.outlook.com ([207.46.100.131]:20203
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753918AbbLBV6M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 16:58:12 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Jake Oshins <jakeo@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v6 0/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
Date: Wed, 2 Dec 2015 21:23:57 +0000
Message-ID: <DM2PR0301MB12326BFF4891831AF426C17DAB0E0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1446499996-1350-1-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1446499996-1350-1-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: jakeo@microsoft.com [mailto:jakeo@microsoft.com]
> Sent: Monday, November 2, 2015 1:33 PM
> To: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; tglx@redhat.com; Haiyang
> Zhang <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Cc: Jake Oshins <jakeo@microsoft.com>
> Subject: [PATCH v6 0/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
> VMs
> 
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This version of this patch series incorporates feedback from Andy
> Shevchenko.
> 
> First, export functions that allow correlating Hyper-V virtual processors
> and Linux cpus, along with the means for invoking a hypercall that targets
> interrupts at chosen vectors on specfic cpus.
> 
> Second, mark various parts of IRQ domain related code as exported, so that
> this PCI front-end can implement an IRQ domain as part of a module.  (The
> alternative would be to pull all this into the kernel, which would pull
> in a lot of other Hyper-V related code, as this IRQ domain depends on
> hv_vmbus.ko.)
> 
> Third, modify PCI so that new root PCI buses can be marked with an
> associated
> fwnode_handle, and so that root PCI buses can look up their associated IRQ
> domain by that handle.
> 
> Fourth, introduce a new driver, hv_pcifront, which eposes root PCI buses in
> a Hyper-V VM.  These root PCI buses expose real PCIe devices, or PCI Virtual
> Functions.
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
>  arch/x86/include/asm/msi.h     |    4 +
>  arch/x86/include/asm/pci.h     |   13 +
>  arch/x86/kernel/apic/msi.c     |    5 +-
>  arch/x86/kernel/apic/vector.c  |    2 +
>  drivers/hv/hv.c                |   20 +-
>  drivers/hv/hyperv_vmbus.h      |    2 +-
>  drivers/hv/vmbus_drv.c         |   17 +
>  drivers/pci/Kconfig            |    7 +
>  drivers/pci/host/Makefile      |    1 +
>  drivers/pci/host/hv_pcifront.c | 2267
> ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/msi.c              |    4 +
>  drivers/pci/probe.c            |   14 +
>  include/asm-generic/pci.h      |    4 +
>  include/linux/hyperv.h         |   14 +
>  kernel/irq/chip.c              |    1 +
>  kernel/irq/irqdomain.c         |    2 +
>  17 files changed, 2365 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/pci/host/hv_pcifront.c
> 
> --
> 1.9.1


Apparently I've been using the wrong e-mail address for Thomas Gleixner.  Sorry about that.

Are there any more comments about this patch series?

Thanks,
Jake Oshins

