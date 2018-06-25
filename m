Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbeFYW7f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 18:59:35 -0400
Subject: [PATCH v1 0/4] PCI: shpchp: NULL pointer fix and cleanups
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2018 17:59:33 -0500
Message-ID: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first patch fixes a NULL pointer dereference reported by Marc and would
be targeted for v4.18.

The others simplify the shpchp probe path and would be for v4.19.

---

Bjorn Helgaas (4):
      PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems
      PCI: shpchp: Separate existence of SHPC and permission to use it
      PCI: shpchp: Inline shpchp_is_native()
      PCI: hotplug: Implement hotplug_is_native() only when CONFIG_ACPI=y


 drivers/pci/hotplug/acpi_pcihp.c  |   40 +++++++++++++++++++++++--------------
 drivers/pci/hotplug/shpchp_core.c |   21 +++++++++++++++++++
 drivers/pci/pci-acpi.c            |   29 ---------------------------
 include/linux/pci.h               |    1 +
 include/linux/pci_hotplug.h       |   20 ++++++++++---------
 5 files changed, 58 insertions(+), 53 deletions(-)
