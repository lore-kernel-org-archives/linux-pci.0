Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49451 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935328AbcKKW2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2016 17:28:02 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uABMNmbt129355
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2016 17:27:48 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26nn8wn9ya-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2016 17:27:48 -0500
Received: from localhost
        by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Fri, 11 Nov 2016 20:27:46 -0200
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
To: benh@au1.ibm.com, Mark Rutland <mark.rutland@arm.com>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20161109190457.GC837@leverpostej> <1478813443.2592.2.camel@au1.ibm.com>
 <20161111163241.GL11945@leverpostej> <1478891547.2592.13.camel@au1.ibm.com>
Cc: devicetree@vger.kernel.org, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        robh+dt@kernel.org, frowand.list@gmail.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Fri, 11 Nov 2016 20:27:34 -0200
MIME-Version: 1.0
In-Reply-To: <1478891547.2592.13.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <582645D6.3040102@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/2016 05:12 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2016-11-11 at 16:32 +0000, Mark Rutland wrote:
>> On Fri, Nov 11, 2016 at 08:30:43AM +1100, Benjamin Herrenschmidt
>> wrote:
>>>
>>> On Wed, 2016-11-09 at 19:04 +0000, Mark Rutland wrote:
>>>>
>>>>
>>>> If we don't have an interrupt-map on a PCI controller, why don't
>>>> we
>>>> instead log a message regarding that being missing, and give up
>>>> early?
>>>
>>> Why ? It's legit to not support LSIs.
>>
>> Sure; I had envisioned a message like:
>>
>> 	pr_info("%s: no interrupt-map, INTx interrupts not possible\n",
>> 		pci_controller_name);
>>
>> ... Which tells the user exaclty what we know, and doesn't imply
>> either
>> an error or the actual absence of HW support.
> 
> Works for me.
> 
> Cheers,
> Ben.
> 

Thanks very much Ben and Mark, for the good suggestions you gave me.
I was talking on IRC today with Mark, about showing a message once per
device (and not in all its functions) about LSI being not available in
that slot, besides the simple/small messages per function, saying
interrupt-map wasn't found.

I'm working on V2, but will delay a bit to send - I'm out next 20 days.
When I'm back, I'll send the improved version. Oh, I removed positive
return value - never will use it again, noticed isn't that popular heheh

Thanks,


Guilherme

