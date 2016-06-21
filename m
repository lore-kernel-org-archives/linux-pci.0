Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60638 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbcFUWAI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jun 2016 18:00:08 -0400
Date: Tue, 21 Jun 2016 17:00:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Extending kernel option pci=resource_alignment to be
 able to specify PCI device/vendor IDs
Message-ID: <20160621220003.GC7603@localhost>
References: <22400b8828ad44ddbccb876cc5ca3b11@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22400b8828ad44ddbccb876cc5ca3b11@FE-MBX1012.de.bosch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 02:24:17PM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned 
> PCI memory resources are not page aligned.

Right.  PCI BARs must be aligned on their size.  BARs that are smaller
than a page are not required by PCI to be page-aligned.  Therefore, a
single page may contain several small BARs, or it may contain a small
BAR and some unallocated space.

Both are potential issues because mmap works on a page granularity.
If a user can mmap a page that contains several small BARs, he may be
able to access to more devices than he should.  If a user can mmap a
page that contains unallocated space, she may be able to cause PCI
errors.

You have a device with a 128-byte BAR at 0xeae4f400.  That doesn't
work with uio_cif because b65502879556 ("uio: we cannot mmap unaligned
page contents"), which appeared in v3.13, makes the mmap fail if the
starting address is not page-aligned.

Your patch works around that by moving BARs so they are page-aligned.
I think this is OK, but of course, there's nothing you can do about
the fact that the BAR is smaller than a page, and there might be other
things after the BAR in the same page.  I think that's a problem, and
I wouldn't be surprised if we eventually disallow mmap of any BAR
smaller than a page.

I don't know the history of UIO mmap, and I do see the comment in
vm_iomap_memory() about how we've historically allowed non
page-aligned mmap because I/O memory often has smaller alignment, but
it seems like a safety issue to me, so I'm kind of surprised that we
allow it.

In any case, I think I'll apply this patch for v4.8 because it seems
like a reasonable extension of the existing resource_alignment
support.

> By using the kernel option "pci=resource_alignment" it is possible to force
> single PCI boards to use page alignment for their memory resources.
> However, this is fairly cumbersome if multiple of these boards are in use as 
> the specification of the cards has to be done via PCI bus/slot/function number
> which might change e.g. by adding another board.
> This patch extends the kernel option "pci=resource_alignment" to allow to
> specify the relevant boards via PCI device/vendor (and subdevice/subvendor) ids.
> The specification of the devices via device/vendor is indicated by a leading
> string "pci:" as argument to "pci=resource_alignment".
> The format of the specification is
>   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> 
> Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> 
> ---
>  Documentation/kernel-parameters.txt |    2 +
>  drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++-----------
>  2 files changed, 49 insertions(+), 19 deletions(-)
> 
> Index: linux-4.7-rc1/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux-4.7-rc1.orig/Documentation/kernel-parameters.txt
> +++ linux-4.7-rc1/Documentation/kernel-parameters.txt
> @@ -2998,6 +2998,8 @@ bytes respectively. Such letter suffixes
>  		resource_alignment=
>  				Format:
>  				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
> +				[<order of align>@]pci:<vendor>:<device>\
> +						[:<subvendor>:<subdevice>][; ...] 
>  				Specifies alignment and device to reassign
>  				aligned memory resources.
>  				If <order of align> is not specified,
> Index: linux-4.7-rc1/drivers/pci/pci.c
> ===================================================================
> --- linux-4.7-rc1.orig/drivers/pci/pci.c
> +++ linux-4.7-rc1/drivers/pci/pci.c
> @@ -4755,6 +4755,7 @@ static DEFINE_SPINLOCK(resource_alignmen
>  static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>  {
>  	int seg, bus, slot, func, align_order, count;
> +	unsigned short vendor, device, subsystem_vendor, subsystem_device;
>  	resource_size_t align = 0;
>  	char *p;
>  
> @@ -4768,28 +4769,55 @@ static resource_size_t pci_specified_res
>  		} else {
>  			align_order = -1;
>  		}
> -		if (sscanf(p, "%x:%x:%x.%x%n",
> -			&seg, &bus, &slot, &func, &count) != 4) {
> -			seg = 0;
> -			if (sscanf(p, "%x:%x.%x%n",
> -					&bus, &slot, &func, &count) != 3) {
> -				/* Invalid format */
> -				printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
> -					p);
> +		if (strncmp(p, "pci:", 4) == 0) {
> +			/* PCI vendor/device (subvendor/subdevice) ids are specified */
> +			p += 4;
> +			if (sscanf(p, "%hx:%hx:%hx:%hx%n",
> +				&vendor, &device, &subsystem_vendor, &subsystem_device, &count) != 4) {
> +				if (sscanf(p, "%hx:%hx%n", &vendor, &device, &count) != 2) {
> +					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: pci:%s\n",
> +						p);
> +					break;
> +				}
> +				subsystem_vendor = subsystem_device = 0;
> +			}
> +			p += count;
> +			if ((!vendor || (vendor == dev->vendor)) &&
> +				(!device || (device == dev->device)) &&
> +				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
> +				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
> +				if (align_order == -1)
> +					align = PAGE_SIZE;
> +				else
> +					align = 1 << align_order;
> +				/* Found */
>  				break;
>  			}
>  		}
> -		p += count;
> -		if (seg == pci_domain_nr(dev->bus) &&
> -			bus == dev->bus->number &&
> -			slot == PCI_SLOT(dev->devfn) &&
> -			func == PCI_FUNC(dev->devfn)) {
> -			if (align_order == -1)
> -				align = PAGE_SIZE;
> -			else
> -				align = 1 << align_order;
> -			/* Found */
> -			break;
> +		else {
> +			if (sscanf(p, "%x:%x:%x.%x%n",
> +				&seg, &bus, &slot, &func, &count) != 4) {
> +				seg = 0;
> +				if (sscanf(p, "%x:%x.%x%n",
> +						&bus, &slot, &func, &count) != 3) {
> +					/* Invalid format */
> +					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
> +						p);
> +					break;
> +				}
> +			}
> +			p += count;
> +			if (seg == pci_domain_nr(dev->bus) &&
> +				bus == dev->bus->number &&
> +				slot == PCI_SLOT(dev->devfn) &&
> +				func == PCI_FUNC(dev->devfn)) {
> +				if (align_order == -1)
> +					align = PAGE_SIZE;
> +				else
> +					align = 1 << align_order;
> +				/* Found */
> +				break;
> +			}
>  		}
>  		if (*p != ';' && *p != ',') {
>  			/* End of param or invalid format */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
