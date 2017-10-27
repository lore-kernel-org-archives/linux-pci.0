Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Oct 2017 19:33:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v8 1/7] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
Message-ID: <20171027023331.GA11665@google.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171026132840.20946-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 26, 2017 at 09:28:34PM +0800, Jeffy Chen wrote:
> Add optional interrupts for PCIe WAKE# pin and PCI interrupt pin.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v8:
> Add optional "pci", and rewrite commit message.
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> Move to pci.txt
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index c77981c5dd18..faed405811cd 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -24,3 +24,6 @@ driver implementation may support the following properties:
>     unsupported link speed, for instance, trying to do training for
>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>     for gen2, and '1' for gen1. Any other values are invalid.
> +- interrupts: Interrupt specifier for each name in interrupt-names.
> +- interrupt-names: May contains "wakeup" for PCIe WAKE# interrupt and "pci"
> +  for PCI interrupt.

Similar criticism to what Rob made on patch 4: this file already says "a
host bridge driver implementation may support the following properties",
so this property is clearly not for child devices. And so having the
"PCI interrupt" here doesn't make much sense.

Similarly, you're documenting "wakeup" here as a host bridge property,
but then patch 7 is adding per-device support it seems? That seems
wrong.

In fact, I'm pretty sure this series fails to actually look in the host
bridge for the "wakeup" interrupt at all! Did you actually test this?

And again, describing your intentions a little better in the commit
message would make this clearer. Then we could tell which way you
intended this to work...

Brian
