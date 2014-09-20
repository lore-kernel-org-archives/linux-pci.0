Return-Path: <linux-acpi-owner@vger.kernel.org>
From: andreas.noever@gmail.com
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.or,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	matthew.garrett@nebula.com,
	Andreas Noever <andreas.noever@gmail.com>
Subject: [PATCH v2 3/3] ACPI: Support _OSI("Darwin") correctly
Date: Sat, 20 Sep 2014 13:19:47 +0200
Message-Id: <bf5856a35c5ba95c4da960f797514ef4cfaf71b2.1411211725.git.andreas.noever@gmail.com>
In-Reply-To: <cover.1411211725.git.andreas.noever@gmail.com>
References: <cover.1411211725.git.andreas.noever@gmail.com>
In-Reply-To: <cover.1411211725.git.andreas.noever@gmail.com>
References: <cover.1411211725.git.andreas.noever@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Garrett <matthew.garrett@nebula.com>

From: Matthew Garrett <matthew.garrett@nebula.com>

Apple hardware queries _OSI("Darwin") in order to determine whether the
system is running OS X, and changes firmware behaviour based on the
answer.  The most obvious difference in behaviour is that Thunderbolt
hardware is forcibly powered down unless the system is running OS X. The
obvious solution would be to simply add Darwin to the list of supported
_OSI strings, but this causes problems.

Recent Apple hardware includes two separate methods for checking _OSI
strings. The first will check whether Darwin is supported, and if so
will exit. The second will check whether Darwin is supported, but will
then continue to check for further operating systems. If a further
operating system is found then later firmware code will assume that the
OS is not OS X.  This results in the unfortunate situation where the
Thunderbolt controller is available at boot time but remains powered
down after suspend.

The easiest way to handle this is to special-case it in the
Linux-specific OSI handling code. If we see Darwin, we should answer
true and then disable all other _OSI vendor strings.

The next problem is that the Apple PCI _OSC method has the following
code:

if (LEqual (0x01, OSDW ()))
  if (LAnd (LEqual (Arg0, GUID), NEXP)
    (do stuff)
  else
    (fail)
NEXP is a value in high memory and is presumably under the control of
the firmware. No methods sets it. The methods that are called in the "do
stuff" path are dummies. Unless there's some additional firmware call in
early boot, there's no way for this call to succeed - and even if it
does, it doesn't do anything.

The easiest way to handle this is simply to ignore it. We know which
flags would be set, so just set them by hand if the platform is running
in Darwin mode.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
[andreas.noever@gmail.com: merged two patches, do not touch ACPICA]
Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
---
 drivers/acpi/osl.c      | 10 ++++++++++
 drivers/acpi/pci_root.c | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3abe9b2..938b6ac 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -152,6 +152,16 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 			osi_linux.dmi ? " via DMI" : "");
 	}
 
+	if (!strcmp("Darwin", interface)) {
+		/*
+		 * Apple firmware will behave poorly if it receives positive
+		 * answers to "Darwin" and any other OS. Respond positively
+		 * to Darwin and then disable all other vendor strings.
+		 */
+		acpi_update_interfaces(ACPI_DISABLE_ALL_VENDOR_STRINGS);
+		supported = ACPI_UINT32_MAX;
+	}
+
 	return supported;
 }
 
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e6ae603..cd4de7e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -35,6 +35,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
+#include <linux/dmi.h>
 #include <acpi/apei.h>	/* for acpi_hest_init() */
 
 #include "internal.h"
@@ -430,6 +431,19 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	acpi_handle handle = device->handle;
 
 	/*
+	 * Apple always return failure on _OSC calls when _OSI("Darwin") has
+	 * been called successfully. We know the feature set supported by the
+	 * platform, so avoid calling _OSC at all
+	 */
+
+	if (dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
+		root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
+		decode_osc_control(root, "OS assumes control of",
+				   root->osc_control_set);
+		return;
+	}
+
+	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
-- 
2.1.0

