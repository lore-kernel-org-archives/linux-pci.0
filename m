Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43942 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbdL1RuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 12:50:12 -0500
Date: Thu, 28 Dec 2017 12:50:09 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
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
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171228175009.ucxr4to2nb42e3s4@D-69-91-141-110.dhcp4.washington.edu>
References: <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712281145510.1688@nanos>
 <20171228142117.GA10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712281531120.1899@nanos>
 <20171228154835.GB10658@chirva-slack.chirva-slack>
 <20171228160522.GC10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712281706010.1899@nanos>
 <20171228172250.GD10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712281823140.1899@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1712281823140.1899@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No; it seems to be tied to this specific issue, and I was seeing even
before getting logs just now, whenever I'd start one of the bad
kernels in recovery mode.

But no, I've never seen that in any other logs, or on any other
screens outside of those popping up in relation to this problem.

On Thu, Dec 28, 2017 at 06:29:05PM +0100, Thomas Gleixner wrote:
> On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> > On Thu, Dec 28, 2017 at 05:10:28PM +0100, Thomas Gleixner wrote:
> > > On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> > > > Actually, it decided to cooperate for just long enough for me to get
> > > > the dmesg out. Attached.
> > > > 
> > > > This is from the kernel you asked about: Dou's patch + yours, i.e. the
> > > > latest one in that git log I just sent, booted up with 'apic=debug'.
> > > 
> > > Ok. As I suspected that warning does not trigger. I would have been
> > > massively surprised if that happened. So Dou's patch is just a red herring
> > > and just might change the timing enough to make the problem 'hide'.
> > > 
> > > Can you try something completely different please?
> > > 
> > > Just use plain Linus tree without any additional patches on top and disable
> > > CONFIG_NO_HZ_IDLE, i.e. select CONFIG_HZ_PERIODIC.
> > > 
> > > If that works, then reenable it and add 'nohz=off' to the kernel command
> > > line.
> > >
> > 
> > No go here I'm afraid:
> > 
> > Linus' clean 4.15-rc5 compiled with CONFIG_HZ_PERIODIC exhibits the
> > familiar behaviour: lockups, sometimes instant upon trying to log in,
> > sometimes logging me in and freaking out seconds later.
> 
> Ok. So it's not the issue I had in mind. 
> 
> Back to some of the interesting bits in the logs:
> 
> [   36.017942] spurious APIC interrupt through vector ff on CPU#0, should never happen.
> 
> Does that message ever show up in 4.14 or 4.9?
> 
> Thanks,
> 
> 	tglx
