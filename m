Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 15 Mar 2018 17:43:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
Message-ID: <20180315174329.GB22176@e107981-ln.cambridge.arm.com>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 03:41:49PM +0800, Ryder Lee wrote:
> A root complex usually consist of a host bridge and multiple P2P bridges,
> and someone may express that in the form of a root node with many subnodes
> and list all four interrupts for each slot (child node) in the root node
> like this:
> 
> 	pcie-controller {
> 		...
> 		interrupt-map-mask = <0xf800 0 0 7>;
> 		interrupt-map = <0x0000 0 0 {INTx} &{interrupt parent} ...>
> 				 0x0800 0 0 {INTx} &{interrupt parent} ...>;
> 
> 		pcie@0,0 {
> 			reg = <0x0000 0 0 0 0>;
> 			...
> 		};
> 
> 		pcie@1,0 {
> 			reg = <0x0800 0 0 0 0>;
> 			...
> 		};
> 	};
> 
> As shown above, we'd like to propagate IRQs from a root port to the devices
> in the hierarchy below it in this way.  However, it seems that the current
> parser couldn't handle such cases and will get something unexpected below:
> 
> 	pcieport 0000:00:01.0: assign IRQ: got 213
> 	igb 0000:01:00.0: assign IRQ: got 212
> 
> There is a device which is connected to 2nd slot, but the port doesn't share
> the same IRQ with its downstream devices.  The problem here is that, if the
> loop found a P2P bridge, it wouldn't check whether the reg property exists
> in ppnode or not but just pass the subordinate devfn to of_irq_parse_raw(),
> thus the subsequent flow couldn't correctly resolve them.
> 
> Fix this by adding a check to fallback to standard device tree parsing.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Please refer to the previous discussion thread: https://patchwork.ozlabs.org/patch/829108/
> ---
>  drivers/of/of_pci_irq.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Hi Ryder,

from the thread discussion I gather I can drop this series from the PCI
queue and you will update the DT as agreed with Ben, that looks like
the most reasonable solution to the problem you are facing, please
let me know if there is anything I am missing.

Thanks,
Lorenzo

> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> index 3a05568..e445866 100644
> --- a/drivers/of/of_pci_irq.c
> +++ b/drivers/of/of_pci_irq.c
> @@ -86,8 +86,18 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
>  	out_irq->np = ppnode;
>  	out_irq->args_count = 1;
>  	out_irq->args[0] = pin;
> -	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
> -	laddr[1] = laddr[2] = cpu_to_be32(0);
> +
> +	if (!dn && ppnode) {
> +		const __be32 *addr;
> +
> +		addr = of_get_property(ppnode, "reg", NULL);
> +		if (addr)
> +			memcpy(laddr, addr, 3);
> +	} else {
> +		laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
> +		laddr[1] = laddr[2] = cpu_to_be32(0);
> +	}
> +
>  	rc = of_irq_parse_raw(laddr, out_irq);
>  	if (rc)
>  		goto err;
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
