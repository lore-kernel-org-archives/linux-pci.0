Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:38953 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdDNIWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2017 04:22:45 -0400
Date: Fri, 14 Apr 2017 10:22:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PCI / PM: Crashes in PME scan during system suspend
Message-ID: <20170414082249.GA5417@wunner.de>
References: <CAMuHMdVf-NT_6oGQVba_QgFuW-fZMBDF1CtidfxSxnCr8+BGHg@mail.gmail.com>
 <2661070.8D7d40DjM3@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2661070.8D7d40DjM3@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 14, 2017 at 12:26:01PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 14, 2017 10:31:38 AM Geert Uytterhoeven wrote:
> > Laurent Pinchart reported that r8a7790/Lager crashes during suspend tests.
> > 
> > I managed to reproduce the issue on r8a7791/koelsch:
> >   - It only happens during suspend tests, after writing either "platform"
> >     or "processors" to /sys/power/pm_test,
> >   - It does not (or is less likely) to happen during full system suspend
> >     ("core" or "none").
> > 
> > More investigation shows this happens when the PME scan runs, once per
> > second.  During PME scan, the PCI host bridge (rcar-pci) registers are
> > accessed while the host bridge's module clock has already been disabled,
> > leading to a crash.
> 
> OK, so clearly PME scans should be suspended before the host bridge
> registers become inaccessible.
> 
> Another question, though, is whether or not PME scans are actually necessary
> on the affected platforms at all.

I'm not seeing a fix for this in linux-next, am I missing something?
Has anyone looked into it or is the issue still open?

Below is a tentative patch which moves PME polling to a freezable
workqueue, so it is frozen before the host bridge is suspended.
Geert, Laurent, could you test this?

The patch may be problematic in that pci_pme_list_scan() acquires
pci_pme_list_mutex, which is also acquired by pci_pme_active(),
which gets called when devices are suspended -- *after* the worker
has been frozen.  I'm not really familiar with the freezer, can it
happen that the worker is frozen while holding the mutex?  If so
this would deadlock.  Rafael?

Alternative approaches would be to
(a) skip devices in pci_pme_list_scan() if their is_prepared or
    is_suspended flags are set, or
(b) disable PME polling via a PM notifier.

The latter seems preferable performance-wise.  (To avoid checking
these flags once per second.)

Best regards,

Lukas

-- >8 --

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..d35c016 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1782,8 +1782,8 @@ static void pci_pme_list_scan(struct work_struct *work)
 		}
 	}
 	if (!list_empty(&pci_pme_list))
-		schedule_delayed_work(&pci_pme_work,
-				      msecs_to_jiffies(PME_TIMEOUT));
+		queue_delayed_work(system_freezable_wq, &pci_pme_work,
+				   msecs_to_jiffies(PME_TIMEOUT));
 	mutex_unlock(&pci_pme_list_mutex);
 }
 
@@ -1848,8 +1848,9 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
 			mutex_lock(&pci_pme_list_mutex);
 			list_add(&pme_dev->list, &pci_pme_list);
 			if (list_is_singular(&pci_pme_list))
-				schedule_delayed_work(&pci_pme_work,
-						      msecs_to_jiffies(PME_TIMEOUT));
+				queue_delayed_work(system_freezable_wq,
+						   &pci_pme_work,
+						   msecs_to_jiffies(PME_TIMEOUT));
 			mutex_unlock(&pci_pme_list_mutex);
 		} else {
 			mutex_lock(&pci_pme_list_mutex);
