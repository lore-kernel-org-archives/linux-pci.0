Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513491;
	b=ZtesSgNCsqkrw7q5ORvXGC3vQF2IMqaxgiFa/4p8MXIxUWHUmKA2l5tGkX6RxJPrnZzo
	 aaYUnCOWLdjI0HbFhk+gaHs+VTLUr3teE98YrFpK0A9aPa6fuUKNJVq8DcBAm27JNLJ+T
	 OiWU8k8dwkMUSXv8d9iG5QZ834uVn2xVj46mMoDDPgkJzhG+f62FHi6AylQdtzZk9h21V
	 MgAv5R+C9ar6jPSY+e6qx/Jjg+ZDFlUnIHOFaCPzt/4GlIeVKQ/EDv0NRJio5jL8INlO1
	 ORoPM+fQgZfskro6sLHA/Ca65LapNnuYsCkgmFbrXoP3QA9jeBxBvsKV7foW+N/kIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=SnrsLB5kZ1UeQnsG8kHcQUsE97ktcTSiGi8C0w4swCU=;
	b=3c55q8Eu/5wxjGa9DybsBG6n4sNtohyxQPWiVpL0qSijk+/85sz8ORxfc8cFS5E2yzVU
	 B1j1XxgLBmWbk2WGq1G2zN56P38cnul2l9wZwUtkPu5ATKGegO+nKaGe5rKN9tL4m5b8Z
	 242h/vh7zAi019D4y+bL6UV+QdLTUwRqd85hZ2QXttX2+6T5U209GU3g9TZVJOLms48ST
	 oLp1LkukAQtfvExmePxN27f38MnLHlJU5geGfGga3Q65xAIEFlLYZ3NfigSAE0prTNuQZ
	 p63PaU6y38Z5datDPWm/ZDwgcFQtOhQRclyDX+Ml6/Akqy8U5+Adk/cYc5pGXVTI8AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4b7rWrO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AA60A2600;
	Tue, 24 Nov 2026 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4b7rWrO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39591F000EB;
	Tue, 24 Nov 2026 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513490;
	bh=SnrsLB5kZ1UeQnsG8kHcQUsE97ktcTSiGi8C0w4swCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4b7rWrO1VpG8afkXvveRCQ6YKJEp+gt/W9EoJDm6WcxBEe/g1W96uFgHuYI8T0+0
	 BIsZY4Chu9xsSLa8vljpFxYTta8Z+s266dbePuaTwuK6xH2VAA24RrIlAus1Z/BOMT
	 hw9RH90qpt+INrnYym7884AjhXqDt3W8yNZistew0pkM/0XIP0C3ws40PdhIVWvN6b
	 DbkttT8lO8Drm4uao2HA5xzSPWlsPJPD2ZQfB6y1zcuAVZf4eUJVgxk5wTzeiwyzf9
	 ULUOcPx/3PYUQfl1nUT+ny64ylWdF1+yNLYkg8To07mua5OHPZBFAO8zhWFvZiWw5D
	 yu1RhikKVzZPg==
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
Subject: [PATCH v4 09/33] ALSA: usb-audio: Release interface claims when probe fails
Date: Tue, 24 Nov 2026 11:43:40 +0200
Message-ID: <20261124-device-trust-core-v4-9-037eb0d17b1f@nvidia.com>
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

If the first control-interface probe fails after claiming streaming or
MIDI interfaces, freeing the card leaves those claims behind. Module
unload can then race with registration of the claimed interfaces and
leave dangling driver pointers.

Release auxiliary claims when discarding a newly created card. Preserve
them when a failed secondary probe leaves an existing card in use.

Fixes: 9ad3d6ccf5ee ("[PATCH] USB: Remove USB private semaphore")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 sound/usb/card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 59979b793fe91..56ebdd61f72e7 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1090,6 +1090,13 @@ static int usb_audio_probe(struct usb_interface *intf,
 		atomic_dec(&chip->active);
 		if (!chip->num_interfaces) {
 			usb_audio_disconnect_components(chip);
+			for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
+				struct usb_interface *iface = dev->actconfig->interface[i];
+
+				if (iface->dev.driver == &usb_audio_driver.driver &&
+				    usb_get_intfdata(iface) == USB_AUDIO_IFACE_UNUSED)
+					usb_driver_release_interface(&usb_audio_driver, iface);
+			}
 			snd_card_free(chip->card);
 		}
 	}

-- 
2.56.1

