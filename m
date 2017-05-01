Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:44207 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423411AbdEAMGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2017 08:06:50 -0400
Message-Id: <cover.1493631639.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 1 May 2017 14:06:39 +0200
Subject: [PATCH 0/5] pciehp runtime PM
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>, Wei Zhang <wzhang@fb.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce runtime PM to pciehp in a more thorough and comprehensive way
than the reverted 68db9bc81436, taking into account the regressions
reported against it.

@Yinghai Lu & Intel/Facebook engineers, I would be grateful if you
could test this on as many systems as you can get your hands on,
in particular the Skylake servers that were broken by 68db9bc81436.
I guess those were Skylake-SP Xeon systems (Purley platform).
They're still unreleased and not available outside Intel and their
partners.  Their release date has been pushed further back to
mid-summer.  Myself I've only got a puny, 7 years old "Light Ridge"
Thunderbolt controller to test with and it doesn't even fully adhere
to the PCIe spec.

I'd also be interested to learn if you can measure a drop in power usage
on systems with unoccupied hotplug ports.

I've pushed this series to GitHub to ease reviewing:
https://github.com/l1k/linux/commits/pciehp_runpm_v1

Thanks!

Lukas


Lukas Wunner (5):
  PCI: pciehp: Resume to D0 on board addition/removal
  PCI: pciehp: Remain in D0 while awaiting command completion
  PCI: pciehp: Resume to D0 on sysfs read access
  PCI: pciehp: Remain in D0 if poll mode is enabled
  PCI: Whitelist native hotplug ports for runtime PM

 drivers/pci/hotplug/pciehp_ctrl.c | 13 +++++++++++--
 drivers/pci/hotplug/pciehp_hpc.c  | 25 ++++++++++++++++++++++---
 drivers/pci/pci.c                 |  7 ++-----
 3 files changed, 35 insertions(+), 10 deletions(-)

-- 
2.11.0
