Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Apr 2015 16:42:27 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>, Feng Kan <fkan@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Loc Ho <lho@apm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH v5 3/4] documentation: dts: Add the device tree binding
 for APM X-Gene v1 PCIe MSI device tree node
Message-ID: <20150421154225.GC10164@leverpostej>
References: <55310050.7000003@arm.com>
 <cover.1429586144.git.dhdang@apm.com>
 <cfdb95a38689836bac693df6edb8c09829ea61cd.1429586144.git.dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cfdb95a38689836bac693df6edb8c09829ea61cd.1429586144.git.dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 21, 2015 at 05:04:23AM +0100, Duc Dang wrote:
> The driver for this binding is under 'drivers/pci/host/pci-xgene-msi.c'

Please provide a bit of description of what this device is, and please
place the binding patch _before_ the driver and DTS patches.

> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  .../devicetree/bindings/pci/xgene-pci-msi.txt      | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> new file mode 100644
> index 0000000..0ffdcb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> @@ -0,0 +1,63 @@
> +* AppliedMicro X-Gene PCIe MSI interface
> +
> +Required properties:
> +
> +- compatible: should contain "apm,xgene1-msi" to identify the core.

What does the core have to do with the MSI controller?

> +- msi-controller: indicates that this is X-Gene1 PCIe MSI controller node
> +- reg: A list of physical base address and length for each set of controller
> +       registers.

How many? Which ones? In which order? Do you need reg-names?

> +- interrupts: A list of interrupt outputs of the controller.

How many? Which ones? In which order? Do you need interrupt-names?

You need to define these for *this particular binding*, in order for
them to actually define the contract. An abstract definition is
completely useless for writing or parsing a DT, and as such this
document is just noise.

Please think about the purpose of this document, and write something
appropriate.

[...]

> +		interrupts = <  0x0 0x10 0x4
> +				0x0 0x11 0x4
> +				0x0 0x12 0x4
> +				0x0 0x13 0x4
> +				0x0 0x14 0x4
> +				0x0 0x15 0x4
> +				0x0 0x16 0x4
> +				0x0 0x17 0x4
> +				0x0 0x18 0x4
> +				0x0 0x19 0x4
> +				0x0 0x1a 0x4
> +				0x0 0x1b 0x4
> +				0x0 0x1c 0x4
> +				0x0 0x1d 0x4
> +				0x0 0x1e 0x4
> +				0x0 0x1f 0x4>;

Nit: please bracket list entries individually.

Mark.
