Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0D412C08;
	Thu,  3 Sep 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455412; cv=none; b=bnpqvgs3gG27UswWQs4zkmEjlleFeSj/CXUZTjySWUbZsLe9Hu47RnjZYCbnoRYCR29cLnuSdXeWHYpApR86AExtXd7GhDQCcRAGgJ2edSc8iV4RQgPfbvr9e6vSncfPaar9iDj47lnNS7H9bAPyciqWxhUfvV5xFUy9YlY8qSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455412; c=relaxed/simple;
	bh=COzBV1EoknZjxFzTtzc1jdZlg09bvszVRgUdep00O4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUy0/WWt/3QOQNdaL3X/GoVW5YyKKfvQNfIac8+mqVC5A3pdtIb/jYdxsen3pKi+7xnOrHX/edEnxdxgmluiVsksTF+09Z9K86aj64kglkcNVcuTE+Q05UIQN3GxTDuyYsOpPS9+Ramg2NZxCOKq1SsnYStMcyPZkUnWwrOX9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/DxO0Qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/DxO0Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E7A1F000E9;
	Thu,  3 Sep 2026 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455410;
	bh=Fnj1RBbFZQ8FrwyQwy/MjRBG39IQ6JmNTjWC7Zdw3vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/DxO0QtNEKx8mGYAqcBjooQ4O5n2lm541EOU56FiFW52LFfWQb4WDuUjtBQwsWQB
	 +V+m8crM8klI5K+lxRI0nMDTwEk/tyz3cL/O4aw1MRp7F0O1bPH1wJWFpeF2o9jzlI
	 JS6Sd0Tvcv7bUUtihzrV4YN1SsyhsMHc0sTECgMUdFyC/2gu87mfP9x4kISqM/8363
	 q/maIrABUVytk6MDEHQ+SB9tQ1ySpf8gZxECm1FfAUy+koEaEY6b6mMDd10/BtGmNu
	 5GUuRWKpkm1c79ozvVjX1Xx1JVEEV+uNyCit0+CpWMMFxBl8mbme2OYBq6GM2WG2NV
	 ePpnme0xWbbqg==
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
 [PATCH v3 3/4] ACPI: PM: Move acpi_bus_init_power() declaration to internal
 header file
Date: Thu, 03 Sep 2026 19:06:32 +0200
Message-ID: <3079955.e9J7NaK4W3@rafael.j.wysocki>
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

Since acpi_bus_init_power() is only used internally in the core ACPI
device enumeration and power management code, it need not be visible
outside, so move its declaration to an internal header file.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v3.

---
 drivers/acpi/internal.h | 1 +
 include/acpi/acpi_bus.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 40f875b265a9..011da4ed6a80 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -157,6 +157,7 @@ void acpi_turn_off_unused_power_resources(void);
                               Device Power Management
    -------------------------------------------------------------------------- */
 int acpi_device_get_power(struct acpi_device *device, int *state);
+int acpi_bus_init_power(struct acpi_device *device);
 int acpi_wakeup_device_init(void);
 
 /* --------------------------------------------------------------------------
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a45e0d521d8..6b3f8b230eec 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -618,7 +618,6 @@ int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_set_power(acpi_handle handle, int state);
 const char *acpi_power_state_string(int state);
 int acpi_device_set_power(struct acpi_device *device, int state);
-int acpi_bus_init_power(struct acpi_device *device);
 int acpi_device_fix_up_power(struct acpi_device *device);
 void acpi_device_fix_up_power_extended(struct acpi_device *adev);
 void acpi_device_fix_up_power_children(struct acpi_device *adev);
-- 
2.51.0




