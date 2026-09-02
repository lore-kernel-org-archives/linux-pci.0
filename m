Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA84A43FF;
	Wed,  2 Sep 2026 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377881; cv=none; b=KQT8a5SHarG6exrEuVWzIBzXMIRBcPSf2covLxSp5UCqOJgFB1v7XnEemMP7NPB8rcmGD3CcguOBgpdtmdJdhPIhI5e6yg2jaeh+AlxFxTr5Nx5Gsh3Jiz33KAtS3kSgE5fW0mM5NoAnDcn7U3rA1y5pMskAEK7WNij5lnfCQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377881; c=relaxed/simple;
	bh=mslYef9epcjFdrtNjvVo/ShEpSYYEeFTzoOoaBRsya8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rslFgLCxMwaALvpix6O0eh13i183wUrVpo6KHmC8YdcXclQtwLOJ0XNTmnMj1Gz9SzgJwberNoEtxIHvSaq9vJnK+YtxPe1v0OEP+Q6r7my9T6rRfkf1NGQjqHPcI2ht86lcQWwIB0kLi6QnycHopirENYO2G2sj1J1r8CY0RCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGhv590u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGhv590u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E005A1F00AC4;
	Wed,  2 Sep 2026 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788377867;
	bh=wJU3SUPx0pJcFUfDmemzpNnRUt7CQUXkTMEZMa3GOM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kGhv590u+kGBo0Y/Kjni6cLrhgMWArlwVlwl4wSK2Kd/M4YJLyOl5wMw80bNPDj11
	 8SaxRgm9xxW6PrKZfN6yvTcKJct3QuMm9pyCU+a1ywpQsf68kGnPSQg+dLLUYhyGus
	 5/QUVB4kyJcA1byOYYvUFRBGSWtiAR0Zs/RjZ9tUS8graYeFwGhk3CSfjsThTKcBZ5
	 AXbzIHzzw/hA6nyahA3bVW/JIcQ8PMKMyPf0BTJkPNxM9vHOaubf8IJAaoeMVkpnuf
	 sWKuDixzff9srsb0DaiQlbJA/a31BvdzkFUfX1xYZJoKoCDtkSARq8podhvJHpi2Qc
	 XZYzi/Aszyr/Q==
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
Subject: [PATCH v2 2/6] ACPI: scan: Stop calling acpi_bus_init_power() early
Date: Wed, 02 Sep 2026 21:26:51 +0200
Message-ID: <3076831.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5144065.31r3eYUQgx@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
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

To that end, notice that each PCI device discovered on the bus is
put into power state D0 via pci_power_up() which involves invoking
acpi_device_set_power() if the given PCI device has an ACPI companion
with flags.power_manageable set.  The initial ACPI power state of
the device needs to be known at that point to carry out the power
transition of it properly, so modify acpi_device_set_power() to
call acpi_bus_init_power() upfront if the device's ACPI power
state is still unknown.

Also use the ACPI power state tracking to decide whether or not
the device's power state needs to be initialized in acpi_bus_attach()
instead of using the "initialized" flag of the ACPI device object
for this purpose, which is fragile and inconvenient.  Also stop
clearing the power_manageable flag for devices with unmet
dependencies and poison the power state as "disabled" if the
initialization of it fails, which may not be recoverable.

While at it, add a debug message printing statement to
acpi_bus_init_power() to facilitate diagnostics.

Fixes: 9d9bcae47fd5 ("ACPI: delay enumeration of devices with a _DEP pointing to an INT3472 device")
Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Address Sashiko review comments:
     https://lore.kernel.org/linux-pci/20260831201426.92F091F000E9@smtp.kernel.org/

---
 drivers/acpi/device_pm.c | 56 +++++++++++++++++++++++++++++++++-------
 drivers/acpi/scan.c      | 15 +++--------
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 4269735aadde..e13096cfd790 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -23,6 +23,8 @@
 #include "fan.h"
 #include "internal.h"
 
+#define ACPI_D_STATE_DISABLED	ACPI_D_STATE_COUNT
+
 /**
  * acpi_power_state_string - String representation of ACPI device power state.
  * @state: ACPI device power state to return the string representation of.
@@ -157,6 +159,15 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 	    || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
 		return -EINVAL;
 
+	if (device->power.state == ACPI_D_STATE_DISABLED)
+		return -ENXIO;
+
+	if (device->power.state == ACPI_STATE_UNKNOWN) {
+		result = acpi_bus_init_power(device);
+		if (result)
+			return result;
+	}
+
 	acpi_handle_debug(device->handle, "Power state change: %s -> %s\n",
 			  acpi_power_state_string(device->power.state),
 			  acpi_power_state_string(state));
@@ -293,20 +304,11 @@ int acpi_bus_set_power(acpi_handle handle, int state)
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
@@ -340,9 +342,43 @@ int acpi_bus_init_power(struct acpi_device *device)
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
+	static DEFINE_MUTEX(init_power_lock);
+	int result;
+
+	/*
+	 * This is done to prevent power state initialization from being carried
+	 * out twice in parallel for the same device (not impossible, but very
+	 * unlikely).
+	 */
+	guard(mutex)(&init_power_lock);
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
+		device->power.state = ACPI_D_STATE_DISABLED;
+		acpi_handle_info(device->handle,
+			"Failed to determine initial power state, ACPI PM disabled\n");
+	}
+
+	return result;
+}
+
 /**
  * acpi_device_fix_up_power - Force device with missing _PSC into D0.
  * @device: Device object whose power state is to be fixed up.
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f48715ed827c..4586f1798685 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1145,8 +1145,7 @@ static void acpi_bus_get_power_flags(struct acpi_device *device)
 			device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
 	}
 
-	if (acpi_bus_init_power(device))
-		device->flags.power_manageable = 0;
+	device->power.state = ACPI_STATE_UNKNOWN;
 }
 
 static void acpi_bus_get_flags(struct acpi_device *device)
@@ -2354,9 +2353,7 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	acpi_bus_get_status(device);
 	/* Skip devices that are not ready for enumeration (e.g. not present) */
 	if (!acpi_dev_ready_for_enumeration(device)) {
-		device->flags.initialized = false;
 		acpi_device_clear_enumerated(device);
-		device->flags.power_manageable = 0;
 		return 0;
 	}
 	if (device->handler)
@@ -2364,16 +2361,10 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 
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




