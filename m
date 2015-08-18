Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38664 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbbHRTWM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 15:22:12 -0400
MIME-Version: 1.0
In-Reply-To: <1439802579-22651-5-git-send-email-lftan@altera.com>
References: <1439802579-22651-1-git-send-email-lftan@altera.com>
	<1439802579-22651-5-git-send-email-lftan@altera.com>
Date: Tue, 18 Aug 2015 14:22:11 -0500
Message-ID: <CADhT+wdwYQWq=yiw1R9YEXX=WTDtoj-5=6EysX=aHUjdSvU89w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Documentation: dt-bindings: pci: altera pcie
 device tree binding
From: Dinh Nguyen <dinh.linux@gmail.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Linux List <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 4:09 AM, Ley Foon Tan <lftan@altera.com> wrote:
> This patch adds the bindings for Altera PCIe host controller driver and
> Altera PCIe MSI driver.
>
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  .../devicetree/bindings/pci/altera-pcie-msi.txt    | 27 ++++++++++++
>  .../devicetree/bindings/pci/altera-pcie.txt        | 49 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt b/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
> new file mode 100644
> index 0000000..7f330c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
> @@ -0,0 +1,27 @@
> +* Altera PCIe MSI controller
> +
> +Required properties:
> +- compatible:  should contain "altr,msi-1.0"
> +- reg:         specifies the physical base address of the controller and
> +               the length of the memory mapped region.
> +- reg-names:   Must include the following entries:
> +               "csr": CSR registers
> +               "vector_slave": vectors region

Can you be a little bit more specific here? What is a vectors region?
Also, I'm not 100% sure, but I think "vector-slave" should be used.

> +-interrupts:   specifies the interrupt source of the parent interrupt
> +               controller. The format of the interrupt specifier depends on the
> +               parent interrupt controller.

Need to document "interrupt-parent" .

> +- num-vectors: Number of vectors, range 1 to 32.
> +- msi-controller:      indicates that this is MSI controller node
> +
> +
> +Example
> +msi0: msi@0xFF200000 {
> +       compatible = "altr,msi-1.0";
> +       reg = <0xFF200000 0x00000010
> +               0xFF200010 0x00000080>;
> +       reg-names = "csr", "vector_slave";
> +       interrupt-parent = <&hps_0_arm_gic_0>;
> +       interrupts = <0 42 4>;
> +       msi-controller = <1>;
> +       num-vectors = <32>;
> +};
> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> new file mode 100644
> index 0000000..73a8dc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> @@ -0,0 +1,49 @@
> +* Altera PCIe controller
> +
> +Required properties:
> +- compatible : should contain "altr,pcie-root-port-1.0"
> +- reg:         A list of physical base address and length for TXS and CRA.
> +- reg-names:   Must include the following entries:
> +               "Txs" or "txs": TXS region

What is a TXS region?

> +               "Cra" or "cra": Control register access region
> +-interrupts:   specifies the interrupt source of the parent interrupt controller.
> +               The format of the interrupt specifier depends on the parent interrupt
> +               controller.
> +- device_type: must be "pci"
> +- #address-cells:      set to <3>
> +- #size-cells: set to <2>
> +- #interrupt-cells:    set to <1>
> +- ranges:              Describes the translation of addresses for root ports and standard
> +               PCI regions.
> +- interrupt-map-mask and interrupt-map: standard PCI properties
> +       to define the mapping of the PCIe interface to interrupt
> +       numbers.

"interrupt-parent" ?

Dinh
