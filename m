Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33792 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758536AbdLSIcz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 03:32:55 -0500
Date: Tue, 19 Dec 2017 03:34:21 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171219083421.GB24638@arch-chirva.localdomain>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218101131.GA5338@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thank you!

On Mon, Dec 18, 2017 at 11:11:31AM +0100, Pavel Machek wrote:
> Hi!
> On Mon 2017-12-18 03:20:11, Alexandru Chirvasitu wrote:
> > Short description of the problem: latest rc kernel results in seemingly APIC-caused hard lockups, whereas latest stable kernel works fine.
> > 
> > I have an old ASUS F5RL laptop with an Intel Core 2 Duo CPU T5450 @1.66GHz. It is currently running Debian 9.3 stable 32 bit (by default on a 4.9-series kernel), but I have been compiling and installing the latest kernels.
> > 
> 
> Thanks for doing that.
> 
> > The latest rc kernel at the time of this writing (4.15.0-rc3) boots but then results in hard lockups on both CPUs after login. Starting in recovery mode returns the error
> > 
> > "spurious APIC interrupt through vector ff on CPU#0, should never happen"
> > 
> > before lockip up the CPUs again. A hard reboot is necessary. 
> > 
> > Starting with kernel option noapic logs me in uneventfully, but for some reason has the effect of rendering my ethrenet card inoperable. It is a Qualcomm Atheros Attansic L2 Fast Ethernet (rev a0), handled by kernel module atl2. In noapic mode the card is still seen by the system, can be brought up / down, etc., but dhclient never manages to acquire a lease.
> > 
> > Starting with kernel option nolapic instead brings up the network and logs me in, but only sees one CPU instead of two, as usual.
> > 
> > The latest kernel that exhibits none of these issues is the latest stable one as of this writing: 4.14.7.
> > 
> > ---
> > 
> > As this seems to be APIC-related, I am sending the message to the maintainers mentioned in arch/x86/kernel/apic/apic.c. I am unsure whether this is the correct procedure however.
> > 
> 
> Good enough procedure. You want to always copy linux-kernel mailing
> list, and you should probably look for X86 maintainers in MAINTAINERS
> file, and  cc them, too.
> 
> If you run out of other options, you can always do "git bisect"...
>


I had never heard of 'bisect' before this casual mention (you might tell I am a bit out of my depth). I've since applied it to Linus' tree between

bebc608 Linux 4.14 (good)

and

4fbd8d1 Linux 4.15-rc1 (bad)

It took about 13 attempts (I had access to a faster machine to compile on, and ccache helped once the cache built up some momentum). The result is (as presented by 'git bisect' at the end of the process, between the --- dividers added by me for clarity):

--- start of output ---

2b5175c4fa974b6aa05bbd2ee8d443a8036a1714 is the first bad commit
commit 2b5175c4fa974b6aa05bbd2ee8d443a8036a1714
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Oct 17 09:54:57 2017 +0200

    genirq: Add config option for reservation mode
    
    The interrupt reservation mode requires reactivation of PCI/MSI
    interrupts. Create a config option, so the PCI code can set the
    corresponding flag when required.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: Josh Poulson <jopoulso@microsoft.com>
    Cc: Mihai Costache <v-micos@microsoft.com>
    Cc: Stephen Hemminger <sthemmin@microsoft.com>
    Cc: Marc Zyngier <marc.zyngier@arm.com>
    Cc: linux-pci@vger.kernel.org
    Cc: Haiyang Zhang <haiyangz@microsoft.com>
    Cc: Dexuan Cui <decui@microsoft.com>
    Cc: Simon Xiao <sixiao@microsoft.com>
    Cc: Saeed Mahameed <saeedm@mellanox.com>
    Cc: Jork Loeser <Jork.Loeser@microsoft.com>
    Cc: Bjorn Helgaas <bhelgaas@google.com>
    Cc: devel@linuxdriverproject.org
    Cc: KY Srinivasan <kys@microsoft.com>
    Link: https://lkml.kernel.org/r/20171017075600.369375409@linutronix.de

:040000 040000 5e73031cc0c8411a20722cce7876ab7b82ed3858 dcf98e7a6b7d5f7c5353b7ccab02125e6d332ec8 M      kernel

--- end of output ---

Consequently, I am cc-ing in the listed addresses.


Thank you,

Alex Chirvasitu

> Best regards,								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
