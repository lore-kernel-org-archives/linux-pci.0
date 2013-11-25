Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46867 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755456Ab3KYRJi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 12:09:38 -0500
Date: Mon, 25 Nov 2013 18:09:35 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
Message-ID: <20131125180935.37ee3222@skate>
In-Reply-To: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Thu, 31 Oct 2013 17:32:59 -0600, Jason Gunthorpe wrote:
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

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
