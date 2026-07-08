Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3E38C2A9;
	Wed,  8 Jul 2026 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505088; cv=none; b=QxBcyN3YkJxttB5OmkhE49pXnN4TkiozItz788NmNi59Pz6FSOM4tnMBtpcjN/ZmiEnthMVDFmifun3ptG6WBVVL7KG+pdyuw7ck4nyUw4q98nPg49urZBEB8EB2hWkWskqDtLnuUtAfP20WZOT3u/k9ADZD7ToAF/TeN6rtS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505088; c=relaxed/simple;
	bh=P2gcSYVj+YSuIfptHAlHXowQVxHQHm6wtyHdqFyu/kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A75ieFdpqjx/w7ysdRe/KPxPV3K/yf8EOtbuJvQX8rMpqLd0+Gdn7GaGdhGHq/+hSZaEDBTAEpw6hhGWCDvA7WLI5N61HcDM95pzI8OZ7Td/f+RYez1UI2ozoqNdDWV0/GT+w42V4amMB9cHk5IKMoRZicwsYQFXQSrZmx1purs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CgbuInYP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CgbuInYP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9F2994E40CF2;
	Wed,  8 Jul 2026 10:04:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70A1C60337;
	Wed,  8 Jul 2026 10:04:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA73D11BC340C;
	Wed,  8 Jul 2026 12:04:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505082; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KqZe5pNjCZjTUX10ucdD2xXyOPwVWtL1RR7G2V3Xw8s=;
	b=CgbuInYPngxIZibC7HmCiIDLj2hKxzwqYF8tzdqxvCOohaj77fBxb4IRiHxWXE/C9Vo7RF
	s41a2ZKtGr7ZBn4oaK507cRK8OHh1uuFxFsUAbJXrbbHARqJspII5xXy5lR8UjyiFpYYqJ
	TeIe8ZvSpS0uGPs8bENDSyWBHt+maP32/yKneoGX10hwJCtjCAEFgVzIRMGL1TMqPB6vgK
	Hw3t9bcnnIzos3/5qNJkvkzG8KHRoXtQ8ojFuSNEPnGQ1misDPR4tzDsUpeSuHSwxQ7vDT
	C7tOskYMuzie0QJZma6O7ORiNMZUQJxhpY4amDkunq6zA6dpU2B7q1duFie49Q==
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
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v9 4/9] cxl/test: Use device_set_node()
Date: Wed,  8 Jul 2026 12:02:54 +0200
Message-ID: <20260708100302.517792-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708100302.517792-1-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The code set directly dev->fwnode.

Use the dedicated helper to perform this operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/testing/cxl/test/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ef92dd35e030..69da0727362b 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1528,7 +1528,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 {
 	device_initialize(&adev->dev);
 	fwnode_init(&adev->fwnode, NULL);
-	dev->fwnode = &adev->fwnode;
+	device_set_node(dev, &adev->fwnode);
 	adev->fwnode.dev = dev;
 }
 
-- 
2.54.0

