Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD1417BC3;
	Tue, 14 Jul 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055575; cv=none; b=pzg4+qQTKVhYvGKSTb5J7QHjhptA83rhq3oRAM7d58v2UeLqhpsUXW8FwG2PSWq5GUMPHQzgpu6SKck9qbFKyWRO5Mbci+wgMW8bD4cMYKONhUT7NLJuRHJaHVnbSawBD30KmPr1OurqlJS4ygCHIlrBcXDRrZ5EHK4Xci8UFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055575; c=relaxed/simple;
	bh=TNlTj//NIMpflYGIzQSPMAJhiNVdgNLM6YBeijAZQz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKvTFlD5xyKgQasI+xJmRPkpfV05dScanJ41c33leTBI4YwtFrTSvGl/iYwufRmC4jiqk3g+XfoB1/boWxEYbK5pV/1wqK55AB98cG3dMJEfR3nTjB0DK/O40Ti+Xuqy3mPbLZdHvpbGgEc86IErgwqtC8/rjtUabTAMjPM7xsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgXs5/CK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgXs5/CK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055574; x=1815591574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNlTj//NIMpflYGIzQSPMAJhiNVdgNLM6YBeijAZQz4=;
  b=NgXs5/CKkHuEhIKpZoTazj/p9lT6JT7yAurKZH6lVDBWaI/hWUywy+75
   VZXhQLhCeDNWE5d5a15Xv3Whs8Ewak/Z6PfsqMo80DPH5wX0yR9uhNL5L
   VkjFqMFWGUZT2gya6UUYwFPvR3Uqzb5lsD87o9ytJDkVorDBo+DesRtqf
   RXbyRj7wLS1ZIYytUKrfWS58LTRJDbaXoTQ7bqYSpLE/QYmyojmtaMBdI
   TvzH/8kgxNa1QLOKfDjBlGdr8dQMdtzQFh57qEAo94ymjpsAJkhg6bpKn
   ALD1F1lr24vpKJohZFPYn21XnALIor4ZyfR4pFn5pbSUD6iNDfMzq2WLq
   w==;
X-CSE-ConnectionGUID: Lx9dPJ+yQye397OVWjJuLA==
X-CSE-MsgGUID: yfshb9YASyiaB36BNZpqsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88364961"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88364961"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:33 -0700
X-CSE-ConnectionGUID: nYgkZIYlRISwlO15WMs79w==
X-CSE-MsgGUID: oaEfJaAOQgiaJrBYaa9/qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="256597178"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 14 Jul 2026 11:59:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 14F1C9E; Tue, 14 Jul 2026 20:59:24 +0200 (CEST)
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
Subject: [PATCH v2 5/6] PCI/VGA: Convert to use acpi_dev_is_video_device() helper
Date: Tue, 14 Jul 2026 20:53:44 +0200
Message-ID: <20260714185915.865396-6-andriy.shevchenko@linux.intel.com>
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
 drivers/pci/vgaarb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c360eee11dd9..3de05aee7859 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -575,9 +575,7 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
 static bool vga_arb_integrated_gpu(struct device *dev)
 {
 #if defined(CONFIG_ACPI)
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-
-	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
+	return acpi_dev_is_video_device(ACPI_COMPANION(dev));
 #else
 	return false;
 #endif
-- 
2.50.1

