Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeHHTRi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Aug 2018 15:17:38 -0400
Date: Wed, 8 Aug 2018 17:57:00 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
Message-ID: <20180808165700.GB486@e107981-ln.cambridge.arm.com>
References: <20180724173150.2701-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180724173150.2701-1-vigneshr@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 24, 2018 at 11:01:46PM +0530, Vignesh R wrote:
> Make workaround for errata i870 applicable in Host mode as
> well(previously it was enabled only for EP mode) as per errata
> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
> 
> Tested on DRA72 EVM
> 
> Tony,
> 
> If you are okay with the series, could you pick this via omap tree?
> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
> rest of DTS changes.

I think we have missed the v4.19 merge window by now - please let me
know if I can drop this series from the PCI patch queue.

Thanks,
Lorenzo

> Regards
> Vignesh
> 
> 
> Changes since v2:
> Reorder patch 2 to appear at the last.
> Collect all the ACKs
> 
> Changes since v1:
> Drop IRQ handling rework (will be sent out separately)
> 
> v2: https://patchwork.ozlabs.org/cover/935454/
> v1: https://lkml.org/lkml/2017/12/1/59
> 
> 
> Vignesh R (4):
>   dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
>     mode
>   ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
>   ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
>   pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
>  arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
>  drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> -- 
> 2.18.0
> 
