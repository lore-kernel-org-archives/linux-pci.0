Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D23330B29;
	Tue, 14 Jul 2026 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055571; cv=none; b=gzBHUtY3E4QpuEdeu8GfwamJqGYbcjHxjp9ItEap7C3LQfpHhQoWd3mvDe6TOyiMpwRhekbTOKTNOH3fZmk5HmEh77RxyyINxC8C935XrJCxp6gjDdX3xp9qpfCDSiLGsRMF+lgs7GaejO9CDuHn0XzQFENd6msrN6GuxzJsdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055571; c=relaxed/simple;
	bh=FqRvqRYtHmzhqRf/3lU2aUkcZK+Qhg1aY/HPQPR+gWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuXnnI3B5UfAhHQNshEehYZRA5jOFIJ8t/YKQeYZAfcqDOtIJ6ZlkS05Xuys439+JJx05vN7WimbqhSpR/qBexDqOH1EJw+yBkgl8fKPluQfdPfv4D5TBvneYfjRiDqRCWCUwD2Y56b2cUO8VJXC5jQP0e0yabb5YBKYL0hTkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE5hI56r; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE5hI56r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055570; x=1815591570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqRvqRYtHmzhqRf/3lU2aUkcZK+Qhg1aY/HPQPR+gWY=;
  b=gE5hI56rgLuqrMlJrI9lva6iIA7qFF82hF5RnhLPsddFw5vixfdDeJJF
   v7g7NYmj/iVvY9QCVYWAPEu5y9qy3WhVKb9ZrfzY9CT9/nBHYw1AT2juQ
   I5mHBSwDwZWOR1CpL9vBYiH2DseK42tu+e8Aw7ltUE1AtZqMFxcwLD17D
   sJ2QiV8kR770ifzmrnvPw8k4C41ek12huFJJiahKIaUUOJUhYOfyLS/7+
   1+dxJJGkFdqq/TqrzkXCLLrwi/Xmz33obBpToGHISDqOXNA1cayp2ZWUF
   13yWdKEUOdH4Yk420ZeF/DHa9Yx6DoKFW5mYRI0tqA6uMg6TlHRx/mW2E
   w==;
X-CSE-ConnectionGUID: n7muoZ7ZRfqVSkbehRcBEQ==
X-CSE-MsgGUID: /zTbz+etRiGjKSXp3VAvlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88364938"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88364938"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:29 -0700
X-CSE-ConnectionGUID: XTY29IbuTAuPxUhRM2eEzA==
X-CSE-MsgGUID: mno2XAJbTTaEVALzdNAkaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="256597164"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 14 Jul 2026 11:59:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 109179D; Tue, 14 Jul 2026 20:59:24 +0200 (CEST)
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
	Hans de Goede <hansg@kernel.org>,
	Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v2 4/6] i2c: acpi: Convert to use acpi_dev_is_video_device() helper
Date: Tue, 14 Jul 2026 20:53:43 +0200
Message-ID: <20260714185915.865396-5-andriy.shevchenko@linux.intel.com>
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

Acked-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 10cdceaba475..8f3bdd50186e 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -131,15 +131,6 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
-static const struct acpi_device_id i2c_acpi_ignored_device_ids[] = {
-	/*
-	 * ACPI video acpi_devices, which are handled by the acpi-video driver
-	 * sometimes contain a SERIAL_TYPE_I2C ACPI resource, ignore these.
-	 */
-	{ ACPI_VIDEO_HID, 0 },
-	{}
-};
-
 struct i2c_acpi_irq_context {
 	int irq;
 	bool wake_capable;
@@ -158,7 +149,11 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 	if (!acpi_dev_ready_for_enumeration(adev))
 		return -ENODEV;
 
-	if (acpi_match_device_ids(adev, i2c_acpi_ignored_device_ids) == 0)
+	/*
+	 * ACPI video devices, which are handled by the acpi-video driver,
+	 * sometimes contain a SERIAL_TYPE_I2C ACPI resource, ignore these.
+	 */
+	if (acpi_dev_is_video_device(adev))
 		return -ENODEV;
 
 	memset(info, 0, sizeof(*info));
-- 
2.50.1

