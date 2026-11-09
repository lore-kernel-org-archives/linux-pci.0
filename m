Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209659;
	b=VesPRVtoyKYUbMhD59R7OdN8j70wCxrd6YjuB+NyIT1+TXyR2bFrLvLAoAzpTFGALAwt
	 qFBt1Q6UAteU5kvLj/jgWM13DDIlKn2pbeo1s5ogR1EeRyKKXPXTbwDCbhRc5WGWXuKg/
	 M2BjxEVtkif38+QLiHSDeQf4NF8WsCyZfucgleT+3zyHzK7UlI3+YdEqF5QCM8WxtAAOG
	 hlA7W9qLLCFx/X80dHkspqtdLv6Eme+fdZ96kdv7Bajk1jjunC99FbTT1EGo6Gfehhxdz
	 r0ZQN52LpDRSkkVFtgFjm2STTgjUry356cA9jd3Ibh/ZNQzNB/O26RYYWw8JGTBBJPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209659;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=Y/diz28OtqaYX4DdZb+JhCSN/xAyOePemSvH2IVI+oI=;
	b=dvqVGHgPtgvNjjetmY6ADqT2djzeP4VTYZnGnmlVhwzI9wM+OE8HKYxBJHzBvgtZ3M1c
	 TGGlvjNwKROPPQmJki1AT9BMogv0Tz/llpWtVRfnpfrO41Mdq4S1+xsnGm/V5eYhMCJ7Z
	 nzO6EkVkjbY/I9274z++BS3zJvxFPF7mZoj1rJn/892sanNES03rZFEx87Pay1ogd56FC
	 5it5AhJKqgIcG6ZnP9K4wfu9emnGX3ozHEAomcYxaHUMm+Yre6ox0Ghwm3i+hhwHLTa4W
	 quJQnAuIIJtw3+aXL8RVNIdcjUw6RteyrXmlIzMbU+lx38dRAK3a6eYdi897TogWKvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHZLHWOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C5606D809;
	Mon,  9 Nov 2026 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHZLHWOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D021F0089F;
	Mon,  9 Nov 2026 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209655;
	bh=Y/diz28OtqaYX4DdZb+JhCSN/xAyOePemSvH2IVI+oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHZLHWOHp1FvXUffp1GHRLkENcwBo2yr76PCtrtRtDk1L6zyKdYK7pe45DxDIKhrN
	 hjdFVbHl7ZSqgKGaAY/r7F7iVP0OEmf4aDbyF6QWnisUryfaon11MfZMitLN41ssuQ
	 xiTZ237mPQjj5AApZ10s9DwIPHs/VYb3PHjsSC6BWnS/arV8S+SiVSNjair+Xrpwz4
	 mC2zHujuvXMUg7howtzEEwIZVAIr/ZfHrzT4c6TjPu/X5SWamy1PW7nCkJYfsZQ/dx
	 vxZlM0krZBNvBtYzJxdAfP1froSzwdqd0jF7P7eGNSH024gvRgux6Tmmx2f4UY+DH2
	 6lK7yuJzaWfxQ==
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
Subject: [PATCH v2 05/19] PNP: Attach card devices through the driver core
Date: Mon,  9 Nov 2026 09:33:35 +0200
Message-ID: <20261109-device-trust-core-v2-5-3b12d9a9f861@nvidia.com>
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

Card device requests probe the selected link driver before driver core can
perform admission and setup.

Use device_driver_attach() for the normal binding transaction. Keep the
card link owned by the enclosing card probe until the device is bound, so
probe cleanup and debug removal cannot free a link still in use by that
transaction.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pnp/card.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index df5e3d3cbf6c0..9aaaa03d5ffa9 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -52,13 +52,17 @@ static const struct pnp_card_device_id *match_card(struct pnp_card_driver *drv,
 
 static void card_remove(struct pnp_dev *dev)
 {
-	dev->card_link = NULL;
+	if (device_is_bound(&dev->dev))
+		dev->card_link = NULL;
 }
 
 static void card_remove_first(struct pnp_dev *dev)
 {
 	struct pnp_card_driver *drv = to_pnp_card_driver(dev->driver);
 
+	/* The card probe still owns its link until this device is bound. */
+	if (!device_is_bound(&dev->dev))
+		return;
 	if (!dev->card || !drv)
 		return;
 	if (drv->remove)
@@ -331,16 +335,12 @@ struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink,
 
 found:
 	dev->card_link = clink;
-	dev->dev.driver = &drv->link.driver;
-	if (pnp_bus_type.probe(&dev->dev))
-		goto err_out;
-	if (device_bind_driver(&dev->dev))
+	if (device_driver_attach(&drv->link.driver, &dev->dev))
 		goto err_out;
 
 	return dev;
 
 err_out:
-	dev->dev.driver = NULL;
 	dev->card_link = NULL;
 	return NULL;
 }

-- 
2.56.0

