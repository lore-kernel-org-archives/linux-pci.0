Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37085 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab3JQOr1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2013 10:47:27 -0400
Date: Thu, 17 Oct 2013 10:47:16 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
Message-ID: <20131017144716.GI22434@titan.lakedaemon.net>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131017131031.GD22434@titan.lakedaemon.net>
 <20131017144112.GA28343@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131017144112.GA28343@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 17, 2013 at 08:41:12AM -0600, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2013 at 09:10:31AM -0400, Jason Cooper wrote:
> > On Tue, Oct 15, 2013 at 02:16:22PM -0600, Jason Gunthorpe wrote:
> > > Make pcie-io-aperture and the IO port MBUS ID in ranges optional.
> > > If not provided the bridge reports to Linux that IO space mapping is
> > > not supported and refuses to configure an IO mbus window.
> > > 
> > > This allows both complete disable (do not specify pcie-io-aperture) and
> > > per-port disable (do not specify a IO target ranges entry for the port)
> > > 
> > > Most PCIE devices these days do not require IO support to function,
> > > so having an option to disable it in the driver is useful.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > >  drivers/pci/host/pci-mvebu.c | 64 +++++++++++++++++++++++++++++---------------
> > >  1 file changed, 43 insertions(+), 21 deletions(-)
> > 
> > Applied to mvebu/drivers
> 
> If possible, Thomas should test this, IMHO. My hardware here
> completely lacks IO port windows so I cannot meaningfully test that
> aspect of the change.

Agreed, Thomas and I were just discussing this on #mvlinux.  I took this
in to get it as much coverage in -next as possible.  Since we are getting
close to the end of the merge window and Stephen Rothwell is on
vacation, so -next testing isn't as smooth and predictable as usual.

Once Thomas (and others, don't be shy!) has tested it, I'll either add
the Tested-by or drop it for a new version.

thx,

Jason.
