Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856F4A99AC;
	Wed,  2 Sep 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377863; cv=none; b=ZhQgaRHihsE5u+WTciLty0zpBYB6pHmFZuPWwMOPtzjnNSsq/ZW0NrRfPPZ7Iz6BnT60KFjw+98bp2FNtTGs6u/sjril5B3ERo2Q38/E3dHHfBQoZj4tPXylCfysuZvYioGEol9ss99fVoKpDBgELA+VX9M/iqGOpHxHRyxxztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377863; c=relaxed/simple;
	bh=jM9b2f+Nn9Imi+lXFsX2BCw2u+RlF2jaBBu0Eu3DeUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiVo+2uUSmXfU50egih43kb1XiDt6AM4VNitfFYbZ+we2OBVpM5N+/xKU1tn2x3tEBqR6x2H++T9/L+IUdi6FSS5AzvQGGBMLcvXxOh+Pbafg57QNiC99ReNm0Qa2wqwDRDQu4TIKw2Cs0qCPC5IFYnT8C4LOc1iE9yyap9xWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt39e7dx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt39e7dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8998B1F000E9;
	Wed,  2 Sep 2026 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788377848;
	bh=ME7Oa9tlnBvhfSeMWhbUflPUMywEW6yITBPS5fkeCss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wt39e7dxKLF/hivfCE65T1B2pooC6lZcaElpjr9OulG69Q8eJ5SbQHEyxxoFTVJTg
	 AD56a2YMhNEOu/DfwwcMWuk4ae1f6cbb2wcVEsYVet6RSiYkyL6paa0uR0v7EAgRq/
	 /cWmJHckiqmW3wQhBpGl9+U6GGVgHQWIMv7C6UnllSzwcnyy8O87LAPROQtzMRgXQI
	 i9M76PLDrjhcnH2JrxsdWPIXwsNluALp6vohJWItDzkFoD631QcheS5iEFhR0QWvOS
	 vB601hOK2DViVH5OI7ub4fKk0DZnghPfS0HS7ITm9r/RYEkJ01nzlzMyqorepWukFy
	 8mdh0PPwhORgg==
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
 [PATCH v2 6/6] ACPI: scan: Take PCI device enumeration into account directly
Date: Wed, 02 Sep 2026 21:36:54 +0200
Message-ID: <6207934.MhkbZ0Pkbq@rafael.j.wysocki>
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

The ACPI companions of PCI devices are associated with the corresponding
PCI devices before being processed by acpi_scan_attach() and by the time
they are passed to attach_subtree(), the PCI devices associated with
them have been already enumerated and initialized.

Accordingly, it is not necessary or even useful to check their status in
attach_subtree(), so do not do that.

Fixes: 2c22e6520ac8 ("ACPI / scan: Use direct recurrence for device hierarchy walks")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Peixin Xie <peixin.xie@linux.spacemit.com>
---

v1 -> v2:
   * Use pci_name() (Andy)
   * Add tag from Peixin Xie

---
 drivers/acpi/scan.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f4718b0207e0..34f7f477a25a 100644
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
@@ -2342,6 +2343,7 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 
 static int attach_subtree(struct acpi_device *device, void *not_used)
 {
+	struct pci_dev *pci;
 	acpi_handle ejd;
 	bool skip;
 	int ret;
@@ -2353,10 +2355,26 @@ static int attach_subtree(struct acpi_device *device, void *not_used)
 	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
 		register_dock_dependent_device(device, ejd);
 
-	acpi_bus_get_status(device);
-	/* Skip devices that are not ready for enumeration (e.g. not present) */
-	if (!acpi_dev_ready_for_enumeration(device))
-		return 0;
+	/*
+	 * If the given ACPI device object has been already associated with a
+	 * PCI device found on the bus, its status is effectively "present
+	 * and functional".
+	 */
+	pci = acpi_dev_get_pci_dev(device);
+	if (pci) {
+		acpi_handle_debug(device->handle, "PCI companion %s found\n",
+				  pci_name(pci));
+
+		pci_dev_put(pci);
+	} else {
+		acpi_bus_get_status(device);
+		/*
+		 * Skip devices that are not ready for enumeration (e.g. not
+		 * present).
+		 */
+		if (!acpi_dev_ready_for_enumeration(device))
+			return 0;
+	}
 
 	acpi_ec_register_opregions(device);
 
-- 
2.51.0




