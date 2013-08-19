Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61369 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab3HSTj4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2013 15:39:56 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so252919iet.8
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2013 12:39:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7kxfJDrm1QwNrGd4onfKBzUW+jVV-8p14i1yJqkMFobg@mail.gmail.com>
References: <1376533135-36708-1-git-send-email-wangyijing@huawei.com>
 <1376533135-36708-2-git-send-email-wangyijing@huawei.com> <20130816221716.GA25780@google.com>
 <521187A5.6030002@huawei.com> <CAPoiz9zpovgcnx=DG-g4v7VpA17H5P2EYv1spm7TGLOwO6zYCQ@mail.gmail.com>
 <CAErSpo7kxfJDrm1QwNrGd4onfKBzUW+jVV-8p14i1yJqkMFobg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 19 Aug 2013 13:39:35 -0600
Message-ID: <CAErSpo7tf+9NUGT2U5WBcQUtZb9=ZT_4wAjxzhiiWh9n_KEbAA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: fix the only slot identification in pcie_find_smpss()
To: Jon Mason <jdmason@kudzu.us>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 19, 2013 at 12:17 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Aug 19, 2013 at 11:42 AM, Jon Mason <jdmason@kudzu.us> wrote:
>> On Sun, Aug 18, 2013 at 7:49 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> Hi Jon, do you think check the slot is only connected to upstream port is necessary?
>>
>> Yes.
>>
>>> As Bjorn's comment, we don't know whether there is a case of a port connected to more than one slot.
>>
>> My understanding of Bjorn's comment is that there may be multiple
>> children of a single device, which may or may not be one or more
>> slots.
>
> I don't understand this.  A PCIe link leads to a single device.  That
> device may be a multi-function device, but a link can not lead to
> multiple devices or multiple slots.
>
> If the device is a multi-function device, obviously there will be
> several pci_devs on the bus->devices list.  But I don't think looking
> at PCI_SLOT() of each of those pci_devs is useful.  Those pci_devs may
> have different PCI_SLOT() values, but that doesn't mean they are in
> different physical slots.  I think it would mean that the
> multi-function device at the end of the link has ARI enabled and it
> has a function number larger than 7.
>
> So I don't think we learned anything by looking at PCI_SLOT() for each
> device on bus->devices.  I think the only useful information is
> whether there's a device present or not.  Maybe you want to use
> list_empty() or something instead of the list_is_singular() test in
> the current code.
>
>>  My response to that is that he is correct and that it is a
>> poor name, but the functionality it necessary (though perhaps
>> incomplete).
>>
>>>
>>> On 2013/8/17 6:17, Bjorn Helgaas wrote:
>>>> On Thu, Aug 15, 2013 at 10:18:54AM +0800, Yijing Wang wrote:
>>>>> We use list_is_singular() to identify the slot whether is
>>>>> only slot directly connected to the root port in
>>>>> pcie_find_smpss(). It's not correct, if we have only slot
>>>>> connected to root port, and this slot has two function devices.
>>>>> list_is_singular() return false. This patch introduces
>>>>> pci_only_one_slot() to fix this issue. In addition, we should
>>>>> pass subordinate bus devices list to list_is_singular(), not
>>>>> its parent bus devices list.
>>>>
>>>> This is a perfect example of a changelog that looks like it has a lot
>>>> of information but makes absolutely no sense.  It describes the lowest
>>>> possible level of detail, but nothing to motivate or justify the
>>>> change.
>>>
>>> I'm so sorry. I update the log as following:
>>>
>>> PCI: use correct interface to identify the only-slot connection
>>>
>>> In "pci=pcie_bus_safe" mode, if find a hotplug slot, we will set
>>> all devices which in the path mps value to the minimum mps
>>> support(128B). Unless the slot is directly connected to root port,
>>> and there are not other devices on the fabric. In the latter case,
>>> we will set root port and device mps to the minmum mpss support
>>> for performace. Currently we use list_is_singular() to identify
>>> whether slot is the only one connected to root port(which seems to
>>> be the most common case). But list_is_singular() can only identify
>>> whether the function device is only one in parent bus. This patch
>>> introduce pci_only_one_slot() funcntion to fix this issue.
>>>
>>>>
>>>> I assume we want this patch because it allows us to set larger MPS
>>>> values for hot-added devices, which increases performance.
>>>
>>> Right.
>>>
>>>> Or maybe
>>>> the hot-added devices just don't work because we set their MPS wrong.
>>>> Whatever it is, you should mention it.
>>>>
>>>> Apparently this change has to do with multi-function devices, but you
>>>> don't say why that's important.  You should include a reference to
>>>> whatever spec section this is related to.
>>>
>>> In the most common case, we hot add device support multi-function.
>>> In the original patch, if we insert multi-function device, the code
>>> which use list_is_singular() function always think there are more than one
>>> slot connected to parent port. And this is not match the comment in pcie_find_smpss().
>>>
>>>>
>>>> I wonder whether pci_only_one_slot() does what you intend for ARI
>>>> devices, where a multi-function device may have up to 256 functions.
>>>> PCI_SLOT() will return different "device" numbers for those functions
>>>> even though they're actually part of the same device.  Please explain.
>>>
>>> No, But I should consider the ARI device case, if ARI device found,
>>> pci_only_one_slot() should always return true.
>>> Exactly, I've never seen root port connected to more than one slot.
>>> Here I just fix the original logic, maybe Jon know whether this is necessary.
>>>
>>>>
>>>> In fact, I'm not sure the idea of "pci_only_one_slot()" even makes
>>>> sense for PCIe.  A conventional PCI bus may have several slots on it,
>>>> so you can have multiple devices (each of which may be a multi-
>>>> function device) on the bus.  But PCIe is inherently point-to-point,
>>>> so there's no way a link (which is really the analog of a conventional
>>>> PCI bus) can lead to multiple slots unless it first leads to a switch
>>>> or bridge that then fans out to multiple slots.
>>>
>>> As mentioned above, I don't know Whether there is a case of a port to connected to
>>> multiple devices.
>>>
>>> HI Jon, any comments about this?
>>>
>>> In my idea, we should fix this issue by using like pci_only_one_slot() or delete the list_is_singular() check (if we think it's unnecessary).
>>
>> It is necessary.  Per the other patch, we need to make sure that no
>> device can be hot-plugged into an already running fabric.
>
> If there's a device in a PCIe hotplug slot, it is impossible to add
> another device there.  If the slot is empty, you have to assume any
> device added in the future is capable of only MPS=128.
>
>> If the
>> fabric is already running, then the MPS cannot be configured except to
>> conform to the MPS already present.  If this is not possible, then the
>> device either needs to disabled or the fabic needs to be already at
>> the minimum size so that any device can be added without needing to
>> modify the MPS of any of the other devices.  The point of this check
>> is to see if this is a possibility.
>
> Sorry, I'm not clear on what possibility you're looking for.  The
> possibility of adding a new device?  If so, something like
> "dev->is_hotplug_bridge && list_empty(dev->subordinate->devices)"
> should tell us that.

Actually, I don't think it matters whether the slot is currently
occupied or not.  If the bridge supports hot-plug, we have to handle
the current device (if any) as well as any other device that might be
added after removing the current device.

>> It checks the parent device and
>> sees if there are any other children (at least that is the intent).
>>
>> I believe what we need to do is rename the checking function something
>> else, perhaps "pci_multiple_children".  Then check to see if the
>> parent has multiple devices hanging off of it (per the original code)
>> or there are multiple devices being added to the slot.
>>
>>>>> -+-[0000:40]-+-00.0-[0000:41]--
>>>>>     ......................
>>>>>  |           +-07.0-[0000:46]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
>>>>>  |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
>>>>>
>>>>> MPS configure after boot up, with boot command "pci=pcie_bus_safe"
>>>>>
>>>>> linux-ha2:~ # lspci -vvv -s 40:07.0
>>>>> 40:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 22) (prog-if 00 [Normal decode])
>>>>>      ...............
>>>>>      Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>>>>>              DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>>>>>                      ExtTag+ RBE+ FLReset-
>>>>>              DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>>>>>                      RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>>>>                      MaxPayload 256 bytes, MaxReadReq 128 bytes
>>>>>
>>>>> linux-ha2:~ # lspci -vvv -s 46:00.0
>>>>> 46:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
>>>>>      ...............
>>>>>      Capabilities: [a0] Express (v2) Endpoint, MSI 00
>>>>>              DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>>>>>                      ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>>>>>              DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>>>>>                      RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>>>>>                      MaxPayload 256 bytes, MaxReadReq 512 bytes
>>>>>
>>>>> linux-ha2:/sys/bus/pci/slots/7 # echo 0 > power     ------>power off slot
>>>>> linux-ha2:/sys/bus/pci/slots/7 # echo 1 > power     ------>power on slot
>>>>> linux-ha2:/sys/bus/pci/slots/7 # dmesg
>>>>> ................
>>>>> pcieport 0000:40:07.0: PCI-E Max Payload Size set to  128/ 256 (was  256), Max Read Rq  128
>>>>> pci 0000:46:00.0: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
>>>>> pci 0000:46:00.1: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
>>>>> pcieport 0000:40:07.0: PCI-E Max Payload Size set to  128/ 256 (was  128), Max Read Rq  128
>>>>> pci 0000:46:00.0: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
>>>>> pci 0000:46:00.1: PCI-E Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
>>>>> .....
>>>>>
>>>>> Because 46:00.0 and 46:00.1 function devices are directly connected to root port 40:07.0.
>>>>> After slot hot plug, root port mps is 256, slot fun devices(46:00.0/1) mps is 128.
>>>>> We should both change root port and slot mps to 256, but now kernel change mps to 128.
>>>>>
>>>>>
>>>>> After applied this patch, dmesg after hot plug:
>>>>> ..............
>>>>> pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
>>>>> pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
>>>>> pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
>>>>> pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
>>>>> pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
>>>>> pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
>>>>>
>>>>> Acked-by: Jon Mason <jdmason@kudzu.us>
>>>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>>>> Cc: Jon Mason <jdmason@kudzu.us>
>>>>> Cc: stable@vger.kernel.org # 3.4+
>>>>> ---
>>>>>  drivers/pci/probe.c |   20 +++++++++++++++++++-
>>>>>  1 files changed, 19 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>>> index cf57fe7..0699ec0 100644
>>>>> --- a/drivers/pci/probe.c
>>>>> +++ b/drivers/pci/probe.c
>>>>> @@ -1484,6 +1484,24 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>>>>>      return nr;
>>>>>  }
>>>>>
>>>>> +static bool pci_only_one_slot(struct pci_bus *pbus)
>>>>> +{
>>>>> +    u8 device;
>>>>> +    struct pci_dev *pdev;
>>>>> +
>>>>> +    if (!pbus || list_empty(&pbus->devices))
>>>>> +            return false;
>>>>> +
>>>>> +    pdev = list_entry(pbus->devices.next,
>>>>> +                    struct pci_dev, bus_list);
>>>>> +    device = PCI_SLOT(pdev->devfn);
>>>>> +    list_for_each_entry(pdev, &pbus->devices, bus_list)
>>>>> +            if (PCI_SLOT(pdev->devfn) != device)
>>>>> +                    return false;
>>>>> +
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>  static int pcie_find_smpss(struct pci_dev *dev, void *data)
>>>>>  {
>>>>>      u8 *smpss = data;
>>>>> @@ -1506,7 +1524,7 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
>>>>>       * common case), then this is not an issue and MPS discovery
>>>>>       * will occur as normal.
>>>>>       */
>>>>> -    if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
>>>>> +    if (dev->is_hotplug_bridge && (!pci_only_one_slot(dev->subordinate) ||
>>>>>           (dev->bus->self &&
>>>>>            pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))
>>>>>              *smpss = 0;
>>>>> --
>>>>> 1.7.1
>>>>>
>>>>>
>>>>
>>>> .
>>>>
>>>
>>>
>>> --
>>> Thanks!
>>> Yijing
>>>
