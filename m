Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH v1 0/2] PCI: shpchp: Minor fixes
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Date: Sat, 02 Jun 2018 00:41:59 -0500
Message-ID: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An AMD POGO check in shpchp incorrectly included any device with device ID
0x7458, no matter what the vendor.

Also, use pci_info() instead of dbg() for messages related to OSHP.
They're important enough that they should appear in dmesg.

I intend to include these along with Mika's shpchp updates.

---

Bjorn Helgaas (2):
      PCI: shpchp: Use dev_printk() for OSHP-related messages
      PCI: shpchp: Fix AMD POGO identification


 drivers/pci/hotplug/acpi_pcihp.c  |   13 ++++++-------
 drivers/pci/hotplug/shpchp_ctrl.c |    8 ++++----
 2 files changed, 10 insertions(+), 11 deletions(-)
