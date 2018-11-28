Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89921C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 19:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4469420832
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 19:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4469420832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeK2Gzf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:55:35 -0500
Received: from foss.arm.com ([217.140.101.70]:49586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeK2Gzf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 01:55:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 281B0A78;
        Wed, 28 Nov 2018 11:52:48 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 353883F59C;
        Wed, 28 Nov 2018 11:52:46 -0800 (PST)
Subject: Re: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
To:     Trent Piepho <tpiepho@impinj.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181128132554.28139-1-stefan@agner.ch>
 <ff476784-b79e-18bf-5870-4365c8377deb@arm.com>
 <1543431377.18519.94.camel@impinj.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f7096d74-9097-771d-1a4b-f6665b3689d4@arm.com>
Date:   Wed, 28 Nov 2018 19:52:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543431377.18519.94.camel@impinj.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/11/2018 18:56, Trent Piepho wrote:
> On Wed, 2018-11-28 at 16:16 +0000, Robin Murphy wrote:
>>
>>>    
>>> +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
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
>> There are plenty of 32-bit Thumb encodings of various LDR/STR variants,
>> and I doubt we can guarantee that the offset, target register, and/or
>> addressing mode for a config space access will *always* suit the
>> (relatively limited) 16-bit ones.
> 
> It might be the case that PLD/PLI, 32-bit thumb2 instructions, could
> trigger an abort too.

Preload instructions shouldn't cause a *synchronous* abort, which is 
what we're trapping here, and they could only result in an asynchronous 
abort coming back later if the address is mapped as Normal memory, which 
it really shouldn't be in this case. Frankly either way, anyone even 
thinking about trying to pull PCI config space into data caches, let 
alone instruction caches, probably deserves everything they get ;)

Robin.
