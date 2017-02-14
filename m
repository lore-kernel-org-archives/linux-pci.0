Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PCI / PM: Crashes in PME scan during system suspend
Date: Tue, 14 Feb 2017 12:26:01 +0100
Message-ID: <2661070.8D7d40DjM3@aspire.rjw.lan>
In-Reply-To: <CAMuHMdVf-NT_6oGQVba_QgFuW-fZMBDF1CtidfxSxnCr8+BGHg@mail.gmail.com>
References: <CAMuHMdVf-NT_6oGQVba_QgFuW-fZMBDF1CtidfxSxnCr8+BGHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, February 14, 2017 10:31:38 AM Geert Uytterhoeven wrote:
> Hi all,
> 
> Laurent Pinchart reported that r8a7790/Lager crashes during suspend tests.
> 
> I managed to reproduce the issue on r8a7791/koelsch:
>   - It only happens during suspend tests, after writing either "platform"
>     or "processors" to /sys/power/pm_test,
>   - It does not (or is less likely) to happen during full system suspend
>     ("core" or "none").
> 
> More investigation shows this happens when the PME scan runs, once per
> second.  During PME scan, the PCI host bridge (rcar-pci) registers are
> accessed while the host bridge's module clock has already been disabled,
> leading to a crash.

OK, so clearly PME scans should be suspended before the host bridge
registers become inaccessible.

Another question, though, is whether or not PME scans are actually necessary
on the affected platforms at all.

> With "core" or "none", system suspend also disables timers, and thus the
> workqueue handling PME scan no longer runs.  I believe the issue can still
> happen, as there's a small window between disabling module clocks and
> disabling timers.
> 
> Lukas' patch "[PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend"
> (http://lkml.iu.edu/hypermail/linux/kernel/1702.0/03245.html) is not
> sufficient to fix the issue.
> 
> Note that the issue was not introduced by commit 68db9bc81436 ("PCI:
> pciehp: Add runtime PM support for PCIe hotplug ports"):  I managed to
> trigger it on 68db9bc81436^ too, albeit not at first try.
> 
> Do you have a clue?

Pretty much. :-)

The PME scans cannot run on a suspended host bridge.

> Shall I bisect it? I have no idea when the issue appeared first, or if it ever
> worked.

It's never worked IMO.

Thanks,
Rafael
