Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 28 Jun 2018 08:07:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
Message-ID: <20180628130737.GA90450@bhelgaas-glaptop.roam.corp.google.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
 <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, lorenzo.pieralisi@arm.com, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, bhelgaas@google.com, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2018 at 05:21:35PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Mediatek's host controller have two slots, each have it's own control
> registers. The host driver need to identify which slot was connected
> in order to access the device's configuration space. There's problem
> for current host driver to find out which slot was connected to for
> a given EP device.

  The Mediatek host controller has two slots, each with its own control
  registers.

> Assuming each slot have connect with one EP device as below:
> 
>                 host bridge
>   bus 0 --> __________|_______
>            |                  |
>            |                  |
>          slot 0             slot 1
>   bus 1 -->|        bus 2 --> |
>            |                  |
>          EP 0               EP 1
> 
> While PCI emulation, system software will scan all the PCI device

s/While PCI emulation/During PCI enumeration/

> starting from devfn 0. So it will get the proper port for slot0 and
> slot1 device when using PCI_SLOT(devfn) for match. But it will get
> the wrong slot for EP1: The devfn will be start from 0 when scanning
> EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> for port0's slot value. So the host driver should not using EP's devfn
> but the slot's devfn(the slot which EP was connected to) for match.
> 
> This patch fix the mtk_pcie_find_port's logical by using the slot's
> devfn for match.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 0baabe3..9cf7ecf 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -337,10 +337,23 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
>  {
>  	struct mtk_pcie *pcie = bus->sysdata;
>  	struct mtk_pcie_port *port;
> +	struct pci_dev *dev;
> +	struct pci_bus *pbus;
>  
> -	list_for_each_entry(port, &pcie->ports, list)
> -		if (port->slot == PCI_SLOT(devfn))
> +	list_for_each_entry(port, &pcie->ports, list) {

mvebu has the identical hardware structure but uses an array instead
of a list:

  num = of_get_available_child_count(np);
  pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
  for_each_available_child_of_node(np, child) {
    struct mvebu_pcie_port *port = &pcie->ports[i];
    mvebu_pcie_parse_port(pcie, port, child);
  }

It would be nice if mvebu and mtk used the same strategy so the code
looks the same.

> +		if (bus->number == 0 && port->slot == PCI_SLOT(devfn)) {

Is the root bus number fixed at 0 or is it programmable?  Many drivers
do something like this:

  if (bus->number == pcie->root_bus_nr)

to handle the case of the root bus number being programmable.

>  			return port;
> +		} else if (bus->number != 0) {
> +			pbus = bus;
> +			do {
> +				dev = pbus->self;
> +				if (port->slot == PCI_SLOT(dev->devfn))
> +					return port;
> +
> +				pbus = dev->bus;
> +			} while (dev->bus->number != 0);

You should not need to search up the tree of dev->bus->self.

mvebu_pcie_find_port() checks the root port secondary and subordinate
bus numbers, which should work here, too.

> +		}
> +	}
>  
>  	return NULL;
>  }
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
