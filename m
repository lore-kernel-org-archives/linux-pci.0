Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753783AbeFDOSK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 10:18:10 -0400
MIME-Version: 1.0
In-Reply-To: <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com> <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Jun 2018 09:17:49 -0500
Message-ID: <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
Subject: Re: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
To: Ray Jui <ray.jui@broadcom.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+Arnd

On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> Update the iProc PCIe binding document for better modeling of the legacy
> interrupt (INTx) support
>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> index b8e48b4..7ea24dc 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> @@ -13,9 +13,6 @@ controller, used in Stingray
>    PAXB-based root complex is used for external endpoint devices. PAXC-based
>  root complex is connected to emulated endpoint devices internal to the ASIC
>  - reg: base address and length of the PCIe controller I/O register space
> -- #interrupt-cells: set to <1>
> -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> -  mapping of the PCIe interface to interrupt numbers
>  - linux,pci-domain: PCI domain ID. Should be unique for each host controller
>  - bus-range: PCI bus numbers covered
>  - #address-cells: set to <3>
> @@ -41,6 +38,16 @@ Required:
>  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
>  address used by the iProc PCIe core (not the PCIe address)
>
> +Legacy interrupt (INTx) support (optional):
> +
> +Note INTx is for PAXB only.
> +
> +- interrupt-controller: claims itself as an interrupt controller for INTx
> +- #interrupt-cells: set to <1>
> +- interrupt-map-mask and interrupt-map, standard PCI properties to define
> +the mapping of the PCIe interface to interrupt numbers
> +- interrupts: interrupt line wired to the generic GIC for INTx support
> +
>  MSI support (optional):
>
>  For older platforms without MSI integrated in the GIC, iProc PCIe core provides
> @@ -77,9 +84,14 @@ Example:
>                 compatible = "brcm,iproc-pcie";
>                 reg = <0x18012000 0x1000>;
>
> +               interrupt-controller;
>                 #interrupt-cells = <1>;
> -               interrupt-map-mask = <0 0 0 0>;
> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0 0 0 1 &pcie0 1>,

Are you sure this works? The irq parsing code will ignore
interrupt-map if interrupt-controller is found. In other words, you
should have one or the other, but not both.

Maybe it happens to work because "pcie0" is this node and your irq
numbers are the same.

Arnd, any thoughts on this?

> +                               <0 0 0 2 &pcie0 2>,
> +                               <0 0 0 3 &pcie0 3>,
> +                               <0 0 0 4 &pcie0 4>;
> +               interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
>
>                 linux,pci-domain = <0>;
>
> @@ -115,9 +127,14 @@ Example:
>                 compatible = "brcm,iproc-pcie";
>                 reg = <0x18013000 0x1000>;
>
> +               interrupt-controller;
>                 #interrupt-cells = <1>;
> -               interrupt-map-mask = <0 0 0 0>;
> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0 0 0 1 &pcie1 1>,
> +                               <0 0 0 2 &pcie1 2>,
> +                               <0 0 0 3 &pcie1 3>,
> +                               <0 0 0 4 &pcie1 4>;
> +               interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>
>                 linux,pci-domain = <1>;
>
> --
> 2.1.4
>
