Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35856 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbbGWPK0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 11:10:26 -0400
Received: by iehx8 with SMTP id x8so114741079ieh.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 08:10:25 -0700 (PDT)
Date: Thu, 23 Jul 2015 10:10:18 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	James Morse <James.Morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [RFT PATCH] ARM: pci: kill pcibios_msi_controller
Message-ID: <20150723151018.GY21967@google.com>
References: <1436784206-14414-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150722090248.GA344@red-moon>
 <55AF6149.4000601@arm.com>
 <20150722124929.GA537@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722124929.GA537@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 22, 2015 at 01:49:29PM +0100, Lorenzo Pieralisi wrote:

> > >> @@ -483,14 +471,25 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> > >>  				break;
> > >>  			}
> > >>  
> > >> -			if (hw->scan)
> > >> +			if (hw->scan) {
> > >>  				sys->bus = hw->scan(nr, sys);
> > >> -			else
> > >> -				sys->bus = pci_scan_root_bus(parent, sys->busnr,
> > >> -						hw->ops, sys, &sys->resources);
> > >> +				if (!sys->bus)
> > >> +					panic("PCI: unable to scan bus!");
> > 
> > This was in the original code, but I have to ask: Do we really want to
> > panic the kernel if we couldn't scan the bus? Worse case, the system
> > won't be able to boot at all and will panic somewhere else anyway, but
> > we should give the user a chance to understand what's happening...
> 
> No, it was in the original code but I was very tempted to remove it
> or merge the error paths and make it a warning, and that's what I am
> going to do, unless someone complains (that panic statement has been there
> forever).

I agree the panic should be removed.  I would do it in a separate patch
since it's not related to your main objective here.

Bjorn
