Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:43905 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932882AbcERRlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 May 2016 13:41:01 -0400
Date: Wed, 18 May 2016 19:14:01 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Rescanning is broken with runtime PM for PCIe ports
Message-ID: <20160518171401.GC1222@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

While testing the pci/pm tree from Bjorn with HEAD being 0195d2813547
("PCI: Add runtime PM support for PCIe ports"), I have noticed that
detaching and rescanning is broken.

When a bridgr is in D3 state, it cannot discover children. Reproducer:

    echo > /sys/bus/pci/devices/0000:01:00.0/remove 1
    # wait for the PCIe port to enter D3cold
    echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1
    # Workaround to get the device back
    echo > /sys/bus/pci/devices/0000:00:01.0/power/control on
    echo > /sys/bus/pci/devices/0000:00:01.0/rescan 1

lspci:

    00:01.0 PCI bridge [0604]: Intel Corporation Skylake PCIe Controller (x16) [8086:1901] (rev 07)
    01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM204M [GeForce GTX 965M] [10de:13d9] (rev a1)

Probably needs a pm_runtime_{get,put}_sync in pci_rescan_bus and
pci_rescan_bus_bridge_resize.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
