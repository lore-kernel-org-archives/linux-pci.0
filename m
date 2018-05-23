Return-Path: <linux-kernel-owner@vger.kernel.org>
From: dmeyer@gigaio.com
To: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>
Subject: [PATCH v2 0/2] PCI Quirk Patchset for Microsemi Switchtec NTB
Date: Wed, 23 May 2018 13:18:04 -0700
Message-Id: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Doug Meyer <dmeyer@gigaio.com>

This is a resend of the patch series to enable Microsemi Switchtec
NTB configurations to run with the IOMMU in the hosts turned on.
Because of the nature PCI Quirk implementation, it was preferable
to migrate the Microsemi PCI vendor and device definitions to the
Linux canonical location. Logan Gunthorpe requested that this
migration be done as a separate patch in a set, and so this patch
series was created as shown here.

The first patch encapsulates the movement of constants from
switchtec.h to pci_ids.h, with commensurate changes to the source
files. This patch is not dependent on any other work.

The second patch is the PCI quirk implementation itself, and is
completely dependent upon the first patch in this series.

Testing of the quirk was done on with a 2-host x86-64 system
with all combinations of IOMMU off/on. The ntb_perf module was
used as test stimulus. 

Blessings,
Doug Meyer

Changes since v1:
- Call pci_device_disable() at return points to clean up properly.
- Changed all dev_* print macros to pci_* macros.
- Removed superfluous variable initializations.

Doug Meyer (2):
  NTB: Migrate PCI Constants to Cannonical PCI Header
  NTB: PCI Quirk to Enable Switchtec NT Functionality with IOMMU On

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |   3 +-
 drivers/pci/quirks.c                   | 197 +++++++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c         |  15 ++-
 include/linux/pci_ids.h                |  32 ++++++
 include/linux/switchtec.h              |   4 -
 5 files changed, 238 insertions(+), 13 deletions(-)

-- 
1.8.3.1
