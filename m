Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38258 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbdJYPOJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Oct 2017 11:14:09 -0400
Date: Wed, 25 Oct 2017 16:14:13 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-alpha@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: alpha boot hang - 4.14-rc* regression
Message-ID: <20171025151413.GA6499@red-moon>
References: <alpine.LRH.2.21.1710251043170.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251109150.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251129520.7098@math.ut.ee>
 <20171025092159.GA14222@red-moon>
 <alpine.LRH.2.21.1710251511090.10071@math.ut.ee>
 <20171025133730.GA5487@red-moon>
 <alpine.LRH.2.21.1710251748170.10071@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1710251748170.10071@math.ut.ee>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 05:49:54PM +0300, Meelis Roos wrote:
> > > > > removing libata modules and rebooting fixes it - so it seems to be 
> > > > > loading of libata.
> > > > 
> > > > Can you please cherry-pick:
> > > > 
> > > > commit b1f9e5e355e9 ("ide: fix IRQ assignment for PCI bus order probing")
> > > > 
> > > > from mainline and let us know if that solves the issue ?
> > > 
> > > No, still breaks the same way (b1f9e5e355e9 patched on top of 
> > > 0e4c2eeb758a).
> > > 
> > > 4.14.0-rc5-00095-g1c9fec470b81 was also still broken the same way (tried 
> > > on Sunday).
> > 
> > I am not sure I patched the right sys file but if I did, does the patch
> > below help ?
> > 
> > I think that at sata driver binding time the kernel finds a freed
> > pointer in the host bridge map_irq() hook and that's where things
> > go wrong.
> > 
> > Please let me know if that's the right sys file, it is a mechanical
> > change and making it for other sys file should be reasonably simple.
> > 
> > Lorenzo
> > 
> > -- >8 --
> > diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
> 
> "Booting GENERIC on Tsunami variation Webbrick using machine vector 
> Webbrick from SRM"
> 
> Seems to be the correct file - tsunami is referenced from this file and 
> the IRQ-s are DP264.
> 
> But the patch does not make a difference :(

It is probably because I patched the wrong map_irq() function,
I am trying to detect which one you are _actually_ using, if
the patch below fails I will patch them all (which is what I
have to do anyway).

Please give this a go - this _has_ to make a difference, it is not
correct to leave map_irq() pointers as __init memory, IRQ routing
for modules can't work.

-- >8 --
diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
index 6c35159..62fd7f1 100644
--- a/arch/alpha/kernel/sys_dp264.c
+++ b/arch/alpha/kernel/sys_dp264.c
@@ -356,7 +356,7 @@ clipper_init_irq(void)
  *  10	 64 bit PCI option slot 3 (not bus 0)
  */
 
-static int __init
+static int
 isa_irq_fixup(const struct pci_dev *dev, int irq)
 {
 	u8 irq8;
@@ -372,10 +372,10 @@ isa_irq_fixup(const struct pci_dev *dev, int irq)
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
@@ -456,10 +456,10 @@ monet_swizzle(struct pci_dev *dev, u8 *pinp)
 	return slot;
 }
 
-static int __init
+static int
 webbrick_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[13][5] __initdata = {
+	static char irq_tab[13][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{    -1,    -1,    -1,    -1,    -1}, /* IdSel 7 ISA Bridge */
 		{    -1,    -1,    -1,    -1,    -1}, /* IdSel 8 unused */
