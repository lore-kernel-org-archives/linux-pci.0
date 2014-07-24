Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57770 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbaGXGkM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Jul 2014 02:40:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1XACh9-0000Ue-8Z
	for linux-pci@vger.kernel.org; Thu, 24 Jul 2014 08:40:03 +0200
Received: from nat-ies.mentorg.com ([192.94.31.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 08:40:03 +0200
Received: from john.fadel by nat-ies.mentorg.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 08:40:03 +0200
To: linux-pci@vger.kernel.org
From: John <john.fadel@gmail.com>
Subject: PCIe IOMEM Resource Allocation
Date: Thu, 24 Jul 2014 06:35:46 +0000 (UTC)
Message-ID: <loom.20140724T083447-909@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi
I am trying to write a PCIe linux device driver to handle PCIe switches and
endpoints that show up after the Redhat 6.4 linux is already up and running.

If I try to allocate the resources of the PCIe switches & endpoints between
0xF4000000 and 0xF47FFFFF everything works fine .. But this range is quite
full with other devices, so I tried to extend this range to start from
0xF0000000, or from 0xD0000000 the allocation works fine, but I am unable to
access devices in the extended range

Anybody has idea why I am unable to use the complete 3G - 4G address range ?
Is it related to some ACPI boot configuration that need to be changed, I can
see in my dmesg

pci_root PNP0A08:00: host bridge window [mem 0xf4000000-0xf7ffffff]
pci_root PNP0A08:00: host bridge window [io 0x1000-0x7fff]
pci_root PNP0A08:00: host bridge window [io 0x0000-0x03af]
pci_root PNP0A08:00: host bridge window [io 0x03e0-0x0cf7]
pci_root PNP0A08:00: host bridge window [io 0x0d00-0x0fff]
pci_root PNP0A08:00: host bridge window [mem 0xfed00000-0xfed03fff]
pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
pci_root PNP0A08:00: host bridge window [io 0x03b0-0x03bb]
pci_root PNP0A08:00: host bridge window [io 0x03c0-0x03df]
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A08:01: host bridge window [mem 0xf8000000-0xfbffffff]
pci_root PNP0A08:01: host bridge window [io 0x8000-0xffff]

Is there a reason for this limited range ? Is it processor dependant ?

Thanks 

