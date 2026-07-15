Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668C40EBA9;
	Wed, 15 Jul 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128925; cv=none; b=DBzY+QM1wUx77LYVyTD8NaOw6GZoe3w4gTjMc2w/9U3zgLgy4VB4FK7qAGQAreKM073ENnFyDw43oR4pgM8CF4J7Qgc5j6bBrcBv/64RdIbZUZYS+UANJence6qBN5zXz6M3ZWBK3ajDc80eChUruL3akFXte/uQhL3yO0vE/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128925; c=relaxed/simple;
	bh=jm1yCrsLvBaRMPeKGtagOtNxLYscLBgr7paRV7Mqbps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoVUAYBvLc/uhmqMEkiBqCHn+QjeZZv5QuKvaQ/xP8JCBXAJqGNFkpTakGO7gP1d5xXIi7pziopZ/8yE5TjXcj+uEI8zfcznKJv6QnLzcJ485XP4D1RaC5LH5kE+5cZHHl7lpdslnoXtzhgVJcHXCYgk9DmZkbRy9U8C+w/obXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nresTu2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nresTu2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF95F1F00A3A;
	Wed, 15 Jul 2026 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128923;
	bh=qAFKoc8VBeYH5evWWoVFgDTqDzDGUM8zZbPAwX9yeQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nresTu2F5MHBRIPdl7GnD12DQFdi0qo0JvM7w/WQpBOnygvqSv/54BCINXAcHKXwK
	 TYfkVQNZ9MdehQ+kvNhfSCq9N2IB4s1YBMddwwtXzOGHv47mXxQKGaz2uFPBrbxzSM
	 0VIFKbY0pid9GtqAmol4UJhp1xMRGrRhNlSHxRKQl8uoPKWiJPFJ1FtE7gWwEMFb91
	 6jvqRgiJ8/uujud56hizwiIBBylOpzByY4KCkuK5fHz0Jxjr2YB5z6GUDWKYLZAzE3
	 Sn7R9AdLwruLuA89b7yFasvNRnoL+Wq24yn7bUI7lHW/KTKNBdYLMEbeugWRv+S+zC
	 8GXq3zup4LXyg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 4/4] ACPI: video: Use acpi_dev_get_pci_dev() instead of
 acpi_get_pci_dev()
Date: Wed, 15 Jul 2026 17:21:23 +0200
Message-ID: <8706171.T7Z3S40VBb@rafael.j.wysocki>
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
---
 drivers/acpi/acpi_video.c   |   11 ++++-------
 drivers/acpi/video_detect.c |    2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1048,7 +1048,7 @@ static int acpi_video_bus_check(struct a
 	if (!video)
 		return -EINVAL;
 
-	dev = acpi_get_pci_dev(video->device->handle);
+	dev = acpi_dev_get_pci_dev(video->device);
 	if (!dev)
 		return -ENODEV;
 	pci_dev_put(dev);
@@ -1702,7 +1702,6 @@ static void acpi_video_dev_register_back
 {
 	struct backlight_properties props;
 	struct pci_dev *pdev;
-	acpi_handle acpi_parent;
 	struct device *parent = NULL;
 	int result;
 	static int count;
@@ -1717,11 +1716,9 @@ static void acpi_video_dev_register_back
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
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -73,7 +73,7 @@ find_video(acpi_handle handle, u32 lvl,
 	};
 
 	if (acpi_dev && !acpi_match_device_ids(acpi_dev, video_ids)) {
-		dev = acpi_get_pci_dev(handle);
+		dev = acpi_dev_get_pci_dev(acpi_dev);
 		if (!dev)
 			return AE_OK;
 		pci_dev_put(dev);



