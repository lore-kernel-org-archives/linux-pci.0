Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:65380 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab3IWSHA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2013 14:07:00 -0400
Message-ID: <5240833E.6050508@gmail.com>
Date: Mon, 23 Sep 2013 21:06:54 +0300
From: Xenia Ragiadakou <burzalodowa@gmail.com>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
CC: linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	Greg KH <greg@kroah.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] xhci: fix write to USB3_PSSEN and XUSB2PRM pci config
 registers
References: <1379695553-5891-1-git-send-email-burzalodowa@gmail.com> <20130923164529.GA16886@xanatos>
In-Reply-To: <20130923164529.GA16886@xanatos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/23/2013 07:45 PM, Sarah Sharp wrote:
> On Fri, Sep 20, 2013 at 07:45:53PM +0300, Xenia Ragiadakou wrote:
>> The function pci_write_config_dword() sets the appropriate byteordering
>> internally so the value argument should not be converted to little-endian.
>> This bug was found by sparse.
> Can you give the exact error or warning message that sparse gave?

Yes, sure.

drivers/usb/host/pci-quirks.c:802:25: warning: incorrect type in 
argument 3 (different base types)
drivers/usb/host/pci-quirks.c:802:25:    expected unsigned int 
[unsigned] [usertype] val
drivers/usb/host/pci-quirks.c:802:25:    got restricted __le32 
[usertype] <noident>
drivers/usb/host/pci-quirks.c:824:25: warning: incorrect type in 
argument 3 (different base types)
drivers/usb/host/pci-quirks.c:824:25:    expected unsigned int 
[unsigned] [usertype] val
drivers/usb/host/pci-quirks.c:824:25:    got restricted __le32 
[usertype] <noident>

>
> I ask because this description sounded odd to Greg and I when we met
> last week at LinuxCon North America.  I've tried to track this down to
> see where the code might be converting the value from CPU format to
> little endian, and I don't see it.
>
> AFAICT, pci_write_config_dword() is defined in include/linux/pci.h, and
> calls pci_bus_write_config_dword():
>
> static inline int pci_write_config_dword(const struct pci_dev *dev, int where,
>                                           u32 val)
> {
>          return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
> }
>
> pci_bus_write_config_dword is defined as a macro in drivers/pci/access.h:
>
> #define PCI_OP_WRITE(size,type,len) \
> int pci_bus_write_config_##size \
>          (struct pci_bus *bus, unsigned int devfn, int pos, type value)  \
> {                                                                       \
>          int res;                                                        \
>          unsigned long flags;                                            \
>          if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;       \
>          raw_spin_lock_irqsave(&pci_lock, flags);                        \
>          res = bus->ops->write(bus, devfn, pos, len, value);             \
>          raw_spin_unlock_irqrestore(&pci_lock, flags);           \
>          return res;                                                     \
> }
>
> That macro simply calls the write function for whatever PCI bus driver
> is installed.  Note that bus driver can be different than the standard
> bus driver.  I don't see any conversion to little endian here, so that
> means each bus driver would have to convert it.
>
> I can dig deeper into each .write function, but if the conversion isn't
> done at the upper layers, it's possible someone will create a .write
> function without the conversion to little endian.
>
> Am I missing something?

I had in mind that the pci_ops .read and .write defined by the PCI 
driver will take care of consistent byteorder access to the 
configuration registers. At least, that was what i understood after 
reading the
chapter on PCI of Linux Device Drivers (more specifically for 
pci_write_config_* functions, it states that "The word and dword 
functions convert the value to little-endian before writing to the 
peripheral device.").

regards,
ksenia

>> Signed-off-by: Xenia Ragiadakou <burzalodowa@gmail.com>
>> ---
>>   drivers/usb/host/pci-quirks.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
>> index 2c76ef1..08ef282 100644
>> --- a/drivers/usb/host/pci-quirks.c
>> +++ b/drivers/usb/host/pci-quirks.c
>> @@ -799,7 +799,7 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev)
>>   	 * switchable ports.
>>   	 */
>>   	pci_write_config_dword(xhci_pdev, USB_INTEL_USB3_PSSEN,
>> -			cpu_to_le32(ports_available));
>> +			ports_available);
>>   
>>   	pci_read_config_dword(xhci_pdev, USB_INTEL_USB3_PSSEN,
>>   			&ports_available);
>> @@ -821,7 +821,7 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev)
>>   	 * host.
>>   	 */
>>   	pci_write_config_dword(xhci_pdev, USB_INTEL_XUSB2PR,
>> -			cpu_to_le32(ports_available));
>> +			ports_available);
>>   
>>   	pci_read_config_dword(xhci_pdev, USB_INTEL_XUSB2PR,
>>   			&ports_available);
>> -- 
>> 1.8.3.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

