Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 3 Aug 2017 17:45:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v2 5/5] dt-bindings: PCI: add support for new generation
 controller
Message-ID: <20170803224516.GO20308@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
 <06c9b3439431221794fc9f723fef52ff59be7ec6.1501122135.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <06c9b3439431221794fc9f723fef52ff59be7ec6.1501122135.git.honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, yong.wu@mediatek.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 robh@kerenl.org, linux-mediatek@lists.infradead.org, xinping.qian@mediatek.com,
 bhelgaas@google.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 27, 2017 at 10:58:39AM +0800, honghui.zhang@mediatek.com wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> Add support for MediaTek new generation controller and update related
> properities.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie.txt      | 168 ++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index a968f25..179329b 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> @@ -3,18 +3,31 @@ MediaTek Gen2 PCIe controller
>  Required properties:
>  - compatible: Should contain one of the following string:
>  	"mediatek,mt2701-pcie"
> +	"mediatek,mt2712-pcie"
> +	"mediatek,mt7622-pcie"
>  	"mediatek,mt7623-pcie"
>  - device_type: Must be "pci"
> -- reg: Base addresses and lengths of the PCIe controller.
> +- reg: Base addresses and lengths of the PICe subsys and root ports.

s/PICe/PCIe/

> +- reg-names: Names of the above areas to use during resource look-up.
>  - #address-cells: Address representation for root ports (must be 3)
>  - #size-cells: Size representation for root ports (must be 2)
>  - clocks: Must contain an entry for each entry in clock-names.
>    See ../clocks/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -  - free_ck :for reference clock of PCIe subsys
> -  - sys_ck0 :for clock of Port0
> -  - sys_ck1 :for clock of Port1
> -  - sys_ck2 :for clock of Port2
> +- clock-names:
> +  Mandatory entries:
> +   - sys_ckN :transaction layer and data link layer clock
> +  Required entries for MT2701/MT7623:
> +   - free_ck :for reference clock of PCIe subsys
> +  Required entries for MT2712/MT7622:
> +   - ahb_ckN :AHB slave interface operating clock for CSR access and RC
> +	      initiated MMIO access
> +  Required entries for MT7622:
> +   - axi_ckN :application layer MMIO channel operating clock
> +   - aux_ckN :pe2_mac_bridge and pe2_mac_core operating clock when
> +	      pcie_mac_ck/pcie_pipe_ck is turned off
> +   - obff_ckN :OBFF functional block operating clock
> +   - pipe_ckN :LTSSM and phy/mac layer operating clock

s/phy/PHY/
s/mac/MAC/

> +  where N starting from 0 to the maximum number of root ports.

Probably to "one less than the number of root ports"?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
