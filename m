Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
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
Date: Sat, 15 Apr 2017 00:27:31 +0200
Message-ID: <3960283.lbE9ESSj2m@aspire.rjw.lan>
In-Reply-To: <20170414082249.GA5417@wunner.de>
References: <CAMuHMdVf-NT_6oGQVba_QgFuW-fZMBDF1CtidfxSxnCr8+BGHg@mail.gmail.com> <2661070.8D7d40DjM3@aspire.rjw.lan> <20170414082249.GA5417@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 14, 2017 10:22:49 AM Lukas Wunner wrote:
> On Tue, Feb 14, 2017 at 12:26:01PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 14, 2017 10:31:38 AM Geert Uytterhoeven wrote:
> > > Laurent Pinchart reported that r8a7790/Lager crashes during suspend tests.
> > > 
> > > I managed to reproduce the issue on r8a7791/koelsch:
> > >   - It only happens during suspend tests, after writing either "platform"
> > >     or "processors" to /sys/power/pm_test,
> > >   - It does not (or is less likely) to happen during full system suspend
> > >     ("core" or "none").
> > > 
> > > More investigation shows this happens when the PME scan runs, once per
> > > second.  During PME scan, the PCI host bridge (rcar-pci) registers are
> > > accessed while the host bridge's module clock has already been disabled,
> > > leading to a crash.
> > 
> > OK, so clearly PME scans should be suspended before the host bridge
> > registers become inaccessible.
> > 
> > Another question, though, is whether or not PME scans are actually necessary
> > on the affected platforms at all.
> 
> I'm not seeing a fix for this in linux-next, am I missing something?
> Has anyone looked into it or is the issue still open?

It is still open AFAICS.

> Below is a tentative patch which moves PME polling to a freezable
> workqueue, so it is frozen before the host bridge is suspended.
> Geert, Laurent, could you test this?
> 
> The patch may be problematic in that pci_pme_list_scan() acquires
> pci_pme_list_mutex, which is also acquired by pci_pme_active(),
> which gets called when devices are suspended -- *after* the worker
> has been frozen.  I'm not really familiar with the freezer, can it
> happen that the worker is frozen while holding the mutex?  If so
> this would deadlock.  Rafael?

That depends on the worker, precisely on where it calls try_to_freeze().

That said I think it won't do that while holding any locks. :-)

Thanks,
Rafael
