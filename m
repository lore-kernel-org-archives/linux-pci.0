Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030086;
	b=3xpwO3ad0whQ3GQF3du/663Rqa+5okaf6FxKzuD3q+ApayMVKWeUT4bZxsmF9SyN+v3H
	 VyDTU3dhts6DSfGtYW28Ifgp7qu8qd2Rbe4KYrYP7qRpYIZ+AfNdphCeA9gqJdbNRkeuw
	 66Fi38mgFDgNOsWtIbcsxKJR2aDaMnWnUuRp3OiibvfnxJalYURpH1AGfT7qh1amlVbuf
	 VnHUdwYGI9GlcIne/odHJ4a8fL9X0eFP0kciiz9FHXvjJnn0HBIbh12hgOk713kaGGJWf
	 Jjbrste6EkCUHFC0LEDtRzqxiImTp0HNPvy2BJDckQIjtdHsWmiybMDLxieSwIwMNjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=SnrsLB5kZ1UeQnsG8kHcQUsE97ktcTSiGi8C0w4swCU=;
	b=rZfrqhPTXixghYiwMysAWvgHtWL0NY5ZKsXalE5AMT+o17RLZqEWb9KACtrAwnLDBJUL
	 vYH8ZlfDpx0MhoP3MrljmSlZhrnUWshmfZOPTM2wL0C8PoRgIW36hF5pNQzqU0PsYoGze
	 3jMV7nZCUs7A7sPjz7+Lts/57x7WpBQ9P7mMNQC6+zmNfIUdblMW/u3jbGDCpT2FcjzJO
	 A4wNj+GiEaArgf2b4b1ZXgYMUZ4F1ITe5IspyNEJepDTP+a6fwCOLvbZ912X5GMRGz+R6
	 UqNPedD6hxFLrw7z9cmGeCOKKowiXCSr4CujRsFNX8TjBrm1MaOgyRWK+PlVrnVLLMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCPIYzfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29E606D35E;
	Wed, 18 Nov 2026 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCPIYzfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ABB1F000C7;
	Wed, 18 Nov 2026 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030085;
	bh=SnrsLB5kZ1UeQnsG8kHcQUsE97ktcTSiGi8C0w4swCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCPIYzfvOpSaWxW7MQKpro4h15QnMMJVwSPJdZjOFqzBIZxjciSgPHzGsK9vib1jQ
	 GgM2hLkK6ypMYv2W5GOZK/JttsXsLjTBYaDSIjFCgj3ipveP9BPs0YBMeBNOH5j5Zi
	 BTlhM+g0yA3T8aR0EOmXh98niJGxJWpx/mxLtW+Zqih0yhCSDGfODnlAB1TLKykznB
	 aBoTEK8SdW9Mj7lJxQXZnTSgaYdNAM4bvwpAi/7UVEu8AHgbp7TYN7e/eH7P3H5iMp
	 POOX9gwWkG08D9sHpw0jcnMIUgEQrruGvkEMZpuEJ297tqzaw9P29HTipyqVJ/63y8
	 Q//VtVqkfDpYQ==
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
Subject: [PATCH v3 08/31] ALSA: usb-audio: Release interface claims when probe fails
Date: Wed, 18 Nov 2026 21:26:38 +0200
Message-ID: <20261118-device-trust-core-v3-8-d655875c4bfb@nvidia.com>
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

