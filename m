Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD74412C05;
	Fri,  7 Aug 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114649; cv=none; b=TZEFSwjbGmP2UAcCnHjHG41ySVC19Cnhjp1b1XuIHwTv3rJOklfNPEYRzEHMpBj5heMdBqQCRQnEwwczDwWd6qAdrCjusG7EpVsbC5WhjDMEWgVIlyLLdWswCvBbVjFG5XYk/c4CKHqbhYEhtN3QSeFI9xed0f2Q71uI9oRhKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114649; c=relaxed/simple;
	bh=6uWV/4a7ou9YlS2DldAkICXYmliziER5KKT2Q7nsl78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6l5KJrh96O4k+LdTDUVcRySjBNyDljISQE8YOUrETo2cm3cs0xEbu0QRI1Q+aw4988GyaTQQH6+dreoHjQKsPe6Mm3ec5QWdWpKXClrHZY2JIj95JUpLDZiMCEGgrNyRBVOoDtn7gbsWNbS+0Tsk2wf6538VVFI24no34cAyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ussxp+Gl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ussxp+Gl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114648; x=1817650648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uWV/4a7ou9YlS2DldAkICXYmliziER5KKT2Q7nsl78=;
  b=Ussxp+GlAb2POL+WCBJUfksUyXzFWFIpVDffyU4JAkAjnyyLjxOJJjmi
   LXVPrb6YYxwCR2r6u9CYRyAaNQQ0C58nF0/6lhqRfFQZJEoBBFRy8Y4H9
   g94BJNJ1ktfftgn7N6+L3AQ/TiG58bA358cH1Rg3PhTQaAaJeIyn69FUy
   zgAyGGG8xZya9RHJoPIP8FGaANQpmjqPe5hK+oNKIx94jX4QSVSGLpZ64
   ie6u4rsPJ7I9xYd8fdUYdz2le3L4PVAG6LWa8dxvm9ZczKIrUci9UtU8A
   E5KKjzbBBalxfYug7WevfmyIxar9G+F+WqVFDk1hgZwWiat+YEaCWabYK
   g==;
X-CSE-ConnectionGUID: ohc333BbTbOBDXlFxT1ZAg==
X-CSE-MsgGUID: oRHiXug/TGWM0wzmNbT1DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485191"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:25 -0700
X-CSE-ConnectionGUID: lo7Te4SoToqvDB3tdFxQGw==
X-CSE-MsgGUID: wBvOWhNHRdOEYhu6B9xuGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809878"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:56:51 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V5 02/14] i3c: Fix unlocked dereference of dev->desc in i3c_device_get_supported_xfer_mode()
Date: Fri,  7 Aug 2026 17:56:26 +0300
Message-ID: <20260807145638.168865-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807145638.168865-1-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

i3c_device_get_supported_xfer_mode() uses dev->desc to obtain the
master controller.  However, dev->desc must not be dereferenced unless
bus->lock is held, and this function does not take that lock.

The function only needs access to the master controller associated with
the device's bus.  Use dev->bus instead, which is always valid for the
lifetime of the device and does not require dereferencing dev->desc.

Fixes: 256a21743d91 ("i3c: Add HDR API support")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V5:

	Added Frank's Rev'd-by

Changes in V4:

	None

Changes in V3:

	New patch


 drivers/i3c/device.c    | 2 +-
 drivers/i3c/internals.h | 5 +++++
 drivers/i3c/master.c    | 6 ------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 101eaa77de68..a3778282e84c 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(i3c_device_match_id);
  */
 u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
 {
-	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
+	return i3c_bus_to_i3c_master(dev->bus)->this->info.hdr_cap | BIT(I3C_SDR);
 }
 EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
 
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0f1f3f766623..86a36b951e0d 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -72,4 +72,9 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
 	}
 }
 
+static inline struct i3c_master_controller *i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
+{
+	return container_of(i3cbus, struct i3c_master_controller, bus);
+}
+
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d2fb1a110521..c7bb52b71d88 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -102,12 +102,6 @@ void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
 	up_read(&bus->lock);
 }
 
-static struct i3c_master_controller *
-i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
-{
-	return container_of(i3cbus, struct i3c_master_controller, bus);
-}
-
 static struct i3c_master_controller *dev_to_i3cmaster(struct device *dev)
 {
 	return container_of(dev, struct i3c_master_controller, dev);
-- 
2.53.0

