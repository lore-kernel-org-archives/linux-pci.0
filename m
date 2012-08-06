Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Huang Ying <ying.huang@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH -v2 4/4] PCI/PM: Add ABI document for sysfs file d3cold_allowed
Date: Mon,  6 Aug 2012 09:34:30 +0800
Message-Id: <1344216870-21105-5-git-send-email-ying.huang@intel.com>
In-Reply-To: <1344216870-21105-1-git-send-email-ying.huang@intel.com>
References: <1344216870-21105-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds ABI document for the following sysfs file:

/sys/bus/pci/devices/.../d3cold_allowed

Signed-off-by: Huang Ying <ying.huang@intel.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/ABI/testing/sysfs-bus-pci |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -210,3 +210,15 @@ Users:
 		firmware assigned instance number of the PCI
 		device that can help in understanding the firmware
 		intended order of the PCI device.
+
+What:		/sys/bus/pci/devices/.../d3cold_allowed
+Date:		July 2012
+Contact:	Huang Ying <ying.huang@intel.com>
+Description:
+		d3cold_allowed is bit to control whether the corresponding PCI
+		device can be put into D3Cold state.  If it is cleared, the
+		device will never be put into D3Cold state.  If it is set, the
+		device may be put into D3Cold state if other requirements are
+		satisfied too.  Reading this attribute will show the current
+		value of d3cold_allowed bit.  Writing this attribute will set
+		the value of d3cold_allowed bit.
