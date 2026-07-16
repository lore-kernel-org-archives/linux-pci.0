Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7240EB9B;
	Thu, 16 Jul 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210739; cv=none; b=m0n8/hP7pi20kdhm/7JRWcI/iEb6Sz6kQ/gfo2xLu6cl8sFRVqijH8I8g7WND5BjgaIoGZuS+RtmB265gMrlN9cSlIENc6h6eDBr4G5nXuBlmZzgKJwSCqg+odUBWufWSRt4SrYgPyryPNrfdz66gpysYkzcla7KjjJ3Udx/Pkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210739; c=relaxed/simple;
	bh=ILJ7+9G4uL4mjYDDMsWVPjHW/3JteGxJkfyAGbR/9dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkd9n30xSPDwVVfcAmsq8AtzC/6SOK9BmsObyBHC4oBzAxrXs796OAc7iryItBncDqnuishsCp1XYqiY0/NIWeG5ZX8ROBi0jK64G2QSYVrLWGNk1ggNYHNxPIhCL5j9Oyqa4piCT9WTW26T24mK/NP3piPwISgFqx48jRlLL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4zDFg2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4zDFg2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31381F00A3A;
	Thu, 16 Jul 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210738;
	bh=Cg2vx+4tImolI22JOxzSJEhwJTEsk2/+XglA8kz+hks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4zDFg2/5O1eqpk2+AhutSyfRN7OZpkPCfrZ568xC7pyCrH2mAuJBkr1bSvcMGrJR
	 XL9yJCYcT21+fav+IhsUOwWDFBVPcLEni8iIz1QFJy9al3uOB0omSYWyYCNAq5oCVQ
	 weo4XdBZD0I/DYuA5tIwauXoWFtdxhbPyP1DdV+0i0Jx4sXaXCdKMbX2kbUs8CLicH
	 3O585+and4eBvPgXVvuYgMsA6gHG3X5bBz4Te07PagCuUGJSpPn0UGx/kON/lPSa7Z
	 3LaqowfpXIxdZDtGr7MUAwZLtIc/sydirQ5ZYFKqHi3BK5kK1p82+7Ss/L8MQlQ7uX
	 mGX4l7eDuhmfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v2 3/4] ACPI: video: Drop backlight parent device reference later
Date: Thu, 16 Jul 2026 16:05:04 +0200
Message-ID: <10885673.nUPlyArG6x@rafael.j.wysocki>
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

Update acpi_video_dev_register_backlight() to put the parent device after
registering the backlight class device under it instead of attempting to
register the backlight class device under a parent that (theoretically)
may be gone at that point.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v1 -> v2:
   * Add R-by from Andy

---
 drivers/acpi/acpi_video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index f93e877f87f6..a738265279cd 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1719,10 +1719,8 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 
 	if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_parent))) {
 		pdev = acpi_get_pci_dev(acpi_parent);
-		if (pdev) {
+		if (pdev)
 			parent = &pdev->dev;
-			pci_dev_put(pdev);
-		}
 	}
 
 	memset(&props, 0, sizeof(struct backlight_properties));
@@ -1734,6 +1732,7 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 						      device,
 						      &acpi_backlight_ops,
 						      &props);
+	put_device(parent);
 	kfree(name);
 	if (IS_ERR(device->backlight)) {
 		device->backlight = NULL;
-- 
2.51.0




