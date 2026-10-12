Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CB3E5595
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913862; cv=none; b=WeTMM5QuK3F7F2MuRluO46GbpvBK1ysyuPVWgOKqdae3cE7new0m1YEoDJxZsYGfD8lM/FEE4HFKBED38WQvZUNG3HU4pIJecXzpDKm3hOgwz0T/s8sB+JK2inO6wQKJJBQDEQohrS6gYGQTSYFikvGTpL2yJ1/qStpAXmD1xt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913862; c=relaxed/simple;
	bh=gMNtK/0YjzbUiWPTlVbcnx+RZMHYxHe3zyVfcHByLZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyYmkupix4LjCqlOi/QYLh+9VuWqJ2h3pXFOq8Tjlo85okW5G2ljTIWUPc5qjcjznfJfNhNTPXWp95kMMMFeLQzRFPV7j5iiiNfSJuIO+V5mmT18H/Ewzeaq/72MtfxgwxII7dW1v1n15B64bNdMd/JGKnw8OMth0CGTyqOwtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vPrBJHiK; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=clnpTkrb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vPrBJHiK";
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="clnpTkrb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CE569C653FB
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:51:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 38EBD60362
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:50:59 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id A865B11D7183E; Tue, 13 Oct 2026 19:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913858; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+ChnyDkFUv0fqgvepwYYsoR4k2/DprmHV3Gvk8JzTTc=;
	b=vPrBJHiKnFwQk5M42+sYh3IFiiAuyoJH1L25yCSb4IYxxFXcvOVVMSWQysBj88X5DPBo63
	jShyr1WSg6OT7Pt9GrQBwxMUj2kPDkTDRBsJ/70l5DM9OY8r0Ry5V9Oh3RMyvw6VC3334z
	63NQjuOJ94aD6rnUHKUSiiYoKmYBIo9ngef4xfM3qk+50z5ns91UV/rneZPBblM6Idabvo
	o7zwd5xj4zk/vJz/QX8ZokxgndxQWcEAjmtersmbW/W5ehkEI5LwCLBVgPDXzI7tRr8/y+
	05l0qgzGrN/f8DQMA0wlayEEb9DrjNKcxoDrDGPOyezlNzeY/H3Qi1mtxO494g==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id aL93AdDuzGpsHhEAtaWaaQ
	(envelope-from <herve.codina@bootlin.com>)
	for <herve.codina@bootlin.com>; Mon, 12 Oct 2026 16:29:36 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A812811D70508;
	Mon, 12 Oct 2026 16:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791815372; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+ChnyDkFUv0fqgvepwYYsoR4k2/DprmHV3Gvk8JzTTc=;
	b=clnpTkrb9ux+68cvnotT8l/KdiVYfLjFygknOBdqlfrxUo5yqEZ2Nwrnba7Xxby/Shyqtf
	n01M7smWgdnfcRbHlJsXvIgJIIFDsAxq5rF7G9YbpXDXiw2khAKxtdBEJ6NppJqswxg6Fn
	DUt8rhuk0sa6D5Ny5+hRiKvGF5tmv2NZnLak0TjzZ/oRMtH1TZtm+Fpi66UNqkI4pVp2yf
	ifGpKp/jEPapsegLs101d5LR8Pew1Sk+oE8BBf7yobvm3GKWO09hWcsh9ZU72btcd/c2xG
	ZA47T6qAvIe23tFTf1cBV9v0F45x9AYzZyOinpBEoqYAaaMJyX2Fgl/6hovMjg==
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
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v13 05/10] cxl/test: Use fw_devlink_set_device()
Date: Mon, 12 Oct 2026 16:28:19 +0200
Message-ID: <20261012142826.159178-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012142826.159178-1-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: A865B11D7183E
X-Spamd-Result: default: False [2.46 / 30.00];
	DATE_IN_PAST(1.00)[27];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	BAYES_HAM(-0.04)[53.32%];
	PREVIOUSLY_DELIVERED(0.00)[herve.codina@bootlin.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	BCC(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[herve.codina@bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,fwnode.dev:url,intel.com:email,qualcomm.com:email,huawei.com:email,bootlin.com:mid,bootlin.com:email,nvidia.com:email];
	FREEMAIL_TO(0.00)[nvidia.com,lunn.ch,kernel.org,linuxfoundation.org,google.com,opensource.cirrus.com,cirrus.com,linux.intel.com,gmail.com,stgolabs.net,intel.com,zohomail.com,bootlin.com,amd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com]

The code set directly fwnode.dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 tools/testing/cxl/test/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 547ebc97bf59..e21e45fe1572 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1678,7 +1678,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 	device_initialize(&adev->dev);
 	fwnode_init(&adev->fwnode, NULL);
 	device_set_node(dev, &adev->fwnode);
-	adev->fwnode.dev = dev;
+	fw_devlink_set_device(&adev->fwnode, dev);
 }
 
 #ifndef SZ_64G
-- 
2.55.0

