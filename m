Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:45192 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759760Ab3EWQrD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 May 2013 12:47:03 -0400
Date: Thu, 23 May 2013 10:46:54 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Marvell PCIe driver improvements
Message-ID: <20130523164654.GA31281@obsidianresearch.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523001353.GH31625@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130523001353.GH31625@1wt.eu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 02:13:53AM +0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Wed, May 22, 2013 at 03:12:34PM +0200, Thomas Petazzoni wrote:
> > Bjorn, Jason, Andrew, Gregory,
> > 
> > You'll find in this patch series 4 small patches that make various
> > improvements to the Marvell PCIe driver.
> (...)
> 
> FWIW, these patches applied on top of your pcie-v10 tree have made
> my mini-pcie dual-nic appear for the first time on the mirabox. Till
> now I never knew if it was a hardware or software issue since the NIC
> does not appear in u-boot nor lspci, whatever the kernel versions,
> including the original Marvell one's. The NIC has two functions (one
> per controller) and no bridge, so it may be a side effect of your
> improvements (or maybe you fixed a bug).

There was some talk earlier that some buggy chips required their
device number to be 0. I'm guessing Thomas's change to ensure that
always happens by moving the device number of the internal device is
the root fix here?

Regards,
Jason
