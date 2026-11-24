Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513464;
	b=hoImwAUnuI5uju3lg9jhO7m38yjvJn9Mq8VxHSOVROTNsOWHU2zxC+6LOq7PT+6NsvCX
	 MflPVB7yOidUX8DWh44Ay85u7aphXc5GTKQdrBVkSGBiFFJ1h1yb22bKnMCvx+LQk1sUO
	 4CPK3BPuW6renG8lOzPBM7OhM0xPClMujmJyGQW2E0/vd6E2lVH/JAVxFjrMplsYY9z33
	 eYNXPFKxW0kgnkCWIDLiOV2E9fTTTW0l8F8doft9NqMHYqR0sizeMhxX2jOiSsLGSi4D/
	 lzQiuBhHKo3A0r0js93ZK6qnJhT2SygKwUsHuYFPPTNQjKKcLYsXabuYzHpDO9/yYSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513464;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=7H0DbC2AGOKMh+PJiFXiDaE/tg5L8MS7tMmMthgfzIY=;
	b=DbD0GqlVQsQY9cxOffCwJvIDGkCHZEh8lDa0VGlfKw/x+NAn8xWL9vaV9Dmiw9x0zy6I
	 m6JDC4vJvkAKkQ94t9A2umnd5eomU7dqvKinzgyDKr+y2HkPyp9znyo4hNd+mMxJbsgGU
	 DWuoY+CKvhfcpfAwmSz6eanr921KjnaaRodXnsyOT/cZeL8zdI91Grnid37fux4LoWi8+
	 YDOqhhd6Odz+nnTZNR/OClOHJaCA5zAqGMBoit3L8gIa+Q6NGG0H8BsbGIOi0EvAgFRYm
	 u2FAlXLdx6IZ+jEozFQc+QPpHl3muJn1bKGJoKcOifsqE1C3lt0EbxAS3arT/AROkoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTXv2o6S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41A606A69F;
	Tue, 24 Nov 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTXv2o6S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D118D1F000C4;
	Tue, 24 Nov 2026 09:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513464;
	bh=7H0DbC2AGOKMh+PJiFXiDaE/tg5L8MS7tMmMthgfzIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTXv2o6SfFVj7sLnN5MnYvR9GFihy2pu6GjRdwT4zUFR8tFsodZdK2H9LbUFJOrD3
	 n7ZqGhMf/pRqQC/MyQZ+Rv8SjIAUWYFWAMdlQomkraPQruF8tEJ1E6XqEHqyx6SBgr
	 mFw3mcC/d1fXfHIbWrZjFBbSiUaty0u3P6im2UB0a8QaBjyvzwh637ZN+b4PRcA6bQ
	 2QeNtFzBKfu+YEBC7mFOw73x7R2bBt6ohgGranDt9YdjHzY+FsZVVJ+l3XNkBVilsi
	 gUcoD1mZK4xBJ9LFqZxbADmh2XFic50Gx9VGtuEcHLoxbwJQKcEl2uGDoblpjRqw1L
	 lV022n2TsFqFA==
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
Subject: [PATCH v4 03/33] USB: Lock interfaces during manual driver binding
Date: Tue, 24 Nov 2026 11:43:34 +0200
Message-ID: <20261124-device-trust-core-v4-3-037eb0d17b1f@nvidia.com>
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

Driver core requires the claimed interface's device lock during binding.
The parent USB device lock alone does not satisfy this requirement.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/bluetooth/btusb_main.c |  2 --
 drivers/usb/core/driver.c      | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 128ec6f7d31f0..37f36434c6e9a 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -3024,10 +3024,8 @@ static int btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	if (err)
 		goto put_interface;
 
-	device_lock(&btmtk_data->isopkt_intf->dev);
 	err = usb_driver_claim_interface(&btusb_driver,
 					 btmtk_data->isopkt_intf, data);
-	device_unlock(&btmtk_data->isopkt_intf->dev);
 	if (err) {
 		/* MT7663 and MT7668 leave interface 2 to Wi-Fi. */
 		bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d3a61ebc6afb0..e1de348cc0cac 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -540,9 +540,8 @@ static void usb_shutdown_interface(struct device *dev)
  * No device driver should directly modify internal usb_interface or
  * usb_device structure members.
  *
- * Callers must own the device lock, so driver probe() entries don't need
- * extra locking, but other call contexts may need to explicitly claim that
- * lock.
+ * Callers must hold the parent USB device lock, but not the claimed
+ * interface's device lock.
  *
  * Return: 0 on success.
  */
@@ -559,9 +558,13 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 	if (dev->driver)
 		return -EBUSY;
 
+	device_lock(dev);
+
 	/* reject claim if interface is not authorized */
-	if (!iface->authorized)
-		return -ENODEV;
+	if (!iface->authorized) {
+		retval = -ENODEV;
+		goto unlock;
+	}
 
 	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
@@ -602,6 +605,8 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 		pm_runtime_set_suspended(dev);
 	}
 
+unlock:
+	device_unlock(dev);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_driver_claim_interface);

-- 
2.56.1

