Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v1 3/3] PCI: xilinx: Rename xilinx_pcie_link_is_up() to
 xilinx_pcie_link_up()
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171113224058.29024.51914.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <d5d907e1-8ee0-763c-63b9-b1f2b30b7a3a@xilinx.com>
Date: Tue, 14 Nov 2017 08:17:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171113224058.29024.51914.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, rfi@lists.rocketboards.org,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Ley Foon Tan <lftan@altera.com>, linux-arm-kernel@lists.infradead.org,
 Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 13.11.2017 23:40, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename xilinx_pcie_link_is_up() to xilinx_pcie_link_up() to follow the
> convention of other drivers.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-xilinx.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 94e13cb8608f..7b5325990f5e 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -129,7 +129,7 @@ static inline void pcie_write(struct xilinx_pcie_port *port, u32 val, u32 reg)
>  	writel(val, port->reg_base + reg);
>  }
>  
> -static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *port)
> +static inline bool xilinx_pcie_link_up(struct xilinx_pcie_port *port)
>  {
>  	return (pcie_read(port, XILINX_PCIE_REG_PSCR) &
>  		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
> @@ -165,7 +165,7 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>  
>  	/* Check if link is up when trying to access downstream ports */
>  	if (bus->number != port->root_busno)
> -		if (!xilinx_pcie_link_is_up(port))
> +		if (!xilinx_pcie_link_up(port))
>  			return false;
>  
>  	/* Only one device down on each root port */
> @@ -541,7 +541,7 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
>  {
>  	struct device *dev = port->dev;
>  
> -	if (xilinx_pcie_link_is_up(port))
> +	if (xilinx_pcie_link_up(port))
>  		dev_info(dev, "PCIe Link is UP\n");
>  	else
>  		dev_info(dev, "PCIe Link is DOWN\n");
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
