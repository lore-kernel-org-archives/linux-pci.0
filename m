Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Matthew Garrett <matthew.garrett@nebula.com>
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	Matthew Garrett <matthew.garrett@nebula.com>
Date: Sun,  1 Jun 2014 12:33:54 -0400
Message-Id: <1401640436-1947-3-git-send-email-matthew.garrett@nebula.com>
In-Reply-To: <1401640436-1947-1-git-send-email-matthew.garrett@nebula.com>
References: <1401640436-1947-1-git-send-email-matthew.garrett@nebula.com>
Subject: [PATCH 2/4] ACPI: Don't call PCI OSC on Apple hardware when claiming to be Darwin
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Apple PCI _OSC method has the following code:

if (LEqual (0x01, OSDW ()))
  if (LAnd (LEqual (Arg0, GUID), NEXP)
    (do stuff)
  else
    (fail)

NEXP is a value in high memory and is presumably under the control of the
firmware. No methods set it. The methods that are called in the "do stuff"
path are dummies. Unless there's some additional firmware call in early boot,
there's no way for this call to succeed - and even if it does, it doesn't do
anything.

The easiest way to handle this is simply to ignore it. We know which flags
would be set, so just set them by hand if the platform is running in Darwin
mode.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
---
 drivers/acpi/pci_root.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d388f13..f04b6b9 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -430,6 +430,17 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	acpi_handle handle = device->handle;
 
 	/*
+	 * Apple always return failure on _OSC calls when _OSI("Darwin") has
+	 * been called successfully. We know the feature set supported by the
+	 * platform, so avoid calling _OSC at all
+	 */
+
+	if (acpi_gbl_osi_data == ACPI_OSI_DARWIN) {
+		root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
+		return;
+	}
+
+	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
-- 
1.8.5.3

