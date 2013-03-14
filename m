Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:59772 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab3CNV3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Mar 2013 17:29:35 -0400
Date: Thu, 14 Mar 2013 15:29:21 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Mitch Bradley <wmb@firmworks.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130314212921.GB18505@obsidianresearch.com>
References: <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
 <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
 <20130314172555.GA14048@obsidianresearch.com>
 <20130314210926.GA9098@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130314210926.GA9098@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 14, 2013 at 10:09:26PM +0100, Thierry Reding wrote:

> > ranges = <0x82000000 0 0x80000000  0x80000000  0 0x00001000   /* port 0 registers */
> > 	  0x82000000 0 0x80001000  0x80001000  0 0x00001000   /* port 1 registers */
> > 	  0x81000000 0          0  0x82000000  0 0x00010000   /* downstream I/O */
> > 	  0x82000000 0 0xa0000000  0xa0000000  0 0x10000000   /* non-prefetchable memory */
> > 	  0xc2000000 0 0xb0000000  0xb0000000  0 0x10000000>; /* prefetchable memory */
> > 
> > Which says 'access to CPU address 0xa0000000 produces a PCI-E memory TLP with
> > address 0xa0000000' - this is the 'normal' case, I assume that is what
> > happens on tegra?
> > 
> > It also says 'access to CPU address 0x82000000 produces a PCI-E IO TLP
> > with address 0' - this translation is something Linux typically
> > expects..
> 
> Both of the above paragraphs are true. However accesses to the windows
> at 0x80000000 and 0x80001000 don't generate memory TLPs but type 0
> configuration space TLPs.

By my understanding access to 0x80000000/0x80001000 doesn't generate
any externally visible TLPs?

IHMO modeling this register space as a controller-internal MMIO region
associated with the bridge is reasonable... After all, you are
iomapping it and accessing it with readl/writel - those are MMIO
functions..

> So my first instinct was to make the first cell of the first two entries
> 0, but that doesn't work, since the OF core expects to find either
> memory or I/O spaces. 

Right, there is no specified way to translate config ss through
ranges.

Regards,
Jason
