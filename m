Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22663 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab3EVNn4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 09:43:56 -0400
Date: Wed, 22 May 2013 09:43:19 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Marvell PCIe driver improvements
Message-ID: <20130522134319.GC31290@titan.lakedaemon.net>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Wed, May 22, 2013 at 03:12:34PM +0200, Thomas Petazzoni wrote:
> Bjorn, Jason, Andrew, Gregory,
> 
> You'll find in this patch series 4 small patches that make various
> improvements to the Marvell PCIe driver.
> 
> I'd like those improvements to be kept separated from the original
> PCIe driver itself: while the PCIe driver has been around and reviewed
> for a long time, those improvements are newer. And I clearly do not
> want the PCIe driver to miss 3.11 because of any problem that could be
> found in those additional improvements.

Agreed.

For Bjorn and others:

The original patch series Thomas is referring to missed the merge window
for v3.10 due to a build failure.  It is currently sitting in our mvebu
repo.  The first three patches, "of/pci ..." are in mvebu/of_pci.  The
rest of the series is on top of that in the branch mvebu/pcie.

I've sent pull requests for both branches to arm-soc.  There are two
other arm SoC pcie efforts which are depending on mvebu/of_pci.  Hence
why I did a separate branch.

Both branches are also merged into mvebu/for-next, and have survived
linux-next for three days or so.  But, it's early, so we'll see how it
goes. :-)

> Bjorn, with your Acked-by, could the Marvell maintainers include those
> patches in their branch, merged through arm-soc? They already have the
> Marvell PCIe driver itself, so I believe it makes sense to merge those
> improvements through the same path.

I agree, please see above regarding arm-soc dependencies.

> Jason, those patches have been prepared on top of my marvell-pcie-v10
> branch, I hope that's ok for you. If you want me to rebase them on
> some other branch in which you have integrated the PCIe driver, don't
> hesitate to tell me to do so. That said, since those patches are only
> touching the driver itself and no other file, they should not cause
> any conflict with other changes.

Should be fine, I'll let you know.

thx,

Jason.
