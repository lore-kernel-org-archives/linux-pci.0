Return-Path: <SRS0=QnIk=DJ=verge.net.au=horms@kernel.org>
Return-Path: <SRS0=QnIk=DJ=verge.net.au=horms@kernel.org>
Date: Wed, 13 Dec 2017 09:29:34 +0100
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: rcar: Fix use-after-free in probe error path
Message-ID: <20171213082933.dpswh3x234bu4dhu@verge.net.au>
References: <1512641720-4715-1-git-send-email-geert+renesas@glider.be>
 <1512641720-4715-2-git-send-email-geert+renesas@glider.be>
 <20171212192942.GE53955@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212192942.GE53955@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 12, 2017 at 01:29:42PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 07, 2017 at 11:15:19AM +0100, Geert Uytterhoeven wrote:
> > If CONFIG_DEBUG_SLAB=y, and no PCIe card is inserted, the kernel crashes
> > during probe on r8a7791/koelsch:
> > 
> >     rcar-pcie fe000000.pcie: PCIe link down
> >     Unable to handle kernel paging request at virtual address 6b6b6b6b
> > 
> > (seeing this message requires earlycon and keep_bootcon).
> > 
> > Indeed, pci_free_host_bridge() frees the PCI host bridge, including the
> > embedded rcar_pcie object, so pci_free_resource_list() must not be
> > called afterwards.
> > 
> > To fix this, move the call to pci_free_resource_list() up, and update the
> > label name accordingly.
> > 
> > Fixes: ddd535f1ea3eb27e ("PCI: rcar: Fix memory leak when no PCIe card is inserted")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Applied with Simon's and Lorenzo's acks to for-linus for v4.15, thanks!
> 
> I'll leave the second patch up to Lorenzo for v4.16, since it doesn't seem
> as critical.

Thanks Bjorn, that's fine by me.
