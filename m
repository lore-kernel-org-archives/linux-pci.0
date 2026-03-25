Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CA3FB7F1;
	Wed, 25 Mar 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449687; cv=none; b=ZKVRA3c5X8ZUVaJM7BugYYfLieLhEOgat8Pg3FNGr8/IOycsP13AgKZQWvCkK7V10nP/tthFLxcBx25hTG7/Bmy5EBzDU/hqz+3AtvGjsV11QzhXJqEWnprumIHpQnL/fc5ARxOyZwqhapnKfHZ3faaW5B/sAbhz4C9y5ffQ5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449687; c=relaxed/simple;
	bh=opKdfdVK4CzMrQ5mOvu1aN+T6KAaaDtxxB/GB80aspg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp53rtye+WxkV5ZAPgzDQMQob2xblfEio4tJyR8DHBL+3fkAcnjJ77Vsjsz5r/BGlKuOhq6ytqHAPewWKkBoY0Jcmjo1gsftAKOKZktg527gSeDaqn+V7ixYwQuSpVtufuq3a0xhLugBdAaE9YdGWNQPq7n6rlHi5Hn7Vi8l09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cdqrgp2N; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cdqrgp2N"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E1BBC1A2EFA;
	Wed, 25 Mar 2026 14:41:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6FF5601E2;
	Wed, 25 Mar 2026 14:41:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 280B110451411;
	Wed, 25 Mar 2026 15:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774449678; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vTj0jmIFVnvyBrAo1BELaCko6WzI+kUICmGliPFJzCI=;
	b=Cdqrgp2NOy+ir/c4DFMnlhHuzvBZcwpcFZZUIDZvhcIn4x1WPWTNE+MlPCfcq+AdXGyg+o
	JU44FbMKZ2TXktvP+4lBVQxOEGBOrPnL5Ues0/h5OsfEwzAZOG5nb+gpCM48rMZEQqISbU
	kOqVDFkmP8vMouAB5pY08DCLcAOkGdxpDo2igFLXqNrLgnPB2T05lmsxh8gUCbKvgyJ4Ju
	S4hj1yB/gOXOcT3KQgzyUkEMpmbPC61OJW609YG5nx6C46iMQY5eSZN5PeJ/3JEfNVNj4k
	1BIZ4MfhIcxwfRJ3WqAhS10uWWKLYtAIn7P5XvvEAUvPhklG6ovgpTmh4OKxKQ==
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
Subject: [PATCH v6 17/27] of: property: Allow fw_devlink device-tree on x86
Date: Wed, 25 Mar 2026 15:35:44 +0100
Message-ID: <20260325143555.451852-18-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325143555.451852-1-herve.codina@bootlin.com>
References: <20260325143555.451852-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

PCI drivers can use a device-tree overlay to describe the hardware
available on the PCI board. This is the case, for instance, of the
LAN966x PCI device driver.

Adding some more nodes in the device-tree overlay adds some more
consumer/supplier relationship between devices instantiated from this
overlay.

Those fw_node consumer/supplier relationships are handled by fw_devlink
and are created based on the device-tree parsing done by the
of_fwnode_add_links() function.

Those consumer/supplier links are needed in order to ensure a correct PM
runtime management and a correct removal order between devices.

For instance, without those links a supplier can be removed before its
consumers is removed leading to all kind of issue if this consumer still
want the use the already removed supplier.

The support for the usage of an overlay from a PCI driver has been added
on x86 systems in commit 1f340724419ed ("PCI: of: Create device tree PCI
host bridge node").

In the past, support for fw_devlink on x86 had been tried but this
support has been removed in commit 4a48b66b3f52 ("of: property: Disable
fw_devlink DT support for X86"). Indeed, this support was breaking some
x86 systems such as OLPC system and the regression was reported in [0].

Instead of disabling this support for all x86 system, use a finer grain
and disable this support only for the possible problematic subset of x86
systems (at least OLPC and CE4100).

Those systems use a device-tree to describe their hardware. Identify
those systems using key properties in the device-tree.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/ [0]
---
 drivers/of/property.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 50d95d512bf5..80800a20d1ac 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1620,12 +1620,36 @@ static int of_fwnode_irq_get(const struct fwnode_handle *fwnode,
 	return of_irq_get(to_of_node(fwnode), index);
 }
 
+static int match_property_by_path(const char *node_path, const char *prop_name,
+				  const char *value)
+{
+	struct device_node *np __free(device_node) = of_find_node_by_path(node_path);
+
+	return of_property_match_string(np, prop_name, value);
+}
+
+static bool of_is_fwnode_add_links_supported(void)
+{
+	static int is_supported = -1;
+
+	if (!IS_ENABLED(CONFIG_X86))
+		return true;
+
+	if (is_supported != -1)
+		return !!is_supported;
+
+	is_supported = !((match_property_by_path("/soc", "compatible", "intel,ce4100-cp") >= 0) ||
+			 (match_property_by_path("/", "architecture", "OLPC") >= 0));
+
+	return !!is_supported;
+}
+
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 {
 	const struct property *p;
 	struct device_node *con_np = to_of_node(fwnode);
 
-	if (IS_ENABLED(CONFIG_X86))
+	if (!of_is_fwnode_add_links_supported())
 		return 0;
 
 	if (!con_np)
-- 
2.53.0

