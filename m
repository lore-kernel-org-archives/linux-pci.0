Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA64446FF;
	Tue, 14 Jul 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055575; cv=none; b=PFNcj8fjQr6S7iNW2NtyXX/6jBLxQOGjlArQsLczB7cMlni46fqljKJsQjkv+yg9dAU1G4ZHc8lKGU6v3IEsvpi+WR+wY1orDiWlRnLCxpKwGBHa/2sd5wOp65iMydeNeaJnFp/txHdBxAs4XGiTR6Q9DZ/k2UOcSFI9VddBiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055575; c=relaxed/simple;
	bh=727ZPA//Fapfq2AT7ttErR8hsE7h5RN7AlQzXcqJes8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxXmxp80q+MRf/x1CNfNGFMRurHz2cxJnzHsVraF59ghqsGStp9tG0Pyvs5f7xCLCNUy/GSP7KsFKJpgCbq6KEGb/NcDZEjre3wZn0p4JHn2iGTbYVjwfru0dzUYJhsor7FAvknjZ5R6c6RPSbFz6HvO7c8ZWhfntMEhIq98MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8coaWIF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8coaWIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055574; x=1815591574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=727ZPA//Fapfq2AT7ttErR8hsE7h5RN7AlQzXcqJes8=;
  b=Q8coaWIFLmUNXMOuSMfRnfC9OehuF4wrjH9UkJzj//L1naCOKPeqDbml
   r3auPOdbvQUPeDwJW0Fsvl04jQPlM/TmEm8JRQOOH3CtbbM1WMur22Zne
   7wiLVSGEARCq9FPIHZMhkMwHfMqO1meVGmp7WmsCN1GhngJ4h3EWcG6wg
   GMgmJDXJ2YNoI58gHG8xyQQYBPt2q4mNNC1NziBXrd1Pxybkkz5dhULiv
   t//XJBo9NMy2aXc6IOWfMhiWTcjUex9hlcXHhKiZtWsNRU6uqsqB4gwqU
   UMfbNO2jEeYS1UQQjhSrm8ZXKj+zjqASQDfhJDaIeB8LyjLBCgM811uz6
   w==;
X-CSE-ConnectionGUID: uoJyTYwaQQSoXxrRkYW0wg==
X-CSE-MsgGUID: XeNQTwXHTBOEWKkTkVO2Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84730521"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84730521"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:33 -0700
X-CSE-ConnectionGUID: zssdyRyCSSCjCMeEX1aToA==
X-CSE-MsgGUID: JdsV2X5KSMCTxKQsFBVD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255442725"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2026 11:59:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 19872A1; Tue, 14 Jul 2026 20:59:24 +0200 (CEST)
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
Subject: [PATCH v2 6/6] platform/x86: thinkpad_acpi: Convert to use acpi_dev_is_video_device() helper
Date: Tue, 14 Jul 2026 20:53:45 +0200
Message-ID: <20260714185915.865396-7-andriy.shevchenko@linux.intel.com>
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

Replace open coded variant of acpi_dev_is_video_device() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 6dd7c28fc0db..aaeada46a0e7 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -774,7 +774,7 @@ static acpi_status __init tpacpi_acpi_handle_locate_callback(acpi_handle handle,
 	if (!strcmp(context, "video")) {
 		struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
 
-		if (!dev || strcmp(ACPI_VIDEO_HID, acpi_device_hid(dev)))
+		if (!acpi_dev_is_video_device(dev))
 			return AE_OK;
 	}
 
-- 
2.50.1

