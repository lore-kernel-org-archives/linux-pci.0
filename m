Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35269 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757273AbcEEWDh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 May 2016 18:03:37 -0400
Date: Thu, 5 May 2016 17:03:31 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: niklass@axis.com, jespern@axis.com, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: add DT binding for Axis ARTPEC-6
 PCIe controller
Message-ID: <20160505220331.GA9225@rob-hp-laptop>
References: <1462362857-27481-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462362857-27481-1-git-send-email-niklass@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 04, 2016 at 01:54:17PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> This commit adds the Device Tree binding documentation that allows to
> describe the PCIe controller found in the Axis ARTPEC-6 SoC.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> new file mode 100644
> index 0000000..fdac2a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> @@ -0,0 +1,45 @@
> +* Axis ARTPEC-6 PCIe interface
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.txt.
> +
> +Required properties:
> +- compatible: "axis,artpec6-pcie", "snps,dw-pcie"
> +- reg: base addresses and lengths of the pcie controller (DBI),
> +	the phy controller, and configuration address space.
> +- reg-names: Must include the following entries:
> +	- "dbi"
> +	- "phy"
> +	- "config"
> +- interrupts: A list of interrupt outputs of the controller. Must contain an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: Must include the following entries:
> +	- "msi": The interrupt that is asserted when an MSI is received
> +- syscon: Should contain a link to the syscon device node.

What is the syscon for? Perhaps a name that reflects the purpose.

Rob
