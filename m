Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52423 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756244AbaGWQh3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 12:37:29 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] ACPI / PM: Make ACPI-based PCI wakeup work for the "freeze" sleep state
Date: Wed, 23 Jul 2014 18:55:53 +0200
Message-ID: <9451719.LAKB4xNqkA@vostro.rjw.lan>
In-Reply-To: <20140723120432.GU3935@laptop>
References: <1907495.agrCMfRsQN@vostro.rjw.lan> <6491652.ycQtdn67HU@vostro.rjw.lan> <20140723120432.GU3935@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Trimming CC list somewhat]

On Wednesday, July 23, 2014 02:04:32 PM Peter Zijlstra wrote:
> On Wed, Jul 23, 2014 at 02:17:55PM +0200, Rafael J. Wysocki wrote:
> > > (also, patchwork blows chunks :/)
> > 
> > That's never happened to me (and there's only one hunk in that patch).
> 
> I meant that patchwork sucks :-) It hides the actual patch, I had to
> download things in order to see the actual patch.

Well, my experience is much better here, never mind. :-)

> > Anyway, the count for 0000:00:01.0:pcie01 means that the wakeup source
> > has been activated, so it should have woken it up in theory.
> > 
> > Unless, of course, it was activated after the power button wakeup.
> 
> Yeah, I was thikning that maybe it doesn't get through entirely but has
> pending state and comes through once we press the power button.

It looks like that's what happens.

> > It looks like the stuff works on the hardware level, though, so we should be
> > able to make the wakeup work too.  I'll have another look later today.
> 
> Thanks.

OK, so I think that before going any deeper it's better to check if we don't
leave anything obvious behind, so please see if this makes any difference (on
top of the previous one):

---
 drivers/pci/pcie/pme.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/pci/pcie/pme.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/pme.c
+++ linux-pm/drivers/pci/pcie/pme.c
@@ -364,7 +364,8 @@ static int pcie_pme_probe(struct pcie_de
 	pcie_pme_interrupt_enable(port, false);
 	pcie_clear_root_pme_status(port);
 
-	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", srv);
+	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
+			  "PCIe PME", srv);
 	if (ret) {
 		kfree(data);
 	} else {

