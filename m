Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:36277 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdDRSj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2017 14:39:26 -0400
Date: Tue, 18 Apr 2017 20:39:38 +0200
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: PCI / PM: Crashes in PME scan during system suspend
Message-ID: <20170418183938.GA7757@wunner.de>
References: <CAMuHMdVf-NT_6oGQVba_QgFuW-fZMBDF1CtidfxSxnCr8+BGHg@mail.gmail.com>
 <20170416075535.GA6620@wunner.de>
 <CAMuHMdUzYUGZT3gWzZ97rmbPXG3RqYLdvYx_ZdLdmCvxbrt4Hw@mail.gmail.com>
 <1776042.AWT4z5IEIn@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1776042.AWT4z5IEIn@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 18, 2017 at 04:06:27PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, April 18, 2017 08:49:39 AM Geert Uytterhoeven wrote:
> > On Sun, Apr 16, 2017 at 9:55 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > Subject: [PATCH] PCI: Freeze PME scan before suspending devices
> > >
> > > Laurent Pinchart reported that the Renesas R-Car H2 Lager board
> > > (r8a7790) crashes during suspend tests.  Geert Uytterhoeven managed to
> > > reproduce the issue on an M2-W Koelsch board (r8a7791):
> > >
> > > It occurs when the PME scan runs, once per second.  During PME scan, the
> > > PCI host bridge (rcar-pci) registers are accessed while its module clock
> > > has already been disabled, leading to the crash.
> > >
> > > The issue only occurs during suspend tests, after writing either
> > > "platform" or "processors" to /sys/power/pm_test.  It does not (or is
> > > less likely) to happen during full system suspend ("core" or "none")
> > > because system suspend also disables timers, and thus the workqueue
> > > handling PME scans no longer runs.  Geert believes the issue may still
> > > happen in the small window between disabling module clocks and disabling
> > > timers.
> > 
> > It can also be reproduced easily by configuring s2ram to use s2idle instead
> > of deep suspend, which is a real usecase:
> > 
> > # echo 0 > /sys/module/printk/parameters/console_suspend
> > # echo s2idle > /sys/power/mem_sleep
> > # echo mem > /sys/power/state
> > 
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> There is a small concern here that some wakeup events may be missed if they
> are delivered via PME without a working IRQ, but that's fairly minor and it
> cannot be avoided entirely, so

Well, that's a conundrum.  I don't know which devices depend on PME polling
and whether they may signal PME between freezing the workqueue and suspending
the host bridge.  If this unexpectedly turns out to be a problem in practice,
it might be possible to solve it by calling pci_pme_list_scan() once directly
from one of the host bridge's pm_ops callbacks.

I've amended the commit message with the tags and additional information
provided by you and Geert and will resend the patch to the list shortly.

Thanks,

Lukas
