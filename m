Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B83890F0;
	Mon, 31 Aug 2026 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199391; cv=none; b=Sq3Ajf+GY+YYjHOvaSO0r6dyYyqu4ept99m+CbsuZ9rjjiXNqvDgh8XYUlRKxK09nlhe85GKk1DNfS9RUdHD6Q1CzcshYQo0Ocf6VtgM8TGtzugWWxeyOArq2MKPeyeoXlayMf4+sR1bR4JSZmLW0vtpBhMPuzia6hND7FS5y3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199391; c=relaxed/simple;
	bh=usTz6BT99YxSRIyvs6OgvIWkR+1sM4Zm4wM/Jxjn08E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUBQgMWV3AMi84bYcnCk+4Rva2YGdmySBTwSsZC6it1mGKZaOmXnhJab1r8RPMeYNSVq5Ulhjg8RW6JTNQ/NBEyxcFyw2n0b/GBx0ootEiZ2iKMkm73FXOztwyLw7to1uytsk3aUv7AV33uf2AqGz4bGlAt6CP2LklsCJte7oBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWFfKGcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWFfKGcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841371F000E9;
	Mon, 31 Aug 2026 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199390;
	bh=REQHlQ5yz6XjcLL7YQQNTFNHpABAFjYAhtK5xxB9FqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWFfKGcyn+Ldwj2pn4QRKiw6+VXJDJXpL/WnHKM0rbwchr8o5KvdQrB60vGtqhUFQ
	 F3UwYS1ZBhJ7yDdOl2HenIBsGs6psyGx3o6LrU/dMBep81lZkxkXGszqllOPZ4Qzfd
	 yv9dwtGdGs9QLPMLr/fnMfAmaPXWq9vrfmi0qdIM8vDdk5jBZS3yFJCrIt95i3kZqu
	 4UHGq/yeXS6SKjcIukUjmdoQT173Rm33cYu4hBt26CteDnak72z+GuezBL70rjOqP6
	 dCTaTi3eDlrw3JP3+c/FoqnigTwA+S+vx00mQbK5eN3JNCaVpGXUHsTl9tA0d2A4U3
	 Ac4Clt0t4Dybg==
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
Subject: [PATCH v1 6/7] ACPI: scan: Adjust and rename acpi_bus_attach()
Date: Mon, 31 Aug 2026 19:59:43 +0200
Message-ID: <119223276.nniJfEyVGO@rafael.j.wysocki>
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

After previous changes, the second argument of acpi_bus_attach() is
ignored and none of its callers checks its return value, so rename
it to attach_subtree(), add a void wrapper around it called
acpi_scan_attach(), and adjust its callers to invoke that wrapper.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 153c66ca9217..517126fa2d50 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2338,7 +2338,7 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 	return ret;
 }
 
-static int acpi_bus_attach(struct acpi_device *device, void *not_used)
+static int attach_subtree(struct acpi_device *device, void *not_used)
 {
 	acpi_handle ejd;
 	bool skip;
@@ -2374,8 +2374,10 @@ static int acpi_bus_attach(struct acpi_device *device, void *not_used)
 	else
 		acpi_default_enumeration(device);
 
+	acpi_handle_debug(device->handle, "Scanning complete\n");
+
 children:
-	acpi_dev_for_each_child(device, acpi_bus_attach, NULL);
+	acpi_dev_for_each_child(device, attach_subtree, NULL);
 
 	if (!skip && device->handler && device->handler->hotplug.notify_online)
 		device->handler->hotplug.notify_online(device);
@@ -2383,6 +2385,11 @@ static int acpi_bus_attach(struct acpi_device *device, void *not_used)
 	return 0;
 }
 
+static void acpi_scan_attach(struct acpi_device *adev)
+{
+	attach_subtree(adev, NULL);
+}
+
 static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
 {
 	struct acpi_device **adev_p = data;
@@ -2414,7 +2421,7 @@ static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
 	struct acpi_device *adev = to_acpi_device(dev);
 
 	acpi_scan_lock_acquire();
-	acpi_bus_attach(adev, (void *)true);
+	acpi_scan_attach(adev);
 	acpi_scan_lock_release();
 
 	acpi_dev_put(adev);
@@ -2427,7 +2434,7 @@ static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 
 	/*
 	 * Async schedule the deferred acpi_scan_clear_dep_fn() since:
-	 * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
+	 * - acpi_scan_attach() needs to run under acpi_scan_lock which cannot
 	 *   be acquired under acpi_dep_list_lock (held here)
 	 * - the deferred work at boot stage is ensured to be finished
 	 *   before userspace init task by the async_synchronize_full()
@@ -2568,7 +2575,7 @@ static void acpi_scan_postponed_branch(acpi_handle handle)
 	 */
 	acpi_mipi_init_crs_csi2_swnodes();
 
-	acpi_bus_attach(adev, NULL);
+	acpi_scan_attach(adev);
 }
 
 static void acpi_scan_postponed(void)
@@ -2725,7 +2732,7 @@ int acpi_bus_scan(acpi_handle handle)
 	acpi_mipi_scan_crs_csi2();
 	acpi_mipi_init_crs_csi2_swnodes();
 
-	acpi_bus_attach(device, (void *)true);
+	acpi_scan_attach(device);
 
 	/* Pass 2: Enumerate all of the remaining devices. */
 
-- 
2.51.0




