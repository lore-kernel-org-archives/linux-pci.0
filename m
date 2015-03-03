Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Voegtle <tv@lio96.de>, Hudd <hedede.l@gmail.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Dave Airlie <airlied@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: [Debug 0/2] Fix regressions caused by commit 593669c2ac0f
Date: Tue,  3 Mar 2015 12:25:39 +0800
Message-Id: <1425356741-26789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 593669c2ac0f (x86/PCI/ACPI: Use common ACPI resource interfaces
to simplify implementation) causes regression to several platforms,
which is caused by stricter checks in new ACPI resource parsing code
and BIOSes report incorrect ACPI resource descriptors.  So try to relax
the check to avoid regressions.

Jiang Liu (2):
  x86/PCI/ACPI: Ignore resources consumed by host bridge itself
  x86/PCI/ACPI: Relax ACPI resource descriptor checks to work around
    BIOS bugs

 arch/x86/pci/acpi.c     |   11 ++++++++---
 drivers/acpi/resource.c |    4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
1.7.10.4

