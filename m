Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34414 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759542AbdLSBQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Dec 2017 20:16:22 -0500
Received: by mail-io0-f195.google.com with SMTP id f18so6778349ioh.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2017 17:16:22 -0800 (PST)
From: Frederick Lawler <fred@fredlawl.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 0/2] PCI: Add and use pci_<level>: dev_<level> equivalents
Date: Mon, 18 Dec 2017 19:16:12 -0600
Message-Id: <1513646174-2269-1-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace current uses of dev_<level> with pci_<level> by adding and using
PCI specific fuctions. 

Frederick Lawler (2):
  PCI: Create  minor pci_dev log wrapper functions
  PCI: Replace calls from dev_<level> to pci_<level>

 drivers/pci/access.c       |   6 +-
 drivers/pci/bus.c          |   4 +-
 drivers/pci/iov.c          |  10 +--
 drivers/pci/irq.c          |   6 +-
 drivers/pci/msi.c          |   6 +-
 drivers/pci/pci-acpi.c     |   2 +-
 drivers/pci/pci-stub.c     |   2 +-
 drivers/pci/pci-sysfs.c    |  10 +--
 drivers/pci/pci.c          |  76 ++++++++---------
 drivers/pci/probe.c        |  74 ++++++++---------
 drivers/pci/quirks.c       | 198 ++++++++++++++++++++++-----------------------
 drivers/pci/rom.c          |   4 +-
 drivers/pci/setup-bus.c    |  44 +++++-----
 drivers/pci/setup-irq.c    |   4 +-
 drivers/pci/setup-res.c    |  38 ++++-----
 drivers/pci/vc.c           |  16 ++--
 drivers/pci/xen-pcifront.c |  16 ++--
 include/linux/pci.h        |  91 +++++++++++++++++++++
 18 files changed, 349 insertions(+), 258 deletions(-)

-- 
2.7.4
