Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817F38C406;
	Mon, 31 Aug 2026 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199397; cv=none; b=eI4+N+KEs/RD8WwpItCeaFeauNVRQ2Q8kN2MZvfKE0wGcNVXHoS6GdhHh5NgDaRYTbii7hcYiNaOWmn/xiE1x4GCi8fGE/k1UDO01iFIhylgfp8rmICLO1FycFkmX7mukltaLJWm0ek5Mt3mJv7SHApRuwdrKW7tzQxllyQPIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199397; c=relaxed/simple;
	bh=z/TKxHS3fiY/x2UBly3DAekxRLbpk/n/JXgR22DbP/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIIs3oTYzgI+XfHj0jwbs5vLwS/ADX1gxxVRUTpHguUnSxwUrqLWZCXC75yDRnGebroeXfnN/NOYcGV69e2pBmY8DKS6G0DmiRREBiGMnGvnPY/4OckQX7kBatl8DJDV7ljQq3G2njepP5+bQAbaMBzmqtGCjVo97G4gsV+c2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJysYaMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJysYaMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA8B1F000E9;
	Mon, 31 Aug 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199395;
	bh=lHzD36Z4PHTZ3/QkDEsEsv+1+hixBejRlTeQsJA85OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kJysYaMJOukPG/OsbIDfv5kiRg4763R1jWvVIKrYSkU/3y6ylj5ERpwYiOsmg6cIv
	 ymbLAtRC2DyVybWKwfnJPbFUoTEXaaSJWdsNCQEgnEq7CLFQMGHSLcXa+QPAxJMIvK
	 Eyi5b9Ivb3l6dYUMLX1g8ZRJDbt74n4r0BRtV2j1DyNjrLxv8DYCSIjNu0i7/ETNCp
	 wnXy3Lo3Fx+IS9SOBq18bXd2UzdyYQHNc3C+L4z7YMOHBxO84nLsP2PBg9PrXrgi7A
	 fSBUM5vZAiNm51KsGBslX5A0ma1D7jGZSZsB3ySOH90fDA6XOy0HJAvQNxnc8Aes8D
	 qhstcQII9Ir5A==
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
Subject: [PATCH v1 5/7] ACPI: scan: Add ACPI device "enumerated" marker
Date: Mon, 31 Aug 2026 19:59:38 +0200
Message-ID: <48339705.fMDQidcC6G@rafael.j.wysocki>
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

Currently, the "visited" flag of ACPI device objects has two roles.
One of them is to indicate that the given ACPI device object has been
enumerated, which basically means that either it has been associated
with a "physical" device representation, or there is no matching
"physical" device representation for it.  The other one is to
indicate that acpi_bus_attach() has processed the device.  That dual
purpose leads to some confusion regarding when that flag should be set
and cleared and by whom.

To address that confusion, add a new bool field called "enumerated"
to struct acpi_device for the purpose of indicating whether or not
the given ACPI device object has been enumerated.  Accordingly, switch
over acpi_device_enumerated() and acpi_device_set/clear_enumerated() to
operate on that field and the "visited" flag will now be only used
internally by the core ACPI device enumeration code.

Namely, acpi_bus_attach() will set flags.visited for a given ACPI
device object after it has been completely processed by that function
and regardless of its current status it needs to be "unattached", for
example by acpi_scan_check_and_detach(), so that acpi_bus_attach() can
process it again.

The rule regarding flags.visited and the "enumerated" field is that the
latter cannot be set until the former has been set and they need to be
cleared in reverse order.

This allows a couple of checks to be dropped from acpi_bus_attach()
and its first_pass argument is not needed any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c     | 28 +++++++++++++---------------
 include/acpi/acpi_bus.h |  3 ++-
 include/linux/acpi.h    |  4 ++--
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8c5a2fcef582..153c66ca9217 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -266,8 +266,8 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 		if (acpi_device_is_enabled(adev))
 			return 0;
 
-		/* Skip device that have not been enumerated. */
-		if (!acpi_device_enumerated(adev)) {
+		/* Skip device that have not been prepared for enumeration. */
+		if (!adev->flags.visited) {
 			dev_dbg(&adev->dev, "Still not enumerated\n");
 			return 0;
 		}
@@ -286,6 +286,7 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 	if (!(flags & ACPI_SCAN_CHECK_FLAG_EJECT)) {
 		adev->handler = NULL;
 		acpi_device_clear_enumerated(adev);
+		adev->flags.visited = 0;
 	}
 	return 0;
 }
@@ -304,6 +305,7 @@ static int acpi_bus_post_eject(struct acpi_device *adev, void *not_used)
 	}
 
 	acpi_device_clear_enumerated(adev);
+	adev->flags.visited = 0;
 
 	return 0;
 }
@@ -2336,26 +2338,23 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 	return ret;
 }
 
-static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
+static int acpi_bus_attach(struct acpi_device *device, void *not_used)
 {
-	bool skip = !first_pass && device->flags.visited;
 	acpi_handle ejd;
+	bool skip;
 	int ret;
 
+	skip = !!device->flags.visited;
 	if (skip)
-		goto ok;
+		goto children;
 
 	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
 		register_dock_dependent_device(device, ejd);
 
 	acpi_bus_get_status(device);
 	/* Skip devices that are not ready for enumeration (e.g. not present) */
-	if (!acpi_dev_ready_for_enumeration(device)) {
-		acpi_device_clear_enumerated(device);
+	if (!acpi_dev_ready_for_enumeration(device))
 		return 0;
-	}
-	if (device->handler)
-		goto ok;
 
 	acpi_ec_register_opregions(device);
 
@@ -2363,21 +2362,20 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	    device->power.state == ACPI_STATE_UNKNOWN)
 		acpi_device_init_power(device);
 
-	if (device->flags.visited)
-		goto ok;
-
 	ret = acpi_scan_attach_handler(device);
 	if (ret < 0)
 		return 0;
 
+	device->flags.visited = 1;
+
 	if (!device->flags.enumeration_by_parent && (ret > 0 ||
 	    (!device->pnp.type.platform_id && !device->pnp.type.backlight)))
 		acpi_device_set_enumerated(device);
 	else
 		acpi_default_enumeration(device);
 
-ok:
-	acpi_dev_for_each_child(device, acpi_bus_attach, first_pass);
+children:
+	acpi_dev_for_each_child(device, acpi_bus_attach, NULL);
 
 	if (!skip && device->handler && device->handler->hotplug.notify_online)
 		device->handler->hotplug.notify_online(device);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 596fbd748e88..4392e3d6cd7a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -467,6 +467,7 @@ struct acpi_device {
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
+	bool enumerated;
 };
 
 /* Non-device subnode */
@@ -653,7 +654,7 @@ void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
 
 static inline bool acpi_device_enumerated(struct acpi_device *adev)
 {
-	return adev && adev->flags.visited;
+	return adev && adev->enumerated;
 }
 
 /*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812094..2e9e49e2e665 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -782,12 +782,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *,
 
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)
 {
-	adev->flags.visited = true;
+	adev->enumerated = true;
 }
 
 static inline void acpi_device_clear_enumerated(struct acpi_device *adev)
 {
-	adev->flags.visited = false;
+	adev->enumerated = false;
 }
 
 enum acpi_reconfig_event  {
-- 
2.51.0




