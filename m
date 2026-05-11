Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4941C2FE;
	Mon, 11 May 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515205; cv=none; b=u0Y9Un1/0sqU0YNyU446uc3BeYZ0GwmNYuh2qjID1whDDO1sEukDznZhT3NjHOcRuIGkThjyyzEFL6thsHZTENqDQ1DjjuLwJPqK2myDp1w5M98cYnz9TOGROze8hubYoedPNeybNn/ClCaPBag5z5fnmq7gwCbA7Ll06TKyHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515205; c=relaxed/simple;
	bh=/XvRviTCSin2LUKs7yMbKa4zISIWmVGD9lbA+HJpyZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPKaxdsOsKeiM6glmNnZ+lXAiSrR45UOppfz8mTt2/XjeiyokOp6h9YM8PiEVD7kiP0kdoHEvKFzuWaAGijny/35UaqdtDWdN98OfKkBoejUEkZq03TUH4Hx8C9kkx+AsrJZKQzpWVEyypJU0s52Yv7KMeAbrmxYzhfENe3q+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NJhItOyl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NJhItOyl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0B6CD1A1DD5;
	Mon, 11 May 2026 16:00:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF1E260646;
	Mon, 11 May 2026 16:00:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0BC3411AF9E9C;
	Mon, 11 May 2026 17:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515198; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eLso7qwKwUfCrw/iPEq5uoZWKKfHhCJUIGRDgunoGhI=;
	b=NJhItOylrAiwDkCzbHOBzVRzh3USUjbhaP0ErMZje3yNJKKe0sOtMd+M0qFpIPrqoxNQK3
	oMbSPSJgEsqCGf7RA6qn6e4yR2fasJxS+xLqYUZH5RG2T1T3iYqnWnQ0k2r1Ksu1KtIhLb
	ML7H5nViITBQ/DKItODI/B7Yn/o0Mt7eEtmYXHQ6+KXkpuRA49tg1FJIW85OYqOu+YieWa
	yqqTXjCPiW/zgDGPWo2YHJAvsNmWltB/Nefokjo1izepLlPpPNzyAlIQI9IJ8HdOEc5g7J
	+oS+dp9j3z2gJrUj+Y3c/YCHFX6+FI/rgisaU0rR7DaQDvwrDCvD55s80TcexQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
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
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
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
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v7 2/8] drivers: core: Use fw_devlink_set_device()
Date: Mon, 11 May 2026 17:59:22 +0200
Message-ID: <20260511155930.34604-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155930.34604-1-herve.codina@bootlin.com>
References: <20260511155930.34604-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The code set directly fwnode->dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bd2ddf2aab50..5c9a34aaefe1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3684,7 +3684,7 @@ int device_add(struct device *dev)
 	 * device and the driver sync_state callback is called for this device.
 	 */
 	if (dev->fwnode && !dev->fwnode->dev) {
-		dev->fwnode->dev = dev;
+		fw_devlink_set_device(dev->fwnode, dev);
 		fw_devlink_link_device(dev);
 	}
 
@@ -3859,7 +3859,7 @@ void device_del(struct device *dev)
 	device_unlock(dev);
 
 	if (dev->fwnode && dev->fwnode->dev == dev)
-		dev->fwnode->dev = NULL;
+		fw_devlink_set_device(dev->fwnode, NULL);
 
 	/* Notify clients of device removal.  This call must come
 	 * before dpm_sysfs_remove().
-- 
2.54.0

