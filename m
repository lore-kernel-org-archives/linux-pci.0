Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513533;
	b=sneVlvtDlSI5lGg/sgvIBUsdR7kpVLBjslyw6wwTou6zUat7yU1iGHIkNpVuAXDMWLpH
	 hQM0JMt9QPcYxRTU4JzbyBE94TKxqYmS/7qsy3c2+35RPMjBbC5rvfR2pHzuRI29KpJiO
	 6Ryn+6M/parTWuWzuaeuqWFIuoAl7/PtmNvvA8w9IvCUrsxg6B07xF4fR+3trmqF5d4+9
	 gfc07WcK5nrqNT7+w9ip3pQXh0PAVBxb1Nftud2BNawJvumYP0WbLxnMLue1E1VoQTe86
	 jdOhru3orD415fsa/ZNYo3mCEYzBnYVONlGpctqeFhPtYRcaK2d3vva/FeCk79OeTNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=ePO1HaQy6BuunjZvvPsV5K/2vWM8debo/YiENR3jWNU=;
	b=z2mPQGRImZhTVsQXboflvRjJPGAVUCWtYlJX78SMego8+BMA9aLm2oF6F9h0SMEYomoy
	 aoB7LFqNbYCjfWEWnRD+IJRz/g1tGNLy+mjBXogxGkJhOyKtYMRKezsGbAqQ+VBQZ+PFz
	 lv2QyUtSlE8wWRoVRbUC79sLqnb+gISXV9udte4stzlo+9ex5zpWLva1BCqHriVj35Y4E
	 1XmV6Z4xLAKiHkeIC9jkARWwoHbZJt1W8+KSS/iowOGC+bdh74zrjUkJTxeC03Lnk3f/B
	 0IZVXMi310JlZuQYFinYcwsrOQ+fwkJnaEY3CwxsJT8s15Kt5cL98/WrXmecyVGkuqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJNHHCiG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A52606B009;
	Tue, 24 Nov 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJNHHCiG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3EE1F000F4;
	Tue, 24 Nov 2026 09:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513533;
	bh=ePO1HaQy6BuunjZvvPsV5K/2vWM8debo/YiENR3jWNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJNHHCiGzv0WWwdpPr1FMAlFOt8wwBxS5sXv8kmA4ekRytwPIv8fStFQiwgccPJrP
	 FJcDzCZEXAOXDaG+hW7vVoSHtCvFqsNVshNhdnEkJL8jKIzWWigshXntueRO2pXPqX
	 2D64PCUgFN2FwBt+1y7HOY4T4SFRY1TX0S+un8UcYb4OFVFHLcDWQBcn17adMbhsmy
	 /b/g/D8+J1SwD5uUGpy2mMmy0mXkKgT4/6xbQSaTcXsAgfybEHx+HIwbeRtuvdUMym
	 kTGklVtTRxr9d3w/5mJUYPzDg0/hXfrKvbszu6tItwb8wygBsOuwj8maD4SuAGbryo
	 ECFVMc6pEGaPg==
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
	Jeff Garzik <jeff@garzik.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Dan Williams <djbw@kernel.org>
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
Subject: [PATCH v4 18/33] Input: serio - use the compatibility driver attachment API
Date: Tue, 24 Nov 2026 11:43:49 +0200
Message-ID: <20261124-device-trust-core-v4-18-037eb0d17b1f@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
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

