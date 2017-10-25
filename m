Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Oct 2017 14:37:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-alpha@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: alpha boot hang - 4.14-rc* regression
Message-ID: <20171025133730.GA5487@red-moon>
References: <alpine.LRH.2.21.1710251043170.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251109150.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251129520.7098@math.ut.ee>
 <20171025092159.GA14222@red-moon>
 <alpine.LRH.2.21.1710251511090.10071@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1710251511090.10071@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 03:21:21PM +0300, Meelis Roos wrote:
> > > (Added linux-pci to CC)
> > > 
> > > > > I run Gentoo Linux on my alphas, with latest git kernels for test. 
> > > > > 4.13.0 worked well on 3 alphas but 4.13.0-09217-g5969d1bb3082 hangs on 
> > > > > boot on all 3 of them. Tried bisecting on PC164, got into unrelated 
> > > > > stuff, so probably it does not trigger always. Retried bisecting on 
> > > > > DS10L. On the first try I got that the same keel where I first saw bad 
> > > > > was the culprit, another bisect led me to 
> > > > > 0e4c2eeb758a91e68b9eaf7a4bee9bd5ed97ff2b which looks more related.
> > > > > 
> > > > > This is how the crash looks on console:
> > > > > 
> > > > >  * Starting udev ...
> > > > > starting version 225
> > > > >  [ ok ]
> > > > >  * Generating a rule to create a /dev/root symlink ...
> > > > >  [ ok ]
> > > > >  * Populating /dev with existing devices through uevents ...
> > > > >  [ ok ]
> > > > > 
> > > > > halted CPU 0
> > > > > 
> > > > > halt code = 5
> > > > > HALT instruction executed
> > > > > PC = fffffc00009bf914
> > > > > boot failure
> > > > > >>>
> > > > > 
> > > > > What else can I do to debug this?
> > > > 
> > > > Booting with debug ignore_loglevel I get also this:
> > > [...]
> > > > So maybe it is related pcspkr loading, or the just loaded libata or 
> > > > floppy...
> > > 
> > > removing libata modules and rebooting fixes it - so it seems to be 
> > > loading of libata.
> > 
> > Can you please cherry-pick:
> > 
> > commit b1f9e5e355e9 ("ide: fix IRQ assignment for PCI bus order probing")
> > 
> > from mainline and let us know if that solves the issue ?
> 
> No, still breaks the same way (b1f9e5e355e9 patched on top of 
> 0e4c2eeb758a).
> 
> 4.14.0-rc5-00095-g1c9fec470b81 was also still broken the same way (tried 
> on Sunday).

I am not sure I patched the right sys file but if I did, does the patch
below help ?

I think that at sata driver binding time the kernel finds a freed
pointer in the host bridge map_irq() hook and that's where things
go wrong.

Please let me know if that's the right sys file, it is a mechanical
change and making it for other sys file should be reasonably simple.

Lorenzo

-- >8 --
diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
index 6c35159..88c72fe 100644
--- a/arch/alpha/kernel/sys_dp264.c
+++ b/arch/alpha/kernel/sys_dp264.c
@@ -356,7 +356,7 @@
  *  10	 64 bit PCI option slot 3 (not bus 0)
  */
 
-static int __init
+static int
 isa_irq_fixup(const struct pci_dev *dev, int irq)
 {
 	u8 irq8;
@@ -372,10 +372,10 @@
 	return irq8 & 0xf;
 }
 
-static int __init
+static int
 dp264_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[6][5] __initdata = {
+	static char irq_tab[6][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{    -1,    -1,    -1,    -1,    -1}, /* IdSel 5 ISA Bridge */
 		{ 16+ 3, 16+ 3, 16+ 2, 16+ 2, 16+ 2}, /* IdSel 6 SCSI builtin*/
