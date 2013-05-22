Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41330 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753956Ab3EVPTF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 11:19:05 -0400
Date: Wed, 22 May 2013 11:18:29 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Marvell PCIe driver improvements
Message-ID: <20130522151829.GD31290@titan.lakedaemon.net>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522134319.GC31290@titan.lakedaemon.net>
 <519CDFBA.8010607@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <519CDFBA.8010607@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 22, 2013 at 05:09:46PM +0200, Gregory CLEMENT wrote:
> On 05/22/2013 03:43 PM, Jason Cooper wrote:
> > Thomas,
> > 
> > On Wed, May 22, 2013 at 03:12:34PM +0200, Thomas Petazzoni wrote:
> >> Bjorn, Jason, Andrew, Gregory,
> >>
> >> You'll find in this patch series 4 small patches that make various
> >> improvements to the Marvell PCIe driver.
> >>
> >> I'd like those improvements to be kept separated from the original
> >> PCIe driver itself: while the PCIe driver has been around and reviewed
> >> for a long time, those improvements are newer. And I clearly do not
> >> want the PCIe driver to miss 3.11 because of any problem that could be
> >> found in those additional improvements.
> > 
> > Agreed.
> 
> All the changes are located in one single file drivers/pci/host/pci-mvebu.c.
> So as soon as they will be acked by Bjron, I think we can make a PR for them.
> As nothing else depend of it, even if for a reason or another it is dropped,
> there will be no reason to drop anything else.

Right, which is why we'll put it in a separate branch.  Say,
mvebu/pcie_bridge.  This way if /pcie_bridge has to be dropped (say an
API that it used is changed), /pcie would remain.  Which is the main
concern.

Had I known enough last time around, I would have done the /of_pci |
/pcie split.  /pcie would have been dropped, and /of_pci would have made
it in.  As well as LinusW's work which depends upon it (and now Arnd
might have something using it as well).

thx,

Jason.
