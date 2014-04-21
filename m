Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:40365 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbaDUQsA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Apr 2014 12:48:00 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so3924434pbc.13
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2014 09:47:59 -0700 (PDT)
Date: Mon, 21 Apr 2014 10:47:54 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/7] pci: mvebu: fix off-by-one in the computed size of
 the mbus windows
Message-ID: <20140421164754.GA17260@google.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397823593-1932-5-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397823593-1932-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 18, 2014 at 02:19:50PM +0200, Thomas Petazzoni wrote:
> From: Willy Tarreau <w@1wt.eu>
> 
> mvebu_pcie_handle_membase_change() and
> mvebu_pcie_handle_iobase_change() do not correctly compute the window
> size. PCI uses an inclusive start/end address pair, which requires a
> +1 when converting to size.
> 
> This only worked because a bug in the mbus driver allowed it to
> silently accept and round up bogus sizes.
> 
> Fix this by adding one to the computed size.
> 
> Fixes: 45361a4fe4464180815157654aabbd2afb4848ad ('PCIe driver for Marvell Armada 370/XP systems')
> Cc: <stable@vger.kernel.org> # v3.11+
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Reviewed-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If I were merging via my tree, I would tweak the subject capitalization
so "git log --oneline drivers/pci/host/pci-mvebu.c" looks consistent.

> ---
>  drivers/pci/host/pci-mvebu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index d3d1cfd..4829921 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -331,7 +331,7 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  	port->iowin_base = port->pcie->io.start + iobase;
>  	port->iowin_size = ((0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
>  			    (port->bridge.iolimitupper << 16)) -
> -			    iobase);
> +			    iobase) + 1;
>  
>  	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
>  					  port->iowin_base, port->iowin_size,
> @@ -364,7 +364,7 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  	port->memwin_base  = ((port->bridge.membase & 0xFFF0) << 16);
>  	port->memwin_size  =
>  		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
> -		port->memwin_base;
> +		port->memwin_base + 1;
>  
>  	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
>  				    port->memwin_base, port->memwin_size);
> -- 
> 1.9.2
> 
