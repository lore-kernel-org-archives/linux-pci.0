Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513507;
	b=v/p71/qJ3KElPnVSmSXoI8cWKKj+olfvgNmBwrW3zEP8eK0GEcYEYxEhu/iMdflo5FRC
	 sBzPCCGw4dQivYitgaKSfRXLWT+N6MGgCvMXC7aX5BTrjHuPJnLkeYj2J7LYmtgf6d7oA
	 pTi/+IvodCUsnhU7tBF5+e4VkVv6ATER5f9wlalbbMlj9jjBhruyCfihy1ux991YOgbXb
	 Sa7VUOc0ZT9McB7l1I2WSDuu0/DFDzPU++hjpha0OFn7EH5N7LrkfxGAQVYRCj4zcCUwu
	 LCO9QoiwpXg9RHHe1RSMczH0OeWnt2p/DiPgjMa+rBxy1GTAkEEEAD/d83n1l1TqZlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=YIoF29/HLGxivKo9y9Umvo7WdoqaNvqRS3anqksW2+E=;
	b=t6+Di7QZ4ObIc/hmoMG1BRuMr36pPYOP2DPfvB8RRRfcK8sMnoK9HzKpRKD61kCANS9l
	 zypC6ZwpSvIoF4rqtd1qHpXYUi6dQjkv/ug4mqcQYLo6ICAYV3GWv1YR6E8j+KMzCrYfI
	 VJ2tC2nfSGImCcK6zLS4MmrGV8qYRvrwswAyUY/CEGNZcqq/SoBohaLWc9Plo8QGulrGB
	 KFgcJWxEHgF0fXs3k0+7asq5SeP00kb6V1Q6r+vGK+95YPwjBrMOTQkVzTeCpWcTrVdr2
	 zh1qaB0EhDMiG20LtmwJ4kzHepNTuCNhIh/1fiOJhM/8DNFG9diCzoUFTmHvG/yuNnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgwRH0Ck;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6261606CF35;
	Tue, 24 Nov 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgwRH0Ck
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BB21F00AD3;
	Tue, 24 Nov 2026 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513507;
	bh=YIoF29/HLGxivKo9y9Umvo7WdoqaNvqRS3anqksW2+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgwRH0CkQ4uomM/AYB8lbt/1yfyHRRuafI2icnWOGOROudY59x/r/2tK9OPo54W8o
	 o+2tUAeTBkGv0SiX5rZIK6bagFWGzU08TmSfbgp9IDp4Wf4vLBchatsrw8YiC04sJm
	 1NzSHH525YOKoA6VCjBP2X6IWYmg2aauh0q2fMG9LFzE5RhWeXutIUiUhOdUTYVZIf
	 xjK2PjwAWQPZVbVkZnRiK0cmjBc+T9OQMTGmWzBuEAc8GR4iiksgeejXmMbf/Y4aFl
	 cl/1o0uAK1nLJAQK5fOrPrBTAn0CGnkjTRuCCdnlSL/yAn5RPgl76shlVgX7vJTGjo
	 mMLg89BLLE6bw==
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
Subject: [PATCH v4 13/33] PNP: Attach card devices through the driver core
Date: Tue, 24 Nov 2026 11:43:44 +0200
Message-ID: <20261124-device-trust-core-v4-13-037eb0d17b1f@nvidia.com>
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

pnp_request_card_device() calls the PnP bus probe directly, bypassing
the driver core's supplier checks and power management setup. If
device_bind_driver() then fails to create the sysfs links, the device
remains attached and may stay active, but the caller receives NULL and
cannot release it.

Use device_driver_attach() for synchronous probing with the driver
core's setup and error handling. Preserve the card link until binding
completes, so probe cleanup and CONFIG_DEBUG_TEST_DRIVER_REMOVE cannot
clear or free a link still owned by the enclosing card probe.

Fixes: bfc7ee207078 ("[PATCH] PNP: handle sysfs errors")
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
2.56.1

