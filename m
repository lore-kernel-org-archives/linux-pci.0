Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37506 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab3JKEoL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2013 00:44:11 -0400
Received: by mail-ie0-f170.google.com with SMTP id x13so7316491ief.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2013 21:44:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201310110418.56460.marex@denx.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
	<CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
	<201310110413.02354.marex@denx.de>
	<201310110418.56460.marex@denx.de>
Date: Thu, 10 Oct 2013 21:44:11 -0700
Message-ID: <CAE9FiQXKgkwgzA0ciRyahObDHvnFtEJxzOhHRo6gytdeKQ-XQQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
From: Yinghai Lu <yinghai@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 10, 2013 at 7:18 PM, Marek Vasut <marex@denx.de> wrote:

> And so does the probe log (but the pcieport failure still persists):
>

> pci_bus 0000:04: bus scan returning with max=04
> pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
> pci_bus 0000:02: bus scan returning with max=04
> pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 04
> pci_bus 0000:01: bus scan returning with max=04
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 04
> pci_bus 0000:00: bus scan returning with max=04
> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 04
> PCI: Device 0000:00:00.0 not available because of resource collisions
> pcieport: probe of 0000:00:00.0 failed with error -22

load pcieport driver too early.

> PCI: Device 0000:00:00.0 not available because of resource collisions
> pci 0000:00:00.0: Error enabling bridge (-22), continuing
> PCI: enabling device 0000:01:00.0 (0140 -> 0143)
> pcieport 0000:01:00.0: enabling bus mastering
> PCI: Device 0000:00:00.0 not available because of resource collisions
> pci 0000:00:00.0: Error enabling bridge (-22), continuing
> PCI: Device 0000:00:00.0 not available because of resource collisions
> pci 0000:00:00.0: Error enabling bridge (-22), continuing
> pci 0000:03:00.0: calling quirk_e100_interrupt+0x0/0x20c
> pci 0000:00:00.0: fixup irq: got 155
> pci 0000:00:00.0: assigning IRQ 155
> pcieport 0000:01:00.0: fixup irq: got 0
> pcieport 0000:01:00.0: assigning IRQ 00
> pcieport 0000:02:01.0: fixup irq: got 0
> pcieport 0000:02:01.0: assigning IRQ 00
> pcieport 0000:02:02.0: fixup irq: got 0
> pcieport 0000:02:02.0: assigning IRQ 00
> pci 0000:03:00.0: fixup irq: got 155
> pci 0000:03:00.0: assigning IRQ 155
> pci 0000:00:00.0: BAR 8: assigned [mem 0x01000000-0x01bfffff]
> pci 0000:00:00.0: BAR 0: assigned [mem 0x01c00000-0x01cfffff]
> pci 0000:00:00.0: BAR 0: set to [mem 0x01c00000-0x01cfffff] (PCI address
> [0x1c00000-0x1c
> fffff])
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01d00000-0x01d0ffff pref]
> pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> pcieport 0000:01:00.0: BAR 8: assigned [mem 0x01000000-0x01bfffff]
> pcieport 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> pcieport 0000:02:01.0: BAR 8: assigned [mem 0x01000000-0x01bfffff]
> pcieport 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
> pci 0000:03:00.0: BAR 0: assigned [mem 0x01000000-0x017fffff]
> pci 0000:03:00.0: BAR 0: set to [mem 0x01000000-0x017fffff] (PCI address
> [0x1000000-0x17
> fffff])
> pci 0000:03:00.0: BAR 3: assigned [mem 0x01800000-0x01803fff]
> pci 0000:03:00.0: BAR 3: set to [mem 0x01800000-0x01803fff] (PCI address
> [0x1800000-0x18
> 03fff])
> pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
> pci 0000:03:00.0: BAR 2: set to [io  0x1000-0x101f] (PCI address
> [0x1000-0x101f])
> pci 0000:00:00.0: PCI bridge to [bus 01-04]
> pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01bfffff]
> pci 0000:00:00.0: PCI bridge to [bus 01-04]
> pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01bfffff]
> pci_bus 0000:00: resource 4 [io  0x1000-0x10000]
> pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
> pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> pci_bus 0000:01: resource 1 [mem 0x01000000-0x01bfffff]
> pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
> pci_bus 0000:02: resource 1 [mem 0x01000000-0x01bfffff]
> pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
> pci_bus 0000:03: resource 1 [mem 0x01000000-0x01bfffff]

Looks your arch call pci_assign_unassigned_resources() too late.

you should have call it with fs_initcall()...

please try to boot with "debug ignore_loglevel initcall_debug" to sort out
the initcall sequence.

Yinghai
