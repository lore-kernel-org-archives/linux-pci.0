Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12067 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752630AbdLTD7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 22:59:04 -0500
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
To: Thomas Gleixner <tglx@linutronix.de>,
        Alexandru Chirvasitu <achirvasub@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devel@linuxdriverproject.org>, KY Srinivasan <kys@microsoft.com>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
Date: Wed, 20 Dec 2017 11:58:57 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1712200124440.2282@nanos>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

At 12/20/2017 08:31 AM, Thomas Gleixner wrote:
> On Tue, 19 Dec 2017, Alexandru Chirvasitu wrote:
> 
>> I had never heard of 'bisect' before this casual mention (you might tell
>> I am a bit out of my depth). I've since applied it to Linus' tree between
> 
>> bebc608 Linux 4.14 (good)
>>
>> and
>>
>> 4fbd8d1 Linux 4.15-rc1 (bad)
> 
> Is Linus current head 4.15-rc4 bad as well?
> 
[...]
> 
> Thanks for doing that bisect, but unfortunately this commit cannot be the
> problematic one, It merily adds a config symbol, but it does not change any
> code at all. It has no effect whatsoever. So something might have gone
> wrong in your bisecting.
> 

Agree.

> I CC'ed Dou Liyang. He has changed the early APIC setup code and there has
> been an issue reported already. Though I lost track of that. Dou, any
        ^^^^^^^^  Is it this one?
                    https://marc.info/?l=linux-kernel&m=151188084018443
> pointers?
> 

Not sure, but seems the APIC failed to start in that 32-bit system.

I will look into it.

Alex,

Could you give me your .config file and the dmesg-log of 4.15.0-rc3.

Thanks,
	dou
