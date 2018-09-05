Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 5 Sep 2018 12:21:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: add UniPhier PCIe host controller
 description
Message-ID: <20180905172118.GN107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1536114731-28630-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1536114731-28630-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1536114731-28630-2-git-send-email-hayashi.kunihiko@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Please follow the capitalization convention, i.e.,

  $ git log --oneline --no-merges Documentaon/devicetree/bindings/pci/ | grep -i pci
  82dfbd27c837 dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
  92f9ccca4c08 PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver DT bindings
  71918e24cb49 dt-bindings: PCI: designware: Add support for EP in DesignWare driver
  467c7a737642 dt-bindings: PCI: designware: Example update
  1dca7a636933 dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe EP driver
  2ca25bd7472f dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to rockchip-pcie-host.txt

On Wed, Sep 05, 2018 at 11:32:10AM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> configured in Root Complex (host) mode. This controller is based on
> the Designware PCIe Core.

s/Designware/DesignWare/
s/Core/core/

> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/pci/uniphier-pcie.txt      | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> new file mode 100644
> index 0000000..ea63f78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> @@ -0,0 +1,78 @@
> +Socionext UniPhier PCI-express host controller bindings

s/PCI-express/PCIe/ (also in other occurrences below)

> +
> +This describes the devicetree bindings for PCI-express host controller
> +implemented on Socionext UniPhier SoCs.
> +
> +UniPhier PCI-express host controller is based on the Synopsys DesignWare
> +PCI core. It shares common functions with the PCIe DesignWare core driver
> +and inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
