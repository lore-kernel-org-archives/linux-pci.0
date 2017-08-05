Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34165 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdHEGi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 02:38:26 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 00/10] PCI: pci resource allocation test module
Date: Fri,  4 Aug 2017 23:37:51 -0700
Message-Id: <20170805063801.15880-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Read from data file and mask file, to build simulated data structure, and
have pci_ops to use them.

Extract calling for pci_create_root_bus, scan_child_bus, resource survey
and resource assign ... to see if those functions work as expected with
simulated data.

mask is with rw bits on pci registers, so we can make pci BAR sizing working.

It also support bus number assign-all.

Only tested on x86 64bit arch.

  # insmod pci_test.ko data_file=pci_test_data.txt mask_file=pci_test_mask.txt
  # lspci -tv
  # cat /proc/ioports_test
  # cat /proc/iomem_test
  # rmmod pci_test

also in git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for_pci_v4.14_pci_next

Thanks

Yinghai

Yinghai Lu (10):
  PCI: avoid arch_remove_reservations() for PCI_TEST
  PCI: introduce ioport_res/iomem_res for PCI_TEST
  PCI: export symbol for PCI_TEST module
  PCI: extend pci device match_driver state
  PCI: Add PCI_TEST module for resource allocation
  PCI: PCI_TEST simple data
  PCI: PCI_TEST data from x5-8
  PCI: PCI_TEST data from x5-8 with zeroed bus number
  PCI: PCI_TEST data from x2-8
  PCI: PCI_TEST data from x2-8 with zeroed bus number

 arch/x86/kernel/resource.c             |    15 +-
 arch/x86/pci/i386.c                    |     1 +
 drivers/iommu/amd_iommu_init.c         |     2 +-
 drivers/pci/Kconfig                    |     6 +
 drivers/pci/Makefile                   |     2 +
 drivers/pci/bus.c                      |     3 +-
 drivers/pci/pci-driver.c               |     2 +-
 drivers/pci/pci_test.c                 |  1281 ++
 drivers/pci/pci_test_data.txt          |    24 +
 drivers/pci/pci_test_data_x2-8.txt     | 22818 +++++++++++++++++++++++++++++++
 drivers/pci/pci_test_data_x2-8_bus.txt | 22818 +++++++++++++++++++++++++++++++
 drivers/pci/pci_test_data_x5-8.txt     |  5656 ++++++++
 drivers/pci/pci_test_data_x5-8_bus.txt |  5656 ++++++++
 drivers/pci/pci_test_mask.txt          |     5 +
 drivers/pci/pci_test_mask_x2-8.txt     |   319 +
 drivers/pci/pci_test_mask_x5-8.txt     |   176 +
 drivers/pci/probe.c                    |     4 +-
 drivers/pci/quirks.c                   |     2 +-
 drivers/pci/setup-bus.c                |     3 +-
 drivers/pci/setup-res.c                |     4 +-
 include/linux/ioport.h                 |     3 +-
 include/linux/pci.h                    |    15 +-
 kernel/resource.c                      |     7 +-
 23 files changed, 58808 insertions(+), 14 deletions(-)
 create mode 100644 drivers/pci/pci_test.c
 create mode 100644 drivers/pci/pci_test_data.txt
 create mode 100644 drivers/pci/pci_test_data_x2-8.txt
 create mode 100644 drivers/pci/pci_test_data_x2-8_bus.txt
 create mode 100644 drivers/pci/pci_test_data_x5-8.txt
 create mode 100644 drivers/pci/pci_test_data_x5-8_bus.txt
 create mode 100644 drivers/pci/pci_test_mask.txt
 create mode 100644 drivers/pci/pci_test_mask_x2-8.txt
 create mode 100644 drivers/pci/pci_test_mask_x5-8.txt

-- 
2.9.4
