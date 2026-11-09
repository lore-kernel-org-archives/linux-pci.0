Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209666;
	b=bcrxhVhM5WhBflfMC8r9th2vmRYt9ndIZH5gsIboviwBHhrBU/hmkZhiKfGEyY/jSPLQ
	 px+wHXUA2dythwZTgRdLKx0v5hk3gzrP2df4Nb00SrwRchki9qwKY+azW4c56b0cGsKhk
	 qQnOtSPQGkZOy4qtZktO0jKgel4YOk/ZSH++ZlK9C/maF9FhuGAeymdGtKnkd6iYjuZ3J
	 ssJxNme44aE6RJ1VrUcRA/bwm0fYjv1Z41MChpnjez9VA+TkZl7Ad93aageGDp3CUrTTe
	 M1Q31QsudmA/Shc7LEFB/DX6VlsOA7sL6N4AQBTsn025eMlGQIZ4rtQV9QePoJrNeeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209666;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=17G9DyFZAfFH8GPfbZpTsBWMIRvPnSGk4HUp+ACrROo=;
	b=LOyKpItrmNg58MRReXmhaVkERXQBWah0V0pNsKEtQT+bPEvBdKLd5ku/z7Vmd1gkVa/B
	 0nAgeNTEPEaUh+9Z0jIdDbyx2ug1m6MkbO6rVNoJkfBrDmH/CWD9msgDToo5V7CCXlpFR
	 OjziO1au26IzT43DEoAo8WpEutz2zSpjQQF+iNIgmnpajPSuMJaNgi1pv40OyuHCjYd5Q
	 zO5KgPjtOOE2EfhOSIB+PTSU8ZsjBSt854JmYIIsseQLym/zk7hDTJpu17IW1gy4E/RB8
	 hxLODMu520L7c+9daTBQSBdnntmqJWAn0HTHHaTAFn+3kxmq53qEpTg4W86TqmPq1kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvvEjfNi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886756083623;
	Mon,  9 Nov 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvvEjfNi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E721F008A2;
	Mon,  9 Nov 2026 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209666;
	bh=17G9DyFZAfFH8GPfbZpTsBWMIRvPnSGk4HUp+ACrROo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvvEjfNis/KFwU9vzGAN8pvLgr0fjdkgdejTc8BPExlNctb8aqJEdc1YUwPCMEieC
	 zepVu8tmJY11WUNpUij3xiIsi9aPDztCQ7qoGN1Qag3KKiWeeh8n56QAK+8zw63iQi
	 e8siadnuZ5lGPjVShUaXOWy8Hs3qDf8JV57dNDZaKm/42XtntE9dewOyaueFtSzVzP
	 /BFAxu0AHtcl9i/soVQSIT9Q5G1vqeS9V6AVj4PDJGh3xJf/4CQBQd0aVqqtoNTb2u
	 vH7TDY8saDgHRYN3AXmY8qAZsHOsbFzKz1pajC9vKykthSAG2ZZG3k8g6Pwl+6SFwj
	 SS/4zRJ2ly1jg==
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
Subject: [PATCH v2 03/19] USB: Lock registered interfaces during manual driver binding
Date: Mon,  9 Nov 2026 09:33:33 +0200
Message-ID: <20261109-device-trust-core-v2-3-3b12d9a9f861@nvidia.com>
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

Interface claims hold the USB device lock, but device_bind_driver()
requires the target interface lock. Without it, trust-policy writes can
race admission. The MediaTek btusb setup path instead holds the target
interface lock and would deadlock if the claim took it again.

Lock registered interfaces around binding. Change btusb setup to hold the
USB device lock with a PM reference and disconnect-aware acquisition,
because disconnect waits for this work while holding that lock. Publish
the claim state before releasing the lock.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/bluetooth/btusb_main.c | 42 ++++++++++++++++++++++++++++++------------
 drivers/usb/core/driver.c      |  5 ++++-
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 92a78a7e60396..8fe6bd1bff906 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -2993,10 +2993,13 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
+/* usb_lock_device_for_reset() gives up after one second of contention */
+#define BTUSB_MTK_ISO_LOCK_TRIES	5
+
 static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 {
 	struct btmtk_data *btmtk_data;
-	int err;
+	int err, i;
 
 	if (!data->hdev)
 		return;
@@ -3011,22 +3014,37 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	}
 
 	/*
-	 * The function usb_driver_claim_interface() is documented to need
-	 * locks held if it's not called from a probe routine. The code here
-	 * is called from the hci_power_on workqueue, so grab the lock.
+	 * Disconnect holds the device lock while draining this setup work, so
+	 * the lock must be taken with disconnect-aware acquisition. Hold a PM
+	 * reference so the device cannot suspend first. A slow interface
+	 * registration can keep the lock past the one-second limit of a single
+	 * attempt, so retry a few times, but not without bound: a teardown
+	 * that holds the lock may be waiting for this work.
 	 */
-	device_lock(&btmtk_data->isopkt_intf->dev);
-	err = usb_driver_claim_interface(&btusb_driver,
-					 btmtk_data->isopkt_intf, data);
-	device_unlock(&btmtk_data->isopkt_intf->dev);
+	err = usb_autopm_get_interface(data->intf);
+	if (!err) {
+		for (i = 0; i < BTUSB_MTK_ISO_LOCK_TRIES; i++) {
+			err = usb_lock_device_for_reset(data->udev, data->intf);
+			if (err != -EBUSY)
+				break;
+		}
+		if (!err) {
+			err = usb_driver_claim_interface(&btusb_driver,
+							 btmtk_data->isopkt_intf,
+							 data);
+			if (!err) {
+				init_usb_anchor(&btmtk_data->isopkt_anchor);
+				set_bit(BTMTK_ISOPKT_OVER_INTR,
+					&btmtk_data->flags);
+			}
+			usb_unlock_device(data->udev);
+		}
+		usb_autopm_put_interface(data->intf);
+	}
 	if (err < 0) {
 		btmtk_data->isopkt_intf = NULL;
 		bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
-		return;
 	}
-
-	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
-	init_usb_anchor(&btmtk_data->isopkt_anchor);
 }
 
 static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d3a61ebc6afb0..ad5d9d5fc7598 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -584,8 +584,11 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 	/* if interface was already added, bind now; else let
 	 * the future device_add() bind it, bypassing probe()
 	 */
-	if (device_is_registered(dev))
+	if (device_is_registered(dev)) {
+		device_lock(dev);
 		retval = device_bind_driver(dev);
+		device_unlock(dev);
+	}
 
 	if (retval) {
 		dev->driver = NULL;

-- 
2.56.0

