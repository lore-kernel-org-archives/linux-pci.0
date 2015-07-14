Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32839 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbGNTo6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 15:44:58 -0400
Received: by oige126 with SMTP id e126so13885378oig.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 12:44:58 -0700 (PDT)
Subject: [PATCH 0/2] PCI: Comment and PCIe capability accessor fixes
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>
Date: Tue, 14 Jul 2015 14:44:55 -0500
Message-ID: <20150714193757.13471.77973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are a trivial comment fix and an almost as trivial accessor fix.

Arcanum for the day: when the PCIe spec says "Downstream Port," it means
both Root Ports and Switch Downstream Ports.

---

Bjorn Helgaas (2):
      PCI: Fix pcie_port_device_resume() comment
      PCI: Add pcie_downstream_port() (true for Root and Switch Downstream Ports)


 drivers/pci/access.c            |   23 +++++++++++++----------
 drivers/pci/pcie/portdrv_core.c |    2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)
