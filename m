Return-Path: <gwshan@linux.vnet.ibm.com>
Return-Path: <gwshan@linux.vnet.ibm.com>
Date: Mon, 25 Jul 2016 11:24:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>, xyjxie@linux.vnet.ibm.com
Subject: Re: [PATCH resend v2] Extending kernel option pci=resource_alignment
 to be able to specify PCI device/vendor IDs
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <14535ddd929448b4b8a9f8f2f58439a6@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14535ddd929448b4b8a9f8f2f58439a6@FE-MBX1012.de.bosch.com>
Message-Id: <20160725012446.GA11609@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 22, 2016 at 10:41:59AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
>Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned 
>PCI memory resources are not page aligned.
>By using the kernel option "pci=resource_alignment" it is possible to force
>single PCI boards to use page alignment for their memory resources.
>However, this is fairly cumbersome if multiple of these boards are in use as 
>the specification of the cards has to be done via PCI bus/slot/function number
>which might change e.g. by adding another board.
>This patch extends the kernel option "pci=resource_alignment" to allow to
>specify the relevant boards via PCI device/vendor (and subdevice/subvendor) ids.
>The specification of the devices via device/vendor is indicated by a leading
>string "pci:" as argument to "pci=resource_alignment".
>The format of the specification is
>  pci:<vendor>:<device>[:<subvendor>:<subdevice>]
>
>Examples: 
>  pci=resource_alignment=4096@pci:1234:abcd:1234:bcde
>  pci=resource_alignment=pci:1234:abcd
>
>Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
>

Mathias, The code change would conflict with Yongji's patch where the wildcard introduced
to identify PCI devices.

https://patchwork.ozlabs.org/patch/642473/

>---
> Documentation/kernel-parameters.txt |    2 +
> drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++-----------
> 2 files changed, 49 insertions(+), 19 deletions(-)
>
>Index: linux-4.7-rc1/Documentation/kernel-parameters.txt
>===================================================================
>--- linux-4.7-rc1.orig/Documentation/kernel-parameters.txt
>+++ linux-4.7-rc1/Documentation/kernel-parameters.txt
>@@ -2998,12 +2998,17 @@ bytes respectively. Such letter suffixes
> 		resource_alignment=
> 				Format:
> 				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
>+				[<order of align>@]pci:<vendor>:<device>\
>+						[:<subvendor>:<subdevice>][; ...]
> 				Specifies alignment and device to reassign
> 				aligned memory resources.
> 				If <order of align> is not specified,
> 				PAGE_SIZE is used as alignment.
> 				PCI-PCI bridge can be specified, if resource
> 				windows need to be expanded.
>+				To specify the alignment for certain types of devices, the
>+				PCI vendor/device (and subvendor/subdevice) may be
>+				specified. E.g. 4096@pci:1234:abcd:1234:bcde
> 		ecrc=		Enable/disable PCIe ECRC (transaction layer
> 				end-to-end CRC checking).
> 				bios: Use BIOS/firmware settings. This is the
>Index: linux-4.7-rc1/drivers/pci/pci.c
>===================================================================
>--- linux-4.7-rc1.orig/drivers/pci/pci.c
>+++ linux-4.7-rc1/drivers/pci/pci.c
>@@ -4755,6 +4755,7 @@ static DEFINE_SPINLOCK(resource_alignmen
> static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
> {
> 	int seg, bus, slot, func, align_order, count;
>+	unsigned short vendor, device, subsystem_vendor, subsystem_device;
> 	resource_size_t align = 0;
> 	char *p;
>
>@@ -4768,28 +4769,55 @@ static resource_size_t pci_specified_res
> 		} else {
> 			align_order = -1;
> 		}
>-		if (sscanf(p, "%x:%x:%x.%x%n",
>-			&seg, &bus, &slot, &func, &count) != 4) {
>-			seg = 0;
>-			if (sscanf(p, "%x:%x.%x%n",
>-					&bus, &slot, &func, &count) != 3) {
>-				/* Invalid format */
>-				printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
>-					p);
>+		if (strncmp(p, "pci:", 4) == 0) {
>+			/* PCI vendor/device (subvendor/subdevice) ids are specified */
>+			p += 4;
>+			if (sscanf(p, "%hx:%hx:%hx:%hx%n",
>+				&vendor, &device, &subsystem_vendor, &subsystem_device, &count) != 4) {
>+				if (sscanf(p, "%hx:%hx%n", &vendor, &device, &count) != 2) {
>+					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: pci:%s\n",
>+						p);
>+					break;
>+				}
>+				subsystem_vendor = subsystem_device = 0;

"pci:" is used as the prefix here. I'm not sure "id:" might be more indicative?

No consecutive calls to sscanf() isn't needed if I'm correct enough. The return value
from first sscanf() call is cached and it can be used to check how many parameters
have been scaned successfully.

>+			}
>+			p += count;
>+			if ((!vendor || (vendor == dev->vendor)) &&
>+				(!device || (device == dev->device)) &&
>+				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
>+				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
>+				if (align_order == -1)
>+					align = PAGE_SIZE;
>+				else
>+					align = 1 << align_order;
>+				/* Found */

Unnecessary comment as the it's obvious from the code.

> 				break;
> 			}
> 		}
>-		p += count;
>-		if (seg == pci_domain_nr(dev->bus) &&
>-			bus == dev->bus->number &&
>-			slot == PCI_SLOT(dev->devfn) &&
>-			func == PCI_FUNC(dev->devfn)) {
>-			if (align_order == -1)
>-				align = PAGE_SIZE;
>-			else
>-				align = 1 << align_order;
>-			/* Found */
>-			break;
>+		else {
>+			if (sscanf(p, "%x:%x:%x.%x%n",
>+				&seg, &bus, &slot, &func, &count) != 4) {
>+				seg = 0;
>+				if (sscanf(p, "%x:%x.%x%n",
>+						&bus, &slot, &func, &count) != 3) {
>+					/* Invalid format */
>+					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
>+						p);
>+					break;
>+				}
>+			}
>+			p += count;
>+			if (seg == pci_domain_nr(dev->bus) &&
>+				bus == dev->bus->number &&
>+				slot == PCI_SLOT(dev->devfn) &&
>+				func == PCI_FUNC(dev->devfn)) {
>+				if (align_order == -1)
>+					align = PAGE_SIZE;
>+				else
>+					align = 1 << align_order;
>+				/* Found */
>+				break;
>+			}
> 		}
> 		if (*p != ';' && *p != ',') {
> 			/* End of param or invalid format */

Thanks,
Gavin
