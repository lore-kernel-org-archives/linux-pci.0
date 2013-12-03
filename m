Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47115 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3LCRj1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2013 12:39:27 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so25012826iej.28
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2013 09:39:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAD6G_RT0S43BrOeXxJ6d3p1ALbXkGumZCSPBaK1Bz=2pX3hHYQ@mail.gmail.com>
References: <CAD6G_RT0S43BrOeXxJ6d3p1ALbXkGumZCSPBaK1Bz=2pX3hHYQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Dec 2013 10:39:06 -0700
Message-ID: <CAErSpo4DNqUpA6Cb_tanW3uRJ3J-4utCQwtRz3eYZETCMtniUQ@mail.gmail.com>
Subject: Re: Need help on Linux PCIe
To: Jagan Teki <jagannadh.teki@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 3, 2013 at 4:24 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Hi,
>
> I have few question on Linux PCIe subsystem, I am trying to understand
> the PCIe on ARM platform.
> 1. Compared to PCI, PCIe have an extra port functionalists/services
> which is implemented drivers/pci/pcie/* is it true?

Yes.

> 2. PCIe root complex is same as Host controller drivers in linux drivers/host/*

Yes.

> 3. As individual endpoint drivers are registered to pci_core as
> pci_driver_register, then what is the common call for registering
> individual HC driver to pci-core?

The host controller-PCI core interface is not as mature as the
pci_register_driver() interface.  The basic interface is
pci_scan_root_bus().  If you skim through the drivers in
drivers/pci/host/* and drivers/acpi/pci_root.c, the interface to the
PCI core will be fairly obvious.  And you'll learn what the existing
practices are in case you need to add or modify something.

> 4. Can you list-down the basic and advanced functionalists supported
> by HC driver in PCIe?

The HC driver supplies struct pci_ops (functions to access config
space), and the resources (bus numbers, MMIO aperture, I/O aperture)
routed to the PCI/PCIe hierarchy below the host bridge.  These are all
supplied to pci_scan_root_bus().  There might also be chipset
initialization and error handling logic in the HC driver.

Pretty much everything else is generic and is supported by PCI core code.

> 5. The PCIe port bus driver is common core? means no need to change w.r.t SOC?

Yes.

Bjorn
