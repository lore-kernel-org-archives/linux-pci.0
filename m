Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:53769 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099Ab3KYFw2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Nov 2013 00:52:28 -0500
Date: Sun, 24 Nov 2013 22:52:22 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
Message-ID: <20131125055222.GA28064@obsidianresearch.com>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131124025808.GQ29241@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131124025808.GQ29241@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 23, 2013 at 09:58:08PM -0500, Jason Cooper wrote:
> Jason,
> 
> On Thu, Oct 31, 2013 at 05:32:59PM -0600, Jason Gunthorpe wrote:
> > When PCI_COMMAND_MEMORY/PCI_COMMAND_IO are cleared the bridge should not
> > allocate windows or even look at the window limit/base registers.
> > 
> > Otherwise it can attempt to setup bogus windows that the PCI core code
> > creates during discovery. The core will leave PCI_COMMAND_IO cleared if
> > it doesn't need an IO window.
> > 
> > Have mvebu_pcie_handle_*_change respect the bits, and call the change
> > function whenever the bits changes.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> >  drivers/pci/host/pci-mvebu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> I'd like to get back on track with these small patches being Acked by
> mvebu maintainers and then going through Bjorn.  Could you please resend
> an updated patchset for this and 2/2?

I recall these two patches are waiting for Thomas to give his Ok. His
testing found problems with the prior versions that I cannot detect on
my hardware..

Once that happens I can send them on with his ack to Bjorn?

Regards,
Jason
