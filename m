Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/4] x86, dmi: introduce and use dmi_get_bios_year()
Date: Thu,  1 Mar 2018 20:02:16 +0200
Message-Id: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce a new helper to extract a year from DMI BIOS date since there
are most existing users do and newcomers would utilize as well.

Ingo, this is respin of the patches in x86/platform. I think, if it's
possible to rebase, would be easier just to replace existing ones.

Otherwise I would reorganize them as a series of fixups.

Bjorn, Jean, Rafael, thank you for your reviews!

Since v1:
- move the helper to be regular function (Bjorn, Rafael)
- fix a potential regression introduced in pci_acpi_crs_quirks() (Jean)
- adjust subject lines and commit message bodies (Bjorn)
- add tags (Bjorn, Jean)

Andy Shevchenko (4):
  firmware: dmi_scan: Introduce the dmi_get_bios_year() helper
  x86/PCI: Simplify code by using the new dmi_get_bios_year() helper
  ACPI / sleep: Simplify code by using the new dmi_get_bios_year()
    helper
  PCI: Simplify code by using the new dmi_get_bios_year() helper

 arch/x86/pci/acpi.c            | 10 +++++-----
 arch/x86/pci/direct.c          |  5 ++---
 arch/x86/pci/mmconfig-shared.c |  9 ++-------
 drivers/acpi/sleep.c           |  4 +---
 drivers/firmware/dmi_scan.c    | 11 +++++++++++
 drivers/pci/pci.c              |  6 +-----
 include/linux/dmi.h            |  2 ++
 7 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.16.1

