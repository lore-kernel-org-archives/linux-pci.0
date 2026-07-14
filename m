Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C5331A61;
	Tue, 14 Jul 2026 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055570; cv=none; b=NPPyvAwlxjn7K90QfdkdhiPyBoAllD2wvSwTt/O/ICZHmDyyxoJBba2AtQlUgCXACb6MSqB7BRFj1Kh+02mZ/dBmYncVbtvDy8ksLPURGciHxUDt5ySm6U1GBNMLtVpRdcNxPLBYBURyXMu/wrLcM0YWpGM7Aa+WqMZYykg274I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055570; c=relaxed/simple;
	bh=heqNQmDwAdDrignoOrONMxusCaeZUzy0EnkWdJCXcWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAccznbXn5dbeDynrT1Apwnp+rMbBcab7n/JEnsZgcisi8sbk5lm1WZ3rk0ndyPuhz4Y/oco1DZek0zREdjyU0Oo4y0G6UZS4ChESLE3Zfa//ny9IJdRwFd6/iDYpcojfe8kqPVI1oUIkw855Q2zhF3pxp9RSwiyqm95ri0PJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQxoaP18; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQxoaP18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055570; x=1815591570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=heqNQmDwAdDrignoOrONMxusCaeZUzy0EnkWdJCXcWw=;
  b=AQxoaP18CvuwXxRpchbd4cQtZOXAnVkLzNZ/wAsLZFKCTO3ZdpBNPmnF
   Qr7nTf+ZmA40vCBN4CPaibMBDBuKT9K+bX2dX4Pk9s7mXIzPVSSpO35vh
   5X38lJkQNH7Q8oNzUHa2Jkxw1N5vbOJ5B+8Zzgm3bceeWK2pRHFHrAEra
   fiTBLVRYUnEPC6FrM9ODUvn+4MTLa+IBqFPyjConbal7IOkiMBfQaQ1Q3
   osLQPo3IgOIRe8mevSag/AUYMZtZvISyl5dwgVDQd0vqMiTzt/vJ5tFhl
   h6fye3N9A8+xdlrn6KZ4C/JCu2wpPoDJqY0bmUwHWGbVzNleBJVabLczr
   g==;
X-CSE-ConnectionGUID: 3i7YMu/KR3qAE5CzD/yjXg==
X-CSE-MsgGUID: N8F1UESCQxisHuFjfng8KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84730488"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84730488"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:29 -0700
X-CSE-ConnectionGUID: A0Wh6wkZTLum2LxTz+yVoA==
X-CSE-MsgGUID: gtWW4VybTTu5c9hPHdd4Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255442695"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2026 11:59:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0B9249B; Tue, 14 Jul 2026 20:59:24 +0200 (CEST)
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
Subject: [PATCH v2 3/6] ACPI: video: Convert to use acpi_dev_is_video_device() helper
Date: Tue, 14 Jul 2026 20:53:42 +0200
Message-ID: <20260714185915.865396-4-andriy.shevchenko@linux.intel.com>
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
 drivers/acpi/video_detect.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 458efa4fe9d4..cf267b518d2b 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -67,12 +67,7 @@ find_video(acpi_handle handle, u32 lvl, void *context, void **rv)
 	long *cap = context;
 	struct pci_dev *dev;
 
-	static const struct acpi_device_id video_ids[] = {
-		{ACPI_VIDEO_HID, 0},
-		{"", 0},
-	};
-
-	if (acpi_dev && !acpi_match_device_ids(acpi_dev, video_ids)) {
+	if (acpi_dev_is_video_device(acpi_dev)) {
 		dev = acpi_get_pci_dev(handle);
 		if (!dev)
 			return AE_OK;
-- 
2.50.1

