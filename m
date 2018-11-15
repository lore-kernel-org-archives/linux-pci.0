Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63790C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D1B22506
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 10:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D1B22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=geanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeKOUh6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:37:58 -0500
Received: from mail.hundeboll.net ([88.198.92.70]:44214 "EHLO
        mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOUh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 15:37:58 -0500
Received: from [10.0.0.10] (unknown [85.184.147.232])
        by mail.hundeboll.net (Postfix) with ESMTPSA id 9D59B1C1AD9;
        Thu, 15 Nov 2018 11:30:41 +0100 (CET)
Subject: Re: [PATCH 1/1] pci: Pick up the acpi numa node value if it is
 specified at the device level.
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        linux-acpi@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20180912152140.3676-1-Jonathan.Cameron@huawei.com>
 <20180912152140.3676-2-Jonathan.Cameron@huawei.com>
 <e4bd3423-ae2a-262c-1391-f9741ac4fdd0@geanix.com>
 <20181113092435.00004466@huawei.com>
 <8a0fd569-fa52-b884-ef0d-18aab1ef8c3f@geanix.com>
 <20181113102344.000078c1@huawei.com>
 <0d7bc41d-71b9-86a5-113e-773177c9e53a@geanix.com>
 <20181113144924.000056e6@huawei.com>
 <c02e2579-3572-533d-2c14-b7fe35a1057b@geanix.com>
 <20181114085717.000046b6@huawei.com>
 <ff6e6c1d-2413-3be5-b76b-9d524646ae39@geanix.com>
 <20181115102454.000004b7@huawei.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <d2406ee5-e72e-4242-2230-0962187b0fcd@geanix.com>
Date:   Thu, 15 Nov 2018 11:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115102454.000004b7@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/11/2018 11.24, Jonathan Cameron wrote:
> On Wed, 14 Nov 2018 10:31:37 +0100
> Martin Hundebøll <martin@geanix.com> wrote:
> 
>> On 14/11/2018 09.57, Jonathan Cameron wrote:
>>> On Tue, 13 Nov 2018 16:50:50 +0100
>>> Martin Hundebøll <martin@geanix.com> wrote:
>>>    
>>>> On 13/11/2018 15.49, Jonathan Cameron wrote:
>>>>> On Tue, 13 Nov 2018 11:26:54 +0100
>>>>> Martin Hundebøll <martin@geanix.com> wrote:
>>>>>       
>>>>>> On 13/11/2018 11.23, Jonathan Cameron wrote:
>>>>>>> On Tue, 13 Nov 2018 10:35:29 +0100
>>>>>>> Martin Hundebøll <martin@geanix.com> wrote:
>>>>>>>          
>>>>>>>> Hi Jonathan,
>>>>>>>>
>>>>>>>> On 13/11/2018 10.24, Jonathan Cameron wrote:
>>>>>>>>> On Mon, 12 Nov 2018 20:40:35 +0100
>>>>>>>>> Martin Hundebøll <martin@geanix.com> wrote:
>>>>>>>>>             
>>>>>>>>>> Hi Jonathan,
>>>>>>>>>>
>>>>>>>>>> I'm afraid this change made my system unbootable :(
>>>>>>>>> Hi Martin,
>>>>>>>>>
>>>>>>>>> Thanks for the report!
>>>>>>>>>>
>>>>>>>>>> Testing both v4.20-rc1 and v4.20-rc2 resulting in nothing but a black
>>>>>>>>>> screen, with no sign of life from either the keyboard or the network.
>>>>>>>>>>
>>>>>>>>>> Bisecting changes from v4.19 led me to this commit, and the system boots
>>>>>>>>>> again with the change reverted.
>>>>>>>>>>
>>>>>>>>>> I know little about ACPI and PCI, so please tell the kind of debug/log
>>>>>>>>>> you need.
>>>>>>>>> The ACPI DSDT would be where I would start.  Please send the output of
>>>>>>>>> $cat /sys/firmware/acpi/tables/DSDT > DSDT.asl
>>>>>>>>> (under whatever boots for you)
>>>>>>>>>
>>>>>>>>> If you want to look further yourself, you'll need to disassemble this using
>>>>>>>>> the iASL compiler.  That is usually in a package called something like
>>>>>>>>> acpica-tools or can be built from source from
>>>>>>>>>
>>>>>>>>> https://github.com/acpica/acpica
>>>>>>>>>
>>>>>>>>> iasl -d DSDT.asl
>>>>>>>>>
>>>>>>>>> This should generate a plain text file called DSDL.dsl.
>>>>>>>>>
>>>>>>>>> Send us that and hopefully it'll be obvious what is wrong!
>>>>>>>>> Given we haven't had lots of reports, I'm going to guess there is something
>>>>>>>>> unusual in the table, but we'll see.
>>>>>>>>
>>>>>>>> Judging from the stderr output of the iasl command, additional ACPI
>>>>>>>> tables were needed to do a full disassembly, so I ended up with:
>>>>>>>>
>>>>>>>> iasl -e SSDT1.asl SSDT2.asl SSDT3.asl SSDT4.asl SSDT5.asl SSDT6.asl
>>>>>>>> SSDT7.asl  -d DSDT.asl
>>>>>>>>
>>>>>>>> I've attached the output.
>>>>>>>
>>>>>>> So a couple of possibilities come to mind.
>>>>>>>
>>>>>>> 1) There are _PXM entries for
>>>>>>> _SB.PCI0 - Looks like a root port. Bus number of 0
>>>>>>> _SB.S0D1 - Looks like a root port. Bus number of 1
>>>>>>> _SB.S0D2 - Looks like a root port. Bus number of 2
>>>>>>> _SB.S0D3 - Looks like a root port. Bus number of 3
>>>>>>>
>>>>>>> covering nodes 0 - 3 which seems reasonable but the kernel log is recording that
>>>>>>> no NUMA information was found - and you didn't attach an SRAT table along with the
>>>>>>> others earlier so I'm going to guess there wasn't one?
>>>>>>
>>>>>> No SRAT file in /sys/firmware/acpi/tables/, so I guess not.
>>>>>>      
>>>>>>> I suspect that will cause us all sorts of fun issues as I don't think the code
>>>>>>> verifies the node exists - or at the very least there is one path that isn't.
>>>>>>>
>>>>>>> I'll fake up some equivalents on a machine here and see whether a few well placed
>>>>>>> sanity checks will fix it.
>>>>>>
>>>>>> I'll be happy to test patches, once we get there.
>>>>> Unfortunately I've not managed to replicate this yet.
>>>>>
>>>>> The code that this particular patch enabled shouldn't be effected by PXM entries
>>>>> for the root ports (and doesn't seem to be on my system).
>>>>>
>>>>> Your log clearly states that PCI bus 40 is on numa node 1.
>>>>> Could you check if that was logged prior to this patch?
>>>>
>>>> Booting v4.18.16 shows the same in the kernel log (somewhat later in the
>>>> boot process: 1.149584 vs 1.394208):
>>>>
>>>> [    1.149584] pci_bus 0000:40: on NUMA node 1
>>>
>>> Hi Martin,
>>>
>>> Finally tracked down why I can't replicate.  A small difference between the arm64
>>> paths and the x86 ones.  When arm64 doesn't find an SRAT it uses a dummy
>>> numa table and one of the things that does is set the numa_off flag.
>>>
>>> After that any call to acpi_get_node will pass the retrieved PXM (which may be
>>> from a parent node in ACPI or anywhere above it in the tree) to acpi_map_pxm_to_node.
>>> This is where things differ.
>>>
>>> On X86 the numa_off flag isn't set so we get a potentially new numa node (with none
>>> of the appropriate infrastructure being set up).  On arm64 we fail the first check
>>> and drop out as numa_off is set. This results in a NUMA_NO_NODE being returned and
>>> everything being fine.
>>>
>>> So this is a question for the x86 people.  Is there reason to not set numa_off
>>> at the end of the dummy_numa_init call?  Or is different handling needed?
>>>
>>> Martin perhaps you can smoke test such a change by adding
>>> numa_off = 1;
>>>
>>> to the end of dummy_numa_init in arch/x86/mm/numa.c ?
>>
>> Hi Jonathan,
>>
>> It seems like your on to something here: My workstation boots again with
>> 'numa_off = 1;' added to dummy_numa_init().
> Cool. I'll send out a patch with your reported-by, feel free to add a tested-by
> if you want to.
> 
> Right now this is buried in the thread, so won't get the visibility of a
> fix patch.
> 
> I don't suppose you would mind sharing details of what the motherboard / system
> is so that we can list it explicitly in the patch description.   It's probably
> optimistic to think this is the only board out there with a bios broken like
> this, but actual part numbers might save someone some time!

Ingo Molnar had the same issue on another Threadripper system 
(Motherboard: MSI X399 SLI PLUS), so it is definitely not the only one.

Anyways:
   CPU: AMD Ryzen Threadripper 2950X
   Motherboard: ASRock X399 TAICHI

// Martin

> Jonathan
> 
>>
>> // Martin
>>
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>>
>>>> // Martin
>>>>   
>>>>> Thanks,
>>>>>
>>>>> Jonathan
>>>>>       
>>>>>>
>>>>>> // Martin
>>>>>>      
>>>>>>> 2) We are successfully associating a lot of other stuff a little earlier
>>>>>>> in the process for ACPI than previously so we 'might' cause a side effect where
>>>>>>> data (that is presumably wrong) is now visible.
>>>>>>>
>>>>>>> This one looks less likely to me...
>>>>>>>
>>>>>>> 3) Something that someone who knows more about ACPI than me will spot!
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Jonathan
>>>>>>>
>>>>>>> p.s. Rule one of ACPI. If it is possible to break it and still have common OSes
>>>>>>> booting then people will manage to do so...
>>>>>>>          
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Martin
>>>>>>>>         
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Jonathan
>>>>>>>>>             
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Martin
>>>>>>>>>>
>>>>>>>>>> On 12/09/2018 17.21, Jonathan Cameron wrote:
>>>>>>>>>>> The ACPI specification allows you to provide _PXM entries for devices based
>>>>>>>>>>> on their location on a particular bus.  Let us use that if it is provided
>>>>>>>>>>> rather than just assuming it makes sense to put the device into the proximity
>>>>>>>>>>> domain of the root.
>>>>>>>>>>>
>>>>>>>>>>> An example DSDT entry that will supply this is:
>>>>>>>>>>>
>>>>>>>>>>>         Device (PCI2)
>>>>>>>>>>>         {
>>>>>>>>>>>           Name (_HID, "PNP0A08") // PCI Express Root Bridge
>>>>>>>>>>>           Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>>>>>>>>>>>           Name(_SEG, 2) // Segment of this Root complex
>>>>>>>>>>>           Name(_BBN, 0xF8) // Base Bus Number
>>>>>>>>>>>           Name(_CCA, 1)
>>>>>>>>>>>           Method (_PXM, 0, NotSerialized) {
>>>>>>>>>>>             Return(0x00)
>>>>>>>>>>>           }
>>>>>>>>>>>
>>>>>>>>>>> ...
>>>>>>>>>>>           Device (BRI0) {
>>>>>>>>>>>             Name (_HID, "19E51610")
>>>>>>>>>>>             Name (_ADR, 0)
>>>>>>>>>>>             Name (_BBN, 0xF9)
>>>>>>>>>>>             Device (CAR0) {
>>>>>>>>>>>               Name (_HID, "97109912")
>>>>>>>>>>>               Name (_ADR, 0)
>>>>>>>>>>>               Method (_PXM, 0, NotSerialized) {
>>>>>>>>>>>                 Return(0x02)
>>>>>>>>>>>               }
>>>>>>>>>>>             }
>>>>>>>>>>>           }
>>>>>>>>>>>         }
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        drivers/pci/pci-acpi.c | 5 +++++
>>>>>>>>>>>        1 file changed, 5 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>>>>>>>>> index 738e3546abb1..f2f5f0ddd60e 100644
>>>>>>>>>>> --- a/drivers/pci/pci-acpi.c
>>>>>>>>>>> +++ b/drivers/pci/pci-acpi.c
>>>>>>>>>>> @@ -753,10 +753,15 @@ static void pci_acpi_setup(struct device *dev)
>>>>>>>>>>>        {
>>>>>>>>>>>        	struct pci_dev *pci_dev = to_pci_dev(dev);
>>>>>>>>>>>        	struct acpi_device *adev = ACPI_COMPANION(dev);
>>>>>>>>>>> +	int node;
>>>>>>>>>>>        
>>>>>>>>>>>        	if (!adev)
>>>>>>>>>>>        		return;
>>>>>>>>>>>        
>>>>>>>>>>> +	node = acpi_get_node(adev->handle);
>>>>>>>>>>> +	if (node != NUMA_NO_NODE)
>>>>>>>>>>> +		set_dev_node(dev, node);
>>>>>>>>>>> +	
>>>>>>>>>>>        	pci_acpi_optimize_delay(pci_dev, adev->handle);
>>>>>>>>>>>        
>>>>>>>>>>>        	pci_acpi_add_pm_notifier(adev, pci_dev);
>>>>>>>>>>>               
>>>>>>>>>>            
>>>>>>>>>
>>>>>>>>>             
>>>>>>>>         
>>>>>>>
>>>>>>>          
>>>>>>      
>>>>>
>>>>>       
>>>>   
>>>
>>>    
>>
> 
> 

-- 
Kind regards,
Martin Hundebøll
Embedded Linux Consultant

+45 61 65 54 61
martin@geanix.com

Geanix IVS
https://geanix.com
DK39600706
