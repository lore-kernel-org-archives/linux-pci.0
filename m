Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB073F23A9;
	Fri, 27 Feb 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200778; cv=none; b=sOcGRr8Z/uSFVxF/fa8FqHHvyeoWMo/Z3GM/HIpT4Vi/CGgv+mEcQqFY8W1VGr8ufQjWu1VOtYs6XjJt9WG6MEITuus6+ix1ww8ilQt/lkAaosDLm3Ue1E7WBfbw5pyABBpZ90IpcDXaEI3Ovq9Kin/kjuHgZk5bB/SNTObFkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200778; c=relaxed/simple;
	bh=DaRfsV2u+e7/20CbFYhTmGEe9Lq4oc9ftgi7hzgtJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU7IRtSh9L5Uy9oGPPUhzybwmzPkpQ4iqGTe8LA+D0FU7KMPlXSGSfrNmdzEZwperswx9FxONb5xjUyMLSCGWRVSCVjHdSb2lWtoi6s9H4mODcVmOtc6kPnXoXh5GLf6pAjGF4J0W3kZDu7atw56qD91y8qyUHm+rvR64onhEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qhWmxsQs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qhWmxsQs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F41A74E41922;
	Fri, 27 Feb 2026 13:59:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C197E5FE74;
	Fri, 27 Feb 2026 13:59:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 512ED10369455;
	Fri, 27 Feb 2026 14:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772200773; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EO+KwDm3fpx2sS0DmTpGwECNmbhB0N19pDgf5whzoMI=;
	b=qhWmxsQsRt0OU1IK3m5H6p4bRNT1Je3fcsO7325r4sNhWLQFLi1BVbQ+7TDw12k2BvQNi1
	3X84m/W2WVyTgydX7dje7kg+8+u67v1eMf2FFLH/OAsvvRtX6o85OrXPw5TVb1fyYazYI5
	44uSEJw58YISkXHDI/w9HAc5HHgMsb59EQ9zUmkcX3YyE6XwDq2KKjs1wKIuGgMlKiur4u
	q1kUn3fAYxbuotjnD+8x/TfAsJKyZvoOvXonz9wvO1zXthYxO35kDLPiihQ3c5YMXdg1aF
	kJcU2UWrZkAGwneOMRxSa9BZAIxsbD6CKQ/NyHpoEqaahluagUjG2IEmFQlCRw==
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
Subject: [PATCH v5 16/28] i2c: mux: Set adapter physical device
Date: Fri, 27 Feb 2026 14:54:13 +0100
Message-ID: <20260227135428.783983-17-herve.codina@bootlin.com>
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

For i2c muxes, the parent of the mux adapter device is the adapter
device the mux is connected to.

This parent is not the physical device related to the mux adapter.
Indeed, the physical device of the mux adapter is the mux device itself.

Fill the adap.physdev with the mux device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/i2c-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..f4e73e7a0e33 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -315,6 +315,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
+	priv->adap.physdev = muxc->dev;
 	priv->adap.retries = parent->retries;
 	priv->adap.timeout = parent->timeout;
 	priv->adap.quirks = parent->quirks;
-- 
2.53.0

