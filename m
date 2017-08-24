Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 24 Aug 2017 06:55:11 -0400
From: Simon Horman <horms@verge.net.au>
To: Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH ] PCI: rcar: Add r8a7743/5 support
Message-ID: <20170824105511.GE27788@verge.net.au>
References: <1503567344-5610-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1503567344-5610-1-git-send-email-biju.das@bp.renesas.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Chris Paterson <chris.paterson2@renesas.com>, linux-pci@vger.kernel.org,
 Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 24, 2017 at 10:35:44AM +0100, Biju Das wrote:
> Add internal PCI bridge support for r8a7743/5 SoC. Renesas RZ/G1[ME]
> (R8A7743/5) internal PCI bridge is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> This patch is tested against Linux next tag next-20170824 and
> renesas-dev branch renesas-devel-20170822-v4.13-rc6. 
> 
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index 07a7509..3d03863 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -6,11 +6,14 @@ AHB. There is one bridge instance per USB port connected to the internal
>  OHCI and EHCI controllers.
>  
>  Required properties:
> -- compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> +- compatible: "renesas,pci-r8a7743" for the R8A7743 SoC;
> +	      "renesas,pci-r8a7745" for the R8A7745 SoC;
> +	      "renesas,pci-r8a7790" for the R8A7790 SoC;
>  	      "renesas,pci-r8a7791" for the R8A7791 SoC;
>  	      "renesas,pci-r8a7793" for the R8A7793 SoC;
>  	      "renesas,pci-r8a7794" for the R8A7794 SoC;
> -	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 compatible device
> +	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 or
> +				      RZ/G1 compatible device.
>  
>  
>  	      When compatible with the generic version, nodes must list the
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
