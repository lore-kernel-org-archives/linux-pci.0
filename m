Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:18210 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754079AbdBGPzf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 10:55:35 -0500
Subject: Re: Pointers for writing a good PCIe driver
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
References: <ff099b5f-efc8-bb5f-41e3-493398844cc0@free.fr>
Message-ID: <05046a8a-ba9f-26f9-4c93-f657f9da6294@free.fr>
Date: Tue, 7 Feb 2017 16:55:28 +0100
MIME-Version: 1.0
In-Reply-To: <ff099b5f-efc8-bb5f-41e3-493398844cc0@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/02/2017 16:54, Mason wrote:

> My platform ( arch/arm/mach-tango ) provides a PCIe controller from PLDA.
> 
> I do have access to a driver that works for a few PCIe boards, but it's
> an ancient out-of-tree driver (targeting v3.4). Also, I'm not sure it
> follows the best-practice guidelines (e.g. it hard-codes a few
> work-arounds directly in drivers/pci/probe.c)
> 
> If I understand correctly, while PCIe is a standard, it is not codified
> as much as USB (XHCI) or SATA (AHCI), which means the register layout
> (and possibly other things) are left up to the integrator? Which means
> there cannot be some kind of "generic" driver that works for a random
> PCIe controller?
> 
> I guess my main question is: do you have pointers on getting started
> writing a PCIe driver good enough for upstream?
> 
> Is Documentation/PCI/PCIEBUS-HOWTO.txt still a relevant resource?
> 
> Are there good resources to get up to speed on the PCIe terminology?

I'm also wondering: in many Linux subsystems, there are often
several drivers of different quality; some are obsolescent and
have not been updated in a while, while some are recent and
follow all the latest best-practice guidelines (and the rest
is somewhere in the middle).

Are there 1 or 2 very good PCIe drivers to take as examples
as good starting points? (Perhaps a simple driver, and a
more complex driver.)

Does anyone know if any SoC with a driver upstream is using
a PLDA controller?

Regards.
