Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2042F716;
	Fri, 17 Jul 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299946; cv=none; b=eHBsqWdxIwt3MmOvopKLAAJrtCqGjZwz+pYUFmLq3Jdnh88ahWaaLotu6/MtTjepinUZTCcBSAfE8917ZzBjE8x3QB1maDeZIpqbS2VVZnOV91BWhytbPbc43oRgGTb2L58sXCmog+dRp6KAOb/UhkD7Oqz6oqnOgrWrdMFJCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299946; c=relaxed/simple;
	bh=fpYOSr1jLNmHWva6oc2O/Jpj3cvX/UUFQWNrhRhfhvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx6FtEORxqz9ppVQfwXz4DBzXwwhOiB4I1OLkuulDSEuUZVgzwNw7gtOqjUjJddrHQKxOvLjYBBVQ45LBOFPyU6iI9ZTNN944iAjBLBCczSR5JtimgDs/VmULW9gRU46a+T3udXu8ODxDmAhl9fKssCM+25EkV+6Y0T3+VOuZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fg1cvspj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fg1cvspj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F29E54E40E1E;
	Fri, 17 Jul 2026 14:52:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C296C60361;
	Fri, 17 Jul 2026 14:52:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0444411BD0313;
	Fri, 17 Jul 2026 16:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784299934; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=tCUxWAaNLTCo2hU7hlbeboEUdOrDp+5URDFS69bgPxw=;
	b=Fg1cvspjzx7ysmNiwKaWkNkxFP4Dxf8xKDpgJSXiTre000+Oj9WCr0a6xyCEL8Kq+7A9Jx
	E9qYJHFwySiAlqKezhnOTuBnjdmA2xB8sHWeI3sdUN8OnWPTO9Ln+bGx7F7gcyY7U/dnvO
	xqrAcvfwG5lIwyMiMqfKCFjLObSrAxZ5j5WD4Mjnv38dE/yjahT4Gm9dKsVWlb53Kk+FDP
	kz5vliVXwcNAwViVjnDPQRssMYPAVd9GyJgSR5k5MPOa5jko6X7Cu1LWXxtsM1EoUpk1tB
	FpruOWNsw3C4K9PC5NEcmA1QPDr2EXnngyxgRlWaoZcIm9DWf+UV0qluAY4TUA==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 01/10] driver core: fw_devlink: Introduce fw_devlink_set_device()
Date: Fri, 17 Jul 2026 16:51:36 +0200
Message-ID: <20260717145147.823749-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717145147.823749-1-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Setting fwnode->dev is specific to fw_devlink.

In order to avoid having a direct 'fwnode->dev = dev;' in several
place in the kernel, introduce fw_devlink_set_device() helper to perform
this operation.

Having this helper allows to hide the fwnode devlink related stuff
behind the helper.

Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Cc stable because used by other patches with Fixes + Cc stable
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 4e86e6990d28..31538f54b1ca 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -256,4 +256,10 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode);
 bool fw_devlink_is_strict(void);
 
+static inline void fw_devlink_set_device(struct fwnode_handle *fwnode,
+					 struct device *dev)
+{
+	fwnode->dev = dev;
+}
+
 #endif
-- 
2.55.0

