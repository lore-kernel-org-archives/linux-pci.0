Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753195AbcKITFL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 14:05:11 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA9J3Spr088788
        for <linux-pci@vger.kernel.org>; Wed, 9 Nov 2016 14:05:10 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26m7fssyre-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2016 14:05:10 -0500
Received: from localhost
        by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Wed, 9 Nov 2016 17:05:07 -0200
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
To: Rob Herring <robh+dt@kernel.org>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <CAL_JsqL13-e5RGfafsLfP7EoJWTkAsuRG4mAF-t52GoDXeQS-Q@mail.gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 9 Nov 2016 17:05:01 -0200
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL13-e5RGfafsLfP7EoJWTkAsuRG4mAF-t52GoDXeQS-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5823735D.5050206@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/09/2016 04:05 PM, Rob Herring wrote:
> On Wed, Nov 9, 2016 at 8:05 AM, Guilherme G. Piccoli
> <gpiccoli@linux.vnet.ibm.com> wrote:
>> On PowerPC machines some PCI slots might not have Level-triggered
>> interrupts capability (also know as Level Signaled Interrupts - LSI),
>> leading of_irq_parse_pci() to complain by presenting error messages
>> on the kernel log - in this case, the properties "interrupt-map" and
>> "interrupt-map-mask" are not present on the device's node on device
>> tree.
>>
>> This patch introduces a different message for this specific case,
>> and it also reduces the level of the message from error to warning.
>> Before this patch, when an adapter was plugged in a slot without Level
>> interrupts capabilities, we saw generic error messages like this:
>>
>>     [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-22
>>
>> Now, with this applied, we see the following specific message:
>>
>>     [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot of this
>>     device has no Level-triggered Interrupts capability.
>>
>> No functional changes were introduced.
>>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>> ---
>>  drivers/of/irq.c        | 5 ++++-
>>  drivers/of/of_pci_irq.c | 8 +++++++-
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> index 393fea8..1ad6882 100644
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -275,7 +275,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>>         of_node_put(ipar);
>>         of_node_put(newpar);
>>
>> -       return -EINVAL;
>> +       /* Positive non-zero return means no Level-triggered Interrupts
>> +        * capability was found.
>> +        */
>> +       return ENOENT;
> 
> It's not really a normal pattern to return positive errno values. You
> should return a negative value and check for that specific error value
> or perhaps move the print statement into this function.

Thanks Rob! I thought about it, I had the option to differentiate the
errors through the value or the sign - ended up taking the wrong way it
seems heheh
I'll send a V2 with this change.

Printing the warning inside of_irq_parse_raw() would require more
changes to the logic, it was my first choice but I changed way during
the implementation.

Cheers,


Guilherme


> 
> Rob
> 

