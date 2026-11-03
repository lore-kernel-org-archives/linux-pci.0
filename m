Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721407;
	b=R0vV6Ub+ZfjA93zRHQtZ3Jh4sCN/KiDR4SV/LUmxp1Hhlp7sm7kXoJBWPHg6uqQk2BD9
	 Rjzv58GViNuy15koBlIdI4l9JiLr0SumWqz8265oEyYnnTZ65cTt29nV6V2Ee9dwZ9c+v
	 DCiwsaB3X0HVJYGiq6GwuTEMAmKgs6HDK4zmncUpUxXsgWe72kxjyscgUbEcofRg66GkQ
	 DDAljfhIuIfzSgnvPBiTxSPZn897IEUdCT79lKrk01xpbbncpL6mKzYkqOPQiDyPCP6YU
	 nHbgWDKOm+sNBLW+Vfte5qb6kq+iCyUjCpYdDjalj6n0rYuFQ0GR6nfIYy3+AYVyp5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721407;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ltVbVz/siAwcbuGvXLwt5fOuNRsRG0B8k83pnxiddeA=;
	b=nRF6xAyZsJn20kLCik3MNQEzUQxqpL10CtECBBGUMv6CXIvSl1pyqe6rY82PyLhU6GlK
	 RR5gsxmT6L+C5Eruxgv6DtP3fFbq+jjHnUfunBeK+n/M7LvUYs9BHFIL4VVF/vKdoxMXT
	 FNyKwYoWyfOQuY3S9Er04R4coX3GvZxzn1CitpZwNdp+m9Q59v5DDljyFTTGljhitK2VT
	 jE2bC0J+SGIru/mTmJrjWQLJsBXadknmaKq0R/KxlLS+sayX9NLr0k0uQC8OOacXjoERR
	 d7+v6AIaYEjuPSI2d3TG5SYg3/14AiwqnxJSy1i0RSj7S0oYgZAd9Dnb+AZ0j4+W6cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OkvMT0qd;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65E606D82F;
	Tue,  3 Nov 2026 15:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA65E606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OkvMT0qd
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 82F221A1435;
	Tue,  3 Nov 2026 15:56:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4AB6B6046C;
	Tue,  3 Nov 2026 15:56:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5568710329123;
	Tue,  3 Nov 2026 16:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793721402; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ltVbVz/siAwcbuGvXLwt5fOuNRsRG0B8k83pnxiddeA=;
	b=OkvMT0qduiKcjweUuPaZ1/yRKtf3FYdVwJHRkg4iarDCT0lBJ5rl0nai4k3aT9GKczLVRv
	WLsMGWHOWnyS6BJ8UwvyjyreA13rfDLUsf0x3IxxbFx4FeD/k4f+SlSUA+EwTpE7cAvxe2
	+xNIPcULM6dy8u4lecYSSZTKz3wBG7J8q7c3wd0FyKa08GH7Zd32OZGkNQ3McN9eYkiEYu
	SIH1ylpOYLY+USrXt5Z780GQ3IihfayArizHrTOm/MTKplmVo4Rvu+eLqxizp1UKyeXEBD
	pp2i2oPIY645APHXj/KE9aPHLCm2H/mFptY99EG2V+NtRbEt3dBpcXLOdtP0jg==
From: Herve Codina <herve.codina@bootlin.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
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
Subject: [PATCH v14 04/10] cxl/test: Use device_set_node()
Date: Tue,  3 Nov 2026 16:55:10 +0100
Message-ID: <20261103155540.365294-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103155540.365294-1-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The code set directly dev->fwnode.

Use the dedicated helper to perform this operation.

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
index 3eb1051b1ee8..63e3d7d18d24 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1747,7 +1747,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 {
 	device_initialize(&adev->dev);
 	fwnode_init(&adev->fwnode, NULL);
-	dev->fwnode = &adev->fwnode;
+	device_set_node(dev, &adev->fwnode);
 	adev->fwnode.dev = dev;
 }
 
-- 
2.56.0

