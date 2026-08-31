Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56938C406;
	Mon, 31 Aug 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199401; cv=none; b=pcn2ifIaYZQf3MLnfwixi63ONoCydgVsjPtZNYliYxR3CKCqyyMqgaeFyupJYTH/X3kvwLaor9meaMyoSUz53vtLsmjd1SMrrfN1ithR88HEWk37pB3BZtTFVKm+t9JZ4cFpPYHnTzgf+Sz5kt+dSbkeBp1sQJ491Qbs/YBEofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199401; c=relaxed/simple;
	bh=LLM3QjjsDMDSP2+dPQ3TrHR4IWV515SY0RBgRIqKp5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exS4iMIlRKsYtrN5p3Fbn+gnQVjEMSEQiIyTYNoi7LldagHbH4voC4zT6A+doKcc/BOM8gPyeHUYPBB11GaoEQFRruibT+UXME035LEVSYhzdHHiRXBNhl0fFL3GA0/rUn+enKVuNMLaTHWlN5UvQ8fU5jUoaemQr4SUNMn9s/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPN2kKee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPN2kKee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A65E1F000E9;
	Mon, 31 Aug 2026 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199400;
	bh=zol6Du139WcwTBPm/HWF2w2s/q8w032+Y/bBf4x9wFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dPN2kKeeN/i/exwcMlvmCaB0FCKD1qpqdVYxwqvYuvUtW+2+V7VLgOn9Khz0yx6nE
	 LpsNxkhUjjK+Ie/de/LHw+qYOckGKSKI2W+rlGkxBk4SlxSGsE/CmckCti1XDYQ2DQ
	 WUJ7Uucp3FfZg+AOQTHfnruJPXsDAZg+YOGJopd7c4NaXv85+W8etAKnDfpUp6BNLp
	 ANpx9Dkf6iBcuU/LNEAysab20i8/a3krY2+XEWQNScZ/P6EjykVPHfwgE10NAavRu9
	 10dXAuY3OUZbv7vq9frQjWI/CXpvZ/7e8cL4WtVv8JgOa/8kRTBumV6PrMKoLuzXn6
	 tpztNaulUyXZQ==
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
 [PATCH v1 4/7] ACPI: scan: Combine two conditionals in acpi_bus_attach()
Date: Mon, 31 Aug 2026 19:59:32 +0200
Message-ID: <2021470.taCxCBeP46@rafael.j.wysocki>
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

There are two conditionals in acpi_bus_attach() that can be combined,
which slightly reduces the overhead and makes the code a bit easier
to follow, so do that.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 019a43e3b5d7..8c5a2fcef582 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2370,16 +2370,11 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	if (ret < 0)
 		return 0;
 
-	if (ret > 0 && !device->flags.enumeration_by_parent) {
+	if (!device->flags.enumeration_by_parent && (ret > 0 ||
+	    (!device->pnp.type.platform_id && !device->pnp.type.backlight)))
 		acpi_device_set_enumerated(device);
-		goto ok;
-	}
-
-	if (device->pnp.type.platform_id || device->pnp.type.backlight ||
-	    device->flags.enumeration_by_parent)
-		acpi_default_enumeration(device);
 	else
-		acpi_device_set_enumerated(device);
+		acpi_default_enumeration(device);
 
 ok:
 	acpi_dev_for_each_child(device, acpi_bus_attach, first_pass);
-- 
2.51.0




