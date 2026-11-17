Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938297;
	b=1P1VBKcZ9n9tecpYEdt6BfyPeVYLuQtu6EsgwdifthoEmooyGC+PA6j4Y0NTsNiQaUOg
	 +l1GRhtgkDQyOLAOse1T55444ZyKvc9HoDFEgDL9hPk9W7/mrPtJFL8TTplsuOXgs5/ga
	 3yoXofv/bRqpkS2xy4XFueQYiGQkVmtw2VcQUwj1bOG3HS5KTkNNj0DjhczwvOW1O7CjV
	 BQKUXhDWyJ4bbr94NSnobeRjQySimab64G1meuc0fdOmP4RXujQicYulz+uBWc6eYzuMU
	 5eMeIuu2FP6wE+wKjxdYhSXrE+2E964+dEHpBj7BbJ7LoA9UkLC6JaT2TKR+zCRrSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938297;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Ao0/3OZje4TLYy53qVbs1Ocrd9OTD/q4KEFpbVJakG8=;
	b=FDkLhIuAJsIg2B2n1B6krKfpylHEoGOpMa2o4UfU4zIveT+gBZt3YWCk3y++Lj813re6
	 T0B5wm/3rbkeOVl8H3i5HrkaauL5OtA8yzu5VMXrCF9K579NfEn2mjOsaL9mTABBEXwML
	 R7d+RsDT01Vccmsx9OYjK0w7uKgMx5wLxw0SdHO2hBqKB0tTu+npyuZgU/3tlGg5Gddal
	 DYtGYzSzFkCQEAVX/rCQMZE5aHUrQ9O5OxCO5yVHv2PeG2WXDZCCw8Vf86QZJHXhp8wL9
	 RkrOaioLK+YzjbOewVvKzAV+B+n/pNZOup2n64/7oG7rgYxy43mqv2KfSVnF6xDru0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0AYM1um;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD64606A31C;
	Tue, 17 Nov 2026 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0AYM1um
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C721F000C4;
	Tue, 17 Nov 2026 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938297;
	bh=Ao0/3OZje4TLYy53qVbs1Ocrd9OTD/q4KEFpbVJakG8=;
	h=From:To:Cc:Subject:Date;
	b=W0AYM1umlEGiOYfBNug3kk1QM+13JWZ2JM7hhqcxCZOji/FGcI5rnVjnHlheoacCa
	 pL03czVIJuhttMKR7ymLg8kOD6d4wfSzGOuIaMqVFkzPJp2zFcn9t+E06J3kznCqPV
	 Pyez5l/72r2BAHpmFE/aUhwrvm7nLdhHtVJiYO9l3qvBPNLuU2gY+32FgPEh1C8Jrg
	 BvLGeRrhOhdWyYPfVCKBj8+DLH1pW9vh8v1aKPNIbwIOs2kCuHV76X8wA+r+Y/MNEo
	 7bBKGgV1c2xqCbMDVWYwm+6+RuIuwWnNlMv92mZbmTm4+tNVRAHHHnvlODTfxhcg1U
	 AqXRpn8JqbKiA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject:
 [PATCH v2] ACPI: PM: Avoid initializing power management for absent devices
Date: Tue, 17 Nov 2026 18:58:14 +0100
Message-ID: <2859265.mvXUDI8C0e@rafael.j.wysocki>
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

v1 -> v2:
   * Clear power_manageable when returning an error early from
     acpi_bus_init_power() (Sashiko)
   * Print debug message when that happens
   * Added Tested-by from Alan (thanks!)

Quick turnaround because it fixes a recent regression.

---
 drivers/acpi/device_pm.c |    7 +++++++
 drivers/acpi/glue.c      |    8 ++------
 2 files changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -360,6 +360,13 @@ int acpi_bus_init_power(struct acpi_devi
 	if (device->power.state != ACPI_STATE_UNKNOWN)
 		return 0;
 
+	if (!acpi_device_is_present(device)) {
+		device->flags.power_manageable = 0;
+		acpi_handle_debug(device->handle,
+				  "Device not present, ACPI PM disabled\n");
+		return -ENXIO;
+	}
+
 	/*
 	 * The ACPI device power state can be only initialized once.  If this
 	 * fails, ACPI power management will not be used for the device going
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



