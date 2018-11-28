Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447CEC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 19:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32EA205C9
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 19:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32EA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeK2GiR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:38:17 -0500
Received: from foss.arm.com ([217.140.101.70]:49286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeK2GiR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 01:38:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 512E9A78;
        Wed, 28 Nov 2018 11:35:33 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DED93F59C;
        Wed, 28 Nov 2018 11:35:31 -0800 (PST)
Subject: Re: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
To:     Stefan Agner <stefan@agner.ch>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, andrew.smirnov@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, tpiepho@impinj.com
References: <20181128132554.28139-1-stefan@agner.ch>
 <ff476784-b79e-18bf-5870-4365c8377deb@arm.com>
 <074f80db0eceb76672bca283c5de37b9@agner.ch>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9861493a-6139-ca3e-41a8-e6fe41c2f3a3@arm.com>
Date:   Wed, 28 Nov 2018 19:35:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <074f80db0eceb76672bca283c5de37b9@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/11/2018 17:53, Stefan Agner wrote:
> On 28.11.2018 17:16, Robin Murphy wrote:
>> Hi Stefan,
>>
>> On 28/11/2018 13:25, Stefan Agner wrote:
>>> Add a fault handler which handles reads in Thumb-2 mode. Install
>>> the appropriate handler depending on which mode the kernel has
>>> been built. This avoids an "Unhandled fault: external abort on
>>> non-linefetch (0x1008) at 0xf0a80000" during boot on a device
>>> with a PCIe switch connected.
>>>
>>> Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan@agner.ch/
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>> FWIW, I found this manual helpful to write the code below:
>>> http://hermes.wings.cs.wisc.edu/files/Thumb-2SupplementReferenceManual.pdf#page=43&zoom=100,0,66
>>
>> This one's rather less ancient and even more authoritative ;)
>>
>> https://static.docs.arm.com/ddi0406/cd/DDI0406C_d_armv7ar_arm.pdf
>>
>> (ARMv7 had a few new encodings over and above ARMv6T2, although in
>> fairness I don't think any should be relevant to this specific case)
>>
> 
> Thanks, I tried to find the right document on arm.com, but I timed out
> after 5 minutes or so :-)
> 
>>> --
>>> Stefan
>>>
>>>    drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++++++++++++++++-
>>>    1 file changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>>> index 69f86234f7c0..683deb74d69f 100644
>>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>>> @@ -29,6 +29,7 @@
>>>    #include <linux/reset.h>
>>>    #include <linux/pm_domain.h>
>>>    #include <linux/pm_runtime.h>
>>> +#include <asm/opcodes.h>
>>>      #include "pcie-designware.h"
>>>    @@ -299,6 +300,37 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>>>    	return 1;
>>>    }
>>>    +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
>>> +		unsigned int fsr, struct pt_regs *regs)
>>> +{
>>> +	unsigned long pc = instruction_pointer(regs);
>>> +	unsigned long instr = *(unsigned long *)pc;
>>> +	unsigned long thumb2_instr = __mem_to_opcode_thumb16(instr);
>>> +	int reg = thumb2_instr & 7;
>>> +
>>> +	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
>>> +		return 1;
>>
>> There are plenty of 32-bit Thumb encodings of various LDR/STR
>> variants, and I doubt we can guarantee that the offset, target
>> register, and/or addressing mode for a config space access will
>> *always* suit the (relatively limited) 16-bit ones.
> 
> Hm, I guess they should be handled too?
> 
> I looked at the code where I had the abort at hand triggered
> (dw_pcie_read).

For the sake of robustness, I think it makes sense to at least handle 
all LDR/LDRH/LDRB encodings which might possibly fall out of a 
read[lwb]() call. Given that we seem to have various versions of this 
decoding in differing states of completeness, perhaps it's even worth 
factoring out into some kind of common "Arm PCI synchronous abort handler".

>>> +
>>> +	/* Load word/byte and halfword immediate offset */
>>> +	if (((thumb2_instr & 0xe800) == 0x6800) ||
>>> +	    ((thumb2_instr & 0xf800) == 0x8800)) {
>>> +		unsigned long val;
>>> +
>>> +		if (thumb2_instr & 0x1000)
>>> +			val = 0xff;
>>> +		else if (thumb2_instr & 0x8000)
>>> +			val = 0xffff;
>>> +		else
>>> +			val = 0xffffffffUL;
>>> +
>>> +		regs->uregs[reg] = val;
>>> +		regs->ARM_pc += 2;
>>> +		return 0;
>>> +	}
>>
>> What about stores? The existing implementation handles them, so either
>> that's dead code which could perhaps be cleaned up, or they need to be
>> handled here too.
>>
> 
> I think the current handler (imx6q_pcie_abort_handler) checks bit 20,
> which means it must be a load not?

Oops, that's just me being dumb - I managed to overlook the pt_regs 
assignment in the second if() block and thought it was just advancing 
the PC, so assumed (because I also didn't bother to actually look up the 
relevant encoding bits) it must be handling stores. Never mind that part 
then.

>>> +
>>> +	return 1;
>>> +}
>>> +
>>>    static int imx6_pcie_attach_pd(struct device *dev)
>>>    {
>>>    	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>>> @@ -1069,6 +1101,8 @@ static struct platform_driver imx6_pcie_driver = {
>>>      static int __init imx6_pcie_init(void)
>>>    {
>>> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
>>
>> Can these aborts definitely *only* be triggered by kernel accesses,
>> and never, say, via an mmap() of anything exposed to userspace?
> 
> Honestly, I am not very familiar with PCIe, I don't know...

Yeah, hopefully the linux-pci audience can clear up that one.

I was thinking in terms of whether we might need a combined handler with 
a runtime "thumb_mode(regs)" check rather than a compile-time decision, 
but Russell has a good point that just reading the instruction at all is 
its own can of worms in that case.

Robin.
