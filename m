Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E5380FD7;
	Mon, 31 Aug 2026 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199387; cv=none; b=aLGwOG7WHbi5fmKdZEr0BGOYtqOaAFSr7gVLrYFguc2gpyZH23zImaJIpveN0kHsgg88HupdUHw0Fc4APYBbQgp1XSAbrI7hpE6B0NO9lagbXvtQcGsQ9NAABJXUcHfw5Qiq3j/JNvUtbi0qrZ7Dm3xjStisFXQyoFFvNThAU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199387; c=relaxed/simple;
	bh=pi3Fwn5vF5AA556g2QfMIap6zHevvziLNXXptsaNp/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQlGzpei5uzVA0o7OlN+KA8XWOXrQVvFBDqOdRONK40VQWp06R5cIZOTBlRkXjtRrB62SUWHHThGDbFXgJRxyvU2aHOo5yMqgRMS45yVOVjsrdlxBjOayM33325Rx6RhbE5jwBJtgILmMntkKUusnoy5frRYglmx9FjI9M0+zu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB+3+kIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB+3+kIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADB91F000E9;
	Mon, 31 Aug 2026 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199385;
	bh=BaAdfFx+ATQeuMwnTLoTnA+GSLV9GVIhP+sms2JoAm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KB+3+kIH+nwmXbQg6Z8gWHHDVBZ8SqI9CccoTJk/+eY3lujQRk5Kt4falYbNVSfKE
	 +YhIvxlvyZ9I+j5ICcityh88zPf4fo+JzpjKzBbYc6iArdJD4/wVHxr3drsdS9Jopy
	 0MzJBUqhH8lMaJf4DtFhehxm8/92qftSmJTz9618enKB832Mryx0tbTBMYR6KPAwp9
	 sYhwPUcJY3bMczOOxdbdooCOh2GwJ43Zqt236FrU6khmWYlYUy1aJjNyQfA1tL1Cu8
	 QX61xnXnsAioy0WtYFMRQ0IoaY7k8zDKKbqg7wBMzI/Gez7G38sAEdKbvOScc8z9VC
	 kEnbGEUBubw1Q==
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
 [PATCH v1 7/7] ACPI: scan: Take PCI device enumeration into account directly
Date: Mon, 31 Aug 2026 19:59:48 +0200
Message-ID: <2497062.NG923GbCHz@rafael.j.wysocki>
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

The ACPI companions of PCI devices are associated with the corresponding
PCI devices before being processed by acpi_scan_attach() and by the time
they are passed to attach_subtree(), the PCI devices associated with
them have been already enumerated and initialized (including power
management initialization).

Accordingly, it is not necessary or even useful to check their status in
attach_subtree(), so do not do that.

Fixes: 2c22e6520ac8 ("ACPI / scan: Use direct recurrence for device hierarchy walks")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 517126fa2d50..53e11cbb79ce 100644
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
@@ -2340,6 +2341,7 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 
 static int attach_subtree(struct acpi_device *device, void *not_used)
 {
+	struct pci_dev *pci;
 	acpi_handle ejd;
 	bool skip;
 	int ret;
@@ -2351,10 +2353,26 @@ static int attach_subtree(struct acpi_device *device, void *not_used)
 	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
 		register_dock_dependent_device(device, ejd);
 
-	acpi_bus_get_status(device);
-	/* Skip devices that are not ready for enumeration (e.g. not present) */
-	if (!acpi_dev_ready_for_enumeration(device))
-		return 0;
+	/*
+	 * If the given ACPI device object has been already associated with a
+	 * PCI device found on the bus, the device can be regarded as present
+	 * and functional.
+	 */
+	pci = acpi_dev_get_pci_dev(device);
+	if (pci) {
+		acpi_handle_debug(device->handle, "PCI companion %s found\n",
+				  dev_name(&pci->dev));
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




