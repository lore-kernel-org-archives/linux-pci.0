Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C547DF80;
	Tue, 14 Jul 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055573; cv=none; b=LwnS7LKF4AiiwdX0edfNYKFw1WDn7ciRLv/PuBE5fqyI1d21Iix8UKmVWw6yHZSgv7uNFVXEkvOCjITQY9bUstX6UY9g7j+oN30wsT7igqaGTWbhjvMIOgV7Yr9HqxsdCRNkB1NjLTxBrzuZt7AOupus7bjtLGdWPh3oW6GQel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055573; c=relaxed/simple;
	bh=m2XV/bBLg7j5MEv11qvDXJyQOyQttNdluVJIyoS49Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt1eT7pajOPii5ueDM4ssYfpc1bVzeTMGv6Sdvrod8OzDW6grEWcYYZWCjUyjE4ZGyvhbOu6YwUU2/MYEzDI5KX0KToXcZdM+J6KzPdIrOX/R8OKAMl917RJOBc+h3qdj5PnmmDIQrRnneRMsfN3tjtu4cQqbcz7NE3Hw1wk4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHcZiv+0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHcZiv+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055572; x=1815591572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2XV/bBLg7j5MEv11qvDXJyQOyQttNdluVJIyoS49Pw=;
  b=OHcZiv+0fXRjcWiyCqpzMq4rRkH5pG3ne7r2mgWIM5s4KW+8Zm5hMIUd
   pvLRoepe9ASvASICy2aWCdoIOVyVU+tJG6R/fkUD39lNXHg56qrEqZmTh
   FZ3vMNuw03fcQw3eQjP8yNBjxHLhxLw1g2dL/ocwiCrTsfC0PLS2eCbDX
   QbC4QLkdd/sDG7dOeZk42oTHfsBy++/G4KmYdikIlyt4TZpdP59FlPvGY
   ZlQY/BF5Vsad09gn32+dqW1xNSMhPVnaxvUNOpxGD4V3tSUSpk6yv6Lz2
   L96u0OfDC+p6+VpCd/IRzCJMJOoD6WyXVSQdd98naOWtCAXxvCOruFO9n
   A==;
X-CSE-ConnectionGUID: tFrI7S+gRpaVqZyLYrmEOg==
X-CSE-MsgGUID: 4MyviMeMTxaOpYqUI2T9mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84730506"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84730506"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:29 -0700
X-CSE-ConnectionGUID: hWh9kX7STsKwgeUeoQdxjA==
X-CSE-MsgGUID: iug8fevPSM2uUUIVHIMd3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255442701"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2026 11:59:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 028B698; Tue, 14 Jul 2026 20:59:24 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 1/6] ACPI: utils: Introduce acpi_dev_is_video_device() helper
Date: Tue, 14 Jul 2026 20:53:40 +0200
Message-ID: <20260714185915.865396-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a couple of users that open code functionality of matching
a given handle against ACPI video device IDs. The current approach
duplicates ID table along with the matching code. Consolidate it
under the acpi_dev_is_video_device() helper's hood.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/utils.c | 17 +++++++++++++++++
 include/linux/acpi.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 6ab27e4826d1..8b3e49f3cefa 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -1047,6 +1047,23 @@ static int __init acpi_backlight(char *str)
 }
 __setup("acpi_backlight=", acpi_backlight);
 
+static const struct acpi_device_id video_device_ids[] = {
+	{ .id = ACPI_VIDEO_HID },
+	{ }
+};
+
+/**
+ * acpi_dev_is_video_device - test if device matches against ACPI video device IDs
+ * @adev: ACPI device to test
+ *
+ * Return: true when matches, otherwise false.
+ */
+bool acpi_dev_is_video_device(struct acpi_device *adev)
+{
+	return adev && !acpi_match_device_ids(adev, video_device_ids);
+}
+EXPORT_SYMBOL(acpi_dev_is_video_device);
+
 /**
  * acpi_match_platform_list - Check if the system matches with a given list
  * @plat: pointer to acpi_platform_list table terminated by a NULL entry
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 899dc00b4b01..99afad0eb49e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -457,6 +457,7 @@ extern char *wmi_get_acpi_device_uid(const char *guid);
 #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO		0x0800
 
 extern char acpi_video_backlight_string[];
+extern bool acpi_dev_is_video_device(struct acpi_device *adev);
 extern long acpi_is_video_device(acpi_handle handle);
 
 extern void acpi_osi_setup(char *str);
-- 
2.50.1

