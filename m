Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01684F55AB;
	Thu,  3 Sep 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455420; cv=none; b=Tcvbg6GNMeAWlL308OkAESFgdDZEpgSwe8SsjmAoYBjodLIQ0ZMlyDJa5Xj7zM8dBbBdBQxCcRiOIb2BGzOlyiH5acqOEwuF0Q3lNt5HCW4zQloTtlqM96Pxw6yCnIJYHA2IWRSAcuBJncluZ3q/peHlsL+ZvpGxblOpA3C0fpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455420; c=relaxed/simple;
	bh=tq5kz92ZHa33XYvfI/dzqN1lJ8CPgpcikeEOXL8VzNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDufdb498vn9ETvN5/czycpnybT7VtYUwmYrwn7ggyfiZiYsMZwQ7M/b6MO9Bub/99/6tf+QN4HLg/knJ1pWVwkq9XUiUc3ZiqBtoWq/U8x90X78chgB7PNTuVWNGapbTiGjoJ/txmzbX7ZgdLwWwoNParAGy3POJN6jpApgYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFZZWsb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFZZWsb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEC71F000E9;
	Thu,  3 Sep 2026 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455418;
	bh=Q7Ch6uXLmIWsW7dIpjX/jEgDr2zGkkWS4CB4d9retI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cFZZWsb8RsWMsFl5QrT5x7DWJZetKw3a1fE+q7d3+9bWUiBkwrpBEGXMEqWbdf+iz
	 8mWAf096NKG95DYevg+DbOop11c9kdSh+ZjQNeeMpdiSE5pT50LS/6FamTGvpzovWR
	 8KYMvPMDTUnODNfXMquGjQwRmkVE6TlT3vlhZEG1tGpB8KZzCf/1qITYCu8Io1lMqQ
	 26h+tuSDrWkrk8ECVvPPH2+Mkirqczw+v2YZzKEIjY0kqFXsOz7B1xCjxKbQDWcJRt
	 l9EX9V3LZjg4uoC75glchXQQFaCT5FtWWoBWgkeWdZEBbC6LWx4rXea/wDLSuzqG+q
	 eDKDFJs0wwh7A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Peixin Xie <peixin.xie@linux.spacemit.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/4] ACPI: scan: Stop calling acpi_bus_init_power() early
Date: Thu, 03 Sep 2026 19:05:37 +0200
Message-ID: <2295263.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <6044499.DvuYhMxLoT@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There is a problem, introduced by commit 9d9bcae47fd5 ("ACPI: delay
enumeration of devices with a _DEP pointing to an INT3472 device")
inadvertently, that devices with missing dependencies may be put
into power state D0 prematurely [1].

Namely, acpi_bus_init_power() called by acpi_bus_get_power_flags()
during the early initialization of ACPI device objects, may discover
that all of the power resources needed by the given device to be in
power state D0 are initially on, so it will reference count those
power resources and transition the device into D0.  Later, if
acpi_bus_attach() running for that device notices that it has missing
dependencies, the enumeration of it will be deferred and its
power_manageable flag will be cleared, even though it is still in D0
at that point.

After the dependencies in question have been met, acpi_bus_attach()
runs again for the device and now it calls acpi_bus_init_power() that
takes additional references to the power resources used by the device
in D0.  These additional references prevent the power resources from
being turned off when the device goes into D3hot/D3cold.

Another problem, related to the previous one, is that ACPI power state
initialization may be carried out for devices whose parents are not
ready for enumeration which may lead to initialization ordering issues.

To address both, stop calling acpi_bus_init_power() from
acpi_bus_get_power_flags(), but also take the initialization of
PCI devices into account, which needs to be done because they
are initialized and bound to their ACPI companions before
acpi_bus_attach() is called for the latter.

To that end, notice that acpi_power_up_if_adr_present() is used for
powering-up PCI devices in D3cold before walking the bus in order to
discover them and the initial ACPI power state of those devices needs
to be known for this purpose, so add an acpi_bus_init_power() invocation
to that function.  [The debug statement printed by it duplicates the
debug statements printed during the acpi_bus_init_power() execution, so
drop it.]

Moreover, since the ACPI companions of PCI devices are associated with
the corresponding PCI devices found on the bus before acpi_bus_attach()
is called for them, it is not necessary or even useful to skip them in
acpi_bus_attach() due to an ACPI status mismatch, so avoid doing that
and complain if the ACPI status does not match the observed situation.

Also use the ACPI power state tracking to decide whether or not
the device's power state needs to be initialized in acpi_bus_attach()
instead of using the "initialized" flag of the ACPI device object
for this purpose, which is fragile and inconvenient, and clear the
power_manageable flag on failure in acpi_bus_init_power() (additionally,
poison the device ACPI power state as "invalid" if the initialization of
it fails).  That allows the clearing of the power_manageable flag for
devices with unmet dependencies to be dropped.

While at it, add a debug message pringing statement to
acpi_bus_init_power() to facilitate diagnostics.

Fixes: 9d9bcae47fd5 ("ACPI: delay enumeration of devices with a _DEP pointing to an INT3472 device")
Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Address Sashiko review comments:
     https://lore.kernel.org/linux-pci/20260902195849.174031F000E9@smtp.kernel.org/
   * Fold patch [6/6] from v2 in for completeness
   * Add recovery for parents with invalid ACPI power states to
     acpi_bus_init_power()
   * Set device->flags.initialized in acpi_bus_attach() to avoid clearing it
     permanently after the first attach/detach cycle of a device

v1 -> v2:
   * Address Sashiko review comments:
     https://lore.kernel.org/linux-pci/20260831201426.92F091F000E9@smtp.kernel.org/

---
 drivers/acpi/device_pm.c | 62 ++++++++++++++++++++++++++++++++--------
 drivers/acpi/scan.c      | 40 +++++++++++++++++---------
 2 files changed, 76 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 4269735aadde..76104f715efa 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -23,6 +23,8 @@
 #include "fan.h"
 #include "internal.h"
 
+#define ACPI_D_STATE_INVALID	ACPI_D_STATE_COUNT
+
 /**
  * acpi_power_state_string - String representation of ACPI device power state.
  * @state: ACPI device power state to return the string representation of.
@@ -293,24 +295,28 @@ int acpi_bus_set_power(acpi_handle handle, int state)
 }
 EXPORT_SYMBOL(acpi_bus_set_power);
 
-int acpi_bus_init_power(struct acpi_device *device)
+static int acpi_device_init_power(struct acpi_device *device)
 {
 	int state;
 	int result;
 
-	if (!device)
-		return -EINVAL;
-
-	device->power.state = ACPI_STATE_UNKNOWN;
-	if (!acpi_device_is_present(device)) {
-		device->flags.initialized = false;
-		return -ENXIO;
-	}
-
 	result = acpi_device_get_power(device, &state);
 	if (result)
 		return result;
 
+	/*
+	 * If the current power state of the device is D0 and it has a parent
+	 * whose power state is not ignored, and the parent's power state
+	 * initialization has failed, the parent's power state can be updated to
+	 * D0 for consistency.
+	 */
+	if (!device->power.flags.ignore_parent && state == ACPI_STATE_D0) {
+		struct acpi_device *parent = acpi_dev_parent(device);
+
+		if (parent && parent->power.state == ACPI_D_STATE_INVALID)
+			parent->power.state = ACPI_STATE_D0;
+	}
+
 	if (state < ACPI_STATE_D3_COLD && device->power.flags.power_resources) {
 		/* Reference count the power resources. */
 		result = acpi_power_on_resources(device, state);
@@ -340,9 +346,36 @@ int acpi_bus_init_power(struct acpi_device *device)
 		state = ACPI_STATE_D0;
 	}
 	device->power.state = state;
+
+	acpi_handle_debug(device->handle, "Initial power state: %s\n",
+			  acpi_power_state_string(state));
+
 	return 0;
 }
 
+int acpi_bus_init_power(struct acpi_device *device)
+{
+	int result;
+
+	if (device->power.state != ACPI_STATE_UNKNOWN)
+		return 0;
+
+	/*
+	 * The ACPI device power state can be only initialized once.  If this
+	 * fails, ACPI power management will not be used for the device going
+	 * forward.
+	 */
+	result = acpi_device_init_power(device);
+	if (result) {
+		device->flags.power_manageable = 0;
+		device->power.state = ACPI_D_STATE_INVALID;
+		acpi_handle_info(device->handle,
+				 "Initial power state undetermined, ACPI PM disabled\n");
+	}
+
+	return result;
+}
+
 /**
  * acpi_device_fix_up_power - Force device with missing _PSC into D0.
  * @device: Device object whose power state is to be fixed up.
@@ -464,8 +497,13 @@ static int acpi_power_up_if_adr_present(struct acpi_device *adev, void *not_used
 	if (!(adev->flags.power_manageable && adev->pnp.type.bus_address))
 		return 0;
 
-	acpi_handle_debug(adev->handle, "Power state: %s\n",
-			  acpi_power_state_string(adev->power.state));
+	/*
+	 * This is done during the PCI root initialization which occurs before
+	 * acpi_bus_attach() is called for the device, so the ACPI power state
+	 * of the device needs to be initialized here.
+	 */
+	if (acpi_bus_init_power(adev))
+		return 0;
 
 	if (adev->power.state == ACPI_STATE_D3_COLD)
 		return acpi_device_set_power(adev, ACPI_STATE_D0);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f48715ed827c..f219a16e018a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -20,6 +20,7 @@
 #include <linux/kthread.h>
 #include <linux/dmi.h>
 #include <linux/dma-map-ops.h>
+#include <linux/pci.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
 #include <linux/crc32.h>
@@ -1145,8 +1146,7 @@ static void acpi_bus_get_power_flags(struct acpi_device *device)
 			device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
 	}
 
-	if (acpi_bus_init_power(device))
-		device->flags.power_manageable = 0;
+	device->power.state = ACPI_STATE_UNKNOWN;
 }
 
 static void acpi_bus_get_flags(struct acpi_device *device)
@@ -2342,38 +2342,50 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 {
 	bool skip = !first_pass && device->flags.visited;
+	struct pci_dev *pci;
 	acpi_handle ejd;
 	int ret;
 
 	if (skip)
 		goto ok;
 
+	device->flags.initialized = true;
+
 	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
 		register_dock_dependent_device(device, ejd);
 
 	acpi_bus_get_status(device);
-	/* Skip devices that are not ready for enumeration (e.g. not present) */
-	if (!acpi_dev_ready_for_enumeration(device)) {
-		device->flags.initialized = false;
+	/*
+	 * If the given ACPI device object has been already associated with a
+	 * PCI device found on the bus, its status is effectively "present and
+	 * enabled", and dependencies are not tracked for PCI devices, so it is
+	 * not necessary or even useful to check the device's readiness in that
+	 * case.
+	 */
+	pci = acpi_dev_get_pci_dev(device);
+	if (pci) {
+		acpi_handle_debug(device->handle, "PCI companion %s found\n",
+				  pci_name(pci));
+
+		if (!acpi_device_is_present(device))
+			pci_info(pci, FW_BUG "ACPI status differs from reality\n");
+
+		pci_dev_put(pci);
+	} else if (!acpi_dev_ready_for_enumeration(device)) {
+		/* The device is not ready (e.g. not present), so skip it. */
 		acpi_device_clear_enumerated(device);
-		device->flags.power_manageable = 0;
 		return 0;
 	}
+
 	if (device->handler)
 		goto ok;
 
 	acpi_ec_register_opregions(device);
 
-	if (!device->flags.initialized) {
-		device->flags.power_manageable =
-			device->power.states[ACPI_STATE_D0].flags.valid;
-		if (acpi_bus_init_power(device))
-			device->flags.power_manageable = 0;
+	acpi_bus_init_power(device);
 
-		device->flags.initialized = true;
-	} else if (device->flags.visited) {
+	if (device->flags.visited)
 		goto ok;
-	}
 
 	ret = acpi_scan_attach_handler(device);
 	if (ret < 0)
-- 
2.51.0




