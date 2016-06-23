Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
To: wim@djo.tudelft.nl
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan> <20160620212507.GA24086@localhost>
 <57686D67.8010201@codeaurora.org> <20160621124715.GB3528@djo.tudelft.nl>
 <576943BA.1000001@codeaurora.org> <20160621221347.GA28603@djo.tudelft.nl>
 <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
 <20160623141234.GA14662@djo.tudelft.nl>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <576BF86E.8060302@codeaurora.org>
Date: Thu, 23 Jun 2016 10:55:42 -0400
MIME-Version: 1.0
In-Reply-To: <20160623141234.GA14662@djo.tudelft.nl>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 6/23/2016 10:12 AM, Wim Osterholt wrote:
> On Wed, Jun 22, 2016 at 11:54:39PM -0400, okaya@codeaurora.org wrote:
>> On 2016-06-21 18:13, Wim Osterholt wrote:
>>>>
>>>> 	pr_info("%s:%d irq = %d penalty = %d\n", __func__, __LINE__, irq,
>>>> 		penalty);
>>>>
>>>
>>> This produced some 60 lines extra....
>>
>> Thanks, let's go back to 4.6 and add a very similar printf to every 
>> single place where the array is modified and also right before the 
>> enabled message.
>>
> 
> I don't get this right.
> Assuming that you're still talking about the same file, I find a few
> instances of 'enabled', most of them in if-statements and one where it might
> be set, so it looks. However, that's already in a printk statement.
> I don't know about arrays and even less where these are set. Even worse, I
> don't know what to put in a 'similar' line if you don't mean 'exactly the
> same'.
> So please state file and line numbers and the line to be inserted.
> 

Sure, let me get a patch for you. I was hoping to do it yesterday. 
I ran out of time. I typed the message from my phone. 

> 
> 
> Groeten, Wim.
> 
> 
> ----- wim@djo.tudelft.nl -----
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
