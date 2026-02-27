Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C6428841;
	Fri, 27 Feb 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200972; cv=none; b=WuDlAuMt5bWm0TQX+gf0r7LLLMXv4QNUft0AGX6w4jWKhsxKqnyz8W2+L/C//arnAUcG0llfHQA/weAfILuRMrKgLLej5T2uXJA+mKIIkkIFfsXnYwH1992EcrQ6RtvLbwdO33lk+FiTm+dzNEpPw023P+5NhuuxYJg1uiDibBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200972; c=relaxed/simple;
	bh=SsD09xOCQ2lgSQj/n0w/ZoUczDXfNByivtOBGWXEmt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5WbmzsDsL+K1FsWhS7mOZFJ1yUlQMArdpOG0Kn7xqc07OKcCDzn4jGWruj/tlVTrqd/Oxw0pQNMlXMVqlyjTxy6QlxOnCT/R4Dw4MBI3huWLRJ8Lbd5jJh0wTwBOq98m26ayAe9LjO9bdxk4wJZwL12YqxCknptz1pN6SNG1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m4t7l6CL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m4t7l6CL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 58ABE4E418EF;
	Fri, 27 Feb 2026 14:02:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D0455FE74;
	Fri, 27 Feb 2026 14:02:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5A8B10369455;
	Fri, 27 Feb 2026 15:02:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772200967; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q13pHLbTNQd/5Auc3jF+bDsxwBJ2OfItINqgqY+fL/8=;
	b=m4t7l6CLBBA9iTTCOyPpqIu/Jtq4asiz5+LxtMLuGbi1rWAr5+NuAo+0JE893eyPpWBXnX
	1JyHY30KY9ekk58yW31RhKOdn0jDjJhOiDeQTl8qGViJIw3Zo/z0JqtnV3AKjQQUm4KCrj
	CtG58IDJuSXdxVfdIYAV3kCfYZAfyuE7iGFfkuNGQLVJpT7eax6BBVmfqWwBngGwedq+w4
	rCWsWWvZ+eglBoCp24F7kUea/YLTYyv8hFSeqbvsIHwk/J4qygbwowdhRy8vxiHZ1TS3XG
	1Raamvfi5wD5+zE6bZiwCJQn7/VTUIWzWWmbYsAA3ZChS8kFYtSmUddjg274EQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 27/28] misc: lan966x_pci: Sort the drivers list in Kconfig help
Date: Fri, 27 Feb 2026 14:54:24 +0100
Message-ID: <20260227135428.783983-28-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227135428.783983-1-herve.codina@bootlin.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The LAN966X Kconfig help section mentions drivers related to
devices.

Sort this list alphabetically.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/misc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5cc79d1517af..9c285a7c88ba 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -635,13 +635,13 @@ config MCHP_LAN966X_PCI
 	  Even if this driver does not depend on those other drivers, in order
 	  to have a fully functional board, the following drivers are needed:
 	    - fixed-clock (COMMON_CLK)
-	    - lan966x-oic (LAN966X_OIC)
 	    - lan966x-cpu-syscon (MFD_SYSCON)
-	    - lan966x-switch-reset (RESET_MCHP_SPARX5)
+	    - lan966x-miim (MDIO_MSCC_MIIM)
+	    - lan966x-oic (LAN966X_OIC)
 	    - lan966x-pinctrl (PINCTRL_OCELOT)
 	    - lan966x-serdes (PHY_LAN966X_SERDES)
-	    - lan966x-miim (MDIO_MSCC_MIIM)
 	    - lan966x-switch (LAN966X_SWITCH)
+	    - lan966x-switch-reset (RESET_MCHP_SPARX5)
 
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
-- 
2.53.0

