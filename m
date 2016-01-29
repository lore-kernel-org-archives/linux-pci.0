Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: iproc: Remove redundant function number check for
 PAXC
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1454024240-12270-1-git-send-email-rjui@broadcom.com>
 <20160129173041.GD12965@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <56ABA704.8080805@broadcom.com>
Date: Fri, 29 Jan 2016 09:53:08 -0800
MIME-Version: 1.0
In-Reply-To: <20160129173041.GD12965@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 1/29/2016 9:30 AM, Bjorn Helgaas wrote:
> Hi Ray,
>
> On Thu, Jan 28, 2016 at 03:37:20PM -0800, Ray Jui wrote:
>> This patch removes the conditional check that limits the number of
>> functions to be supported by the internally emulated endpoint device
>> connected to PAXC. Investigation shows that the emulated PAXC endpoint
>> device can properly reject request for unsupported functions, which
>> makes this conditional check redundant
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> ---
>>   drivers/pci/host/pcie-iproc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index 9ae43ed..b65185d 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -204,7 +204,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>>   	 * allows only one device and supports a limited number of functions.
>>   	 */
>>   	if (pcie->type == IPROC_PCIE_PAXC)
>> -		if (slot > 0 || fn >= MAX_NUM_PAXC_PF)
>> +		if (slot > 0)
>>   			return NULL;
>>
>>   	/* EP device access */
>
> Thanks for checking this out.  I removed the now-unused
> MAX_NUM_PAXC_PF and folded this into the first patch, resulting in
> the combined patch below.
>
> I'm sorry to say that I have yet one more question.

You don't need to feel sorry for asking these questions, :) It's your 
previous question that initiates the investigation and as a result, one 
more redundant check (and potential limitation for future iProc based 
SoCs) is removed from the driver. I really appreciate these questions 
from you.

> It looks somewhat
> hacky to have the PAXC-specific "slot > 0" test, and I'm not sure it
> should be necessary (again, unless there's some implementation
> deficiency in that PAXC embedded endpoint).  I'm looking at section
> 7.3 in the spec, and it seems like that endpoint *should* handle
> a config transaction with a non-zero Device Number, i.e., "slot", as
> an Unsupported Request.  This should be standard behavior for all PCIe
> endpoints -- we can generate config transactions like that on all root
> complexes on all systems, so all endpoints should be able to handle
> it.

Unfortunately, it looks like the integrated endpoint connected to PAXC 
is not fully compliant to the above described behavior.

I tested by removing the "slot > 0" test in the driver and added some 
debug prints, it appears that attempted access to slot 1, 2, 3 cannot be 
rejected properly and results an kernel crash.

Debugging prints are in the format of <bus>:<slot>:<func> offset:0x<where>

[    3.871332] 1:1:0 offset:0x0
[    3.874552] 1:2:0 offset:0x0
[    3.877759] 1:3:0 offset:0x0
[    3.881454] Bad mode in Error handler detected, code 0xbf000002 -- SError
[    3.888996] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0+ #117
[    3.895801] Hardware name: Broadcom NS2 SVK (DT)
[    3.900967] task: ffffffc0fb088000 ti: ffffffc0fb090000 task.ti: 
ffffffc0fb090000
[    3.909271] PC is at pci_generic_config_read32+0x74/0xa0
[    3.915190] LR is at pci_generic_config_read32+0x28/0xa0
[    3.921081] pc : [<ffffffc000374684>] lr : [<ffffffc000374638>] 
pstate: 200000c5
[    3.929309] sp : ffffffc0fb093900
[    3.932969] x29: ffffffc0fb093900 x28: ffffffc0fa9d2400
[    3.938864] x27: ffffffc07a93c090 x26: 0000000000000000
[    3.944838] x25: 0000000000000000 x24: ffffffc0fa9d2800
[    3.950776] x23: 0000000000000040 x22: ffffffc000883318
[    3.956678] x21: 0000000000000018 x20: ffffffc0fb093a0c
[    3.962589] x19: 0000000000000000 x18: 000000000000073f
[    3.968491] x17: ffffffffffffffff x16: 0000000000000011
[    3.974356] x15: 0000000000000000 x14: ffffffffffffffff
[    3.980311] x13: ffffffffffffffff x12: 0000000000000000
[    3.986258] x11: 00000000000002eb x10: 0000000000000006
[    3.992177] x9 : 00000000000002ec x8 : 3078303a74657366
[    3.998106] x7 : ffffffc000812a70 x6 : ffffffc0007d4dc4
[    4.004026] x5 : 000000000000000f x4 : ffffffc0fb09398c
[    4.009937] x3 : 0000000000000004 x2 : ffffff80000d41f8
[    4.015865] x1 : ffffff80000d4000 x0 : 0000000000000000

Therefore, we need to keep this 'hacky check' in the iProc host driver.

Thanks,

Ray
