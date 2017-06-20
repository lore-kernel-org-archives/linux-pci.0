Return-Path: <SRS0=Vl7K=5Z=axtens.net=dja@kernel.org>
Return-Path: <SRS0=Vl7K=5Z=axtens.net=dja@kernel.org>
From: Daniel Axtens <dja@axtens.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Xinliang Liu <z.liuxinliang@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH] PCI: Support hibmc VGA cards behind a misbehaving HiSilicon bridge
In-Reply-To: <20170619235535.GH554@bhelgaas-glaptop.roam.corp.google.com>
References: <20170619023528.11532-1-dja@axtens.net> <20170619235535.GH554@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 20 Jun 2017 10:28:41 +1000
Message-ID: <87k247pkna.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> On Mon, Jun 19, 2017 at 12:35:28PM +1000, Daniel Axtens wrote:
>> The HiSilicon D05 board has some PCI bridges (PCI ID 19e5:1610) that
>> are not spec-compliant: they do not set the VGA Enable bit when a VGA
>> card is behind the bridge. This breaks Xorg auto-detection.
>
> I don't understand what is not spec-compliant about this.  The VGA
> Enable bit (PCI_BRIDGE_CTL_VGA) is a read/write bit, and the bridge
> itself is not responsible for figuring out whether it has a VGA card
> below it.
>
> Some software (firmware/OS/etc) that enumerates the hierarchy is
> responsible for setting PCI_BRIDGE_CTL_VGA if desired.

Ah sorry, this was poorly understood/expressed on my part. The bit is
fixed in hardware: I wrote a 1 to it, read it back immediately, and got
a 0. I'll respin with a corrected comment and commit message.

Regards,
Daniel
>
>> Despite this, the hibmc VGA card (PCI ID 19e5:1711) is known to work
>> when behind these bridges.
>> 
>> Provide a quirk so that this combination of bridge and card is eligible
>> to be the default VGA card.
>> 
>> This fixes Xorg auto-detection.
>> 
>> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
>> Cc: Rongrong Zou <zourongrong@gmail.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  drivers/pci/quirks.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 16e6cd86ad71..9475d6056dd3 100644
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
>> + * bridge. The bridge doesn't advertise the PCI_BRIDGE_CTL_VGA bit in
>> + * its config space. This prevents the vgaarb from marking a card
>> + * behind it as boot VGA device.
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
