Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:62100 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdBFPyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Feb 2017 10:54:17 -0500
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
From: Mason <slash.tmp@free.fr>
Subject: Pointers for writing a good PCIe driver
Message-ID: <ff099b5f-efc8-bb5f-41e3-493398844cc0@free.fr>
Date: Mon, 6 Feb 2017 16:54:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

My platform ( arch/arm/mach-tango ) provides a PCIe controller from PLDA.

I do have access to a driver that works for a few PCIe boards, but it's
an ancient out-of-tree driver (targeting v3.4). Also, I'm not sure it
follows the best-practice guidelines (e.g. it hard-codes a few
work-arounds directly in drivers/pci/probe.c)

If I understand correctly, while PCIe is a standard, it is not codified
as much as USB (XHCI) or SATA (AHCI), which means the register layout
(and possibly other things) are left up to the integrator? Which means
there cannot be some kind of "generic" driver that works for a random
PCIe controller?

I guess my main question is: do you have pointers on getting started
writing a PCIe driver good enough for upstream?

Is Documentation/PCI/PCIEBUS-HOWTO.txt still a relevant resource?

Are there good resources to get up to speed on the PCIe terminology?

Regards.
