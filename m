Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41333 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbbGWROu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jul 2015 13:14:50 -0400
Date: Thu, 23 Jul 2015 18:15:25 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>,
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
Message-ID: <20150723171514.GA23324@red-moon>
References: <1436784206-14414-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150722090248.GA344@red-moon>
 <55AF6149.4000601@arm.com>
 <20150722124929.GA537@red-moon>
 <20150723151018.GY21967@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150723151018.GY21967@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 04:10:18PM +0100, Bjorn Helgaas wrote:
> On Wed, Jul 22, 2015 at 01:49:29PM +0100, Lorenzo Pieralisi wrote:
> 
> > > >> @@ -483,14 +471,25 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> > > >>  				break;
> > > >>  			}
> > > >>  
> > > >> -			if (hw->scan)
> > > >> +			if (hw->scan) {
> > > >>  				sys->bus = hw->scan(nr, sys);
> > > >> -			else
> > > >> -				sys->bus = pci_scan_root_bus(parent, sys->busnr,
> > > >> -						hw->ops, sys, &sys->resources);
> > > >> +				if (!sys->bus)
> > > >> +					panic("PCI: unable to scan bus!");
> > > 
> > > This was in the original code, but I have to ask: Do we really want to
> > > panic the kernel if we couldn't scan the bus? Worse case, the system
> > > won't be able to boot at all and will panic somewhere else anyway, but
> > > we should give the user a chance to understand what's happening...
> > 
> > No, it was in the original code but I was very tempted to remove it
> > or merge the error paths and make it a warning, and that's what I am
> > going to do, unless someone complains (that panic statement has been there
> > forever).
> 
> I agree the panic should be removed.  I would do it in a separate patch
> since it's not related to your main objective here.

Ok, I will post v2 shortly.

Thanks !
Lorenzo
