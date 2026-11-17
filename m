Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929582;
	b=FxWfsu3vjdqTalVbJ5M4tXpj5pRaNQQdmgy2Joc6QOrySPZccZP9qOND6RZJHk/rbCqP
	 Cw/QROnN7HBOS3b3G9omicFvZaGE0cwmflC+Tee4TU2Pvi/zMAErxtglC5N51InUD/qpW
	 Jnmyh1n4rU8M93ldQgv0mogEuE2jdHn0Er9s2GNYx1sJIvnrd8S+jH7j46J4IEmiHuET2
	 /42TcybPBEQcD35eh2eLXgkbjmlCO9QhfWiNabMEfkxAYpBpfEt5++ICDU5XnVlhgNQUT
	 zexhkcWhD9wltW7KITLnjwU3YWr+REqoJQRYlKbL2Q9HgLfIpGHbUKPA+M+ATnOvxAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929582;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=PCcoQbJlx1RYc6bQEWqrDO84aljJTHxUH08ZR34fWtQ=;
	b=Oz5DpK4hKsHF5Nj5GFPWhVvwpW9XPfT7KneZA5qpiOEL8ieChLeglb98git5Q+CG/BGk
	 fiK9ETNtt/ECpmXgDY0lOYeXcLtp/1KDCLu7GfKbzg2A9ber7CBiJzFu7mEx4sGQaXEbe
	 gNqY5dqd6/Q6ycaR+KEIYwYZ1G5Lbva1I4B3QMjcbZhxsj7ddAG0rniRY2p4NfzfuQEYy
	 yHjSi4dwTzlxPPhl2skq9fZ/JPLuyVFzZcDc0TteDsvUcVt/pWhDhS4JWpbGbraLdfYJi
	 KZfw3yUl6l5PwU3tjzh8rQjG5Xf5F8Hmyo+iVpJTnGyXOzRRtYLOntH7aekdFuUHlYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtQh5jMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F518606A32A;
	Tue, 17 Nov 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtQh5jMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61491F000C8;
	Tue, 17 Nov 2026 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929581;
	bh=PCcoQbJlx1RYc6bQEWqrDO84aljJTHxUH08ZR34fWtQ=;
	h=From:To:Cc:Subject:Date;
	b=YtQh5jMGYMLu78trYUFtG9/RGW1/XDpfkVfmEw5JftOyWnNl9MV4QGMgvgF8PUtaW
	 995lAC0ucuH26uyA2G0xldbVb8ggVmb69Fy2Owrv3LceSnDX1wPkswBXXKOElPp3S8
	 ZfitZUgaFDyr/9Sr4Vp5sFQ4bKrUveGsS8vd4UCcKv34e1ND2c9g+oCtZYM/RQ1V4G
	 UgevCBsOIVZUzqvGlBQZdZXoftKIauMQBypVl6eYPtYYWH0DXjdizwaxSXDkrH1HZb
	 KEyjDLNQQgBa+qtVx3zNBrN8rIjPu2ieUt6HKIxb8sglki85MaY4jXOS3CKTTEH9gx
	 p77MO4FluQguw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject:
 [PATCH v1] ACPI: PM: Avoid initializing power management for absent devices
Date: Tue, 17 Nov 2026 16:32:58 +0100
Message-ID: <6047463.DvuYhMxLoT@rafael.j.wysocki>
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
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    3 +++
 drivers/acpi/glue.c      |    8 ++------
 2 files changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -360,6 +360,9 @@ int acpi_bus_init_power(struct acpi_devi
 	if (device->power.state != ACPI_STATE_UNKNOWN)
 		return 0;
 
+	if (!acpi_device_is_present(device))
+		return -ENXIO;
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



