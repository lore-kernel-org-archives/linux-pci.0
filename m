Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:53463 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdHHJpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2017 05:45:15 -0400
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC] what should we report for the failure of pcie_set_mps?
To: Keith Busch <keith.busch@intel.com>
References: <1729fb86-b9be-0ba6-4b65-33bb5a3527f9@rock-chips.com>
 <20170808063818.GA9938@localhost.localdomain>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <f0b0bd5a-16b8-33ff-0e97-dc19a1aa5bf7@rock-chips.com>
Date: Tue, 8 Aug 2017 17:45:03 +0800
MIME-Version: 1.0
In-Reply-To: <20170808063818.GA9938@localhost.localdomain>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On 2017/8/8 14:38, Keith Busch wrote:
> On Mon, Aug 07, 2017 at 04:53:25PM +0800, Shawn Lin wrote:
>> Hi Bjorn,
>>
>> I notice the log below showing the add-in NVMe failed to set MPS to 256.
>> My RC could support up to 256 but the Intel 600P series NVMe could only
>> support up to 128. So I am confusing now it's normal to fallback to the
>> minimal MPS negotiaged but why it deserve a warning and what should I
>> report a bug for?
> 

Thanks a lot for your comment.

> The "report a bug message" is the text from commit 5895af79158a when it
> was an indication the BIOS had done something wrong. If you booted with

My platfrom enumerates PCIe topology in kernel, so that implies kernel
or more probably the RC driver does something wrong?


> the 600P inserted (the timestamp appears that you did), then it sounds
> like the platform initialized the port incorrectly for the device's
> capabilities. This mismatched MPS can sometimes mean you won't be able

I still don't understand this.

Per the code, pci_configure_mps, it just tries to match the new add-in
devices' MPS to match the existing PCIe topology, right?

(1)if the existing PCIe topology use 256 MPS but the new add-in device
could only support 128, so it deserve a warning.
(2)if the existing PCIe topology use 128 MPS but the new add-in device
could support up to 256, so the new add-in device should fallback to
128, and it's ok.

So mine is nearly the same as case(1) that my RC claims to support 256
and the only one add-in device claims to support only up to 128.

If my understanding above is correct, why can't the existing
PCIe topology fallback to 128 so that the newly add-in device could
work fine?


> to write to the device, even though reads may work fine.
> 
> So, if you are obseriving a problem with the kernel's default pci
> settings, I think the 'report a bug' is suggesting you report it to your
> platform maker rather than the kernel, and the kernel is providing a
> way to work around this.
> 
>   
>> [    0.694942] pci 0000:01:00.0: can't set Max Payload Size to 256; if
>> necessary, use "pci=pcie_bus_safe" and report a bug
>> [    0.706267] pci 0000:00:00.0: BAR 14: assigned [mem
>> 0xfa000000-0xfa0fffff]
>> [    0.706966] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff
>> 64bit]
>> [    0.707736] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    0.708238] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
>> [    0.709232] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>> [    0.710674] pcieport 0000:00:00.0: Signaling PME with IRQ 215
>> [    0.711654] pcieport 0000:00:00.0: AER enabled with IRQ 215
>>
>>
>> lspci -vvv
>>
>> 00:00.0 Class 0604: Device 1d87:0100
>> 	...
>>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>          Capabilities: [c0] Express (v2) Root Port (Slot+), MSI 00
>>                  DevCap: MaxPayload 256 bytes, PhantFunc 0
>>                          ExtTag- RBE+
>>                  DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ 	
>> 		Unsupported+
>>                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>                          MaxPayload 256 bytes, MaxReadReq 512 bytes
>>
>> 01:00.0 Class 0108: Device 8086:f1a5 (rev 03) (prog-if 02)
>> 	...
>> 	Capabilities: [70] Express (v2) Endpoint, MSI 00
>>                  DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
>> 			unlimited, L1 unlimited
>> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>> 			SlotPowerLimit 0.000W
>>                  DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
>> 			Unsupported+ RlxdOrd+ ExtTag- PhantFunc- AuxPwr-
>> 			NoSnoop- FLReset-
>> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
>>
> 
> 
> 
