Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379A481649;
	Wed, 15 Jul 2026 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128936; cv=none; b=LPTJ9tc5ScsqYsfI+b2hSwcVQvFj5rVueWihmhoJBY5Sfp788SlSBySyWTkglYgfKavJiK5zVj9nmkcpiuqWkfIc2Xm8+FO0z3DFQPXzqNPw7bI5ytpKaHi5dw1ghILQWja3TrLT+gBQTeQE0SIHDKyqiPoP6kXqvOnMCx5jKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128936; c=relaxed/simple;
	bh=5kN7mG8MLPeE9D88nkEBmLkjEsCxbdAekhzV3FbzuIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry5aiNcC5gMwqwBLwue+x8byzF8Nb+kW2r0sbDBnROmAECIKQmV+AOadzH8w4cp1ABRLoo1IBLbHRMHiKv0suhZf64OCqQGjdquWJyUddFA8SaiN5F4u6IaE5WxvXx1whBSe3c3R6AEiq+XN2mwQ3J+vwP9wNfe7zQdG4kvEdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKTPTZEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKTPTZEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5146F1F000E9;
	Wed, 15 Jul 2026 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128934;
	bh=UTenFSNRSjR+ibmn54+yGt4eFEr8XTDncmHSXL7R4vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKTPTZExW7nGutrI28Ewtx5WJVOIEOsW2IH+fN8daEXtfvXfhN4AoC/oLENy7Ezb6
	 GEkISbAZ6CLe0W0KdCxiYL8etWDbVIh10dKSkONjgvvHRVMiQQpYIbsfqSDMsv5EXn
	 K3onR5Q1JadUgzjuMaunMpems++RCibjseK4jB+Z7Cf3UC6Cldboawac9PXtkHe8n+
	 +5AxhodKE66f8Zv24Ec0LR0gAP2M9FIoc+X3OlKfBGir6TFpgu+87i1QrXGPf5jVHb
	 8hc2mkcTFlAauANRmNDy3PHiUM1AhNA1V2lj13hklUoCZkRYTPoPIg3bFeN38TlbB5
	 U2CyWNY3+hxKw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
Date: Wed, 15 Jul 2026 17:16:19 +0200
Message-ID: <1961532.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5115219.31r3eYUQgx@rafael.j.wysocki>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Some acpi_get_pci_dev() callers already have a struct ACPI device for
which they want to get the struct pci_dev pointer of the associated
PCI device, so they don't need to look for one.

For this reason, add acpi_dev_get_pci_dev() that will get a PCI device
for a given ACPI one (if possible) and turn acpi_get_pci_dev() into
a static inline helper passing the acpi_fetch_acpi_dev() return value
directly to acpi_dev_get_pci_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c     |   22 +++++++++++-----------
 include/acpi/acpi_drivers.h |    9 +++++++--
 2 files changed, 18 insertions(+), 13 deletions(-)

--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -292,20 +292,20 @@ struct acpi_pci_root *acpi_pci_find_root
 EXPORT_SYMBOL_GPL(acpi_pci_find_root);
 
 /**
- * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
- * @handle: the handle in question
+ * acpi_dev_get_pci_dev - Get a struct pci_dev for a given ACPI device
+ * @adev: Target ACPI device.
  *
- * Given an ACPI CA handle, the desired PCI device is located in the
- * list of PCI devices.
+ * Get the first PCI device associated with @adev, if present, and bump up its
+ * reference counter.
  *
- * If the device is found, its reference count is increased and this
- * function returns a pointer to its data structure.  The caller must
- * decrement the reference count by calling pci_dev_put().
- * If no device is found, %NULL is returned.
+ * Callers are responsible for dropping the PCI device reference obtained by
+ * this function.
+ *
+ * Return: The struct pci_dev pointer of a reference-counted PCI device on
+ * success or NULL on failure.
  */
-struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
+struct pci_dev *acpi_dev_get_pci_dev(struct acpi_device *adev)
 {
-	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 	struct acpi_device_physical_node *pn;
 
 	if (!adev)
@@ -322,7 +322,7 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
+EXPORT_SYMBOL_GPL(acpi_dev_get_pci_dev);
 
 /**
  * acpi_pci_osc_control_set - Request control of PCI root _OSC features.
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -59,14 +59,19 @@ int acpi_pci_link_free_irq(acpi_handle h
 struct pci_bus;
 
 #ifdef CONFIG_PCI
-struct pci_dev *acpi_get_pci_dev(acpi_handle);
+struct pci_dev *acpi_dev_get_pci_dev(struct acpi_device *adev);
 #else
-static inline struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
+static inline struct pci_dev *acpi_dev_get_pci_dev(struct acpi_device *adev)
 {
 	return NULL;
 }
 #endif
 
+static inline struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
+{
+	return acpi_dev_get_pci_dev(acpi_fetch_acpi_dev(handle));
+}
+
 /* Arch-defined function to add a bus to the system */
 
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);



