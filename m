Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8173F54B6;
	Thu, 16 Jul 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210743; cv=none; b=mhjcy27ju0KKgogdP5IuIwXlhaTiZI6CbxhcsRlsEu8jrDTxM2sS9wdcsvgQgH7p8qtNM2H6PN1HigqFneZFHtXSSBn3SNx1krFs+Bg3mmsjfHZoIxVLFWIl8sh18oJ86zAYmQ9+N/urVAq9Y9Fp9ijVV9MWX7s1vJoTkduS7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210743; c=relaxed/simple;
	bh=ZOxNgOkv97RUGpAV5shxTbc5OjBWsdrvOhRczsurv8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyIOOW9ai+ff9ZAhvdM9PMzNrKaODPtyI6Xdihh4PpSEmorEum6ZeTM5kR8PPueqBokRI2RE4x+BrkR0chbSWcW/zeWmsR2qM6CK/vtzcJXxd6GrNrKsvzSfzfohPGVrJgs6lw04bwXatsMO/R3co3iyvfNXsn5ESLIKXOtngRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ9w/B8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ9w/B8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7BC1F00A3A;
	Thu, 16 Jul 2026 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210742;
	bh=xfMn2v+2dl9+Vzqd+0nRUzqnuYQ2L5XV2A/PvxeGCWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZ9w/B8DKxtR08GyKdnsSDTRAflt7vNSvUkob9BeeAdbP1XFt3KoUYcIaeWmC8rPE
	 bYVMygsgI72GK4XWWaXNp3l2Ycjflpd7WmudSuxvD+4JGII74vfdreiRP70lMawZUt
	 00SZHn7UrN4/uEJBBcLc2D+dU9f1FmRDPMGeqw8xkGMP9u751POW86lcD236JdthBj
	 gMwKqsAXE8+UuxQYKLsIzSxYC9HuWzYdxCxqDsFs3tA3iM1+sbdGSwszfcWsz41hAt
	 DCShF76LZ51GotF4LT4CRShXpotf/VokU1Of0JwdynyPXn11vkRogjGr5K1JWBWAZk
	 hXMzeXxFU6kUw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
Date: Thu, 16 Jul 2026 16:04:53 +0200
Message-ID: <3430928.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12935400.O9o76ZdvQC@rafael.j.wysocki>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki>
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

v1 -> v2:
   * Rephrase a new comment in acpi_dev_get_pci_dev() (Andy)

---
 drivers/acpi/pci_root.c     | 22 +++++++++++-----------
 include/acpi/acpi_drivers.h |  9 +++++++--
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d0dafc38b0cf..424f1b350983 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -293,20 +293,20 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 EXPORT_SYMBOL_GPL(acpi_pci_find_root);
 
 /**
- * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
- * @handle: the handle in question
+ * acpi_dev_get_pci_dev - Get a struct pci_dev for a given ACPI device
+ * @adev: Target ACPI device.
  *
- * Given an ACPI CA handle, the desired PCI device is located in the
- * list of PCI devices.
+ * Find the PCI device associated with @adev, if any, and bump up its reference
+ * counter.
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
@@ -323,7 +323,7 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
+EXPORT_SYMBOL_GPL(acpi_dev_get_pci_dev);
 
 /**
  * acpi_pci_osc_control_set - Request control of PCI root _OSC features.
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 402b97d12138..bff2ca035fcf 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -59,14 +59,19 @@ int acpi_pci_link_free_irq(acpi_handle handle);
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
-- 
2.51.0




