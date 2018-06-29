Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936587AbeF2U1f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 16:27:35 -0400
Subject: [PATCH v1 0/2] PCI: Add patch submission and ACPI FW/OS info
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 29 Jun 2018 15:27:33 -0500
Message-ID: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add hints about my patch idiosyncrasies and and ACPI firmware/OS interface
usage.  I posted the latter 18 months ago or so, but never followed up on
it.

---

Bjorn Helgaas (2):
      PCI: Document patch submission hints
      PCI: Document ACPI description of PCI host bridges


 Documentation/PCI/00-INDEX               |    4 +
 Documentation/PCI/acpi-info.txt          |  183 ++++++++++++++++++++++++++++++
 Documentation/PCI/submitting-patches.txt |  153 +++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 Documentation/PCI/acpi-info.txt
 create mode 100644 Documentation/PCI/submitting-patches.txt
