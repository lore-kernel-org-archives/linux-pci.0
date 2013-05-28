Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Betty Dall <betty.dall@hp.com>
To: rjw@sisk.pl, bhelgaas@google.com
Cc: ying.huang@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Betty Dall <betty.dall@hp.com>
Subject: [PATCH 0/3] PCI/ACPI: Fix firmware first error recovery with root port in reset
Date: Tue, 28 May 2013 12:48:46 -0600
Message-Id: <1369766929-4386-1-git-send-email-betty.dall@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set fixes a bug on platforms that use firmware first AER.
Firmware can leave the root port in Secondary Bus Reset (SBR) and
communicate this to the OS through the "reset" bit in the flags field
of the HEST table and associated CPER records. Firmware wants to do this
so that the error is contained and the hardware is in a known state.

Without these patches, the root port stays in SBR and the device drivers
cannot recover. These patches recognize when the firmware first root port
is in SBR and bring the root port out of SBR so the devices under the root
port can recover.

The changes have been tested on systems with firmware first that set the
"reset" bit by injecting various hardware errors. The errors successfully
recover.

---
Betty Dall (3):
  PCI/AER: Fix incorrect return from aer_hest_parse()
  ACPI/APEI: Force fatal AER severity when bus has been reset
  PCI/AER: Provide reset_link for firmware first root port
---
 drivers/acpi/apei/ghes.c           |   21 ++++++++++++++++++-
 drivers/pci/pcie/aer/aerdrv_acpi.c |    3 ++
 drivers/pci/pcie/aer/aerdrv_core.c |   38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletions(-)
