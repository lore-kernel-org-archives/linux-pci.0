Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AB4A0900;
	Mon, 31 Aug 2026 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199416; cv=none; b=h8D3lRbt/MxDD8Ru3RBz6GulzlYxXyaJeWfmQS7HxjDsn3GVHoVx47w+dE0RpR1qfrgaIabtbsY+3pFmhg/pDXrvsQ0WxlOVZDBzIf9Mjclcd3nDcbSQNKsGk5fXrif96QBptbJ7gzDQSdn87gLAG7ZukT8g95lfzi6mon3WbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199416; c=relaxed/simple;
	bh=iMyxhWVh7Rr4KJRfKTQvtR8kMi5JQSShYR/h1ADrzCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/1jTChIxuqzu/D0TPiL0bING43cqMYlZ6xFX+tFv7LiGgp4twyitrLV5tyKHOczgc0BQK/Kh2sq/b8V1mV5qezwX65QyxWmVKeQ7nZBjsujLNgKROgNYOJHeRjIqYLw002qq8ZXDWCTbdX0zxfZkrO2ebmU34i0GEU8NJrQEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df2CxEFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df2CxEFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C371F000E9;
	Mon, 31 Aug 2026 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199414;
	bh=cskd0iYTaUw20Ox+TPHEQ0TPFgbD3GtDQn6sghM2JB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Df2CxEFgeqhW7RzBheoXSJDLJB6/2iOaD5KGmCoFGTVBj9qTUXeSi87QgWwyo1l/S
	 K20Dm3AsAmCsaY2Wh+7HLJx0QC/e77FbGfzUnoAQBW2P3lyWpr0q4GexGUs0m9rVvR
	 ggW1VG/VhqsPkIGmykaA9qcqt4d+Susd3y/SQVn0qoCpywTwltLeztI3r9G6OnN2AX
	 HIrT4cK/JeV9+xIGD/R5ttz+rcxe/S32GA4unZlzIGIMpMvlJ0hklX1TsGAy7O6Fkx
	 4Zl4980cJya5INsrm6C0fwQwkP1yP/gG9qcJrVIsPevl9uDPXaL2plnwk/7Ftujt9u
	 X/XpPRDmiL4IA==
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
Subject: [PATCH v1 1/7] ACPI: scan: Stop calling acpi_bus_init_power() early
Date: Mon, 31 Aug 2026 18:24:45 +0200
Message-ID: <10913616.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3435655.aeNJFYEL58@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
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
inadvertently, that causes devices with missing dependencies to be
put into power state D0 prematurely on some systems [1].

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
will run again for the device and now it will call
acpi_bus_init_power() that will take additional references to the
power resources used by the device in D0.  These additional
references prevent the power resources from being turned off when
the device goes into D3hot/D3cold.

To address this, stop calling acpi_bus_init_power() from
acpi_bus_get_power_flags(), but also take the initialization of
PCI devices into account, which needs to be done because they
are initialized and bound to their ACPI companions before
calling acpi_bus_attach() for the latter.

To that end, notice that each PCI device discovered on the bus
is put into power state D0 via pci_power_up() which involves
invoking acpi_device_set_power().  The initial ACPI power state of
the device needs to be known at that point to carry out the power
transition of it properly, so modify acpi_device_set_power() to
call acpi_bus_init_power() upfront if the device's ACPI power
state is still unknown.

Also use the ACPI power state tracking to decide whether or not
acpi_bus_init_power() needs to be called by acpi_bus_attach()
instead of using the "initialized" flag of the ACPI device object
for this purpose, which is fragile and inconvenient, and stop
clearing the power_manageable flag for devices with unmet
dependencies, which is not necessary.

While at it, add a debug message pringing statement to
acpi_bus_init_power() to facilitate diagnostics.

Fixes: 9d9bcae47fd5 ("ACPI: delay enumeration of devices with a _DEP pointing to an INT3472 device")
Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c | 19 ++++++++++---------
 drivers/acpi/scan.c      | 18 ++++++------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index aa55ecfc2923..a680e6972a8c 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -168,6 +168,12 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 	    || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
 		return -EINVAL;
 
+	if (device->power.state == ACPI_STATE_UNKNOWN &&
+	    acpi_bus_init_power(device)) {
+		device->flags.power_manageable = 0;
+		return -ENODEV;
+	}
+
 	acpi_handle_debug(device->handle, "Power state change: %s -> %s\n",
 			  acpi_power_state_string(device->power.state),
 			  acpi_power_state_string(state));
@@ -309,15 +315,6 @@ int acpi_bus_init_power(struct acpi_device *device)
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
@@ -351,6 +348,10 @@ int acpi_bus_init_power(struct acpi_device *device)
 		state = ACPI_STATE_D0;
 	}
 	device->power.state = state;
+
+	acpi_handle_debug(device->handle, "Initial power state: %s\n",
+			  acpi_power_state_string(state));
+
 	return 0;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f48715ed827c..1ad8dffc2daf 100644
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
@@ -2364,16 +2361,13 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 
 	acpi_ec_register_opregions(device);
 
-	if (!device->flags.initialized) {
-		device->flags.power_manageable =
-			device->power.states[ACPI_STATE_D0].flags.valid;
-		if (acpi_bus_init_power(device))
-			device->flags.power_manageable = 0;
+	if (device->flags.power_manageable &&
+	    device->power.state == ACPI_STATE_UNKNOWN &&
+	    acpi_bus_init_power(device))
+		device->flags.power_manageable = 0;
 
-		device->flags.initialized = true;
-	} else if (device->flags.visited) {
+	if (device->flags.visited)
 		goto ok;
-	}
 
 	ret = acpi_scan_attach_handler(device);
 	if (ret < 0)
-- 
2.51.0




