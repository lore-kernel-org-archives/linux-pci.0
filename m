Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030098;
	b=Ri7/181pGujhKCeo8Scx/un0F6CSbX2tiZPm3e1C7De3hjBOdBBm1t4vV/+t0nr7VDuA
	 EZ1u+InFWXTu2oly4hxvuhozL3GXle6yf7OC4DEDG5C6jDkg8R8QkBjIA29mWJpn1KKCM
	 I6cyZeOi6xbhNbTss1jjAL09SGBJgqSssHcTY1Nb9ueymFLztW6fIfoGgo3KKvy3CSZrv
	 pycJpVQk2u9re6EBDH02pM7tFCRGtktYzvvxUXaka69tjYqULoxMGMWVaozZjccEQjBcp
	 jiLss/dvSjXyeAftqPR6RVDBAL7g7VUZpBDPGLDqAgU45vnisfp15fhKYl5Ju0FXw1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=LHYj5RNi7XvfXBnbm1SbTiMtiCmXpIiLuGJrR2GJWwc=;
	b=II1NqQUhaIjIqmiTZnWOHSlN0yZxKZCXYSI6ZHdUXF4jd414kFf2RXlxBmAvxjFUHI7d
	 7IlYaqUGcCNbnHPIp7dqvhGipOOi8SnzR15JkE+JSpFwRlBR5guqkQ2o7LwTU21Qr4Zge
	 zgt+2KIBVBNlR7oWgjDc8hOmR5zujyFhYQVm9XDZCJPRQGNrcyNQtWI2gFWYOC2kJM/Ao
	 tkq8SS92GFdknqomO+h/Ltzfww4POjoVGwFCMPRAZYTRgmlHO/5sLHr0iAP07GoSL8BIX
	 um+guRBVgQrPmf7Jzz2rhuGswWmpsaK4djNRPCmKxrrsSA7bVBuZBjmxclsTAizwuvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMTKy2f5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DD606F50B;
	Wed, 18 Nov 2026 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMTKy2f5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8221F000C4;
	Wed, 18 Nov 2026 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030098;
	bh=LHYj5RNi7XvfXBnbm1SbTiMtiCmXpIiLuGJrR2GJWwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMTKy2f5hOajpdVsxT7Z/qw0cQ+SUGAGAfoQht9oGCzvVeXtU0969ho9alvjVOJBc
	 Ihu0HHC9GpuR3MVLz4y1bbjoodIDEDbtnYI68gnxsp/MQ4zitgMllGoWybTniZ/DKV
	 uet44X/q63U5kdP2oIqk6X6+Shay3RFoig5U8qPFbaIXiPJo8vRYBcvxUeV4cF6BJu
	 S4lD0thMtGD+spztVFCEAPrGZwZQr9wcDlXm0hCyMa9G5qLrPTpVLRDLvlPE2ykNDN
	 9C8Ad4rK6ch3gVlw/2rApQEzvJcbCGzlft5XztqnVDGv0GI+X5tMEd/0OBln8vg3m4
	 DwQwNNsNcbbGg==
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
Subject: [PATCH v3 16/31] Input: gameport - use the compatibility driver attachment API
Date: Wed, 18 Nov 2026 21:26:46 +0200
Message-ID: <20261118-device-trust-core-v3-16-d655875c4bfb@nvidia.com>
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

Manual gameport binding calls the driver's connect callback without the
device lock, allowing it to race with generic sysfs probing. Normal
probing would run CONFIG_DEBUG_TEST_DRIVER_REMOVE under gameport_mutex;
a disconnect callback that unregisters a child port would then deadlock
trying to acquire the same mutex.

Use device_driver_attach_unrestricted() to centralize binding and failure
cleanup without the debug removal cycle. Take the device lock with
device_trylock() to serialize attachment with generic probing. Return
-EBUSY on contention because waiting while holding gameport_mutex could
deadlock with probe cleanup that needs it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/input/gameport/gameport.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 9707b155bc947..88b1a3464bf3e 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -216,24 +216,12 @@ static int gameport_bind_driver(struct gameport *gameport, struct gameport_drive
 {
 	int error;
 
-	gameport->dev.driver = &drv->driver;
-	if (drv->connect(gameport, drv)) {
-		gameport->dev.driver = NULL;
-		return -ENODEV;
-	}
+	if (!device_trylock(&gameport->dev))
+		return -EBUSY;
 
-	error = device_bind_driver(&gameport->dev);
-	if (error) {
-		dev_warn(&gameport->dev,
-			 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
-			gameport->phys, gameport->name,
-			drv->description, error);
-		drv->disconnect(gameport);
-		gameport->dev.driver = NULL;
-		return error;
-	}
-
-	return 0;
+	error = device_driver_attach_unrestricted(&drv->driver, &gameport->dev);
+	device_unlock(&gameport->dev);
+	return error;
 }
 
 static void gameport_find_driver(struct gameport *gameport)

-- 
2.56.1

