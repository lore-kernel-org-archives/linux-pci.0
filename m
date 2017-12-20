Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbdLTAbe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 19:31:34 -0500
Date: Wed, 20 Dec 2017 01:31:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexandru Chirvasitu <achirvasub@gmail.com>
cc: Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
In-Reply-To: <20171219083421.GB24638@arch-chirva.localdomain>
Message-ID: <alpine.DEB.2.20.1712200124440.2282@nanos>
References: <20171218082011.GA24638@arch-chirva.localdomain> <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 19 Dec 2017, Alexandru Chirvasitu wrote:

> I had never heard of 'bisect' before this casual mention (you might tell
> I am a bit out of my depth). I've since applied it to Linus' tree between

> bebc608 Linux 4.14 (good)
> 
> and
> 
> 4fbd8d1 Linux 4.15-rc1 (bad)

Is Linus current head 4.15-rc4 bad as well?

> It took about 13 attempts (I had access to a faster machine to compile
> on, and ccache helped once the cache built up some momentum). The result
> is (as presented by 'git bisect' at the end of the process, between the
> --- dividers added by me for clarity):

> --- start of output ---
> 
> 2b5175c4fa974b6aa05bbd2ee8d443a8036a1714 is the first bad commit
> commit 2b5175c4fa974b6aa05bbd2ee8d443a8036a1714
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Oct 17 09:54:57 2017 +0200
> 
>     genirq: Add config option for reservation mode
>     
>     The interrupt reservation mode requires reactivation of PCI/MSI
>     interrupts. Create a config option, so the PCI code can set the
>     corresponding flag when required.
>     
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Josh Poulson <jopoulso@microsoft.com>
>     Cc: Mihai Costache <v-micos@microsoft.com>
>     Cc: Stephen Hemminger <sthemmin@microsoft.com>
>     Cc: Marc Zyngier <marc.zyngier@arm.com>
>     Cc: linux-pci@vger.kernel.org
>     Cc: Haiyang Zhang <haiyangz@microsoft.com>
>     Cc: Dexuan Cui <decui@microsoft.com>
>     Cc: Simon Xiao <sixiao@microsoft.com>
>     Cc: Saeed Mahameed <saeedm@mellanox.com>
>     Cc: Jork Loeser <Jork.Loeser@microsoft.com>
>     Cc: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: devel@linuxdriverproject.org
>     Cc: KY Srinivasan <kys@microsoft.com>
>     Link: https://lkml.kernel.org/r/20171017075600.369375409@linutronix.de
> 
> :040000 040000 5e73031cc0c8411a20722cce7876ab7b82ed3858 dcf98e7a6b7d5f7c5353b7ccab02125e6d332ec8 M      kernel
> 
> --- end of output ---
> 
> Consequently, I am cc-ing in the listed addresses.

Thanks for doing that bisect, but unfortunately this commit cannot be the
problematic one, It merily adds a config symbol, but it does not change any
code at all. It has no effect whatsoever. So something might have gone
wrong in your bisecting.

I CC'ed Dou Liyang. He has changed the early APIC setup code and there has
been an issue reported already. Though I lost track of that. Dou, any
pointers?

Thanks,

	tglx
