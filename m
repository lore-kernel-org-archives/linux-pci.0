Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C64A8A3E;
	Wed,  2 Sep 2026 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377862; cv=none; b=Y5z8ZGzimKOHfyPBKxjGyNWV3Chk2qM4lceICELGDXbiuK8gh5PSss40ytUEWyVWeyEM/v2cHx1DgQRzgbE5XGp0FbYkhCE1GAok9qhBqFaO2jJp41zVeOK23c+Dk5TSXx0pfYUEa5PwRdwgTLcGEAog4YPRRaELatkVQ3IpiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377862; c=relaxed/simple;
	bh=DjTzLEHyk0kUZYaDTa0IYd0U8AjvXuDZw/iDjGi3OFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hI7oTq6QcqrBhkkexGPOTMAp9HTabYtIDvNpvPPb4zDsj8S7U2kqH7w1qkKTXuNcRTIYwy6MSVnzZqTAy3ZaszSq2ieJzufc+cUmHmC9aIv/TAQcipTJ3P1aBJW5TeAO78ZCD9sm8P0p2FMQLReA0aeZprVbC3HXjyt4exfIKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrU+vtGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrU+vtGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8D81F00A3A;
	Wed,  2 Sep 2026 19:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788377853;
	bh=Lq75btu937NUn8COCR1UmKHeQrreV5Fn5t7Gn+0V3Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RrU+vtGHwUuXGgVQYyvNyuo2UQAEIf937ff85XW3oP4IThfjWuvIMU5C0/Yhmup8M
	 ekJ2mvqOZJOSx0kYAXprYBUqXIw1dVIn1vr6Jb4KJHuSnHmDljDI+Cp77QxmghF4zz
	 2ggmAE6etOsWClub7ONmgB3VaRTRQjPJxZIHVs04DgPNjkmubXmubXYwHJOuBt3b8z
	 Hv+gqGa9XUIGqhKIvXKMFTkeXa6dgjbtyy2l9l/bPdwo7tN5UPU+AoTyNeu1nUTZAz
	 fdIEnigNEzVZMUo9qN4a8n33zhn92MAqjWtdYlJNa7jjfySL71X9jTFwbv4rFDb72H
	 /OHyMvd1L865Q==
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
Subject: [PATCH v2 5/6] ACPI: scan: Adjust and rename acpi_bus_attach()
Date: Wed, 02 Sep 2026 21:35:12 +0200
Message-ID: <9686682.CDJkKcVGEf@rafael.j.wysocki>
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

After previous changes, the second argument of acpi_bus_attach() is
ignored and none of its callers checks its return value, so rename
it to attach_subtree(), add a void wrapper around it called
acpi_scan_attach(), and adjust its callers to invoke that wrapper.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Peixin Xie <peixin.xie@linux.spacemit.com>
---

v1 -> v2:
   * Add tag from Peixin Xie

---
 drivers/acpi/scan.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2e853add5e60..f4718b0207e0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2340,7 +2340,7 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 	return ret;
 }
 
-static int acpi_bus_attach(struct acpi_device *device, void *not_used)
+static int attach_subtree(struct acpi_device *device, void *not_used)
 {
 	acpi_handle ejd;
 	bool skip;
@@ -2374,8 +2374,10 @@ static int acpi_bus_attach(struct acpi_device *device, void *not_used)
 	else
 		acpi_device_set_enumerated(device);
 
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




