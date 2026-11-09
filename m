Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209648;
	b=FDq0JNYrpocfic1MC/ftVPrFbpnxc4sXPZZVdKqu1GaME/N3KryexzXZw84jnZY8PKlc
	 k/ZYsqfIZt/O2cCX9eXTp+Z5TtduIyViQkPySI6qErPgbVPVu+BOli4RCYqidQ46uGsxp
	 ctJlxPxyayL4Y6fwOgdRSYBSuVzsR1Y6GQCQfDckun4K0411mWm3sekxK4KvnT9qhQqqu
	 j5UQQkCgm+ZsaNtzWV0qmWErNHNJw8chNwZPArfPrJFHHFR4ZxS/unIlAAQiTlO9+6THq
	 XJb4CyQOrUvGX+juACsagWfurvioZ7hmEiY8hfxfvxL39WdKNsOBwutLkJNFch1yoZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209648;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=cqZgEa3fWaSRKdNA/kRQddW5Yao1N6EqxQ4vC2mu8po=;
	b=ua2oawBeX1PguVFrrUFbXwCTiN2S9B91/FE3ZFxGKF2BQvUuyA/jysdhLFX9CgvB42Gf
	 yJDN/KA2GvTiV1gTfFQ7nWuVmExTg0+whhNrgFBSK4u5DXJTSHhy9Cu5JKu2IPkoBCeFT
	 Bs19KcB8AbJTlWSM1x9TRxU4kmnEiqAH5VQj363r1cENsh7Gf37RuIvrmT/kWWC8OWY4H
	 pLqKpPZeDPMK8CsT3E3DzOMoxEelcyMcqwxCPmS6tc6WZe7736fcN5ec5t2PDRDqzsML3
	 3KDcH1Yw2KUhyx00YL2DSItQR7TrELQwuBdUI84bG/RqINhH6VnBRCosGTfVpA6y2OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLu0vKUr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737F606A333;
	Mon,  9 Nov 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLu0vKUr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA61F0089F;
	Mon,  9 Nov 2026 07:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209648;
	bh=cqZgEa3fWaSRKdNA/kRQddW5Yao1N6EqxQ4vC2mu8po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bLu0vKUrD3cDT/qaervg2di3zkERF6/cciAIK43BD4nhYvNKlNRXF4/vR9Y3epDi4
	 v4assoGxsYd0G5fydaLEx8x8iK5roW4wU1FQy4KKQWvkc3AeIb7ajmex84xb5flKI3
	 rCNcF/qttoswbs6SoPV23aFq6/JYZLO80XEkTGDBprWn7EvCx9ufP0XGt8Xa2Nga6f
	 rirYuOB3FFNySftsLHqVme+mdjZc87nyj1Uv3bNDIJX13HEInMsNljVbQVYADHfl9f
	 IS1F3HjqKPZO9HyyH0gRW2zcUD+SJtiJrBe7QA8xxR4DfB/PcFTonxQJ88Mg3LTCBh
	 rWEn9O4bWGNVw==
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
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
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
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 01/19] Input: gameport - attach manual drivers through the driver core
Date: Mon,  9 Nov 2026 09:33:31 +0200
Message-ID: <20261109-device-trust-core-v2-1-3b12d9a9f861@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
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

Manual gameport binding calls connect before publishing the binding, so
driver-core admission cannot reject a device before functional setup.

Use device_driver_attach() to run the existing bus probe and removal
callbacks under the device lock. This gives manual attachment the same
admission, setup and failure cleanup as automatic probing.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/input/gameport/gameport.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 9707b155bc947..c9efec2dc55da 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -214,26 +214,7 @@ static void gameport_run_poll_handler(struct timer_list *t)
 
 static int gameport_bind_driver(struct gameport *gameport, struct gameport_driver *drv)
 {
-	int error;
-
-	gameport->dev.driver = &drv->driver;
-	if (drv->connect(gameport, drv)) {
-		gameport->dev.driver = NULL;
-		return -ENODEV;
-	}
-
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
+	return device_driver_attach(&drv->driver, &gameport->dev);
 }
 
 static void gameport_find_driver(struct gameport *gameport)

-- 
2.56.0

