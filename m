Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:36531 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751049Ab2DPQVp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:21:45 -0400
Message-ID: <4F8C714E.10708@xenotime.net>
Date: Mon, 16 Apr 2012 12:21:50 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Onkar N Mahajan <kernzap@gmail.com>
CC: linux-pci@vger.kernel.org
Subject: Re: pci_check_type2() help.
References: <1334592160.26350.13.camel@oc4748611672.ibm.com>	 <4F8C6F44.6060407@xenotime.net> <1334593251.26350.15.camel@oc4748611672.ibm.com>
In-Reply-To: <1334593251.26350.15.camel@oc4748611672.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/16/2012 09:20 AM, Onkar N Mahajan wrote:

> On Mon, 2012-04-16 at 12:13 -0700, Randy Dunlap wrote: 
>> On 04/16/2012 09:02 AM, Onkar N Mahajan wrote:
>>
>>> Hello list, 
>>>
>>> I am trying to understand the PCI functionality in Linux kernel. 
>>> What is the best way to start to understanding this - where to start 
>>> in the kernel code ? Books ? Manuals ? 
>>>
>>> I started reading the code - where I am stuck in this function -
>>> pci_check_type2() ; Wherein I am not able to get from where these values
>>> 0xCFB,0xCF8,0xCFA are arrived at ? I guess these are port numbers , but 
>>> in which manuals can I find this all information. 
>>>
>>> linux/arch/x86/pci/init.c: 
>>> static int __init pci_check_type2(void)
>>> {
>>>     unsigned long flags;
>>>     int works = 0;
>>>
>>>     local_irq_save(flags);
>>>
>>>     outb(0x00, 0xCFB);
>>>     outb(0x00, 0xCF8);
>>>     outb(0x00, 0xCFA);
>>>     if (inb(0xCF8) == 0x00 && inb(0xCFA) == 0x00 &&
>>>         pci_sanity_check(&pci_direct_conf2)) {
>>>         works = 1;
>>>     }
>>>
>>>     local_irq_restore(flags);
>>>
>>>     return works;
>>> }
>>>
>>>
>>> Please help me figuring out right manuals for this. 
>>
>>
>> The PCI spec (version 2.1 seems to be all I have available)
>> discusses PCI Configuration Mechanisms and Special Cycles and
>> these PCI config registers.
>>
> Thanks Randy , for your help. Can you please also guide me with 
> respect to good way to start understanding the PCI implementation 
> in Linux ?


Not really.  It's best to ask specific questions about it.

-- 
~Randy
