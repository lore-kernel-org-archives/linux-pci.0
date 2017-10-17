Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 14:31:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Roger Quadros <rogerq@ti.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 0/2] phy: ti-pipe3: Update PCIe PHY settings
Message-ID: <20171017193129.GM5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171009090338.26033-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171009090338.26033-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 02:33:36PM +0530, Kishon Vijay Abraham I wrote:
> This was supposed to only update ti-pipe3 PHY registers. However because
> of the way the ti-pipe3 PHY, OCP2SCP and PCIe controller are connected
> in dra7xx where
> 
> PCIe controller --------------> ti-pipe3 PHY --------------> OCP2SCP
> 		  depends on		       depends on
> 
> updating ti-pipe3 PHY registers results in an abort.
> 
> Though the dependency between ti-pipe3 PHY and OCP2SCP is created
> (OCP2SCP is parent of ti-pipe3 PHY), and enabling ti-pipe3 PHY clocks
> should in turn enable OCP2SCP (with the help of pm_runtime framework),
> this doesn't work in no_irq stage since pm_runtime is disabled during
> no_irq stage. Since pci-dra7xx enables/initializes ti-pipe3 phy in
> no_irq stage, OCP2SCP is not enabled resulting in an abort with ti-pipe3
> PHY registers are accessed.
> 
> In order to solve this a functional dependency is created between
> PCIe and ti-pipe3 PHY so that PCIe is suspended before PHY/OCP2SCP
> and resumed after PCIe PHY/OCP2SCP
> 
> Kishon Vijay Abraham I (2):
>   PCI: dwc: dra7xx: Create functional dependency between PCIe and PHY

s/PCI: dwc: dra7xx: Create functional dependency between PCIe and PHY/
  PCI: dra7xx: Create functional dependency between PCIe and PHY/

Should these be merged together?  If it makes sense for you to merge them
together, here's my ack for the PCI piece:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Let me know if you'd like me to take one or both of them.

>   phy: ti-pipe3: Update pcie phy settings
> 
>  drivers/pci/dwc/pci-dra7xx.c  |  16 +++++++
>  drivers/phy/ti/phy-ti-pipe3.c | 101 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 116 insertions(+), 1 deletion(-)
> 
> -- 
> 2.11.0
> 
