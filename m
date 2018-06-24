Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeFXMMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jun 2018 08:12:54 -0400
Date: Sun, 24 Jun 2018 14:12:49 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] genirq: Synchronize only with single thread on
 free_irq()
In-Reply-To: <20180624113403.GA22016@wunner.de>
Message-ID: <alpine.DEB.2.21.1806241411040.8650@nanos.tec.linutronix.de>
References: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de> <d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de> <alpine.DEB.2.21.1806241148030.8650@nanos.tec.linutronix.de> <20180624113403.GA22016@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 24 Jun 2018, Lukas Wunner wrote:

> On Sun, Jun 24, 2018 at 11:49:10AM +0200, Thomas Gleixner wrote:
> > On Sun, 24 Jun 2018, Lukas Wunner wrote:
> > > When pciehp is converted to threaded IRQ handling, removal of unplugged
> > > devices below a PCIe hotplug port happens synchronously in the IRQ
> > > thread.  Removal of devices typically entails a call to free_irq() by
> > > their drivers.
> > 
> > Is this an actual mainline problem or did you discover that in course of
> > upcoming work?
> 
> It's needed for upcoming work, specifically the pciehp event handling
> rework which will hopefully appear in 4.19, so nothing urgent.
> Doesn't hurt at all to let this bake in linux-next for a few weeks.

Good.

> There is something else, you introduced irq_wake_thread() four years ago
> with a92444c6b222 for sdhci/sdio, but for some reason it was never used.
> Before you or anyone else deletes it for lack of callers, please be aware
> that I'm making heavy use of it now in pciehp.

Ha! I was looking at it yesterday for unrelated reasons and was wondering
about the huge amount of users ....

> I forgot to cc you on the relevant patch [17/32], but I'll bounce it to
> you in a minute in case you want to take a look at it.

Sure

> Of course this begs the question how irq_wake_thread() is serialized
> against __free_irq(), but it seems that's safe because irq_wake_thread()
> searches the action list while holding desc->lock:  If it grabs the lock
> before __free_irq(), it'll just wake the thread normally.  If it grabs
> the lock after __free_irq(), the action will be gone from the list,
> so irq_wake_thread() essentially becomes a no-op.

Exactly.

Thanks,

	tglx
