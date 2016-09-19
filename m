Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f181.google.com ([209.85.213.181]:34656 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcISSPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2016 14:15:40 -0400
Received: by mail-yb0-f181.google.com with SMTP id x93so93710147ybh.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2016 11:15:40 -0700 (PDT)
MIME-Version: 1.0
From: Robert Jones <rjones@gateworks.com>
Date: Mon, 19 Sep 2016 11:15:39 -0700
Message-ID: <CALAE=UDqxjh1qt5OJexyonynj+uEyhiwdAtUF0_dD5ffRkUo=Q@mail.gmail.com>
Subject: PCI Resource Allocation
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greetings,

I'm looking into a PCI resource limitation issue on an IMX6 based
board and I find that in the 3.14 kernel I am able to use 6 Ath10k
devices with the following resources:

03:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac
Wireless Network Adapter
        Flags: fast devsel, IRQ 155
        Memory at 01200000 (64-bit, non-prefetchable) [disabled] [size=2M]
        [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit-
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00

In the 3.15 kernel following commit
(5b28541552ef5eeffc41d6936105f38c2508e566), allocation has changed in
such a way that results in none of the 6 radios nor the pci based
ethernet interface being mapped.
I am very new to PCI but after fiddling with some of the changes in
the aforementioned commit I was able to come up with a 1 line patch
that allows all 6 radios to once again become mapped and usable on the
IMX6. The patch contents being:

--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -807,6 +807,7 @@ static struct resource
*find_free_bus_resource(struct pci_bus *bus,
 {
        int i;
        struct resource *r;
+       type_mask = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH;

        pci_bus_for_each_resource(bus, r, i) {
                if (r == &ioport_resource || r == &iomem_resource)


I understand that this blatantly ignores the type mask parameter and
would greatly appreciate any insight that you can provide as far as
the proper way to proceed.

Note that the IMX6 has a limited memory window (16M) between the PCI
core and the memory controller. This is mapped as:

512KB config space
64KB io space
15MB mem space available for devices

Best Regards,
Robert
