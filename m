Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B738DC7D;
	Mon, 31 Aug 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199406; cv=none; b=AMbWkfTdHy7hSUWQCa8duWw16j1zsoOOsqqttp8AtsM4KL9QJsG9CQXD0LwMYpgwXJ8wuwNb/W+dZkoVohn+Aj/XkC9QhCDNlGZZxYb/1c+p+rHvEkJREowrkkzmGkArZ3IBl+ogxkVtjk0cfSP8YAFmo//hEUTn0f9clU9kvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199406; c=relaxed/simple;
	bh=gFd0bJceZRbhmNr1NylyJtrUq/eohfDtcuJOnaDCZis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnehYekHEOifywYNkEoRbn0iKYFwnTYbirFeCqke2UqUzlW37JgAnDj5nFnSWJlhNe/Bl2y/jT3QbACMHQLlkZvLJM4xOXucpZIlDh9II1bnukVoHLsLpFRTJnHC9pTwAZiQR4v+QKMAJXWCQIkYbGjwP8z1tFj2H3bpgnSZv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/0wkucI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/0wkucI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D301F000E9;
	Mon, 31 Aug 2026 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199404;
	bh=RIJXAeTE/524kPKgwK0kh3gpXIdyXkgU64O8BI3fE0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/0wkucIRpyHgkZTScrkx2Ofkpesb/4iv1thOhtGmHF++4cNVJhosRFP+wOCi/vp+
	 FQdDw2La6HdHddTbPT8FK+vNtvCKK+hH8q9sPO7KQXebUqtxCwOVKz7L041gf30LjL
	 hAP4WDevaQUi4xtO5p0QaSLKhh2R1Eyn663x6C1RDeGZdUWh3Q5twmqThQL3kQq5NR
	 dTUHEIUeVpjyQEmKO6uLNRDwy/MQ0OXPeT2g2CM9Ho5lRpzyZdYHkX1kOnPrJ2xKJX
	 zpkQxTYRV4h/a2Rq+ItRL9uLfC4BrLvYcjLX+0oKIXxLi8hmZp6mwa8ZsoqWG+ynf2
	 rChclA+66S7Lg==
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
Subject:
 [PATCH v1 3/7] ACPI: bus: Drop initialized flag from struct acpi_device_flags
Date: Mon, 31 Aug 2026 19:59:23 +0200
Message-ID: <3782570.R56niFO833@rafael.j.wysocki>
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

After previous changes, the ACPI device object "initialized" flag is
not particularly useful.  It is set almost all the time and it is
only checked along with the "visited" flag, but checking the latter
is sufficient.

Drop it accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c     | 2 --
 include/acpi/acpi_bus.h | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5aa3ecb000e1..019a43e3b5d7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -281,7 +281,6 @@ static int acpi_scan_check_and_detach(struct acpi_device *adev, void *p)
 	 * that.
 	 */
 	acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
-	adev->flags.initialized = false;
 
 	/* For eject this is deferred to acpi_bus_post_eject() */
 	if (!(flags & ACPI_SCAN_CHECK_FLAG_EJECT)) {
@@ -1827,7 +1826,6 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	acpi_set_pnp_ids(handle, &device->pnp, type);
 	acpi_init_properties(device);
 	acpi_bus_get_flags(device);
-	device->flags.initialized = true;
 	device->flags.enumeration_by_parent =
 		acpi_device_enumeration_by_parent(device);
 	acpi_device_clear_enumerated(device);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b0d9057ccb8a..596fbd748e88 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -180,7 +180,6 @@ struct acpi_device_flags {
 	u32 removable:1;
 	u32 ejectable:1;
 	u32 power_manageable:1;
-	u32 initialized:1;
 	u32 visited:1;
 	u32 hotplug_notify:1;
 	u32 is_dock_station:1;
@@ -189,7 +188,7 @@ struct acpi_device_flags {
 	u32 cca_seen:1;
 	u32 enumeration_by_parent:1;
 	u32 honor_deps:1;
-	u32 reserved:19;
+	u32 reserved:20;
 };
 
 /* File System */
@@ -654,7 +653,7 @@ void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
 
 static inline bool acpi_device_enumerated(struct acpi_device *adev)
 {
-	return adev && adev->flags.initialized && adev->flags.visited;
+	return adev && adev->flags.visited;
 }
 
 /*
-- 
2.51.0




