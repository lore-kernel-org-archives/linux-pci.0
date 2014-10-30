Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57180 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbaJ3UEm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 16:04:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Mohit Kumar <mohit.kumar@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
Date: Thu, 30 Oct 2014 21:03:51 +0100
Message-ID: <2033107.209JbeZvkg@wuerfel>
In-Reply-To: <20141030193538.GK26820@obsidianresearch.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com> <3532414.9PZuBnKWYz@wuerfel> <20141030193538.GK26820@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 30 October 2014 13:35:38 Jason Gunthorpe wrote:
> On Thu, Oct 30, 2014 at 08:21:40PM +0100, Arnd Bergmann wrote:
> 
> > > So how does mvebu now allocate a unique domain number per mvebu_pcie?
> > 
> > I believe the answer to that is that the mvebu PCIe driver currently only
> > supports one domain, and it will have the unique number '0', which is the
> > default.
> 
> It is like most of the the other new drivers, each mvebu_pcie_probe
> expects to create a new domain with a unique bus number set for that
> platform_device. AFAIK everything is uniq'd to the struct mcebu_pcie,
> so there is nothing precluding the driver from being instantiated
> twice.
> 
> Indeed, the way mvebu hardware works you could actually create a DT
> that assigned some ports to one domain and some other ports to a
> different domain, using two platform_devices. All that was missing
> from the driver was to increment the domain number.

Right, makes sense.

> I think Lorenzo's patches improve this, at least it appears that
> unique domain numbers are now being assigned, I'm not sure - I'm a
> little confused how we can safely blindly apply the new domain logic
> without the driver opt'ing in....

I think it will just work: the host driver should not care about
the particular domain number, it just needs to be unique, which
the core now ensures.

> I thought older PCI platforms tended to call pci_common_init for each
> physical PCI bus, and we don't want them to suddenly have non-zero
> domain numbers??

Only cns3xxx calls pci_common_init with fixed domain numbers, and
Lorenzo's patch 1/2 changes it. All other drivers fall into one
of three categories:

a) there is only ever one host bridge
b) There are multiple host bridges, but they are all in the same
   domain, and the driver calls pci_common_init() once to initialize
   them all, and pci_common_init calls back into the driver with
   the hw_pci->setup() function passing the instance number.
c) The driver calls pci_common_init_dev() for each new host bridge
   and assigns a new domain every time but never has more than one
   host bridge per domain.

a) and b) are not impacted by this patch, while c) becomes simpler.

BTW, pci-mvebu is currently the only driver using c) with pci_common_init
rather than pci_common_init_dev. We should probably apply this trivial
patch to make it more consistent:

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b1315e197ffb..efe4bd370b37 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -825,7 +825,7 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
 	hw.align_resource = mvebu_pcie_align_resource;
 	hw.add_bus        = mvebu_pcie_add_bus;
 
-	pci_common_init(&hw);
+	pci_common_init_dev(&pcie->pdev.dev, &hw);
 }
 
 /*


	Arnd
