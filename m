Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:38440 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdLWT7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Dec 2017 14:59:42 -0500
Date: Sat, 23 Dec 2017 15:01:12 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dexuan Cui <decui@microsoft.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171223200112.GC1138@arch-chirva.localdomain>
References: <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
 <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
 <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.20.1712231432210.1853@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1712231432210.1853@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 23, 2017 at 02:32:52PM +0100, Thomas Gleixner wrote:
> On Sat, 23 Dec 2017, Dexuan Cui wrote:
> 
> > > From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
> > > Sent: Friday, December 22, 2017 14:29
> > > 
> > > The output of that precise command run just now on a freshly-compiled
> > > copy of that commit is attached.
> > > 
> > > On Fri, Dec 22, 2017 at 09:31:28PM +0000, Dexuan Cui wrote:
> > > > > From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
> > > > > Sent: Friday, December 22, 2017 06:21
> > > > >
> > > > > In the absence of logs, the best I can do at the moment is attach a
> > > > > picture of the screen I am presented with on the apic=debug boot
> > > > > attempt.
> > > > > Alex
> > > >
> > > > The panic happens in irq_matrix_assign_system+0x4e/0xd0 in your picture.
> > > > IMO we should find which line of code causes the panic. I suppose
> > > > "objdump -D kernel/irq/matrix.o" can help to do that.
> > > >
> > > > Thanks,
> > > > -- Dexuan
> > 
> > The BUG_ON panic happens at line 147:
> >                    BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
> > 
> > I'm sure Thomas and Dou know it better than me. 
> 
> I'll have a look after the holidays.
>

Thanks for that!

A quick follow-up on my inability to make kexec / kdump work in order
to perhaps produce better logs: I've done another bisect for that with
this result:

# first bad commit: [e802a51ede91350438c051da2f238f5e8c918ead] x86/idt: Consolidate IDT invalidation

I am quite certain this is the one for that issue. Its only parent is

# good: [8f55868f9e42fea56021b17421914b9e4fda4960] x86/idt: Remove unused set_trap_gate()

(i.e. one of the "good" commits I hit upon during the bisect).

On the core 2 duo machine I've been referring to e802a51 and later
commits simply return me to a regular BIOS boot when issuing either
kexec -e on a loaded crash kernel or crashing with echo c >
/proc/sysrq-trigger.


Alex
