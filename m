Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47401 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaBQBkB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 16 Feb 2014 20:40:01 -0500
Date: Sun, 16 Feb 2014 20:39:49 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI
 aperture resources
Message-ID: <20140217013949.GE7862@titan.lakedaemon.net>
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

I have one small change for mvebu-mbus queued up, which won't conflict
here.  Please take both:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
