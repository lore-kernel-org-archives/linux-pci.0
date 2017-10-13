Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 13 Oct 2017 16:45:09 -0500
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH 2/4] dt-bindings: PCI: dra7xx: Add properties to enable
 x2 lane in dra7
Message-ID: <20171013214509.kqjx3gxudaysvnqg@rob-hp-laptop>
References: <20171010101606.15951-1-kishon@ti.com>
 <20171010101606.15951-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010101606.15951-3-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 10, 2017 at 03:46:04PM +0530, Kishon Vijay Abraham I wrote:
> Add syscon properties required for configuring PCIe in x2 lane mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 82cb875e4cec..455cb74a475c 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -13,6 +13,10 @@ PCIe DesignWare Controller
>   - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
>  	       where <X> is the instance number of the pcie from the HW spec.
>   - num-lanes as specified in ../designware-pcie.txt
> + - syscon-lane-conf : phandle/offset pair. Phandle to the system control module and the
> +   register offset to specify 1 lane or 2 lane.
> + - syscon-lane-sel : phandle/offset pair. Phandle to the system control module and the
> +   register offset to specify lane selection.

Needs vendor prefixes.

Rob
