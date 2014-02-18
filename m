Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:38049 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaBRRF0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Feb 2014 12:05:26 -0500
Date: Tue, 18 Feb 2014 10:05:18 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture
 resources
Message-ID: <20140218170518.GA29304@obsidianresearch.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20140214182910.GC31093@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140214182910.GC31093@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 14, 2014 at 11:29:10AM -0700, Bjorn Helgaas wrote:
> On Wed, Feb 12, 2014 at 03:57:07PM -0700, Jason Gunthorpe wrote:
> > reg[0] is the DT base, reg[1] is the DT length in bytes,
> > struct resource.end is the inclusive end address, so a -1 is
> > required.
> > 
> > Tested on kirkwood.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> Do these two patches need to go together?  I don't maintain
> drivers/bus/mvebu-mbus.c, but if these should be kept together, I'd be
> happy to merge them both, given the appropriate ack from Jason C or Thomas.

I recommend keeping them together, requesting the wrong resource size
range in PCI-E did not fail on my test system, but it has the
potential to fail on systems with a different memory layout.

Thanks,
Jason
