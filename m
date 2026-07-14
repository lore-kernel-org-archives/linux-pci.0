Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BB43D4F5;
	Tue, 14 Jul 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055572; cv=none; b=dOIFjO139PXdJb2Nq6MEk/gxWwQ+r+onWVz59KtemToZ5X1yxWRpbWJ7pEfhAKke0ozgycAi3GB/N/TGqosPz2BV9X1k6o39Bv9WWeN/ZMjKMUN6sAAQtK+zk1ggXtxzwVfBALtqJ+awaDFAAcp/LI29g7ckuDONXQ+oB9pFfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055572; c=relaxed/simple;
	bh=TxU0xtO/ZKILyjgUFhivco9R1sTVeCWrqThcu4DVPnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRabJyo0JW8Qgj28imQF/b70Iqc8a6uiDUIYXdtWOT9TtSPQqu/JxWDObdODqVY1vbP37uX09LuiaJvWqhlOvZqh5Q8+OnyQyzt3xUrO+uS1Cfk+6Zqof4BBkut4bhm5qHb4VmQ3fXNfVz70xfPhex1Ce6FFThasiystULckoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P41Ie51z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P41Ie51z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055571; x=1815591571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxU0xtO/ZKILyjgUFhivco9R1sTVeCWrqThcu4DVPnY=;
  b=P41Ie51zeML78bXh9bIsDqdsxwtBhMYHQyxYw8/lU+nzDuYQOrCnYP1F
   erEOvYAXj4/PTLOCx7U2eSkdYvnW2RWsp4PnGfbFWlu3fFFSIibkPJbGV
   RUDGKmOvlxY5J6Q5nAe9AMZvM0Q9t1SSIvHTvuVbuXdpBgzkjRZ845gsB
   M7Jx+WzHgH5N7vwIHnujkg0wJ+QX7C1/rzBIriFs3SsiwfgLo4TzvFcYF
   hY1bQmScnXJ1YvQQLvm0HchU7VIvHvLGKMDqxHnUiGxLdNjZU7hfzqNau
   8z9twW67xFyKJzHoLGa6Fw1XdLHzKBXWW1Ww/8JCA//qEm0T6oVg8zLnP
   A==;
X-CSE-ConnectionGUID: 4m9zx3GiSByRvKNR1lHyzw==
X-CSE-MsgGUID: 15WVO38lQDStk7hJdYd2kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84730501"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84730501"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:29 -0700
X-CSE-ConnectionGUID: GhNwa1k3TaqNrZyfoi44vw==
X-CSE-MsgGUID: RDPSkEwfQkuxz4yNQMzdFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255442697"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2026 11:59:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 070E599; Tue, 14 Jul 2026 20:59:24 +0200 (CEST)
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
Subject: [PATCH v2 2/6] ACPI: scan: Convert to use acpi_dev_is_video_device() helper
Date: Tue, 14 Jul 2026 20:53:41 +0200
Message-ID: <20260714185915.865396-3-andriy.shevchenko@linux.intel.com>
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
 drivers/acpi/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2f6185dbe785..ef9995bac746 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1764,7 +1764,6 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * Some ACPI devs contain SerialBus resources even though they are not
 	 * attached to a serial bus at all.
 	 */
-		{ACPI_VIDEO_HID, },
 		{"MSHW0028", },
 	/*
 	 * HIDs of device with an UartSerialBusV2 resource for which userspace
@@ -1787,6 +1786,9 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
+	if (acpi_dev_is_video_device(device))
+		return false;
+
 	if (!acpi_match_device_ids(device, ignore_serial_bus_ids))
 		return false;
 
-- 
2.50.1

