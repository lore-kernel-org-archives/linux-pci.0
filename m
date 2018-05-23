Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933791AbeEWV42 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 17:56:28 -0400
Date: Wed, 23 May 2018 16:56:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: rcar: Rename
 rcar_pcie_parse_request_of_pci_ranges()
Message-ID: <20180523215626.GG150632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180523161711.GA8113@e107981-ln.cambridge.arm.com>
 <5fc7b4ff-1c75-4d3f-6cb7-fda4559a3635@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5fc7b4ff-1c75-4d3f-6cb7-fda4559a3635@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 07:05:06PM +0200, Marek Vasut wrote:
> On 05/23/2018 06:17 PM, Lorenzo Pieralisi wrote:
> > On Mon, May 21, 2018 at 03:11:20PM +0200, Marek Vasut wrote:
> >> The function name is just too confusing, rename it, no functional change.
> >> Rename the function to rcar_pcie_alloc_and_parse_pci_resource_list() as
> >> it's matching failpath function is pci_free_resource_list() so the names
> >> align much better and the new name also describes what the function does
> >> much better.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> ---
> >>  drivers/pci/host/pcie-rcar.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Can you rebase this series against my pci/rcar branch please ?
> > 
> > I will merge it then, thanks.
> 
> Where is that tree/branch located ?
> 
> It applies fine on current next 20180517, is there a problem ?

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=pci/rcar

I don't think next 20180517 includes Lorenzo's pci/rcar branch, so
there might be conflicts.  I think Stephen is on vacation until next
week, so there isn't a newer -next tree yet.
