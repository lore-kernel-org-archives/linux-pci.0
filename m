Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Sep 2016 09:52:59 -0500
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, hch@infradead.org,
        Joao.Pinto@synopsys.com, mingkai.hu@nxp.com, m-karicheri2@ti.com,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joao Pinto <jpinto@synopsys.com>, nsekhar@ti.com
Subject: Re: [RFC PATCH 08/11] pci: controller: dra7xx: Add EP mode support
Message-ID: <20160923145259.GA28285@rob-hp-laptop>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-9-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473829927-20466-9-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 10:42:04AM +0530, Kishon Vijay Abraham I wrote:
> The PCIe controller integrated in dra7xx SoCs is capable of operating
> in endpoint mode. Add support for dra7xx SoCs to operate in endpoint
> mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |   30 ++-
>  drivers/pci/controller/Kconfig                   |   21 +++
>  drivers/pci/controller/pci-dra7xx.c              |  211 +++++++++++++++++++---
>  3 files changed, 225 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 60e2516..b0e76f6 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -1,17 +1,22 @@
>  TI PCI Controllers
>  
>  PCIe Designware Controller
> - - compatible: Should be "ti,dra7-pcie""
> - - reg : Two register ranges as listed in the reg-names property
> - - reg-names : The first entry must be "ti-conf" for the TI specific registers
> -	       The second entry must be "rc-dbics" for the designware pcie
> -	       registers
> -	       The third entry must be "config" for the PCIe configuration space
> + - compatible: Should be "ti,dra7-pcie" for RC
> +	       Should be "ti,dra7-pcie-ep" for EP
>   - phys : list of PHY specifiers (used by generic PHY framework)
>   - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
>  	       number of PHYs as specified in *phys* property.
>   - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
>  	       where <X> is the instance number of the pcie from the HW spec.
> + - num-lanes as specified in ../designware-pcie.txt
> +
> +HOST MODE
> +=========
> + - reg : Two register ranges as listed in the reg-names property
> + - reg-names : The first entry must be "ti-conf" for the TI specific registers
> +	       The second entry must be "rc-dbics" for the designware pcie
> +	       registers
> +	       The third entry must be "config" for the PCIe configuration space
>   - interrupts : Two interrupt entries must be specified. The first one is for
>  		main interrupt line and the second for MSI interrupt line.
>   - #address-cells,
> @@ -19,13 +24,24 @@ PCIe Designware Controller
>     #interrupt-cells,
>     device_type,
>     ranges,
> -   num-lanes,
>     interrupt-map-mask,
>     interrupt-map : as specified in ../designware-pcie.txt
>  
>  Optional Property:
>   - gpios : Should be added if a gpio line is required to drive PERST# line

Don't you need gpios as the input side of GPIO outputs in RC mode? Or 
for EP mode they are all handled by h/w?

>  
> +DEVICE MODE
> +===========
> + - reg : Two register ranges as listed in the reg-names property
> + - reg-names : "ti-conf" for the TI specific registers
> +	       "ep_dbics" for the standard configuration registers as
> +		they are locally accessed within the DIF CS space
> +	       "ep_dbics2" for the standard configuration registers as
> +		they are locally accessed within the DIF CS2 space
> + - interrupts : one interrupt entries must be specified for main interrupt.
> + - num-ib-windows : number of inbound address translation windows
> + - num-ob-windows : number of outbound address translation windows
> +
>  Example:
>  axi {
>  	compatible = "simple-bus";
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 8574828..4d70981 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -23,6 +23,27 @@ config PCI_DRA7XX_HOST
>  	 Enables support for the PCIe controller in the DRA7xx SoC to work in
>  	 host mode.
>  
> +config PCI_DRA7XX_EP
> +	bool "Endpoint Only Mode"
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	 Enables support for the PCIe controller in the DRA7xx SoC to work in
> +	 endpoint mode.
> +
> +config PCI_DRA7XX_HOST_EP

I'd make these 2 options just RC and EP depending on PCI_DRA7XX_HOST 
with RC option being default yes.


> +	bool "Both Host and Endpoint Mode"
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCI
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_HOST
> +	select PCIE_DW_EP
> +	help
> +	 Enables support for the PCIe controller in the DRA7xx SoC to work in
> +	 both endpoint mode and host mode. If the board has 2 PCIe ports and
> +	 one of them has to work in host mode and the other has to work in
> +	 EP mode then this option has to be enabled.
> +
>  endchoice
>  
>  endif
