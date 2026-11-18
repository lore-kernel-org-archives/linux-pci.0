Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030066;
	b=yz0YLaNJh/MRi0Hgr/EzqTcGTt1IVpUUFhTFmObumSZJb9Za9190LCaI3iM8K18JNgV1
	 8rjzi1MJj81FPlHUtxBaEqfQZHmoNm2mBxBt/zBoBn1mm/PLm5KS6CnPcNJ3CDlDSt2ye
	 QO/+II0GaLf045zHg0VqRSo4gpLU4w++kChpbNtxJD9VuUPdBfawJK62NQ3y2LXhkOku3
	 Z5xNGoi7ZsigiyAMKTUOQ0H0GEG6BZJwFQHG7oBH9VM6jBlwo2PiEr8PG+BmYJrDOmyOH
	 9JL8ZWnc9rfbPl9dlECfmlxhrYL5UZzzHEVm/KdzK2z7b8h8vYySSxJGFy7JuYXBfgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=Z/yKhrxLxY5/QLlKEzAf373V1QSOWce0k8iO5P+HaBs=;
	b=FXaRw/nk/YOJT3FO+BkfaK8x+mgTm2cfGHYMXws4ImCl2KBRO4KBxULO+HtO0Y5M1mxx
	 /bA5YPbkHtF7sIkG3jRgXK8LKLliYUr74HCiQxyBhBs+poKPyD6ClLHoUSFDVk9B3uSOk
	 unZtoWGXTe/JmRt6CnzwO1vfY5Nw1hU9icYBX4QMyXh3ymCDT6tiBzW8LzKbYO4IN8fya
	 nu6wEH/lA/1pRB5PL/7pTpDVnODUKBQXYY2xIeGMjPsq8/YeF9N2pnd9oKGy+QupBxvnk
	 YdnmAImyKK4ls2kIG3aPmjLQa/DnlqF0+VaL54SbYg5EEdm3RY7vo/P12aa5Zxmom5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DY78JipM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D2606A7E4;
	Wed, 18 Nov 2026 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DY78JipM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8611F000CC;
	Wed, 18 Nov 2026 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030066;
	bh=Z/yKhrxLxY5/QLlKEzAf373V1QSOWce0k8iO5P+HaBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DY78JipMgP+vOpyauGUGl2mB3jhx3Nu9So6YsoE/1eiKzLgjO91sWehBucvfbScsw
	 9L/YSO3/27XCyHQOs9O8Ylu0IvfIe9bLJxBKQkyLbq4lzjbUgBgiSAwYrxg4nJDz9F
	 kH20O63ggrUQyN5pHqP4c3vn+ghLeX3qWvuaykzSy5znn6efz6V0i9oRa5hoFXltxe
	 AamHO42vQYCzpnewQgp3dXfwCtQ9tZYR1Ojaks4vjPr5pFUaW8PYriawUckaYX7Kcn
	 HMvdb21DTuWso54liwHmmoHvgulXyhfk/gE6usf8OG1t6cIBwd/L4TlnaYM7Om0boS
	 V6MJz0ewGC3TQ==
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
Subject: [PATCH v3 02/31] Bluetooth: btusb: Fix MediaTek ISO claim locking
Date: Wed, 18 Nov 2026 21:26:32 +0200
Message-ID: <20261118-device-trust-core-v3-2-d655875c4bfb@nvidia.com>
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

MediaTek ISO claims are performed from HCI setup work outside USB probe.
Locking only the interface does not protect the claim against teardown
of the parent device. Unconditionally waiting for the parent lock can
deadlock with disconnect while it drains the setup work.

Resume the interface before acquiring the parent lock and use bounded
retries to keep the interface locked while claiming it. This change
propagates claim errors to setup together with -EHOSTUNREACH which means
that the parent is suspended, since subsequent controller setup requires
the parent device.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/bluetooth/btusb_main.c | 55 +++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 92a78a7e60396..8307fd819cc2e 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -2993,40 +2993,57 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
-static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
+#define BTUSB_MTK_ISO_LOCK_TRIES	5
+static int btusb_mtk_claim_iso_intf(struct btusb_data *data)
 {
 	struct btmtk_data *btmtk_data;
-	int err;
+	int err, i;
 
 	if (!data->hdev)
-		return;
+		return 0;
 
 	btmtk_data = hci_get_priv(data->hdev);
 	if (!btmtk_data)
-		return;
+		return 0;
 
 	if (!btmtk_data->isopkt_intf) {
 		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
-		return;
+		return 0;
 	}
 
-	/*
-	 * The function usb_driver_claim_interface() is documented to need
-	 * locks held if it's not called from a probe routine. The code here
-	 * is called from the hci_power_on workqueue, so grab the lock.
-	 */
+	err = usb_autopm_get_interface(data->intf);
+	if (err)
+		goto err_clear_iso_intf;
+
+	/* Disconnect may hold the parent lock while waiting for this work. */
+	for (i = 0; i < BTUSB_MTK_ISO_LOCK_TRIES; i++) {
+		err = usb_lock_device_for_reset(data->udev, data->intf);
+		if (err != -EBUSY)
+			break;
+	}
+	if (err)
+		goto err_put_interface;
+
 	device_lock(&btmtk_data->isopkt_intf->dev);
 	err = usb_driver_claim_interface(&btusb_driver,
 					 btmtk_data->isopkt_intf, data);
 	device_unlock(&btmtk_data->isopkt_intf->dev);
-	if (err < 0) {
-		btmtk_data->isopkt_intf = NULL;
-		bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
-		return;
-	}
+	if (err)
+		goto err_unlock;
 
-	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
 	init_usb_anchor(&btmtk_data->isopkt_anchor);
+	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
+	usb_unlock_device(data->udev);
+	usb_autopm_put_interface(data->intf);
+	return 0;
+
+err_unlock:
+	usb_unlock_device(data->udev);
+err_put_interface:
+	usb_autopm_put_interface(data->intf);
+err_clear_iso_intf:
+	bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
+	return err;
 }
 
 static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
@@ -3169,7 +3186,11 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	/* Claim ISO data interface and endpoint */
 	if (!test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
 		btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
-		btusb_mtk_claim_iso_intf(data);
+		err = btusb_mtk_claim_iso_intf(data);
+		if (err) {
+			btmtk_data->isopkt_intf = NULL;
+			return err;
+		}
 	}
 
 	err = btmtk_usb_setup(hdev);

-- 
2.56.1

