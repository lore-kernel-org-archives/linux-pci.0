Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731982AbeHFX7j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 19:59:39 -0400
Date: Mon, 6 Aug 2018 16:48:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH] x86/PCI: Claim the resources of firmware enabled IOAPIC
 before children bus
Message-ID: <20180806214807.GE30691@bhelgaas-glaptop.roam.corp.google.com>
References: <20180724110144.16442-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180724110144.16442-1-jlee@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 24, 2018 at 07:01:44PM +0800, Lee, Chun-Yi wrote:
> I got a machine that the resource of firmware enabled IOAPIC conflicts
> with the resource of a children bus when the PCI host bus be hotplug.
> 
> [ 3182.243325] PCI host bridge to bus 0001:40
> [ 3182.243328] pci_bus 0001:40: root bus resource [io  0xc000-0xdfff window]
> [ 3182.243330] pci_bus 0001:40: root bus resource [mem 0xdc000000-0xebffffff window]
> [ 3182.243331] pci_bus 0001:40: root bus resource [mem 0x212400000000-0x2125ffffffff window]
> [ 3182.243334] pci_bus 0001:40: root bus resource [bus 40-7e]
> ...
> [ 3182.244737] pci 0001:40:05.4: [8086:6f2c] type 00 class 0x080020
> [ 3182.244746] pci 0001:40:05.4: reg 0x10: [mem 0xdc000000-0xdc000fff]
> ...
> [ 3182.246697] pci 0001:40:02.0: PCI bridge to [bus 41]
> [ 3182.246702] pci 0001:40:02.0:   bridge window [mem 0xdc000000-0xdc7fffff]
> ...
> pci 0001:40:05.4: can't claim BAR 0 [mem 0xdc000000-0xdc000fff]: address conflict with PCI Bus 0001:41 [mem 0xdc000000-0xdc7fffff]
> 
> The bus topology:
> 
>  +-[0001:40]-+-02.0-[41]--
>  |           +-03.0-[41]--
>  |           +-03.2-[41]--+-00.0  Intel Corporation I350 Gigabit Network Connection
>  |           |            +-00.1  Intel Corporation I350 Gigabit Network Connection
>  |           |            +-00.2  Intel Corporation I350 Gigabit Network Connection
>  |           |            \-00.3  Intel Corporation I350 Gigabit Network Connection
>  |           +-05.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management
>  |           +-05.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO Hot Plug
>  |           +-05.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO RAS/Control Status/Global Errors
>  |           \-05.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D I/O APIC
> 
> This problem causes that the NIC behine the child bus was not available
> after PCI host bridge hotpluged.
> 
> Kernel does not want to change resource of firmware enabled IOAPIC, but
> the priority of children bus's resources are higher than any other devices.
> So this conflict can not be handled by the reassigning logic of kernel.

I don't understand this paragraph.  AFAIK, if two devices on a bus
both decode the same address, as the IOAPIC and the bridge do here,
the only real "priority" in PCI would be subtractive decode.  But I
don't think that applies here since the bridge is using a positive
decode window.

I would expect that a read to the [mem 0xdc000000-0xdc000fff] range
would potentially receive two read completions, which would cause an
Unexpected Completion error.

Maybe you mean that we don't want to change the IOAPIC resources, but
it's OK if we move the bridge window, so in that sense, the IOAPIC is
"higher priority" than the bridge window?  This is the reverse of what
your paragraph seems to say.

> This patch claims the resources of firmware enabled IOAPIC before
> children bus. Then kernel gets a chance to reassign the resources of
> children bus to avoid the conflict.

Can you open a report at https://bugzilla.kernel.org, attach the
before and after dmesg logs, and include the URL in the commit log?

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  arch/x86/pci/i386.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index ed4ac215305d..6413eda87c72 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -230,13 +230,40 @@ static void pcibios_allocate_bridge_resources(struct pci_dev *dev)
>  	}
>  }
>  
> +static bool ioapic_firmware_enabled(struct pci_dev *dev)
> +{
> +	u16 class = dev->class >> 8;
> +
> +	if (class == PCI_CLASS_SYSTEM_PIC) {
> +		u16 command;
> +
> +		pci_read_config_word(dev, PCI_COMMAND, &command);
> +		if (command & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass);
> +
>  static void pcibios_allocate_bus_resources(struct pci_bus *bus)
>  {
>  	struct pci_bus *child;
> +	struct pci_dev *dev;
>  
>  	/* Depth-First Search on bus tree */
>  	if (bus->self)
>  		pcibios_allocate_bridge_resources(bus->self);
> +
> +	/* allocate firmware enabled APIC before children bus */
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (ioapic_firmware_enabled(dev)) {
> +			pcibios_allocate_dev_resources(dev, 0);
> +			pcibios_allocate_dev_resources(dev, 1);
> +		}
> +	}
> +
>  	list_for_each_entry(child, &bus->children, node)
>  		pcibios_allocate_bus_resources(child);
>  }
> -- 
> 2.13.6
> 
