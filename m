Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeABTRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jan 2018 14:17:35 -0500
Date: Tue, 2 Jan 2018 13:16:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] PCI: Regroup all PCI related entries into
 drivers/pci/Makefile
Message-ID: <20180102191639.GD6211@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <49f5a733e05a46521340e913876332f3804e2042.1513620412.git.cyrille.pitchen@free-electrons.com>
 <20171228224718.GA19819@bhelgaas-glaptop.roam.corp.google.com>
 <0b366da6-7673-4473-c9a5-9f6b643a093f@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <0b366da6-7673-4473-c9a5-9f6b643a093f@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 29, 2017 at 09:21:56PM +0100, Cyrille Pitchen wrote:
> Hi Bjorn,
> 
> Le 28/12/2017 à 23:47, Bjorn Helgaas a écrit :
> > On Mon, Dec 18, 2017 at 07:16:01PM +0100, Cyrille Pitchen wrote:
> >> This patch cleans drivers/Makefile up by moving the pci/endpoint and
> >> pci/dwc entries from drivers/Makefile into drivers/pci/Makefile.
> > 
> > Thanks a lot for doing this!
> > 
> > s/This patch cleans/Clean up/
> >
> 
> updated for the next series
>  
> > Speaking of cleanup, this Makefile has useless comments and blank
> > lines.  Maybe you could add a new patch to remove them and reorder it
> > into a sensible order, with the Intel MID special case at the end and
> > the host/dwc/cadence stuff together?
> >
> 
> OK, I'm working on it. So right now I'm trying to sort entries by
> alphabetical order but the first test has just failed: kernel oops
> when calling pcied_init().

Sorting isn't a big deal.  The blank lines and useless comments do
make it hard to scan, but if we can't sort them, I'm fine with that.

But I *am* curious about the failure you observed.  That sounds like
we might have a dependency bug there and I'd like to fix that.  I
don't like to rely on link ordering because it's invisible in the
source code.

Can you post the reordering patch you used so I can investigate it?

> I guess there are more hidden dependencies than expected, solved by the
> link order. This cleanup might bit risky after all, especially since I
> won't be able to test all combinations or with all possible hardwares. 

Bjorn
