Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Voegtle <tv@lio96.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dave Airlie <airlied@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: [Debug 0/2] Debug ACPI resource parsing failure
Date: Mon,  2 Mar 2015 17:51:36 +0800
Message-Id: <1425289898-22377-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <alpine.LSU.2.11.1503020932210.29400@er-systems.de>
References: <alpine.LSU.2.11.1503020932210.29400@er-systems.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,
	According to the dmesg, it seems that BIOS reports malformed
ACPI resource descriptors. The new code enforces stricter checks for
ACPI resource descriptors, so it skips some malformed ACPI resource
descriptors. Could you please to try this two patches again?
Thanks!
Gerry

Jiang Liu (2):
  x86/PCI/ACPI: Ignore resources consumed by host bridge itself
  x86/PCI/ACPI: Gather debug info

 arch/x86/pci/acpi.c     |   10 +++++++---
 drivers/acpi/resource.c |    7 ++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
1.7.10.4

