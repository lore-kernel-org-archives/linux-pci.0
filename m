Return-Path: <SRS0=tjpD=6G=axtens.net=dja@kernel.org>
Return-Path: <SRS0=tjpD=6G=axtens.net=dja@kernel.org>
From: Daniel Axtens <dja@axtens.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Xinliang Liu <z.liuxinliang@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH v2] PCI: Support hibmc VGA cards behind a misbehaving HiSilicon bridge
In-Reply-To: <20170620174759.GA3363@bhelgaas-glaptop.roam.corp.google.com>
References: <20170620013302.528-1-dja@axtens.net> <20170620174759.GA3363@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 03 Jul 2017 14:15:43 +1000
Message-ID: <878tk6nok0.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> How exactly is this bridge broken?  Apparently the PCI_BRIDGE_CTL_VGA
> is a read-only zero.  Does the bridge then *always* forward the
> 0xa0000-0xbffff mem range and the 0x3b0-0x3bb and 0x3c0-0x3df I/O
> ranges?  (This is from the PCI-to-PCI Bridge Spec, r1.2, sec
> 3.2.5.18).

So I asked the HiSilicon hardware folk, and they said "no". My
understanding is that the resources are never forwarded. The
justification I was given is that "this legacy mem range and IO are not
used in ARM". (The D05 is an arm64 system.)

> I don't know whether the hibmc VGA card requires those legacy VGA
> resources, so the fact that the card works doesn't answer the
> question -- the driver may be able to operate the card without those
> legacy resources.

I also asked the HiSilicon folk; and yes, the driver operates the card
without the legacy resources.

> But if the system contains multiple VGA devices, we may not be able to
> arbitrate between them correctly if this bit doesn't work.  For
> example, if the bridge always forwards the legacy VGA resources, and a
> second VGA devices behind a different bridge requires those resources,
> we'll have a problem: a read may receive two responses.
>
> The fact that this patch doesn't save any kind of "vga_broken" bit for
> later use by the VGA arbiter makes me suspect that we're making the
> device work in the current configuration, but things might break if we
> add another VGA card.

All the PCI ports on the system I have access to are behind these
bridges, so:

 - it looks like VGA cards will only work if their drivers support
   operating the card without legacy resources.

 - the vga default device should be set only when this quirk activates:
   normal VGA devices will fail the bridge capability test in
   vgaarb.c. If there are mutiple BMC cards then the check for an
   existing default device will ensure the default device is only set
   once.

Having said that, I am happy to write a patch to disable the arbiter if
you want - I'm just not sure quite how that would work.

Regards,
Daniel

>
>> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
>> Cc: Rongrong Zou <zourongrong@gmail.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  drivers/pci/quirks.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 16e6cd86ad71..86d7c848f3e2 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/ktime.h>
>>  #include <linux/mm.h>
>> +#include <linux/vgaarb.h>
>>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>>  #include "pci.h"
>>  
>> @@ -4664,3 +4665,48 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
>>  }
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
>> +
>> +/*
>> + * The hibmc card on a HiSilicon D05 board sits behind a non-compliant
>> + * bridge. The bridge has the PCI_BRIDGE_CTL_VGA config bit fixed at 0
>> + * in hardware. This prevents the vgaarb from marking a card behind it
>> + * as boot VGA device.
>> + *
>> + * However, the hibmc card is known to still work, so if we have that
>> + * card behind that particular bridge (19e5:1610), mark it as the
>> + * default device if none has been detected.
>> + */
>> +static void hibmc_fixup_vgaarb(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *bridge;
>> +	struct pci_bus *bus;
>> +	u16 config;
>> +
>> +	bus = pdev->bus;
>> +	bridge = bus->self;
>> +	if (!bridge)
>> +		return;
>> +
>> +	if (!pci_is_bridge(bridge))
>> +		return;
>> +
>> +	if (bridge->vendor != PCI_VENDOR_ID_HUAWEI ||
>> +	    bridge->device != 0x1610)
>> +		return;
>> +
>> +	pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
>> +			     &config);
>> +	if (config & PCI_BRIDGE_CTL_VGA) {
>> +		/*
>> +		 * Weirdly, this bridge *is* spec compliant, so bail
>> +		 * and let vgaarb do its job
>> +		 */
>> +		return;
>> +	}
>> +
>> +	if (vga_default_device())
>> +		return;
>> +
>> +	vga_set_default_device(pdev);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1711, hibmc_fixup_vgaarb);
>> -- 
>> 2.11.0
>> 
