Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:64333 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab3BVHiT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Feb 2013 02:38:19 -0500
Message-ID: <5127203F.1040007@cn.fujitsu.com>
Date: Fri, 22 Feb 2013 15:37:35 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Cole Mickens <cole.mickens@gmail.com>
CC: linux-pci@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: Hot (un)plugging a Thunderbolt Ethernet adapter causes kernel
 panic
References: <CAJ9Gbf1o0JHTWRvx=5x51q-wpZctkjFQuufR4fdNja_kV56dqw@mail.gmail.com>
In-Reply-To: <CAJ9Gbf1o0JHTWRvx=5x51q-wpZctkjFQuufR4fdNja_kV56dqw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/22/2013 07:45 AM, Cole Mickens wrote:

> Hello, I was instructed to send this issue to this mailing list:
> https://bugzilla.kernel.org/show_bug.cgi?id=54131
> 
> --
> 
> I have a Macbook Air 2012 running Ubuntu 13.04 with the 3.8.0 kernel
> (not an RC).
> 
> My Thunderbolt Ethernet adapter is usable but only if it is inserted at boot.
> 
> If it is removed after being available, the kernel will panic. Generally it
> takes a minute or two or I have to fire up Chrome or something to stir it.
> 
> I assume the crash isn't written out on a Mac EFI system but I can easily
> reproduce it and retype whatever bits are important. I did take a
> snapshot with my camera: http://i.imgur.com/q2iuHWZ.jpg
> 
> Apologies if this is the wrong format or place for this; I'm reporting my first
> kernel bug. Cheers.

Hi Cole,
It seems not a new issue, see these: 
https://lkml.org/lkml/2012/12/13/589
http://help.lockergnome.com/linux/Linux-Support-Thunderbolt-Apple-Monitor--ftopict553657.html
Maybe Thunderbolt hotplug is not well supported now.
If this issue does disturb you, you can try Kirill's patch <https://lkml.org/lkml/2012/12/13/589>,
maybe it can help you.:)

thanks,
Gu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


