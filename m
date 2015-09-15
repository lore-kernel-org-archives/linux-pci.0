Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52382 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbbIOSkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 14:40:03 -0400
Date: Tue, 15 Sep 2015 19:40:03 +0100
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] PCI: generic: Add support for Cavium ThunderX PCIe root
 complexes.
Message-ID: <20150915184003.GS31157@arm.com>
References: <1442016439-7636-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442016439-7636-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 12, 2015 at 01:07:19AM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The config space for external PCIe root complexes on some Cavium
> ThunderX SoCs is very similar to CAM and ECAM, but differs in the
> shift values that have to be applied to the bus and devfn numbers to
> compose that address window offset.  These root complexes also have
> the interesting property that there is no root bridge, so the standard
> manner of limiting scanning to only the first device doesn't work.  We
> can use the standard pci-host-generic driver if we make a minor
> addition to handle these differences, so we...
> 
> Add a mapping function for ThunderX PCIe root complexes with a bus
> shift of 24 and devfn shift of 16.  Ignore accesses for devices other
> than the first device on the primary bus.
> 
> Document the whole thing in devicetree/bindings/pci/host-generic-pci.txt
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> 
> This patch depends on the set I recently sent:
> https://lkml.org/lkml/2015/9/11/764
> 
>  .../devicetree/bindings/pci/host-generic-pci.txt   |  5 +++-
>  drivers/pci/host/pci-host-generic.c                | 29 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index daa6942..51cc1d1 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -16,7 +16,10 @@ Properties of the host controller node:
>  
>  - compatible     : Must be "pci-host-cam-generic" or "pci-host-ecam-generic"
>                     depending on the layout of configuration space (CAM vs
> -                   ECAM respectively).
> +                   ECAM respectively). Also supported is
> +                   "cavium,pci-host-thunder-pem" which has bus:devfn:reg in
> +                   bits 24:16:0 respectively of the PCI config space address
> +                   window.

It's probably easier to read and maintain if we reword this as a list of
property + comment rather than continue the freeform text.

Other than that, I'm fine with special-casing your accessors if need-be.

Will
