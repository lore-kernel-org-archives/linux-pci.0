Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36597 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752895Ab3KYLaB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 06:30:01 -0500
Date: Mon, 25 Nov 2013 06:29:51 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
Message-ID: <20131125112951.GO29241@titan.lakedaemon.net>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131124025808.GQ29241@titan.lakedaemon.net>
 <20131125055222.GA28064@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131125055222.GA28064@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 24, 2013 at 10:52:22PM -0700, Jason Gunthorpe wrote:
> On Sat, Nov 23, 2013 at 09:58:08PM -0500, Jason Cooper wrote:
> > Jason,
> > 
> > On Thu, Oct 31, 2013 at 05:32:59PM -0600, Jason Gunthorpe wrote:
> > > When PCI_COMMAND_MEMORY/PCI_COMMAND_IO are cleared the bridge should not
> > > allocate windows or even look at the window limit/base registers.
> > > 
> > > Otherwise it can attempt to setup bogus windows that the PCI core code
> > > creates during discovery. The core will leave PCI_COMMAND_IO cleared if
> > > it doesn't need an IO window.
> > > 
> > > Have mvebu_pcie_handle_*_change respect the bits, and call the change
> > > function whenever the bits changes.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > >  drivers/pci/host/pci-mvebu.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > I'd like to get back on track with these small patches being Acked by
> > mvebu maintainers and then going through Bjorn.  Could you please resend
> > an updated patchset for this and 2/2?
> 
> I recall these two patches are waiting for Thomas to give his Ok. His
> testing found problems with the prior versions that I cannot detect on
> my hardware..
> 
> Once that happens I can send them on with his ack to Bjorn?

Please do.

thx,

Jason.
