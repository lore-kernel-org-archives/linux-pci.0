Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 31 Jan 2018 10:02:43 -0600
Message-ID: <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
To: Ryder Lee <ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 1:41 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> A root complex usually consist of a host bridge and multiple P2P bridges,
> and someone may express that in the form of a root node with many subnodes
> and list all four interrupts for each slot (child node) in the root node
> like this:
>
>         pcie-controller {
>                 ...
>                 interrupt-map-mask = <0xf800 0 0 7>;
>                 interrupt-map = <0x0000 0 0 {INTx} &{interrupt parent} ...>
>                                  0x0800 0 0 {INTx} &{interrupt parent} ...>;
>
>                 pcie@0,0 {
>                         reg = <0x0000 0 0 0 0>;
>                         ...
>                 };
>
>                 pcie@1,0 {
>                         reg = <0x0800 0 0 0 0>;
>                         ...
>                 };
>         };
>
> As shown above, we'd like to propagate IRQs from a root port to the devices
> in the hierarchy below it in this way.  However, it seems that the current
> parser couldn't handle such cases and will get something unexpected below:
>
>         pcieport 0000:00:01.0: assign IRQ: got 213
>         igb 0000:01:00.0: assign IRQ: got 212
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
>
> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> index 3a05568..e445866 100644
> --- a/drivers/of/of_pci_irq.c
> +++ b/drivers/of/of_pci_irq.c
> @@ -86,8 +86,18 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
>         out_irq->np = ppnode;
>         out_irq->args_count = 1;
>         out_irq->args[0] = pin;
> -       laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
> -       laddr[1] = laddr[2] = cpu_to_be32(0);
> +
> +       if (!dn && ppnode) {

I would think whether you have a child device in DT or not is
irrelevant. If it's the bridge address you need to look at for
resolving interrupts, that would be true regardless.

> +               const __be32 *addr;
> +
> +               addr = of_get_property(ppnode, "reg", NULL);
> +               if (addr)
> +                       memcpy(laddr, addr, 3);

Can't you just adjust pdev to be ppdev in this case and then use the
existing code to set laddr?

Please copy the powerpc list on this. I worry that touching this
function will break something.

BTW, this code is moving to drivers/pci/ in 4.16.

> +       } else {
> +               laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
> +               laddr[1] = laddr[2] = cpu_to_be32(0);
> +       }
> +
>         rc = of_irq_parse_raw(laddr, out_irq);
>         if (rc)
>                 goto err;
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
