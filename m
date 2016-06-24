Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from straum.hexapodia.org ([192.235.78.53]:55561 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcFXSxx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2016 14:53:53 -0400
Date: Fri, 24 Jun 2016 11:46:02 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-mips@linux-mips.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jayachandran C <jchandra@broadcom.com>,
	Ganesan Ramalingam <ganesanr@broadcom.com>,
	David Daney <david.daney@cavium.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: PCI_PROBE_ONLY clean-up
Message-ID: <20160624184602.GG32461@hexapodia.org>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160624155021.GD5930@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160624155021.GD5930@linux-mips.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 24, 2016 at 05:50:21PM +0200, Ralf Baechle wrote:
> >   bcm1480
> >     Andrew Isaacson <adi@broadcom.com>
> >     dc41f94f7709 ("Support for the BCM1480 on-chip PCI-X bridge.")
> > 
> >   ip27
> >     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> >     96173a6c4ebc ("[MIPS] IP27: misc fixes")
> 
> Afair  I did originally implement the IP27 use of PCI_PROBE_ONLY.  The
> problem is that it was not possible for the kernel to assign resources
> properly on an IP27.  Also that would invalidate firmware configuration
> information, so we had to live with whatever the firmware (mis)configured
> for us.  Afair - it's a darn long time ...  I think the reasoning for
> the BCM1480 was similar but Andy will hopefully recall the details.

I don't remember the details, unfortunately, but my general recollection
is similar -- CFE on bcm1480 was doing a fairly good job of configuring
PCI, and I think we needed to preserve the configuration for Reasons
rather than letting the kernel change things away from the CFE setup.

I unfortunately no longer have any 1480 hardware to test on, nor do I
know who's left at BCM who might be able to validate this change.

-andy
