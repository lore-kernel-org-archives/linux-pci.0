Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48328 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759173AbcAKOsz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 09:48:55 -0500
Date: Mon, 11 Jan 2016 08:48:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Various R-Car PCIe patches
Message-ID: <20160111144852.GC25540@localhost>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 05, 2016 at 01:00:27PM +0000, Phil Edworthy wrote:
> The first patch removes code that is no longer used. The next two allow us to
> use runtim PM. The last patch is for PHY setup in order to get PCIe compliance
> apparently. For that last patch, I've been told that this is what I must set.
> 
> v2:
>  PATCH 2/4 - Use readl_poll_timeout_atomic when waiting until we are in L1.
>  PATCh 4/4 - Added comment about where the PHY settings come from.
> 
> Phil Edworthy (4):
>   PCI: rcar: remove unused pci_sys_data structure in pcie-rcar
>   PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
>   PCI: rcar: Add runtime PM support to pcie-rcar
>   PCI: rcar: Add Gen2 PHY setup to pcie-rcar
> 
>  drivers/pci/host/pcie-rcar.c | 115 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 91 insertions(+), 24 deletions(-)

I dropped "Support runtime PM link state L1 handling in pcie-rcar" for
now (until we figure out how that's supposed to work).

I applied the others to pci/host-rcar and plan to squeeze them into
v4.5.
