Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41191 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381AbaCTRbV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Mar 2014 13:31:21 -0400
Date: Thu, 20 Mar 2014 11:31:07 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	linux-sh@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Magnus Damm <damm@opensource.se>,
	Ben Dooks <ben-linux@fluff.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: DMABOUNCE in pci-rcar
Message-ID: <20140320173106.GA19395@obsidianresearch.com>
References: <201402241200.21944.arnd@arndb.de>
 <5527822.QYtFYiIpiW@wuerfel>
 <532B137B.7010900@codethink.co.uk>
 <4884083.IuNl44Y6XD@wuerfel>
 <532B2485.6010005@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <532B2485.6010005@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 20, 2014 at 06:25:25PM +0100, Ben Dooks wrote:
> So doing:
> 
> static void pci_rcar_fixup(struct pci_dev *dev)
> {
> 	if (dev->bus->ops == &rcar_pci_ops) {
> 		dev_info(&dev->dev, "applying new dma mask\n");
> 		dev->dma_mask = DMA_BIT_MASK(31);
> 	}
> }
> 
> DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_rcar_fixup);
> 
> Did not work for me :(

Seems like it should work, do you have CONFIG_PCI_QUIRKS turned on?

Jason
