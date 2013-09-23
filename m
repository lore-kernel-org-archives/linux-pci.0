Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:44878 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab3IWVio (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2013 17:38:44 -0400
Received: by mail-ie0-f172.google.com with SMTP id x13so7495489ief.31
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2013 14:38:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130923204928.GA24225@kroah.com>
References: <1379695553-5891-1-git-send-email-burzalodowa@gmail.com>
 <20130923164529.GA16886@xanatos> <5240833E.6050508@gmail.com> <20130923204928.GA24225@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Sep 2013 16:38:22 -0500
Message-ID: <CAErSpo7_obVo0nLNBzv7c=ZxPzdzJaDiatDjOfVRS+CbF7rc-A@mail.gmail.com>
Subject: Re: [PATCH] xhci: fix write to USB3_PSSEN and XUSB2PRM pci config registers
To: Greg KH <greg@kroah.com>
Cc: Xenia Ragiadakou <burzalodowa@gmail.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	USB list <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 23, 2013 at 3:49 PM, Greg KH <greg@kroah.com> wrote:
> On Mon, Sep 23, 2013 at 09:06:54PM +0300, Xenia Ragiadakou wrote:
>> On 09/23/2013 07:45 PM, Sarah Sharp wrote:
>> >On Fri, Sep 20, 2013 at 07:45:53PM +0300, Xenia Ragiadakou wrote:
>> >>The function pci_write_config_dword() sets the appropriate byteordering
>> >>internally so the value argument should not be converted to little-endian.
>> >>This bug was found by sparse.
>> >Can you give the exact error or warning message that sparse gave?
>>
>> Yes, sure.
>>
>> drivers/usb/host/pci-quirks.c:802:25: warning: incorrect type in
>> argument 3 (different base types)
>> drivers/usb/host/pci-quirks.c:802:25:    expected unsigned int
>> [unsigned] [usertype] val
>> drivers/usb/host/pci-quirks.c:802:25:    got restricted __le32
>> [usertype] <noident>
>> drivers/usb/host/pci-quirks.c:824:25: warning: incorrect type in
>> argument 3 (different base types)
>> drivers/usb/host/pci-quirks.c:824:25:    expected unsigned int
>> [unsigned] [usertype] val
>> drivers/usb/host/pci-quirks.c:824:25:    got restricted __le32
>> [usertype] <noident>
>>
>> >
>> >I ask because this description sounded odd to Greg and I when we met
>> >last week at LinuxCon North America.  I've tried to track this down to
>> >see where the code might be converting the value from CPU format to
>> >little endian, and I don't see it.
>> >
>> >AFAICT, pci_write_config_dword() is defined in include/linux/pci.h, and
>> >calls pci_bus_write_config_dword():
>> >
>> >static inline int pci_write_config_dword(const struct pci_dev *dev, int where,
>> >                                          u32 val)
>> >{
>> >         return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>> >}
>> >
>> >pci_bus_write_config_dword is defined as a macro in drivers/pci/access.h:
>> >
>> >#define PCI_OP_WRITE(size,type,len) \
>> >int pci_bus_write_config_##size \
>> >         (struct pci_bus *bus, unsigned int devfn, int pos, type value)  \
>> >{                                                                       \
>> >         int res;                                                        \
>> >         unsigned long flags;                                            \
>> >         if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;       \
>> >         raw_spin_lock_irqsave(&pci_lock, flags);                        \
>> >         res = bus->ops->write(bus, devfn, pos, len, value);             \
>> >         raw_spin_unlock_irqrestore(&pci_lock, flags);           \
>> >         return res;                                                     \
>> >}
>> >
>> >That macro simply calls the write function for whatever PCI bus driver
>> >is installed.  Note that bus driver can be different than the standard
>> >bus driver.  I don't see any conversion to little endian here, so that
>> >means each bus driver would have to convert it.
>> >
>> >I can dig deeper into each .write function, but if the conversion isn't
>> >done at the upper layers, it's possible someone will create a .write
>> >function without the conversion to little endian.
>> >
>> >Am I missing something?
>>
>> I had in mind that the pci_ops .read and .write defined by the PCI
>> driver will take care of consistent byteorder access to the
>> configuration registers. At least, that was what i understood after
>> reading the
>> chapter on PCI of Linux Device Drivers (more specifically for
>> pci_write_config_* functions, it states that "The word and dword
>> functions convert the value to little-endian before writing to the
>> peripheral device.").
>
> Hm, I wrote that paragraph (or at least I think I did), but I sure
> didn't remember this at all...
>
> Hm, wait, I do see this happening for the PowerPC cell PCI code, so it
> might happen somewhere burried in the platform-specific code for
> different arches.  You will not see it happen on x86 as there's no need
> to swap any bytes around.

Greg, with regard to Xenia's patch, is this an ack or a nack?  Since
you didn't include an "Acked-by" line, I assume you think Xenia's
patch is unnecessary.  In that case, is there any way to shut sparse
up so it doesn't complain about this?

Bjorn
