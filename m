Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34341 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcEJRAQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2016 13:00:16 -0400
Subject: Re: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe
 bindings
To: Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <f.fainelli@gmail.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-2-git-send-email-f.fainelli@gmail.com>
 <4513390.VWu0VVAxOl@wuerfel>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5732139C.80101@gmail.com>
Date: Tue, 10 May 2016 10:00:12 -0700
MIME-Version: 1.0
In-Reply-To: <4513390.VWu0VVAxOl@wuerfel>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/05/2016 02:15 PM, Arnd Bergmann wrote:
>> +Required properties:
>> +- compatible: must be one of: "brcm,bcm7425-pcie"
>> +			      "brcm,bcm7435-pcie"
>> +			      "brcm,bcm7445-pcie"
>> +
>> +- reg: specifies the physical base address of the controller registers and
>> +  its length
>> +
>> +- interrupt-parent: must be a reference (phandle) to the parent interrupt
>> +  controller in the system (7038-l1-intc on MIPS, GIC on ARM/ARM64)
>> +
>> +- interrrupts: first interrupt must be the Level 1 interrupt number corresponding
>> +  to the main PCIe RC interrupt, second interrupt must be the MSI interrupt
>> +  See the interrupt-parent documentation for the number of cells and their meaning:
>> +  MIPS: Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
>> +  ARM/ARM64: Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
>> +
>> +- interrupt-names: must be "pcie", and if present "msi"
> 
> When I suggested splitting out the MSI support, I was thinking (but not writing)
> that you'd use an msi-parent property to refer to the node that holds the
> msi-controller as well.

Oh got it now, and it can actually refer to iself.

> 
>> +- ranges: ranges for the PCI outbound windows, no I/O or prefetchable windows
>> +  must be specified here, only non-prefetchable. 32-bits windows or 64-bits
>> +  windows are allowed based on the host processor's capabilities (ARM w/ LPAE,
>> +  ARM64).
> 
> So this supports 64-bit non-prefetchable windows? Usually 64-bit windows
> are prefetchable.

I have yet to verify this, but on ARM64-based STB this should indeed be
the case.

> 
>> +- brcm,log2-scb-sizes: log2 size of the SCB window that is mapped to PCIe space
>> +  there must be exactly one value per memory controller present in the system
>> +  (ranges from 1 to 3)
> 
> I'm still not too happy with this property. I see no reason for the log2
> format (rather than length in bytes, or offset/length tuples, or dma-ranges,
> or phandles pointing to the memory controllers). I think we need to discuss
> this some more.

The two critical pieces of information that the PCIe RC needs are:

- number of memory controllers present in the system to avoid
configuring a window to a non-existing or non-populated memory controller

- size of the memory populated on the memory controller

You would think that we should somehow be able to derive this
information from the "memory" node, but there are a few caveats:

- on MIPS platforms, we have discontiguous physical memory ranges (256MB
@ 0x0, then 768MB or 1792MB @ 0x 0x20000000 and 1GB @ 0x90000000), yet
the PCIe RC does not know about the hole(s)

- on ARM platforms, we have an identiy mapping for the PAs below 4GB,
but when we cross it, we have additional non-linear memory regions

Both of these memory nodes would imply we know how to identify which
physical address belongs to which memory controller, while this is
actually possible and known, it creates a dependency on another piece of
driver to provide that information.

We do have memory controller nodes populated in the Device Tree, however
their binding (out of tree for the moment) does only specify their
programmable register interface, and not how how much physical memory
and where they provide to the system.

It does seem like we should be able to utilize the "dma-ranges" property
to determine both the memory controller number and their respective
populated memory sizes.

In the case where we have an identiy mapping though, this seems a little
redundant, but less of a stretch than our custom properties and nodes.

Does that sound reasonable to you?
-- 
Florian
