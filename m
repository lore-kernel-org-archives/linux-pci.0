Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>, Lukas Wunner <lukas@wunner.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] x86, dmi: Uninline dmi_get_bios_year()
Date: Tue, 20 Mar 2018 15:54:08 +0200
Message-Id: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce a new helper to extract a year from DMI BIOS date since there
are most existing users do and newcomers would utilize as well.

This is a fix up series on top what had been applied already.

Since v2:
- resend as fix up series
- address comments from Bjorn, Jean, Lukas, Rafael

Since v1:
- move the helper to be regular function (Bjorn, Rafael)
- fix a potential regression introduced in pci_acpi_crs_quirks() (Jean)
- adjust subject lines and commit message bodies (Bjorn)
- add tags (Bjorn, Jean)

Andy Shevchenko (2):
  x86/PCI: Fix a potential regression when use dmi_get_bios_year()
  firmware: dmi_scan: Uninline dmi_get_bios_year() helper

 arch/x86/pci/acpi.c         |  4 +++-
 drivers/firmware/dmi_scan.c | 20 ++++++++++++++++++++
 include/linux/dmi.h         | 11 ++---------
 3 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.16.2

