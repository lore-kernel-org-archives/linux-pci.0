Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461641C31D;
	Mon, 11 May 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515225; cv=none; b=If5Xs10KFKcIIqB0zmqbvDiYQrc/PC7ICttlyyWi4AS+pHBEET9hvcPz5VBy7WKwnPpT1JraMjM6+QvHcze4XOnAZ637kcvTe5b51ebfWqed2BQtcp8LHfsGqLoQ34rxttd/Qa23pdhnf+yul1QAhRlIJ/DXtfQbsDuL7wuB5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515225; c=relaxed/simple;
	bh=XUWvCkoAnUyMK4tGjyBt9ZcONb8hLWQy64O2gAYY33s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjzHr7INGUjc3KyffSx/IXroukKkXOK+eRZnZxAiA2fEhvVTRlM9WGRfYq1u/47cGmST04IHkBsJJDSsKZgWVEDGCGB568XErPpPEwnWXl/JXtfvCTru/EAteaXMs8p+uPHdEYo3dDrmYC0Ndm2JRySI2GOnII0hyorZm+tX5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VsTqFQF4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VsTqFQF4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7BCE7C5E154;
	Mon, 11 May 2026 16:01:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0E6760646;
	Mon, 11 May 2026 16:00:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B25D611AF9F19;
	Mon, 11 May 2026 18:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515220; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2qLmBPzMvY1Nji5IhEh9xcC0D2bttHi9TI4ANRnDPTE=;
	b=VsTqFQF42WJO367yULMUNxbELM8Zz/nQvv4CavNsGwN7x/67dsUTxkoxSw2FDX/azovHc4
	ZVnX3SROWQvDsoFvIazRu2TSkIa38yzXsUfPiyo9G7OCcNMF03+DjMWj8TYjfKl/Qr0Ck6
	a79MA8A9ICXn/5RW3wuEezboqNVgZlZwJ59ttGNjOoBHuSmGxA7LehfFxfKMoWO/+egKK4
	Tl693dSp5yfW50UJphZVmG4IFbesOyYrOeaeQk5S2+kSzQFK+BKproeF5C3BeUCw/HtWI4
	uOgkTucQfk5Y/0hybGchjeXVtH2OBXCZ1YOO7M6XVxFCe+pMbeWYrtZ2tP55lg==
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
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v7 5/8] cxl/test: Use fw_devlink_set_device()
Date: Mon, 11 May 2026 17:59:25 +0200
Message-ID: <20260511155930.34604-6-herve.codina@bootlin.com>
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

The code set directly fwnode.dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 tools/testing/cxl/test/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2fdf8c0eca10..4c33b85dc846 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1516,7 +1516,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 	device_initialize(&adev->dev);
 	fwnode_init(&adev->fwnode, NULL);
 	device_set_node(dev, &adev->fwnode);
-	adev->fwnode.dev = dev;
+	fw_devlink_set_device(&adev->fwnode, dev);
 }
 
 #ifndef SZ_64G
-- 
2.54.0

