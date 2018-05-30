Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbeE3QpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 12:45:13 -0400
Date: Wed, 30 May 2018 11:45:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Meelis Roos <mroos@linux.ee>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v1 0/4] sparc/PCI: VGA resource and other fixes
Message-ID: <20180530164511.GG39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 08:02:17AM -0500, Bjorn Helgaas wrote:
> [+cc sparclinux, sorry I missed this first time around]
> 
> On Mon, May 21, 2018 at 07:30:29PM -0500, Bjorn Helgaas wrote:
> > The main thing here is the first patch, a legacy VGA framebuffer fix for
> > issues reported by Meelis.
> > 
> > The others are to converge the pci_enable_device() path for LEON and PCIC
> > with other arches (including sparc64), and to convert some logging to use
> > dev_printk() and make it more consistent with the PCI core.
> > 
> > I propose to merge these via the PCI tree.
> > 
> > ---
> > 
> > Bjorn Helgaas (4):
> >       sparc/PCI: Request legacy VGA framebuffer only for VGA devices
> >       sparc32/PCI/LEON: Converge device enable path
> >       sparc32/PCI/PCIC: Converge device enable path
> >       sparc/PCI: Use dev_printk() when possible
> > 
> > 
> >  arch/sparc/kernel/leon_pci.c   |   62 ++++++------------
> >  arch/sparc/kernel/pci.c        |  136 +++++++++++++++++++++++++---------------
> >  arch/sparc/kernel/pci_common.c |   31 ++-------
> >  arch/sparc/kernel/pci_msi.c    |   10 +--
> >  arch/sparc/kernel/pcic.c       |   86 ++++++++++++-------------
> >  5 files changed, 159 insertions(+), 166 deletions(-)

I applied these to my pci/sparc branch for v4.18 (with fixes for the typos
reported by Meelis and the kbuild robot).
