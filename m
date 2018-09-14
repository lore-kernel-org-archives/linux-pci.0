Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mta-01.yadro.com ([89.207.88.251]:60240 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbeINVgo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:44 -0400
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 0/4] PCI: Allow BAR movement during hotplug
Date: Fri, 14 Sep 2018 19:14:00 +0300
Message-ID: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the firmware or kernel has arranged memory for PCIe devices in a way that doesn't
provide enough space for BARs of a new hotplugged device, the kernel can pause the
drivers of the "obstructing" devices and move their BARs, so new BARs can fit into the
created hole.

When a driver is un-paused by the kernel after the PCIe rescan, it should check if its
BARs had changed and ioremap() them if needed.

BARs are moved not directly, but by releasing bridge resources, then sorting and
assigning them back, similarly to the initial PCIe topology scan during system boot
(when pci=realloc is passed).

Pausing drivers is performed via reset_prepare() and reset_done() callbacks of struct
pci_error_handlers. Drivers should pause during rescan not only because of potential
movement of their BARs, but also because of possible updating of the bridge windows.

This patchset is a part of our work on adding support for hotplugging bridges full of
NVME devices (without special requirement such as Hot-Plug Controller, reservation of
bus numbers and memory regions by firmware, etc.), should I also add here the patch that
adds support of moving BARs to the NVME driver?

Sergey Miroshnichenko (4):
  PCI: hotplug: Add parameter to put devices to reset during rescan
  PCI: Release and reassign resources from the root during rescan
  PCI: Invalidate the released BAR resources
  PCI: Fix writing invalid BARs during pci_restore_state()

 .../admin-guide/kernel-parameters.txt         |  6 ++
 drivers/pci/pci.c                             |  4 +-
 drivers/pci/pci.h                             |  8 ++
 drivers/pci/probe.c                           | 78 ++++++++++++++++++-
 drivers/pci/setup-bus.c                       | 33 +++++---
 include/linux/pci.h                           |  1 +
 6 files changed, 119 insertions(+), 11 deletions(-)

-- 
2.17.1
