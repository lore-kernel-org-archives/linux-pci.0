Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Dec 2017 12:57:15 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: dra7xx: Add properties to
 enable x2 lane in dra7
Message-ID: <20171220185715.j5h7dlricom6kuiz@rob-hp-laptop>
References: <20171219085823.8695-1-kishon@ti.com>
 <20171219085823.8695-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219085823.8695-3-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 02:28:22PM +0530, Kishon Vijay Abraham I wrote:
> Add syscon properties required for configuring PCIe in x2 lane mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 82cb875e4cec..bfbc77ac7355 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -13,6 +13,12 @@ PCIe DesignWare Controller
>   - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
>  	       where <X> is the instance number of the pcie from the HW spec.
>   - num-lanes as specified in ../designware-pcie.txt
> + - ti,syscon-lane-conf : phandle/offset pair. Phandle to the system control
> +			 module and the register offset to specify 1 lane or
> +			 2 lane.
> + - ti,syscon-lane-sel : phandle/offset pair. Phandle to the system control
> +			module and the register offset to specify lane
> +			selection.

Adding a property for every syscon register doesn't really scale and 
doesn't work if the register layout changes.

Rob
