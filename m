Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933035AbcKWTtf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 14:49:35 -0500
Date: Wed, 23 Nov 2016 13:49:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] pci: Don't set RCB bit in LNKCTL if the upstream
 bridge hasn't
Message-ID: <20161123194928.GG16033@bhelgaas-glaptop.roam.corp.google.com>
References: <20161102223552.14776-1-jthumshirn@suse.de>
 <20161102223552.14776-2-jthumshirn@suse.de>
 <20161116181158.GB26600@bhelgaas-glaptop.roam.corp.google.com>
 <20161121165352.GM25762@bhelgaas-glaptop.roam.corp.google.com>
 <20161123173152.GC16033@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161123173152.GC16033@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 11:31:52AM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 21, 2016 at 10:53:52AM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 16, 2016 at 12:11:58PM -0600, Bjorn Helgaas wrote:
> > > Hi Johannes,
> > > 
> > > On Wed, Nov 02, 2016 at 04:35:52PM -0600, Johannes Thumshirn wrote:
> > > > The Read Completion Boundary (RCB) bit must only be set on a device or
> > > > endpoint if it is set on the root complex.
> > ...
> 
> > Here's the fixed one.
> 
> I applied the one below to for-linus for v4.9.
> 
> I did tweak the preceding patch to only share pcie_find_root_port()
> inside drivers/pci -- moved the declaration from include/linux/pci.h
> to drivers/pci/pci.h and moved the definition to drivers/pci/search.c.
> 
> I don't think it needs to be visible to the whole kernel.

Sigh, I guess it *does*, because the aer_inject user can be a module.
I'll fix that.

Bjorn
