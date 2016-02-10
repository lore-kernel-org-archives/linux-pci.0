Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:37603 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbcBJRWg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 12:22:36 -0500
Date: Wed, 10 Feb 2016 18:22:29 +0100
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/4] PCI: rcar, rcar-gen2: More Gen2 compatibility
 strings
Message-ID: <20160210172229.GC17671@verge.net.au>
References: <1453093785-21067-1-git-send-email-horms+renesas@verge.net.au>
 <20160205202135.GA9594@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160205202135.GA9594@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 02:21:35PM -0600, Bjorn Helgaas wrote:
> Hi Simon,
> 
> On Mon, Jan 18, 2016 at 02:09:41PM +0900, Simon Horman wrote:
> > this short series adds fallback gen2 and SoC-specific r8a7793 compatibility
> > strings to the rcar PCI and rcar-gen2 PCIE drivers. The intention is to
> > provide a complete set of compatibility strings for known Gen2 SoCs.
> > 
> > Bjorn, the intention of the revised changelogs for the r8a7793 is to
> > address your concerns regarding providing an explanation of why there are
> > no driver changes. Please consider taking this series through your tree.
> > 
> > Key Changes between v2 and v3:
> > * Enhance changelog to describe why documenting the r8a7793 is necessary
> >   and sufficient
> > * Added acks.
> > 
> > Key Changes between v1 and v2:
> > * Include "rcar-" in generic bindings
> > 
> > Simon Horman (4):
> >   PCI: rcar-gen2: add gen2 fallback compatibility string
> >   PCI: rcar-gen2: add device tree support for r8a7793
> >   PCI: rcar: add gen2 fallback compatibility string
> >   PCI: rcar: add device tree support for r8a7793
> > 
> >  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 12 ++++++++++--
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt      | 14 +++++++++++---
> >  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
> >  drivers/pci/host/pcie-rcar.c                            |  1 +
> >  4 files changed, 23 insertions(+), 5 deletions(-)
> 
> Whew, it took a long time to pound that through my thick skull :)
> 
> I think patches 1 and 3 are already in v4.5-rc1, and I applied patches 2
> and 4 to my for-linus branch as below.  Please double-check and make sure
> for-linus has everything you want.  I'll ask Linus to pull that before
> v4.5.

Thanks,

I checked your for-linus branch and everything seems to be in order.
