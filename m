Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53142 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791AbbLWAnT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Dec 2015 19:43:19 -0500
Date: Tue, 22 Dec 2015 18:43:12 -0600
From: Rob Herring <robh@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] pci, pcie-thunder-pem: Add PCIe host driver for
 ThunderX processors.
Message-ID: <20151223004312.GA23676@rob-hp-laptop>
References: <1450749222-15966-1-git-send-email-ddaney.cavm@gmail.com>
 <1450749222-15966-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450749222-15966-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 21, 2015 at 05:53:42PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Some Cavium ThunderX processors require quirky access methods for the
> config space of the PCIe bridge.  Add a driver to provide these config
> space accessor functions.  The pci-host-generic driver code is used to
> configure the PCI machinery.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/pci/pcie-thunder-pem.txt   |  43 ++++
>  drivers/pci/host/Kconfig                           |   6 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-thunder-pem.c                | 283 +++++++++++++++++++++
>  4 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-thunder-pem.txt
>  create mode 100644 drivers/pci/host/pcie-thunder-pem.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/pcie-thunder-pem.txt b/Documentation/devicetree/bindings/pci/pcie-thunder-pem.txt
> new file mode 100644
> index 0000000..66824d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pcie-thunder-pem.txt
> @@ -0,0 +1,43 @@
> +* ThunderX PEM PCIe host controller
> +
> +Firmware-initialized PCIe host controller found on some Cavium
> +ThunderX processors.
> +
> +The properties and their meanings are identical to those described in
> +host-heneric-pci.txt except as listed below.

s/heneric/generic/

> +
> +Properties of the host controller node that differ from
> +host-heneric-pci.txt:

ditto

> +
> +- compatible     : Must be "cavium,pci-host-thunder-pem"

pcie rather than pci?


> +
> +- reg            : Two entries: First the configuration space for down
> +                   stream devices base address and size, as accessed
> +                   from the parent bus. Second, the register bank of
> +                   the PEM device PCIe bridge.
> +
> +Example:
> +
> +    pem2 {

pcie-controller@...

> +	compatible = "cavium,pci-host-thunder-pem";
> +	device_type = "pci";
> +	msi-parent = <&its>;
> +	msi-map = <0 &its 0x10000 0x10000>;
> +	bus-range = <0x8f 0xc7>;
> +	#size-cells = <2>;
> +	#address-cells = <3>;
> +
> +	reg = <0x8880 0x8f000000 0x0 0x39000000>,  /* Configuration space */
> +	      <0x87e0 0xc2000000 0x0 0x00010000>; /* PEM space */
> +	ranges = <0x01000000 0x00 0x00020000 0x88b0 0x00020000 0x00 0x00010000>, /* I/O */
> +		 <0x03000000 0x00 0x10000000 0x8890 0x10000000 0x0f 0xf0000000>, /* mem64 */
> +		 <0x43000000 0x10 0x00000000 0x88a0 0x00000000 0x10 0x00000000>, /* mem64-pref */
> +		 <0x03000000 0x87e0 0xc2f00000 0x87e0 0xc2000000 0x00 0x00100000>; /* mem64 PEM BAR4 */
> +
> +	#interrupt-cells = <1>;
> +	interrupt-map-mask = <0 0 0 7>;
> +	interrupt-map = <0 0 0 1 &gic0 0 0 0 24 4>, /* INTA */
> +			<0 0 0 2 &gic0 0 0 0 25 4>, /* INTB */
> +			<0 0 0 3 &gic0 0 0 0 26 4>, /* INTC */
> +			<0 0 0 4 &gic0 0 0 0 27 4>; /* INTD */
> +    };

