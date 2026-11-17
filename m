Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942588;
	b=Hi/C+2HlJdWGkBaUCFlKAJTqeV3jfbM47Z/1qX+obr6ByEK6bzl+9Z8utaQk6b9jILT3
	 lVfHSEx4HtiYZXJPP58ZzodZnGyxGItSJ6tQF4PIfSuBsCLjwjkJqgc/m+fj+TC7ktQKf
	 Uw0Sfwer7oIXGbCRIDpw/MDdW7J8bhiwScYDBJZMUyyLHi6rfizKybGXgnHy/ykuPIuR7
	 7UU5iGhhWgyJD1rZCsgX21CgNrFIrM9wKEg0NXoATBtgswjcrPK+QDeMsB123omwsOGR+
	 YpCGk4mmuOdmoJjyZzdTrSGLt4XY3VEqKYOJnxyY60ivqeLhvH4XqfKODvK+cQjGp/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=ZDcHq/AOC/OWPDGUOT6/vfP4a3L21dDTqfqlVs8RLMc=;
	b=HsLYc4udgqOCK1pZTGJRe/WNmG7E6BoxBhMLAwFCt6jhurDpHFvCnimo0ZfwKzGgFEaO
	 6mWYBFiqEXlNm3CTs1CUbvv1gJq2ZFC+2Pj+5sF48sAhPwwmDPo+adhXnUbHgRpxv6Afg
	 ETQIUjoFsstsTJ9fnSXjUsSef4BtnhLA1TDSwa3nonVWQusezSaa1mvf5W4IQ2wJQrMYU
	 2OvHY05Y8cPEYxEaqVpRVrUl306oR23pC/VPBfv6maw8FUMYIC5ep9/D9rBgEo4mUAKIG
	 SwKE54Wu/FfzJ/iqwxvXknizxkFuzZrwRVRSDZOpzR5UiEs7bpLFtbaVrITRuat5jJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyV+XpF8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D7606A32C;
	Tue, 17 Nov 2026 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyV+XpF8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5E81F000C4;
	Tue, 17 Nov 2026 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942588;
	bh=ZDcHq/AOC/OWPDGUOT6/vfP4a3L21dDTqfqlVs8RLMc=;
	h=From:To:Cc:Subject:Date;
	b=PyV+XpF8cNgrNmloGNf9z60qVUikEdZxgTJyZulItapkO09LfMmYKJGk8CAbr9BAK
	 3V3fAB9XEUdVJVWNDaIWAjidi0LLnwVLCwvjIwr1A2OjFxmRbWXBjUra0SjRkj3GhK
	 nPaHShmIdWjsq0NhojI/wV+9GnyvuUsct3Yd/iyJKvCGYPxd+u0n3hxRvRYh7TcnoP
	 g99k9UUd1DbhSUT6A/5I8kYmiPDbQ28c7HFEJMeKkwgJ1HohONit3C6vZ+I85bK3Z3
	 OPkDaSWI3yCoKW0bymUh1Gj9X/qIeJhF4hzC53V5XQrlP+O5R40RG8aUMvQsis4ihQ
	 VELzxqoLOGZDw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject:
 [PATCH v3] ACPI: PM: Avoid initializing power management for absent devices
Date: Tue, 17 Nov 2026 20:09:45 +0100
Message-ID: <13013440.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Commit 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power()
early") removed a device presence check from acpi_bus_init_power() which
in some cases causes power management to be initialized for an ACPI
device object and never used going forward.  That in turn may prevent
power management from working as expected for other devices.

Namely, if a given ACPI device object is not enabled according to its
_STA, find_child_checks() will return an error for it which will prevent
it from being used as an ACPI companion for a PCI device.  Thus if
acpi_device_init_power() initializes power management for it and its
initial power state turns out to be different from D3cold, it may stay
in that power state forever.  If it has power resources and they are
"on" during the initialization, they may be reference-counted and never
turned off.  If they are shared with other devices, they will prevent
power from going down after attempting to put the other devices into
low-power states.

To prevent that from happening, restore the device presence check in
acpi_bus_init_power(), but also adjust find_child_checks() to return
an error for absent devices (instead of doing that for disabled devices)
in accordance with acpi_bus_init_power() and the existing check in
acpi_bus_attach().

Fixes: 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power() early")
Reported-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Tested-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Also set power.state to ACPI_D_STATE_INVALID if the device is
     not present when acpi_bus_init_power() runs (Sashiko)

v1 -> v2:
   * Clear power_manageable when returning an error early from
     acpi_bus_init_power() (Sashiko)
   * Print debug message when that happens

Quick turnaround because it fixes a recent regression.

---
 drivers/acpi/device_pm.c |   15 +++++++++++++--
 drivers/acpi/glue.c      |    8 ++------
 2 files changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -365,14 +365,25 @@ int acpi_bus_init_power(struct acpi_devi
 	 * fails, ACPI power management will not be used for the device going
 	 * forward.
 	 */
+	if (!acpi_device_is_present(device)) {
+		acpi_handle_debug(device->handle,
+				  "Device not present, ACPI PM disabled\n");
+		result = -ENXIO;
+		goto fail;
+	}
+
 	result = acpi_device_init_power(device);
 	if (result) {
-		device->flags.power_manageable = 0;
-		device->power.state = ACPI_D_STATE_INVALID;
 		acpi_handle_info(device->handle,
 				 "Initial power state undetermined, ACPI PM disabled\n");
+		goto fail;
 	}
 
+	return 0;
+
+fail:
+	device->flags.power_manageable = 0;
+	device->power.state = ACPI_D_STATE_INVALID;
 	return result;
 }
 
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -109,14 +109,10 @@ static bool acpi_dev_has_children(struct
 
 static int find_child_checks(struct acpi_device *adev, bool check_children)
 {
-	unsigned long long sta;
-	acpi_status status;
-
 	if (check_children && !acpi_dev_has_children(adev))
 		return -ENODEV;
 
-	status = acpi_evaluate_integer(adev->handle, "_STA", NULL, &sta);
-	if (status == AE_NOT_FOUND) {
+	if (!acpi_has_method(adev->handle, METHOD_NAME__STA)) {
 		/*
 		 * Special case: backlight device objects without _STA are
 		 * preferred to other objects with the same _ADR value, because
@@ -128,7 +124,7 @@ static int find_child_checks(struct acpi
 		return FIND_CHILD_MIN_SCORE;
 	}
 
-	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_ENABLED))
+	if (!acpi_device_is_present(adev))
 		return -ENODEV;
 
 	/*



