Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us-smtp-delivery-107.mimecast.com ([216.205.24.107]:59954 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751577AbdIHLOC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2017 07:14:02 -0400
Subject: Re: [PATCH 1/2 v3] PCI: v3: Update the device tree bindings
To: Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20170907114431.4748-1-linus.walleij@linaro.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <7e98a151-0489-61bd-ec8d-a0bc7014cc59@sigmadesigns.com>
Date: Fri, 8 Sep 2017 13:12:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170907114431.4748-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/09/2017 13:44, Linus Walleij wrote:

> The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
> and predates the more formal format we have adopted for the bindings.
> 
> Update them a bit so it is easier to read, and add the Integrator AP-
> specific compatible so we can detect that we are running on that specific
> platform.
> 
> Add a second register bank for the configuration memory area. The
> device tree specs does specify a memory range for configuration
> space but it is not applicable to custom accessors like this. Instead
> follow the pattern from the Versatile PCI adapter and simply add
> a second register bank for this memory.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Add a second register bank for the config space.
> - Mention that nonpre and pre memory must be 256MB and adjacent
> - Make the prefetched and non-prefetched memory mapped 1:1 to
>    the PCI address space so that local bus 0x40000000 and
>    0x50000000 maps to the *same* local (CPU) bus addresses.
> - Add reference to dma-ranges and that this is required.
> - Add an example from the ARM Integrator/AP
> - Rob ACKed an earlier version, he might want to have a glance
>    at this before merging.
> ChangeLog v1->v2:
> - Added Rob's ACK.
> 
> Bjorn: please merge this when you feel confident with it.
> ---
>   .../devicetree/bindings/pci/v3-v360epc-pci.txt     | 73 +++++++++++++++++++---
>   1 file changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> index 30b364e504ba..7729295506f5 100644
> --- a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> @@ -2,14 +2,73 @@ V3 Semiconductor V360 EPC PCI bridge
>   
>   This bridge is found in the ARM Integrator/AP (Application Platform)
>   
> -Integrator-specific notes:
> +Required properties:
> +- compatible: should be one of:
> +  "v3,v360epc-pci"
> +  "arm,integrator-ap-pci", "v3,v360epc-pci"
> +- reg: should contain two register areas:
> +  first the base address of the V3 host bridge controller, 64KB
> +  second the configuration area register space, 16MB
> +- interrupts: should contain a reference to the V3 error interrupt
> +  as routed on the system.
> +- ranges: this follows the standard PCI bindings in the IEEE Std
> +  1275-1994 (see pci.txt) with the following restriction:
> +  - The non-prefetchable and prefetchable memory windows must
> +    each be exactly 256MB (0x10000000) in size.
> +  - The prefetchable memory window must be immediately adjacent
> +    to the non-prefetcable memory window
> +- dma-ranges: three ranges for the inbound memory region. The ranges must
> +  be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB,
> +  64MB, 128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked
> +  as pre-fetchable. Two ranges are supported by the hardware.

Hello Linus,

FWIW, I was told that the bus-range property is not optional,
despite what is written in
Documentation/devicetree/bindings/pci/host-generic-pci.txt

Regards.
