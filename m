Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46033 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbbGXQUh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Jul 2015 12:20:37 -0400
Date: Fri, 24 Jul 2015 17:21:17 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFT PATCH v3] PCI: move pci_read_bridge_bases to the generic
 PCI layer
Message-ID: <20150724162117.GB8207@red-moon>
References: <1436439557-21075-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150723161257.GZ21967@google.com>
 <20150723174845.GB23324@red-moon>
 <20150724085542.GB30410@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150724085542.GB30410@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 24, 2015 at 09:55:42AM +0100, Will Deacon wrote:
> On Thu, Jul 23, 2015 at 06:48:45PM +0100, Lorenzo Pieralisi wrote:
> > On Thu, Jul 23, 2015 at 05:12:57PM +0100, Bjorn Helgaas wrote:
> > > I'm a little uneasy that we might break some alpha or mips system, since
> > > there must have been some reason this was done originally.  It'd be ideal
> > > if somebody could test a non-PCI_PROBE_ONLY system.  But maybe they're all
> > > obsolete.
> > 
> > I have no way to test them, that's the reason behind the RFT on this
> > patch, I am uneasy too I do not if anyone can help us test it
> > (maybe adding it to -next can help with that).
> 
> I've got some dusty old alpha and mips machines w/pci at home if you
> want to borrow them? They were last seen running 3.0.

Yes it would be very useful to check their PCI resources allocation
policy and test this patch on them.

Thank you !
Lorenzo
