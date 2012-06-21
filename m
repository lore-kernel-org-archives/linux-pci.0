Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:53460 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab2FULJE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 07:09:04 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Jan Beulich" <JBeulich@suse.com>
Cc: "Wei Wang" <wei.wang2@amd.com>,
	"Jesse Barnes" <jbarnes@virtuousgeek.org>,
	"Sherry Hurwitz" <sherry.hurwitz@amd.com>,
	"Andrew Cooper" <andrew.cooper3@citrix.com>,
	"Jeremy Fitzhardinge" <jeremy@goop.org>, <stable@kernel.org>,
	"xen-devel\@lists.xensource.com" <xen-devel@lists.xensource.com>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	<linux-pci@vger.kernel.org>
References: <4FD72FE4.80009@amd.com>
	<4FD778C802000078000897EF@nat28.tlf.novell.com>
	<4FD76976.2020203@citrix.com>
	<4FD78DE6020000780008986D@nat28.tlf.novell.com>
	<4FD9D559.9050206@amd.com>
	<4FDA0ECD0200007800089FEA@nat28.tlf.novell.com>
	<4FDA0028.3090609@amd.com>
	<4FE30CBB020000780008B06B@nat28.tlf.novell.com>
Date: Thu, 21 Jun 2012 04:08:46 -0700
In-Reply-To: <4FE30CBB020000780008B06B@nat28.tlf.novell.com> (Jan Beulich's
	message of "Thu, 21 Jun 2012 10:59:55 +0100")
Message-ID: <8762ak9b29.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] PCI/MSI: don't disable AMD IOMMU MSI on Xen dom0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"Jan Beulich" <JBeulich@suse.com> writes:

>>>> On 14.06.12 at 17:15, Wei Wang <wei.wang2@amd.com> wrote:
>> Am 14.06.2012 16:18, schrieb Jan Beulich:
>>> Have you at all considered getting this fixed on the kernel side?
>>> As I don't have direct access to any AMD IOMMU capable
>>> system - can one, other than by enumerating the respective
>>> PCI IDs or reading ACPI tables, reasonably easily identify the
>>> devices in question (e.g. via vendor/class/sub-class or some
>>> such)? That might permit skipping those in the offending kernel
>>> code...
>> 
>> AMD IOMMUs (both v1 and v2) uses class id 08 (System Base Peripheral) 
>> and sub class id 06 (IOMMU). Combined with PCI_VENDEOR_ID_AMD, this 
>> should be enough to identify amd iommu device. I could send you a kernel 
>> patch for review using this approach. I would believe that fixing this 
>> issue in 4.2, no matter how, is really important for amd iommu.
>
> As you didn't come forward with anything, here's my first
> take on this:
>
> Commit d5dea7d95c48d7bc951cee4910a7fd9c0cd26fb0 ("PCI: msi: Disable msi
> interrupts when we initialize a pci device") caused MSI to get disabled
> on Xen Dom0 despite it having got turned on purposefully by the
> hypervisor. As an immediate band aid, suppress the disabling in this
> specific case.
>
> I don't think, however, that either the original change or this fix are
> really appropriate. The original fix, besides leaving aside the
> presence of a hypervisor like Xen, doesn't deal with all possible
> cases (in particular it has no effect if the secondary kernel was built
> with CONFIG_PCI_MSI unset). And taking into account a hypervisor like
> Xen, the logic like this should probably be skipped altogether (i.e. it
> should be entirely left to the hypervisor, being the entity in control
> of IRQs).

The original fix is fine. Xen dom0 remains insane.  Although perhaps
some better than Xen dom0 once was.

Why does the dom0 kernel even get any access to pci devices that
Xen doesn't want it to touch?

As far as I can tell my patch has revealed a design bug in Xen.  If you
don't want to be messed up by the kernel don't let the kernel touch
things.  At the very least we need an abstraction much cleaner
than the patch below.

Eric


> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@kernel.org 
>
> ---
>  drivers/pci/msi.c       |    7 +++++++
>  include/linux/pci_ids.h |    1 +
>  2 files changed, 8 insertions(+)
>
> --- 3.5-rc3/drivers/pci/msi.c
> +++ 3.5-rc3-xen-pci-msi-no-iommu-disable/drivers/pci/msi.c
> @@ -20,6 +20,7 @@
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <xen/xen.h>
>  
>  #include "pci.h"
>  #include "msi.h"
> @@ -1022,7 +1023,13 @@ void pci_msi_init_pci_dev(struct pci_dev
>  	/* Disable the msi hardware to avoid screaming interrupts
>  	 * during boot.  This is the power on reset default so
>  	 * usually this should be a noop.
> +	 * But on a Xen host don't do this for IOMMUs which the hypervisor
> +	 * is in control of (and hence has already enabled on purpose).
>  	 */
> +	if (xen_initial_domain()
> +	    && (dev->class >> 8) == PCI_CLASS_SYSTEM_IOMMU
> +	    && dev->vendor == PCI_VENDOR_ID_AMD)
> +		return;
>  	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
>  	if (pos)
>  		msi_set_enable(dev, pos, 0);
> --- 3.5-rc3/include/linux/pci_ids.h
> +++ 3.5-rc3-xen-pci-msi-no-iommu-disable/include/linux/pci_ids.h
> @@ -75,6 +75,7 @@
>  #define PCI_CLASS_SYSTEM_RTC		0x0803
>  #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
>  #define PCI_CLASS_SYSTEM_SDHCI		0x0805
> +#define PCI_CLASS_SYSTEM_IOMMU		0x0806
>  #define PCI_CLASS_SYSTEM_OTHER		0x0880
>  
>  #define PCI_BASE_CLASS_INPUT		0x09
