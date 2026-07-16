Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8C30D3F6;
	Thu, 16 Jul 2026 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210735; cv=none; b=URQusoa4xnnPM8ajGsi+2LE59sW8gNlRYXLaMvXQBV8BLEin8STzcuNXJ2AoQ5XPQf0oet/wfXOsnA+qqsMMDgPdqj4Y293TBab+i9QGFwBPa6kchMi6GF6/cuMTuViUUjZCp79TLvpdFOjs2vxkQE6SO8Kl67gGNhT0VgNNqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210735; c=relaxed/simple;
	bh=qOame8yL2bFS9tmVYgjvmMBhJg+G9yIhjdWUBW9pBEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JznXer83vmKMqk6WyqPJHJ15eYnBte8zVCwh/7YvL8kvlKHqID/cod0J+JQjRU6FSwHGMCe1frHKLqO20UaNdhryYMpX/R90L9vngU6w2RGLTLHq30sxoezwr7kCcPPm1e5K0/ZCDpT3y5luczdlsQAtuuwbNjrI9b+qoBG35mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV9rECtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV9rECtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD71F000E9;
	Thu, 16 Jul 2026 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210734;
	bh=T2yQvWX9WQPJKafPt9KYxplekoHhn1wAaR3oP4LsIqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GV9rECtCJ6ZZ9l86qn29lYQfPUUAYwO6CrjbSEA82xVl7504vO0mtj3U/Y1HAh2Ok
	 MovMb7Q/HVmebIXtHKUh5ptLcYL6u6abvl7rCPg60BU158nXBZX4CZVipya4cr2HRy
	 j0QR5NSo/6WqcnB9XUCNpbTMYqPf1UiHwznUtjSitP5Ec31r26TwXoQWX3thNIUvX/
	 cgMVWOxFoTWIQg8jXDp9r/s6e3pI0ehebVMrQ1BoT1iltmSRMzFdpYGJ0IpByE43DT
	 biiZU5uCLML34lJDKGHr6lnakDMQadkGmMI/5wUMnlPFqFS0srQM+9E5G9nHKg5iMB
	 94TVDlSRYvBbQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v2 4/4] ACPI: video: Use acpi_dev_get_pci_dev() instead of
 acpi_get_pci_dev()
Date: Thu, 16 Jul 2026 16:05:13 +0200
Message-ID: <2047771.PYKUYFuaPT@rafael.j.wysocki>
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

In acpi_video_bus_check() and find_video(), simply replace
acpi_get_pci_dev() with acpi_dev_get_pci_dev() that can be used
in both places because the ACPI device needed to do the lookup is
available.

In acpi_video_dev_register_backlight(), instead of doing a parent ACPI
handle lookup based on the handle of an ACPI device that is already
available, pass that ACPI device to acpi_dev_parent() which is much
more straightforward and pass the return value of the latter directly
to acpi_dev_get_pci_dev() to get the PCI device associated with it.
That allows local variable acpi_parent to be eliminated.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v1 -> v2:
   * Add R-by from Andy

---
 drivers/acpi/acpi_video.c   | 11 ++++-------
 drivers/acpi/video_detect.c |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a738265279cd..4d6fd9f6e9ad 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1048,7 +1048,7 @@ static int acpi_video_bus_check(struct acpi_video_bus *video)
 	if (!video)
 		return -EINVAL;
 
-	dev = acpi_get_pci_dev(video->device->handle);
+	dev = acpi_dev_get_pci_dev(video->device);
 	if (!dev)
 		return -ENODEV;
 	pci_dev_put(dev);
@@ -1702,7 +1702,6 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 {
 	struct backlight_properties props;
 	struct pci_dev *pdev;
-	acpi_handle acpi_parent;
 	struct device *parent = NULL;
 	int result;
 	static int count;
@@ -1717,11 +1716,9 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 		return;
 	count++;
 
-	if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_parent))) {
-		pdev = acpi_get_pci_dev(acpi_parent);
-		if (pdev)
-			parent = &pdev->dev;
-	}
+	pdev = acpi_dev_get_pci_dev(acpi_dev_parent(device->dev));
+	if (pdev)
+		parent = &pdev->dev;
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_FIRMWARE;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 458efa4fe9d4..c5b08c19e847 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -73,7 +73,7 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	};
 
 	if (acpi_dev && !acpi_match_device_ids(acpi_dev, video_ids)) {
-		dev = acpi_get_pci_dev(handle);
+		dev = acpi_dev_get_pci_dev(acpi_dev);
 		if (!dev)
 			return AE_OK;
 		pci_dev_put(dev);
-- 
2.51.0




