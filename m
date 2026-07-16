Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134B05A79B;
	Thu, 16 Jul 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210747; cv=none; b=suHiutJKDXQwbqxuu77OjaFg49jRBXH+aXd7Lh2dDCvwd/St6qrSg72BCHYSodk20LugVIz685JbsVI9v8GCH9ngDmPnwuH7xdQy1jZ7uGSPg4xYOuhFr9O9AVt9XSf2oF67W8cvHl/4fU7o254r1PsL1/qY1chHsm6zkGxFAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210747; c=relaxed/simple;
	bh=/sDPU6q9CK5n1ZQZkgjk5Vjow1hJOjk3J1T2W6vaX4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwO/EGEqtwe4YO1dJ0/xYUO4dPuT3+A6vHRIm29akofGKMQqn5/YAdu+rJ1Xc6P/b05z7plGT0Ng20lXnGRfSm1rLqRP/Ba2Bf5G4hHUfqvwJFjc05Tk9hqgcryy1FJcnNHqSVP00vup53bNz0ssHtEnm23r0HLBbHnhdSbXJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpseATal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpseATal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC4E1F00A3A;
	Thu, 16 Jul 2026 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210746;
	bh=X59kUg7q0I2C2CUNjvH2OEd+dNX4xknbv3IrGE+sgLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpseATalPRBXw9KUpgsqu/oZSe/omV/CvOmAlHxBtctFFVSOLqc/PVH4ToQz9h99/
	 XSEXfj+GBwkGoTEBUvFxRst/5eohiRBJ2F81vbiL21DD+ptmClkEampVGhU15bo+fC
	 h3yMZokU3k+L3a46+kL5feh+kSs3LAoZlMvYaplKtoPJtq2IkAyW0Q60Bvb5kMlRb/
	 xc0p58CP1sta1yK+dM57Mclu946gRjkEgOsjbnDwcTZhSCxJt/BhCPyNVreEJ4xRrZ
	 moXKN2iFol9A94mErz3m3XUgYU+eRQ79gxghUQ6tjXgXYyXrjKHhtvy5R8ejVgMf8y
	 jofghIetsjNMA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v2 1/4] ACPI: PCI: Use a mutex guard to simplify acpi_get_pci_dev()
Date: Thu, 16 Jul 2026 16:04:43 +0200
Message-ID: <3056272.e9J7NaK4W3@rafael.j.wysocki>
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

Use a mutex guard in acpi_get_pci_dev() for the physical_node_lock
locking and drop local variable pci_dev that becomes redundant after
that change.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Add cleanup.h include to pci_root.c (Andy)

---
 drivers/acpi/pci_root.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4c06c3ffd0cb..d0dafc38b0cf 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -307,24 +308,20 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 {
 	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 	struct acpi_device_physical_node *pn;
-	struct pci_dev *pci_dev = NULL;
 
 	if (!adev)
 		return NULL;
 
-	mutex_lock(&adev->physical_node_lock);
+	guard(mutex)(&adev->physical_node_lock);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node) {
 		if (dev_is_pci(pn->dev)) {
 			get_device(pn->dev);
-			pci_dev = to_pci_dev(pn->dev);
-			break;
+			return to_pci_dev(pn->dev);
 		}
 	}
 
-	mutex_unlock(&adev->physical_node_lock);
-
-	return pci_dev;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 
-- 
2.51.0




