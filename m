Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37333 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964803AbeALP4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 10:56:37 -0500
Received: by mail-wm0-f41.google.com with SMTP id f140so12692083wmd.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2018 07:56:36 -0800 (PST)
Subject: Re: [PATCH] PCI: dwc: fix enumeration end when reaching root
 subordinate
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        niklas.cassel@axis.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1515508941-20055-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180109152550.GA16285@red-moon>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <4bf872a4-ce26-aca6-eacd-db25673fb8c6@ncentric.com>
Date: Fri, 12 Jan 2018 16:56:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180109152550.GA16285@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

Apologies for the late reply, It's been really busy over here.


On 2018-01-09 16:25, Lorenzo Pieralisi wrote:
> <snip>
>> Fix this by initializing the RC to a subordinate value of 0xff, meaning
>> that all busses [0x00-0xff] are reachable through this RC.
> This is not a correct description of the problem. AFAICS all busses
> are reachable through this RC _regardless_ of whatever subordinate
> bus number value you programme into it.
Noted.

This was written meaning: "as seen be the probing functions below"
I'll try harder in V2 to actually include the message that it's not a HW 
related problem or influencing HW in any way, but really "tricking" the 
probing functions below
>
> You should extend the CC list to all dwc host submaintainers so
> that you can actually get it tested.
How to figure out who to include? (& please provide who to include)
Reading online manuals on "how to send patches" only demo's 
"get_maintainer.pl" script

>> <snip>
>> ---
>>
>> Will send separate patches to stable as this file got moved/renamed
> Fixes: commit appeared at v4.15-rc1 (and v4.15 has not been released
> yet) - there is no separate patch to be sent.
This is something typical which is hard to learn/understand by just 
reading "how to send patches" docs available everywhere. (like I did 
before sending this one over ;-) )

2 questions basically:
- As the commit causing it was included in 4.15-*RC1*,  do I need to add 
a "Fixes; bla bla" at all?
- As the commit causing it was backported to 4.9, (how) should I send a 
separate patch in order to get it fixed there? [0]

> Thanks,
> Lorenzo

Probably annoying questions triggering a 'sigh' .. but I'm lacking 
experience here ..

Thanks for your time & patience so far,
Highly appreciated,

Koen


[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=v4.9.76&id=9a4bf05126f42c2632729ab0da503021d74ed454
