Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbdGETtf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jul 2017 15:49:35 -0400
Date: Wed, 5 Jul 2017 14:49:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: kys@microsoft.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        devel@linuxdriverproject.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] hv: fix msi affinity when device requests all possible
 CPU's
Message-ID: <20170705194933.GN13824@bhelgaas-glaptop.roam.corp.google.com>
References: <20170628232204.15227-1-sthemmin@microsoft.com>
 <20170702213819.GF18324@bhelgaas-glaptop.roam.corp.google.com>
 <20170704145942.53390432@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170704145942.53390432@xeon-e3>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 04, 2017 at 02:59:42PM -0700, Stephen Hemminger wrote:
> On Sun, 2 Jul 2017 16:38:19 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Jun 28, 2017 at 04:22:04PM -0700, Stephen Hemminger wrote:
> > > When Intel 10G (ixgbevf) is passed to a Hyper-V guest with SR-IOV,
> > > the driver requests affinity with all possible CPU's (0-239) even
> > > those CPU's are not online (and will never be). Because of this the device
> > > is unable to correctly get MSI interrupt's setup.
> > > 
> > > This was caused by the change in 4.12 that converted this affinity
> > > into all possible CPU's (0-31) but then host reports
> > > an error since this is larger than the number of online cpu's.
> > > 
> > > Previously, this worked (up to 4.12-rc1) because only online cpu's
> > > would be put in mask passed to the host.
> > > 
> > > This patch applies only to 4.12.
> > > The driver in linux-next needs a a different fix because of the changes
> > > to PCI host protocol version.  
> > 
> > If Linus decides to postpone v4.12 a week, I can ask him to pull this.  But
> > I suspect he will release v4.12 today.  In that case, I don't know what to
> > do with this other than maybe send it to Greg for a -stable release.
> 
> Looks like this will have to be queued for 4.12 stable.

I assume you'll take care of this, right?  It sounds like there's nothing
to do for upstream because it needs a different fix.

Bjorn
