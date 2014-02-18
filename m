Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:46773 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbaBRUiG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 15:38:06 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp4so19256749obc.30
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2014 12:38:05 -0800 (PST)
Date: Tue, 18 Feb 2014 13:38:01 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture
 resources
Message-ID: <20140218203801.GA8786@google.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20140214182910.GC31093@google.com>
 <20140217013949.GE7862@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140217013949.GE7862@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 16, 2014 at 08:39:49PM -0500, Jason Cooper wrote:
> On Fri, Feb 14, 2014 at 11:29:10AM -0700, Bjorn Helgaas wrote:
> > On Wed, Feb 12, 2014 at 03:57:07PM -0700, Jason Gunthorpe wrote:
> > > reg[0] is the DT base, reg[1] is the DT length in bytes,
> > > struct resource.end is the inclusive end address, so a -1 is
> > > required.
> > > 
> > > Tested on kirkwood.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > 
> > Do these two patches need to go together?  I don't maintain
> > drivers/bus/mvebu-mbus.c, but if these should be kept together, I'd be
> > happy to merge them both, given the appropriate ack from Jason C or Thomas.
> 
> I have one small change for mvebu-mbus queued up, which won't conflict
> here.  Please take both:
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

I added the acks and applied both patches to pci/host-mvebu for v3.15,
thanks!

Bjorn
