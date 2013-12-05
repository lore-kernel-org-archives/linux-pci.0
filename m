Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43689 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797Ab3LESya (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 13:54:30 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so30608567iec.13
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 10:54:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
References: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 5 Dec 2013 11:54:09 -0700
Message-ID: <CAErSpo407DH2AY2a=umZZf5pxfzSFQ1Tr6E-uPBn-ZCehTVH3w@mail.gmail.com>
Subject: Re: [Discussion]: ARM: PCIE: Setup bridges not happening with portbus
 driver enabled
To: Jay Agarwal <jagarwal@nvidia.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 4, 2013 at 10:44 PM, Jay Agarwal <jagarwal@nvidia.com> wrote:
> Hi All,
>
> I am seeing below issue on an ARM platform with CONFIG_PCIEPORTBUS enabled in kernel
>
> ISSUE:  Any memory access by devices fails

"Memory access by device fails" sounds like DMA doesn't work.  Is that
what you mean?

> FINDINGS:
>
> 1. No bridge windows like below are setup and probably this is not allowing any memory access by devices
> [    1.280324] pci 0000:00:00.0:   bridge window [mem 0xXXX00000-0xXXXfffff]
> [    1.280350] pci 0000:00:00.0:   bridge window [mem 0xXXX00000-0xXXXfffff pref]

These bridge windows are used for MMIO, i.e., accesses performed by
the CPU, routed toward the device.  CPU accesses to the device will
use addresses inside a window, and the bridge will forward those
accesses from the primary (CPU) side to the secondary (device) side.
Device accesses, i.e., DMA, will use addresses outside the windows,
and the bridge will forward those accesses from the secondary (device)
side to the primary (CPU/memory) side.

All pci_setup_bridge() does is write the window base/limit registers.
It doesn't even figure out what to *put* in those registers; it just
uses the values already in bus->resource[].  So if DMA doesn't work,
and calling pci_setup_bridge() fixes it, bus->resource[] must already
have valid windows, but they don't match the base/limit registers.

What is in the registers and what is in bus->resource[]?  Comparing
the dmesg from with and without your patch should tell us this.

One thing we have to check is whether this path is used during
hotplug.  If there can be other active devices below the bridge,
calling pci_setup_bridge() may cause failures for them because it
temporarily disables the windows.

> 2. On debugging, I see pci_enable_bridge(setup-bus.c) is not called because pci_is_enabled returns true. This is because pci_enable_device is already called for this bridge by portbus driver in pcie_port_device_register(portdrv_core.c).
> 3. Below patch is resolving this issue without any visible side effects. In fact, I verified AER(which needs PORTBUS) also with this.
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c index 64a7de2..9b67fff 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1200,8 +1200,7 @@ void __ref __pci_bus_assign_resources(const struct pci_bus *bus,
>
>                 switch (dev->class >> 8) {
>                 case PCI_CLASS_BRIDGE_PCI:
> -                       if (!pci_is_enabled(dev))
> -                               pci_setup_bridge(b);
> +                       pci_setup_bridge(b);
>                         break;
>
>                 case PCI_CLASS_BRIDGE_CARDBUS:
>
> 3. This patch works without PORTBUS enabled also.
>
> QUESTIONS:
> 1. Does anybody see any problem with this patch? Any reason for pci_is_enabled check above?
>
> With best,
> Jay
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
