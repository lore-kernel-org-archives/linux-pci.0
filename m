Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934324AbeB1Uhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 15:37:50 -0500
Date: Wed, 28 Feb 2018 14:37:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix possible NULL pointer dereference for
 of_pci_bus_find_domain_nr
Message-ID: <20180228202425.GJ127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519526762-136838-1-git-send-email-shawn.lin@rock-chips.com>
 <20180227174957.GA12756@e107981-ln.cambridge.arm.com>
 <9fde4c77-cb07-a520-0114-683d331beeb7@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9fde4c77-cb07-a520-0114-683d331beeb7@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 09:42:39AM +0800, Shawn Lin wrote:
> On 2018/2/28 1:49, Lorenzo Pieralisi wrote:
> > On Sun, Feb 25, 2018 at 10:46:02AM +0800, Shawn Lin wrote:
> > I really need to get rid of this function in its current form. In the
> > interim, I think that printing NULL as faulting node gives no
> > information whatsoever so this patch should be updated either by
> > avoiding to print or better by demoting the dev_err() to a pr_err(),
> > whatever works better for Bjorn.
> 
> Ok, that sounds reasonable to me, so which ways is preferred, Bjorn?

If we get to the point of that dev_err(), I don't think we really know
what to do, so we should always print *something* as a clue to the
user because I think things are going to break if we use -1 as the
domain -- not because -1 is such an invalid value per se, but it's an
indication that the DT doesn't correctly describe the machine.  We
may make incorrect assumptions about which devices are in the same
domain.

So I'd make it a pr_err() for now.  It would be good to include the
%pOF when "parent" is not NULL.

The changelog could be simply:

  If the "parent" pointer passed to of_pci_bus_find_domain_nr() is
  NULL, don't dereference it.
