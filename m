Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE704B2CA0;
	Thu,  3 Sep 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455405; cv=none; b=XV5vbfUYBEPQfNjBGzqHiE4vNdXqyBxFwUt1TwFIWsRN7p+A79Bkgl9XqFfkYPc/cu2XQ+3Y4Zx36YVy3d6gBdgN64DfGtWBGH+h5iq/hUQLxkuJQhpAavtEPF6GGi8M14e512NFAv0RqfhYi0hDzPhqBiEN4kPUbsc54ki44nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455405; c=relaxed/simple;
	bh=dluzVSKTf65VqIkVILVo/FgxU6nMjjs7GpSnm/yY4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObeqOFIRosUsynryS1iQz3iXH1crERF/8YcBLw6YPQ/b2eJJmW15h9r1HH1JSArGikTDfLSs1yTrSkLnNtLkwNhPUjFFX/AS676zcxpwxQLrvdq+7kFIWZucnc1j6iiPuXbSRnR7v3CwOmYlTNvlH/qFeyx3G44ROK/HCahewqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8qC0anX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8qC0anX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01E1F000E9;
	Thu,  3 Sep 2026 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455404;
	bh=VYL4apQp4181jFM3gLL245DiS0XmgWuuOXR8uMoXMyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8qC0anXzw2LyQnYfqc4ymYucuz4lysQS8IvaJMQdfK3/Q8xQ06Oknv4Xhvh5wRpy
	 k2qtaH5IuSS1P+TDinPPMDelVPXQwLPZ5iHYXipZctf8c/1EHle7uatHB6YvsPCzlM
	 FYeWH19AW04+SxXwTl5SeKj0e4C0KBaNjrk7bWaQHvPl0DVQC1uP4dYeQGDyl93cmk
	 iXWN1kqkJBqJ0lQRViX1HdwrDfbGx5YpA1s7wLElzqoFtR204dmyA/esl4Bbk6Rqhr
	 Wd7PH3//Qglfh/e9mSIFeSFjFU5Xlrqn49os2n287ehWeImjeRQYWHim8dqlRwyCLV
	 LwVH7ep0jWJ2Q==
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
 [PATCH v3 4/4] ACPI: scan: Combine two conditionals in acpi_bus_attach()
Date: Thu, 03 Sep 2026 19:09:22 +0200
Message-ID: <8746939.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <6044499.DvuYhMxLoT@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There are two conditionals in acpi_bus_attach() that can be combined,
which slightly reduces the overhead and makes the code a bit easier
to follow, so do that.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2 -> v3:
   * Add tag from Andy

v1 -> v2:
   * Reverse checks to avoid multiple negations (Andy)
   * Rebase on top of the new [2/6]

Link to the v1:
https://lore.kernel.org/linux-pci/2021470.taCxCBeP46@rafael.j.wysocki/

---
 drivers/acpi/scan.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f219a16e018a..1b8d833131a0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2391,13 +2391,8 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	if (ret < 0)
 		return 0;
 
-	if (ret > 0 && !device->flags.enumeration_by_parent) {
-		acpi_device_set_enumerated(device);
-		goto ok;
-	}
-
-	if (device->pnp.type.platform_id || device->pnp.type.backlight ||
-	    device->flags.enumeration_by_parent)
+	if (device->flags.enumeration_by_parent ||
+	    (!ret && (device->pnp.type.platform_id || device->pnp.type.backlight)))
 		acpi_default_enumeration(device);
 	else
 		acpi_device_set_enumerated(device);
-- 
2.51.0




