Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:55160 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab2L3Tqk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 30 Dec 2012 14:46:40 -0500
Received: by mail-la0-f49.google.com with SMTP id fk20so3054278lab.8
        for <linux-pci@vger.kernel.org>; Sun, 30 Dec 2012 11:46:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50DD6811.7020301@ic.fr>
References: <50DD6811.7020301@ic.fr>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 30 Dec 2012 13:46:17 -0600
Message-ID: <CAErSpo4nkWwwY5qtsAzgsPYAvUWAKPkML99u+2oiuuzdq4VPKw@mail.gmail.com>
Subject: Re: Question: how can I get the real PCI address of a BAR?
To: =?ISO-8859-1?Q?C=E9dric_Cano?= <ccano@interfaceconcept.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 28, 2012 at 2:36 AM, Cédric Cano <ccano@interfaceconcept.com> wrote:
> Hi,
>
> I'm writing a driver for a DMA engine on the PCI bus. My architecture is a
> 36-bit PowerPC (MPC85xx).
>
> In my DMA driver, I want to configure the DMA to transfer data to/from a PCI
> device.
> I get the PCI address of the device BAR with the command pci_resource_start.

pci_resource_start() doesn't give you a PCI bus address; it gives you
a CPU physical address.  You ioremap() that address if you want a CPU
to access the BAR MMIO space.

> This address is 36-bit but the PCI BAR of the device is 32-bit: I can't use
> the 36-bit address to run the DMA.
>
> In kernel documentations, it's advised not to directly read the BAR.
>
> Is there a function which provides the real PCI address i.e. the one stored
> in the BAR?

You can use pcibios_resource_to_bus() to convert the CPU physical
address from the pci_dev.resource[] back to a PCI bus address.
sym_iomap_device() does something similar to what you're asking about.

Bjorn
