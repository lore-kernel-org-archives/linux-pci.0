Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752613AbdHVTJn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 15:09:43 -0400
Date: Tue, 22 Aug 2017 14:09:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] PCI: v3: Update the device tree bindings
Message-ID: <20170822190940.GD6948@bhelgaas-glaptop.roam.corp.google.com>
References: <20170809141455.22220-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170809141455.22220-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 09, 2017 at 04:14:54PM +0200, Linus Walleij wrote:
> The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
> and predates the more formal format we have adopted for the bindings.
> Update them a bit so it is easier to read, and add the Integrator AP-
> specific compatible so we can detect that we are running on that specific
> platform.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Added Rob's ACK.
> 
> Bjorn: please merge this when you feel confident with it.
> ---
>  .../devicetree/bindings/pci/v3-v360epc-pci.txt        | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> index 30b364e504ba..bcc5fe2a74cb 100644
> --- a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> @@ -2,14 +2,15 @@ V3 Semiconductor V360 EPC PCI bridge
>  
>  This bridge is found in the ARM Integrator/AP (Application Platform)
>  
> -Integrator-specific notes:
> -
> -- syscon: should contain a link to the syscon device node (since
> -  on the Integrator, some registers in the syscon are required to
> -  operate the V3).
> -
> -V360 EPC specific notes:
> -
> -- reg: should contain the base address of the V3 adapter.
> +Required properties:
> +- compatible: should be one of:
> +  "v3,v360epc-pci"
> +  "arm,integrator-ap-pci", "v3,v360epc-pci"
> +- reg: should contain the base address of the V3 host bridge.

Does this need some sort of comment about how the non-pref and pref mem
windows need to be 256Mb and adjacent?  I think the driver makes some
unverified assumptions about them.

>  - interrupts: should contain a reference to the V3 error interrupt
>    as routed on the system.
> +
> +Integrator-specific required properties:
> +- syscon: should contain a link to the syscon device node, since
> +  on the Integrator, some registers in the syscon are required to
> +  operate the V3 host bridge.
> -- 
> 2.9.4
> 
