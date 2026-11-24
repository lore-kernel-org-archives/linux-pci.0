Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513473;
	b=cYp3FeyErpES5CGamxKHX2RutgR1zl9Lp8JWrYzt0ANnu72OFMsfNv/n8OKUriSzXbXu
	 +dcCtz8BA0n+5vDoMkCYnvlQk+KqfsaS2gcPSvr/q5Lu21PenKunC+kGP3rwd/07CcF+T
	 vA9Ng8Q+yeGlAg8ZkamRydKD3/yJE6eaBz/WHFoi6V0+F+qtab5roARpJgU/afOkhaCHM
	 zlXCEdZc9pBbk+WCcctSvfFQJUTkky/mVOzELhA5YL06PRmpboNqk4qZfK8Xm0W1ksfnb
	 R5WZQ+fSM1pG3zbD3CNcervlNxeBmRMat55fmqDKobIFCy7W0jAVY09bi8FOqoLDqhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=GKf1qq1Q4Q8gvlxJRJSu4dWPQt//OA1a4q2gcs9EFzA=;
	b=RtBaIzVUrr/CJy1DQEuIjIxDzQ+VkVwjYxsnBZeAPsTKq3znOKk0BXEp4NHSz9wqJogp
	 116WVCHaGaNdyJd8EBtBPes7+l15stwpVmaz1ciVWasfohNWpHSHN7Etuo7tnfZ0B2o1r
	 mjTzktXsEegsOgLJBmMG+EPdYH8zqypESyQ6hYP5eHx1A4NeAeWnccSz1gHwr6tr9DRVE
	 KG1HcugFM7nw3YtgSNRBTeFw+OKJqqNjt756Ji0rvjihnNbl+WMPlmWDxr5NA8S/+sgSm
	 HK0CJtva668oYCzgREqckOfa+CtXQZLnb6DaQ6EDiM2ORW8xEjRvqgHWdyhUHCT/oCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO90Du0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D185606A33B;
	Tue, 24 Nov 2026 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO90Du0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F59D1F000D1;
	Tue, 24 Nov 2026 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513473;
	bh=GKf1qq1Q4Q8gvlxJRJSu4dWPQt//OA1a4q2gcs9EFzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO90Du0yO6AiDOVaqwdpNl0WRxHRLVyNGYDjXdP+L0EJFgFuaYseC3vtCvbuiNCz/
	 ww1QoXoQqYogUsW4MY4Lyq/RfWa3okQKfJddfCdE1DaOaMUrmoSbPTQ0SMRwYSbcOQ
	 aDRrHVBpWrkZeSgauDul1bZ4FHHYfy77twqEQW533pgBKsy7uiBcbzDX4FbGiHTXpI
	 aiLDmvh+ESPyIoKpCuzp6mSH4Dk7WLMeviS5kvZicBRVWeOv93LRtvRW6Of6tm9xl8
	 Z0jRTCUIVZnep6VvokShRCr/nYTVkrFGKsdZfM07TS1W1CshqX39Zn1EcQrg3axeEj
	 BSnVHDIh3WBjQ==
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
Subject: [PATCH v4 02/33] Bluetooth: btusb: Fix MediaTek ISO claim locking
Date: Tue, 24 Nov 2026 11:43:33 +0200
Message-ID: <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
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

MediaTek ISO claims are performed from HCI setup work outside USB probe.
Locking only the interface does not protect the claim against teardown
of the parent device. Unconditionally waiting for the parent lock can
deadlock with disconnect while it drains the setup work.

Resume the interface before acquiring the parent lock and use bounded
retries to keep the interface locked while claiming it. Propagate resume
and lock failures to setup, since controller setup requires the parent
device. Keep a failed claim non-fatal: MT7663 and MT7668 leave interface
2 to Wi-Fi.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/bluetooth/btusb_main.c | 53 +++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 92a78a7e60396..128ec6f7d31f0 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -2993,40 +2993,54 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
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
+		return err;
+
+	/* Disconnect may hold the parent lock while waiting for this work. */
+	for (i = 0; i < BTUSB_MTK_ISO_LOCK_TRIES; i++) {
+		err = usb_lock_device_for_reset(data->udev, data->intf);
+		if (err != -EBUSY)
+			break;
+	}
+	if (err)
+		goto put_interface;
+
 	device_lock(&btmtk_data->isopkt_intf->dev);
 	err = usb_driver_claim_interface(&btusb_driver,
 					 btmtk_data->isopkt_intf, data);
 	device_unlock(&btmtk_data->isopkt_intf->dev);
-	if (err < 0) {
-		btmtk_data->isopkt_intf = NULL;
+	if (err) {
+		/* MT7663 and MT7668 leave interface 2 to Wi-Fi. */
 		bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
-		return;
+		err = 0;
+	} else {
+		init_usb_anchor(&btmtk_data->isopkt_anchor);
+		set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
 	}
 
-	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
-	init_usb_anchor(&btmtk_data->isopkt_anchor);
+	usb_unlock_device(data->udev);
+put_interface:
+	usb_autopm_put_interface(data->intf);
+	return err;
 }
 
 static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
@@ -3169,7 +3183,14 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	/* Claim ISO data interface and endpoint */
 	if (!test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
 		btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
-		btusb_mtk_claim_iso_intf(data);
+		err = btusb_mtk_claim_iso_intf(data);
+		if (!test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags))
+			btmtk_data->isopkt_intf = NULL;
+		if (err) {
+			bt_dev_err(hdev, "Failed to resume or lock iso interface: %d",
+				   err);
+			return err;
+		}
 	}
 
 	err = btmtk_usb_setup(hdev);

-- 
2.56.1

