Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60602 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756873AbdGYBOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2017 21:14:53 -0400
Subject: Re: [PATCH] PCI: xilinx: Remove platform/architecture restrictions
To: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        James Hogan <james.hogan@imgtec.com>
References: <1500856777-23383-1-git-send-email-linux@roeck-us.net>
 <3882569.bb2rKKAOIY@np-p-burton>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5da467c2-7494-bbb5-1007-6990f04877be@roeck-us.net>
Date: Mon, 24 Jul 2017 18:14:50 -0700
MIME-Version: 1.0
In-Reply-To: <3882569.bb2rKKAOIY@np-p-burton>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/24/2017 03:49 AM, Paul Burton wrote:
> Hi Guenter & all,
> 
> On Monday, 24 July 2017 01:39:37 BST Guenter Roeck wrote:
>> The MIPS Boston board configuration tries to enable CONFIG_PCIE_XILINX.
>> That doesn't work since PCIE_XILINX depends on ARCH_ZYNQ || MICROBLAZE.
>> Remove that restriction.
> 
> I'd prefer that this patch does not go in standalone. The intent for the MIPS
> Boston board is that this driver is enabled for MIPS by this patch:
> 
> https://patchwork.kernel.org/patch/9794361/
> 
> But not until after earlier patches in that series fix issues with the driver:
> 
> https://patchwork.kernel.org/patch/9794355/
> https://patchwork.kernel.org/patch/9794357/
> https://patchwork.kernel.org/patch/9794359/
> 
> That has been held up by disagreement about whether the driver should be using
> 0-3 or 1-4 for hardware IRQ numbers, sadly, despite the driver already being
> in tree & clearly broken, and my series not changing which the driver uses...
> 
> In any case, I don't really mind if people would rather remove the
> architecture restrictions than just add MIPS, but I'd prefer this doesn't go
> in until the rest of my series since without at least patch 1 of my seres this
> will lead to various WARN()s on Boston boards.
> 

Not with qemu, at least not yet.

from the exchange, it doesn't look like that is going to be resolved anytime
soon.

Ok, I'll hold back with adding mips/boston to my qemu tests. Too bad.
Hope this is going to be resolved before qemu and/or platform support
for boston falls apart.

Makes me wonder - is there a way to add initrd support for the platform ?

Guenter

> Thanks,
>      Paul
> 
>>
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/pci/host/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 89d61c2cbfaa..ed905a5401c3 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -71,7 +71,6 @@ config PCI_HOST_GENERIC
>>
>>   config PCIE_XILINX
>>   	bool "Xilinx AXI PCIe host bridge support"
>> -	depends on ARCH_ZYNQ || MICROBLAZE
>>   	help
>>   	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>>   	  Host Bridge driver.
> 
