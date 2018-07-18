Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeGRV4b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 17:56:31 -0400
Date: Wed, 18 Jul 2018 16:16:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        poza@codeaurora.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2, 0/1] PCI/AER: fix use-after-free in
 pcie_do_fatal_recovery
Message-ID: <20180718211645.GF128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
 <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
 <20180712215700.GA17092@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180712215700.GA17092@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 12, 2018 at 03:57:01PM -0600, Keith Busch wrote:
> On Thu, Jul 12, 2018 at 04:51:51PM -0500, Bjorn Helgaas wrote:
> > However, I think we're also slightly exposed in dpc_work(), in basically
> > the same (possibly harmless) way.
> > 
> >   dpc_irq
> >     schedule_work(&dpc->work)
> >   ...
> >   dpc_work
> >     pdev = dpc->dev->port
> >     pcie_do_fatal_recovery(pdev)
> > 
> > pdev may be removed by pcie_do_fatal_recovery(), but dpc_work() is still
> > holding onto a pointer (which it never uses again).
> > 
> > The DPC driver should be holding a reference to pdev (through some black
> > magic I don't understand), but that would be released when pdev is removed,
> > and I don't know what ensures that dpc_work() runs before that release.
> > 
> > Bjorn
> 
> Yep, you're right on that point. There's different ways we can fix
> that. The most recent one I proposed was to replace the scheduled work
> with the threaded irq[1]. That should make it safe since the lifetime of
> when bottom half can be executed is tied to the lifetime of the device
> that registered it.
> 
>  1. https://patchwork.kernel.org/patch/10478755/

This one is headed for v4.19 (it's on pci/dpc right now).  I don't
think anybody will trip over this with DPC, so I don't think we need
to get this in v4.18 (let me know if you think otherwise).

But of course it doesn't fix the crash Thomas is seeing, because
that's in the AER path, not the DPC path.  I think you're working on
an AER fix involving threaded IRQs, right, Thomas?  Just want to make
sure I haven't missed something.

Bjorn
