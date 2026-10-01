Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714A51DE04;
	Thu,  1 Oct 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864950; cv=none; b=awH/OnbUBeenXGxgnZqXt275wmhjcYVD3W/o9fvVTI06yzzS66wb/G4e4l2qd498pGgIflSinB4yeOjiFc6K7Poxk6colNU9vWGaXkmUfAXgWRo79cWpj8jdBT8kdmwJqtZrujdmGCbR5UncpcmS5GcGR5t1mvS/LUHx/60KZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864950; c=relaxed/simple;
	bh=XJGZt4sM4QDdUD+aKGxPtJ5bcAgcvVECbNG7ZFrPU+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnQoRATTIT2HIRSjvZ6hlbDuXIJ516uAfjrkE+BA/zkRGSQB/RFN0eARTWQnult+iyTF9Y3pWNMe/abwZLaI+Bsi1I0E80/cA09c6ld5w64Ok+t0EVZEHJHct84xDXbguI8QJbrWt7te+bmCELc6upx1sF2pPQ1VFeyoxMlQb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NSuxuOMI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NSuxuOMI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 721A54E41111;
	Thu,  1 Oct 2026 14:28:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42C0160341;
	Thu,  1 Oct 2026 14:28:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32D6010328149;
	Thu,  1 Oct 2026 16:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790864935; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WlJnRueXb2zLEVWYbGRXOmQIh5q28yJIiHd5XzyKIjc=;
	b=NSuxuOMIqSMh5HOq3/Fn+ytU2qulro96CM/fNpMzBoOwLjV9EKAIGczMdBp+2Phh2R/7lf
	C0XGW4aAHPs+TtrXwqAtGt9O04USnDNdhaMrJ58LO8nDPT3Qi2tf3yfd9+S87Rb9zaP/vY
	9Ux27QasHevHPe/pRoAc1K052G3JxayBUhfTZBggxYa0D3chUruOdjXobC39SrO+dIbbJO
	eIutLLvFmE34jgf7iPgchDdagWkXs5YQqubdnr3M0rOTcIyLS3aEwF4YJpTfB3e2XLOE7r
	Wx3K6OF4gywXHCGnGmhTdNB1owdB8H0AK055GxzNSzmBacmVg66UldqIixoGgA==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v12 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
Date: Thu,  1 Oct 2026 16:28:03 +0200
Message-ID: <20261001142815.277550-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001142815.277550-1-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
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
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index 8990fab0446c..563070aba3d8 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -576,7 +576,7 @@ static int cs42l43_pin_probe(struct platform_device *pdev)
 				return ret;
 
 			if (!child->dev)
-				child->dev = priv->dev;
+				fw_devlink_set_device(child, priv->dev);
 			fwnode = child;
 		}
 	}
-- 
2.55.0

