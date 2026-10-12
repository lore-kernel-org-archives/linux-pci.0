Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41F52D2D6
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913775; cv=none; b=K/eC7svzQ3Cufalx8cdNm159e/ug8lajWtEamglgnr79q+cedJCwEeUB8gekHo/PMTywGt475fkB1Ew9S14QXOWDDYMqCp/xlgQbvGECyW7t0k7CH3DoEewzU81v9IfocEkmQOerqyKtQZf/xy5UhkZwWKhyXY8rMlqIcdONebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913775; c=relaxed/simple;
	bh=LeDPnBgrM7pNQ8OlNZHsJRQR3r2PXLGLegBZ2Qsqzf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7up1WEhnzVLkI54kEEmzDo+QQvW2F+ae1yqefRb+Wjz+m42YXKoaWkLuLmvcnqSO3YLzLko8sGYjoLzifm30TaV8KvjMkY+R1V5Q7kgeRc7EatP70z3cmd0I4izu97TYYQD7VRCPesdFeXXcg1NA+xopGGfjMJSKyi2yhvA6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NdNabsP0; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FjGgQOgH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NdNabsP0";
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FjGgQOgH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA3271A1216
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:49:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF13B60362
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:49:29 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 24A1C11D7159B; Tue, 13 Oct 2026 19:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913769; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kAb7NHjVc8QoTRTxUb1OG7thf2F5YhXlem84GhsJqnE=;
	b=NdNabsP02HZDL1Yd0p9xn7Gq6jFgqZeByRAX+Q7CpJoSqxQXz6P/UjMdj3ZRDFWblZAxsL
	7OBEfL06buPxK2+Sw+K+rjUi4obnwek+nyoCjKbwDeTyErXjffqWOGVxgUml0KjY8WHByJ
	0J+xWbQVsI9aWuYJ/waZG8f8TXBKVaGWJERvsBbuKN2cPB4Gn1dwdeU0HfM2vSRg6tcx0r
	TKHvQ3lOKsYWFC0IDdq28VnTB4j3PSgRsnS4o/g33+5Pz85mjgX1AWPLBlVoeZ8SePXOkM
	u+aj1BnLTLQeI0PoIWW5CKqvt4pe5H7aatv2JxkA8JEMhko8q4HQ1WbLzev7fw==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id SKPIALTuzGoYHxEAtaWaaQ
	(envelope-from <herve.codina@bootlin.com>)
	for <herve.codina@bootlin.com>; Mon, 12 Oct 2026 16:29:08 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F37FF11D708B4;
	Mon, 12 Oct 2026 16:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791815339; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kAb7NHjVc8QoTRTxUb1OG7thf2F5YhXlem84GhsJqnE=;
	b=FjGgQOgHcTUDDGnIbSuozwmNqeMTRdBQVZaPNnUfhfNiHolctNHx1hOE21Ll6aYc6zsp1v
	tYfEnkKxdGOOtY680hMNAcNEJaM9GkRVagicVm8ou5DFrd5VuLmwgGbbtWaPBFa0nRcAW7
	iuGKxtDnIWPKwfwaYZObdeJ9zckNqniI+KLN1vyuvrXhXy0sCRuVe0N2R2v06p+hCVJxzJ
	Oxu6iH3orqfi6ElTPOegR+Wj2TpZlYb7tN7T2IqKprgAnyueowX5lDSHa/Zsq+QxXiQiAc
	GNRjXOfG2P+7tWArtGJk8xGwxsp+opS6e8tVRR7Xqp4HXMpqP3lAkPgm74kLIg==
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
	stable@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v13 01/10] driver core: fw_devlink: Introduce fw_devlink_set_device()
Date: Mon, 12 Oct 2026 16:28:15 +0200
Message-ID: <20261012142826.159178-2-herve.codina@bootlin.com>
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
X-Rspamd-Queue-Id: 24A1C11D7159B
X-Spamd-Result: default: False [1.77 / 30.00];
	DATE_IN_PAST(1.00)[27];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.73)[77.64%];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	URIBL_BLOCKED(0.00)[bootlin.com:mid,bootlin.com:email,intel.com:email,localhost:rdns,localhost:helo,qualcomm.com:email,nvidia.com:email,linaro.org:email,cirrus.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	BCC(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[herve.codina@bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[45];
	PREVIOUSLY_DELIVERED(0.00)[herve.codina@bootlin.com];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,lunn.ch,kernel.org,linuxfoundation.org,google.com,opensource.cirrus.com,cirrus.com,linux.intel.com,gmail.com,stgolabs.net,intel.com,zohomail.com,bootlin.com,amd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com]

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
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Cc stable because used by other patches with Fixes + Cc stable
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index a9dcaf7e7076..3ce49575cf82 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -260,4 +260,10 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
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

