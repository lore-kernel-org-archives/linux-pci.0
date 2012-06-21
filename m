Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:48812
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758998Ab2FULXo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 07:23:44 -0400
Message-ID: <4FE303C4.3060705@amd.com>
Date: Thu, 21 Jun 2012 13:21:40 +0200
From: Wei Wang <wei.wang2@amd.com>
MIME-Version: 1.0
To: Jan Beulich <JBeulich@suse.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, <ebiederm@xmission.com>,
	Sherry Hurwitz <sherry.hurwitz@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>, <stable@kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: don't disable AMD IOMMU MSI on Xen dom0
References: <4FD72FE4.80009@amd.com> <4FD778C802000078000897EF@nat28.tlf.novell.com> <4FD76976.2020203@citrix.com> <4FD78DE6020000780008986D@nat28.tlf.novell.com> <4FD9D559.9050206@amd.com> <4FDA0ECD0200007800089FEA@nat28.tlf.novell.com> <4FDA0028.3090609@amd.com> <4FE30CBB020000780008B06B@nat28.tlf.novell.com>
In-Reply-To: <4FE30CBB020000780008B06B@nat28.tlf.novell.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/21/2012 11:59 AM, Jan Beulich wrote:
>>>> On 14.06.12 at 17:15, Wei Wang<wei.wang2@amd.com>  wrote:
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

Hi Jan
Thanks a lot for the patch. Actually I plan to send my version today, 
which is based on 3.4 pv_ops but looks very similar to yours. So, Acked!

I also evaluated the possibility of hiding iommu device from dom0. I 
think the change is no quite a lot, at least, for io based pcicfg 
access. A proof-of-concept patch is attached.

Thanks,
Wei

diff -r baa85434d0ec xen/arch/x86/traps.c
--- a/xen/arch/x86/traps.c      Thu Jun 21 11:30:59 2012 +0200
+++ b/xen/arch/x86/traps.c      Thu Jun 21 13:19:02 2012 +0200
@@ -73,6 +73,7 @@
  #include <asm/hpet.h>
  #include <public/arch-x86/cpuid.h>
  #include <xsm/xsm.h>
+#include <asm/hvm/svm/amd-iommu-proto.h>

  /*
   * opt_nmi: one of 'ignore', 'dom0', or 'fatal'.
@@ -1686,10 +1687,19 @@ static int pci_cfg_ok(struct domain *d,
  {
      uint32_t machine_bdf;
      uint16_t start, end;
+    struct amd_iommu *iommu;
+
      if (!IS_PRIV(d))
          return 0;

      machine_bdf = (d->arch.pci_cf8 >> 8) & 0xFFFF;
+
+    for_each_amd_iommu ( iommu )
+    {
+        if ( machine_bdf == iommu->bdf )
+            return 0;
+    }
+
      start = d->arch.pci_cf8 & 0xFF;
      end = start + size - 1;
      if (xsm_pci_config_permission(d, machine_bdf, start, end, write))

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
>
> Signed-off-by: Jan Beulich<jbeulich@suse.com>
> Cc: stable@kernel.org
>
> ---
>   drivers/pci/msi.c       |    7 +++++++
>   include/linux/pci_ids.h |    1 +
>   2 files changed, 8 insertions(+)
>
> --- 3.5-rc3/drivers/pci/msi.c
> +++ 3.5-rc3-xen-pci-msi-no-iommu-disable/drivers/pci/msi.c
> @@ -20,6 +20,7 @@
>   #include<linux/errno.h>
>   #include<linux/io.h>
>   #include<linux/slab.h>
> +#include<xen/xen.h>
>
>   #include "pci.h"
>   #include "msi.h"
> @@ -1022,7 +1023,13 @@ void pci_msi_init_pci_dev(struct pci_dev
>   	/* Disable the msi hardware to avoid screaming interrupts
>   	 * during boot.  This is the power on reset default so
>   	 * usually this should be a noop.
> +	 * But on a Xen host don't do this for IOMMUs which the hypervisor
> +	 * is in control of (and hence has already enabled on purpose).
>   	 */
> +	if (xen_initial_domain()
> +	&&  (dev->class>>  8) == PCI_CLASS_SYSTEM_IOMMU
> +	&&  dev->vendor == PCI_VENDOR_ID_AMD)
> +		return;
>   	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
>   	if (pos)
>   		msi_set_enable(dev, pos, 0);
> --- 3.5-rc3/include/linux/pci_ids.h
> +++ 3.5-rc3-xen-pci-msi-no-iommu-disable/include/linux/pci_ids.h
> @@ -75,6 +75,7 @@
>   #define PCI_CLASS_SYSTEM_RTC		0x0803
>   #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
>   #define PCI_CLASS_SYSTEM_SDHCI		0x0805
> +#define PCI_CLASS_SYSTEM_IOMMU		0x0806
>   #define PCI_CLASS_SYSTEM_OTHER		0x0880
>
>   #define PCI_BASE_CLASS_INPUT		0x09
>
>
>
>


