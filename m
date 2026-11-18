Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030102;
	b=JENCuCzjGl4oD6HXKU73rYhn6YAaAxXbnjrSE7IkesQP23zWBOi05ZQMuRU4P62x2Qfw
	 VvhE/mcmV6eYCQPaRD5ThWpNggmE9P6juDKAdmRNtcgSuy3C+nITMAIRGErsRDlfvSmUV
	 Hnch90igjWToQ2Z/PJsKoga1rp3ZtYckmJ83VzFt7YxKqXI2yE8xwFs3YK1QLTy6MT47I
	 1HTTaKcdtNPmb2CQxjiBMYdacRTSzDMMbhFS8pi9gNJX3wBvCp+fkv7PMo1PnE5y4U93d
	 sJ5Jp4Rd7HTkAAnwHopEW/BaGqtvRVeadqf5JLYwWk097yyje7P6fMrL7aqf2DhRT7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=ePO1HaQy6BuunjZvvPsV5K/2vWM8debo/YiENR3jWNU=;
	b=RDdK6gDiriUryUGmu9kEsyAynEnU0oqtek4GYX82tkJ9sHoPx0ammHT7Zx6wPJpx+f13
	 UDQEZY9wdPTnwntnO8t3leWTlBNKYNnDV8GMIRgurdT06ZHcCQh2jy4wL8dxMiqHhaDpn
	 sIHNke5SgKHR1/CmchnWL7duxiZK0m4BYkz610LABtwjGk6SThP9OWmp/dYuxz3WGEBHj
	 oNiDjLkWS3++w+PKYoYgGCDgNrjkc3Lv8dO/8SYxwOxhRdkjQ7Vg/EWNXcugSJEaQIBYU
	 RfOqB/1iefWppWx4ObsX7mcbxD3wLtNC2Iw2mSdjQcqjf0ZvhYvncWVoezaWMp3I2Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ijm0HvjC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166EC60A6F61;
	Wed, 18 Nov 2026 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ijm0HvjC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AED1F000C6;
	Wed, 18 Nov 2026 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030101;
	bh=ePO1HaQy6BuunjZvvPsV5K/2vWM8debo/YiENR3jWNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ijm0HvjCOyPj2Sz14XGqAh55LuqsbUomOOgZ/+CyYcJsyWT2xlKZfIt/W7eAFOI1H
	 0Lp7EgtnU0lqKrNd6DVcVQCMqg41Y4UgL8ih3FVULgHtVGgqTGyYI9Q/T3tAASroeJ
	 ceuB40VBCqdG/AL2VMHN4JOkQ3c6dM/d6qB3ZpprZTBgfqSh8M3Ciy1PUfC5WKioBx
	 bKB/2uY7Is496NoS7pRKe6XChnfzk/UxprutVByaTIpTetUb6cHbjEa8Ug4n+Mal/5
	 7EJ4UaG0HnXuSY1V1wpiXy9b+b98pvsCBP/4PflIFZunvhobQEXqetAAlty2EdHZc7
	 0JmA9Kiaz9mgQ==
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Mans Rullgard <mans@mansr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cornelia.huck@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 17/31] Input: serio - use the compatibility driver attachment API
Date: Wed, 18 Nov 2026 21:26:47 +0200
Message-ID: <20261118-device-trust-core-v3-17-d655875c4bfb@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Manual serio binding holds serio_mutex, but generic sysfs probing does
not take that mutex. The two paths can race while updating driver state
or cleaning up a failed probe.

Use device_driver_attach_unrestricted() after the port ID check to
centralize binding and cleanup. Acquire the device lock with
device_trylock() to exclude generic probing, returning -EBUSY instead of
waiting while holding serio_mutex. Map legacy -1 connect failures to
-ENODEV in the probe callback so they are not reported as -EPERM, while
preserving errors returned by the attachment helper.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/input/serio/serio.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 54dd26249b027..f239217d7de45 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -83,26 +83,15 @@ static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
 {
 	int error;
 
-	if (serio_match_port(drv->id_table, serio)) {
+	if (!serio_match_port(drv->id_table, serio))
+		return 0;
 
-		serio->dev.driver = &drv->driver;
-		if (serio_connect_driver(serio, drv)) {
-			serio->dev.driver = NULL;
-			return -ENODEV;
-		}
+	if (!device_trylock(&serio->dev))
+		return -EBUSY;
 
-		error = device_bind_driver(&serio->dev);
-		if (error) {
-			dev_warn(&serio->dev,
-				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
-				 serio->phys, serio->name,
-				 drv->description, error);
-			serio_disconnect_driver(serio);
-			serio->dev.driver = NULL;
-			return error;
-		}
-	}
-	return 0;
+	error = device_driver_attach_unrestricted(&drv->driver, &serio->dev);
+	device_unlock(&serio->dev);
+	return error;
 }
 
 static void serio_find_driver(struct serio *serio)
@@ -744,8 +733,10 @@ static int serio_driver_probe(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
 	struct serio_driver *drv = to_serio_driver(dev->driver);
+	int error;
 
-	return serio_connect_driver(serio, drv);
+	error = serio_connect_driver(serio, drv);
+	return error == -1 ? -ENODEV : error;
 }
 
 static void serio_driver_remove(struct device *dev)

-- 
2.56.1

