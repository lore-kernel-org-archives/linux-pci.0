Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD69480DEA;
	Wed, 15 Jul 2026 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128930; cv=none; b=MHtYHr3E78YZdoykhz+Of87whqQhDVVrgG67Qk1hDu0nid1tjdFRMVfSAj+OpBB0d0GZ23/D3xLX5oOOSfmdrbgZTI3/Uv1MMRr0bidmKV470QVae8SLFJzO2GMWptGWAtT02NnVZLcrEzCkuIk1EdPxaDX2yAu+1FI36WO5uTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128930; c=relaxed/simple;
	bh=NJwngsj2BfQ9Ix2pHh54/q2ByY9XfKwTz+ab5tsBCuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmV45PB+8QUorsvfhX/RY+E/vRNlkfqjmrIR0xW2GPVOg95ZKAy0csBkJXK3fj+Y3UvBjjGrM0P7Tq8rfBXcHLZRlHOPOfmQ9wwbhZC1tWj27wXKHL/SnJfF2fgzzc6ynUcyz7an87QBSr5wE3+SCA+xwsZsSX0Licl1FJ6wU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOjgOfCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOjgOfCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADA11F00A3A;
	Wed, 15 Jul 2026 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128929;
	bh=9ZXuSwwi8Q8hBGWu3awGYkOUS7/xJRkJwC+I+CXvTYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOjgOfCDXTvGEKwmy6waNqwpIWLwhZpE+IcRYLnXDSIDpz2TJFQL8ZDmZXt2kGeph
	 tQTk8099WzyhCC8JFnJEc+7cHQujbiPyk8lMANknfancBFgUjQQyv50qzW6n/PEG1D
	 Gf+q2mVxR2JjyYV1rlIO3Q+SohYe4TDxskfPlyPMvhDG7Nfyq15ZLN5i2XSbtaawwC
	 epvr1JpOaVF2BJ7FKEoehjvSbYqe5qrgezPJS8xC4IfcSYpbQOdQtdgITsxdqFNaPm
	 ab4BvFRYC9WgNS7EEHjSwu/43mEbLW0OQ/cbl/RZqdKk7A1RiYB2UHRJ5mvF8342Xd
	 ZWgJMWRgw73bA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 3/4] ACPI: video: Drop backlight parent device reference later
Date: Wed, 15 Jul 2026 17:19:08 +0200
Message-ID: <3052896.e9J7NaK4W3@rafael.j.wysocki>
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

Update acpi_video_dev_register_backlight() to put the parent device after
registering the backlight class device under it instead of attempting to
register the backlight class device under a parent that (theoretically)
may be gone at that point.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1719,10 +1719,8 @@ static void acpi_video_dev_register_back
 
 	if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_parent))) {
 		pdev = acpi_get_pci_dev(acpi_parent);
-		if (pdev) {
+		if (pdev)
 			parent = &pdev->dev;
-			pci_dev_put(pdev);
-		}
 	}
 
 	memset(&props, 0, sizeof(struct backlight_properties));
@@ -1734,6 +1732,7 @@ static void acpi_video_dev_register_back
 						      device,
 						      &acpi_backlight_ops,
 						      &props);
+	put_device(parent);
 	kfree(name);
 	if (IS_ERR(device->backlight)) {
 		device->backlight = NULL;



