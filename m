Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49243 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756226Ab3KXC6P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Nov 2013 21:58:15 -0500
Date: Sat, 23 Nov 2013 21:58:08 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
Message-ID: <20131124025808.GQ29241@titan.lakedaemon.net>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jason,

On Thu, Oct 31, 2013 at 05:32:59PM -0600, Jason Gunthorpe wrote:
> When PCI_COMMAND_MEMORY/PCI_COMMAND_IO are cleared the bridge should not
> allocate windows or even look at the window limit/base registers.
> 
> Otherwise it can attempt to setup bogus windows that the PCI core code
> creates during discovery. The core will leave PCI_COMMAND_IO cleared if
> it doesn't need an IO window.
> 
> Have mvebu_pcie_handle_*_change respect the bits, and call the change
> function whenever the bits changes.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

I'd like to get back on track with these small patches being Acked by
mvebu maintainers and then going through Bjorn.  Could you please resend
an updated patchset for this and 2/2?

thx,

Jason.
