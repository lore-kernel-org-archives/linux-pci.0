Return-Path: <SRS0=rgPv=7R=verge.net.au=horms@kernel.org>
Return-Path: <SRS0=rgPv=7R=verge.net.au=horms@kernel.org>
Date: Tue, 15 Aug 2017 17:56:35 +0200
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: rcar-pcie: Fix memory leak
Message-ID: <20170815155634.GA21763@verge.net.au>
References: <20170804033255.27171-1-harunobu.kurokawa.dn@renesas.com>
 <20170814211114.GH32525@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814211114.GH32525@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 14, 2017 at 04:11:14PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 04, 2017 at 12:32:53PM +0900, Harunobu Kurokawa wrote:
> > When no PCIe card is inserted, there is a memory leak as
> > pci_free_resource_list is not called before returning.
> > 
> > v2:
> >  separate the patch to two files.
> > 
> > Harunobu Kurokawa (1):
> >   PCI: rcar-pcie: Fix memory leak when no PCIe card is inserted
> > 
> > Lorenzo Pieralisi (1):
> >   PCI: rcar: Fix error exit path
> > 
> >  drivers/pci/host/pcie-rcar.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Waiting for Simon's ack...

Acked-by: Simon Horman <horms+renesas@verge.net.au>
