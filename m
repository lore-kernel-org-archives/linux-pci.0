Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.mev.co.uk ([62.49.15.74]:51015 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797Ab2J3IAH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Oct 2012 04:00:07 -0400
Message-ID: <508F8969.8030309@mev.co.uk>
Date: Tue, 30 Oct 2012 08:01:45 +0000
From: Ian Abbott <abbotti@mev.co.uk>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Ian Abbott <ian.abbott@mev.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: add workaround for PLX PCI 9050 bug
References: <1351521618-6818-1-git-send-email-abbotti@mev.co.uk> <CAErSpo7mOxU=5u_-kehBnPU0Hr0thY8uZk6CXvp3kUbaqgKs7g@mail.gmail.com>
In-Reply-To: <CAErSpo7mOxU=5u_-kehBnPU0Hr0thY8uZk6CXvp3kUbaqgKs7g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30/10/12 03:13, Bjorn Helgaas wrote:
> On Mon, Oct 29, 2012 at 8:40 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
>> The PLX PCI 9050 PCI Target bridge controller has a bug that prevents
>> its local configuration registers being read through BAR0 (memory) or
>> BAR1 (i/o) if the base address lies on an odd 128-byte boundary, i.e. if
>> bit 7 of the base address is non-zero.  This bug is described in the PCI
>> 9050 errata list, version 1.4, May 2005.  It was fixed in the
>> pin-compatible PCI 9052, which can be distinguished from the PCI 9050 by
>> checking the revision in the PCI header, which is hard-coded for these
>> chips.
>>
>> Workaround the problem by re-allocating the affected regions to a
>> 256-byte boundary.  Note that BAR0 and/or BAR1 may have been disabled
>> (size 0) during initialization of the PCI chip when its configuration is
>> read from a serial EEPROM.
>>
>> Currently, the fix-up has only been used for devices with the default
>> vendor and device ID of the PLX PCI 9050.  The PCI 9052 shares the same
>> default device ID as the PCI 9050 but they have different PCI revision
>> codes.
>>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> ---
>>   drivers/pci/quirks.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 7a451ff..7e6be56 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1790,6 +1790,31 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
>>                           PCI_DEVICE_ID_TOSHIBA_TC86C001_IDE,
>>                           quirk_tc86c001_ide);
>>
>> +/*
>> + * PLX PCI 9050 PCI Target bridge controller has an errata that prevents the
>> + * local configuration registers accessible via BAR0 (memory) or BAR1 (i/o)
>> + * being read correctly if bit 7 of the base address is set.
>> + * The BAR0 or BAR1 region may be disabled (size 0) or enabled (size 128).
>> + * Re-allocate the regions to a 256-byte boundary if necessary.
>> + */
>> +static void __devinit quirk_plx_pci9050(struct pci_dev *dev)
>> +{
>> +       unsigned int bar;
>> +
>> +       /* Fixed in revision 2 (PCI 9052). */
>> +       if (dev->revision >= 2)
>> +               return;
>> +       for (bar = 0; bar <= 1; bar++)
>> +               if (pci_resource_len(dev, bar) == 0x80 &&
>> +                   (pci_resource_start(dev, bar) & 0x80)) {
>> +                       struct resource *r = &dev->resource[bar];
>> +                       r->start = 0;
>> +                       r->end = 0xff;
>
> I assume the intent here is to make these BARs "unassigned" so they
> will be reassigned later?  We don't yet have a clean generic way of
> indicating "unassigned," so "r->start = 0" is the best we can do for
> now.

I more-or-less copied the method from quirk_tc86c001_ide().  I don't 
have any prior experience with writing PCI quirks, so I don't know if 
this is the best way to do it!  All I really care about is that these 
BARs don't have bit 7 set.

> I think it'd be nice to have a dev_info() here to explain what's going
> on.  Otherwise, the dmesg will be a bit mysterious.

OK, I'll add that in the next version of this patch.


-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
