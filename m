Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:33776 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdL2R5V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Dec 2017 12:57:21 -0500
Date: Fri, 29 Dec 2017 09:57:17 -0800
From: Tony Lindgren <tony@atomide.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v12 1/5] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
Message-ID: <20171229175717.GL3875@atomide.com>
References: <20171226020806.32710-1-jeffy.chen@rock-chips.com>
 <20171226020806.32710-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171226020806.32710-2-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Jeffy Chen <jeffy.chen@rock-chips.com> [171226 02:11]:
> We are going to handle PCIe WAKE# pin for PCI devices in the pci core,
> so add definitions of the optional PCIe WAKE# pin for PCI devices.
> 
> Also add an definition of the optional PCI interrupt pin for PCI
> devices to distinguish it from the PCIe WAKE# pin.

> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -24,3 +24,13 @@ driver implementation may support the following properties:
>     unsupported link speed, for instance, trying to do training for
>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>     for gen2, and '1' for gen1. Any other values are invalid.
> +
> +PCI devices may support the following properties:

This should say PCI ports instead of PCI devices.

> +- interrupts: Interrupt specifier for each name in interrupt-names.
> +- interrupt-names:
> +    May contain "wakeup" for PCIe WAKE# interrupt and "pci" for PCI interrupt.
> +    The PCI devices may optionally include an 'interrupts' property that
> +    represents the legacy PCI interrupt. And when we try to specify the PCIe
> +    WAKE# pin, a corresponding 'interrupt-names' property is required to
> +    distinguish them.
> -- 
> 2.11.0
> 
> 
