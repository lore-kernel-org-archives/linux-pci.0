Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 2 Sep 2016 10:17:25 -0500
From: Rob Herring <robh@kernel.org>
To: Po Liu <po.liu@nxp.com>
Subject: Re: [PATCH v4 2/2] pci:aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Message-ID: <20160902151725.GA25273@rob-hp-laptop>
References: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <1472625442-23309-1-git-send-email-po.liu@nxp.com>
 <1472625442-23309-2-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
In-Reply-To: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Roy Zang <roy.zang@nxp.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stuart Yoder <stuart.yoder@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 31, 2016 at 02:37:22PM +0800, Po Liu wrote:
> On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> maybe there is interrupt line for aer pme etc. Search the interrupt
> number in the fdt file. Then fixup the dev->irq with it.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
> Changes for v4:
> 	- re-use the patch changes in the root port driver;
> 	- add binding information;
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |  4 +--
>  drivers/pci/pcie/portdrv_core.c                    | 31 +++++++++++++++++++---
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 41e9f55..1dfb1da 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -19,7 +19,7 @@ Required properties:
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
>  - interrupt-names: Must include the following entries:
> -  "intr": The interrupt that is asserted for controller interrupts
> +  "aer": The interrupt that is asserted for aer interrupts

You can't just change this. That breaks compatibility with old dts 
files. Plus, it is just a name. Why does it even matter? Not to mention 
having the name for a single irq is a bit pointless.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
