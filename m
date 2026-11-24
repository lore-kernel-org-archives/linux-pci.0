Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513478;
	b=IEXFV/kxqxqNz0OcS92MBrCjXKMy7bW7uNXYmbnP9OAJph5n/fA0RBYwGvSbTPEqzLoi
	 BoNK4jv4eZIt0GTaytjvWVTw3i3nlvHhMxmlsi+2y3NRaCXxN9hZcYZ2Wcfg2BXOX2GIY
	 j/rD/7wxB69ndedND9rrkzvZJTiKFXpTWNIn5OocgWC66RMCJFKWrDmwC59J9Vifgpecs
	 oTaX8j94TE3n4wSp5vVEbdmhdU1x5nFmN60yKf3nQH2t0ZVPZSAqqI7vyBcCM0E7gf01J
	 RahC0e4hs4xoitdFwzjpuWxuKtpJdqC3xlGj74Cv/XKWdoHjzRpHSuUXu86vptPYajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=U1U4cqLXy2TPKYTc2nCd+GXlXsu96XA9ImgVgtVC+CM=;
	b=uImIfrB/I7jqpo3Rqhepoa6AcFvo+5eJPnrtUsxOLIiavmTrskzoYkcumFUt/tEIuWa4
	 ZkZ+rUb4OdlqzX9WIfxJc2wlodUK3OWjIGLt3CBS5OEtcnBEJ2Qiajq6PQcLGJfTteOBJ
	 ji+67keWATKCsu5thApNcsfoD9mS7+TCEdpusXzJOutj4UlivT92yUWc+78Zq0a0eaayl
	 l4dB73Y6gyx7vRbw6+hRiuBzKaWfxtusa9XwUySFAoq2RA9sz9UfIAOh+fmt79XfP8Bk+
	 MjgWdMHS+2DZTKkMQilAWgY3RjWszVB1d0cz8PxTVQ/S8jtSwd4aejK+H09O3HCTrkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOOAh7Hu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7507606A68C;
	Tue, 24 Nov 2026 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOOAh7Hu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9573F1F000E0;
	Tue, 24 Nov 2026 09:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513478;
	bh=U1U4cqLXy2TPKYTc2nCd+GXlXsu96XA9ImgVgtVC+CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AOOAh7HuGjeBfXfb5eWeJV+oHc8wfCUEHmHQ+DBb/OCZdkyZmUA1e7PTZhrRXkfIS
	 O5yANy1DoQl3UPJyfh69s1JvEp1jj5q5lDfylrtJUZRXIYs0S0B/vi/nrJlDYAQMAM
	 3rgavDyekraF5uuVXjYQ27JfnDmrk/WS4mf6EA2kugPAUyvwhChfKkAiAE+jOvBDPB
	 MUwaHNWrq2Xrv2W8MdSmSYsXscFbXTzNHfaEYpjsjm8/H0lG0B0bXaVo0Ih5qWuKaJ
	 3GSN7DOEC3fb91rBY3o0x8jvSgSVdg5EpWFk8V7GsKsctQ0RDH5mu1oBx/yT0zl2GQ
	 NFOO9/bcoFfOA==
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
Subject: [PATCH v4 06/33] USB: Reject usbfs connect requests for unregistered interfaces
Date: Tue, 24 Nov 2026 11:43:37 +0200
Message-ID: <20261124-device-trust-core-v4-6-037eb0d17b1f@nvidia.com>
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

USB core does not register DT-disabled interfaces, and an interface whose
registration failed stays in the active configuration. USBDEVFS_CONNECT
still asks driver core to attach a driver to such an interface:

proc_ioctl()
  device_attach()
    __device_attach()

The interface has no driver-core private data, so the request
dereferences a NULL pointer.

Return -ENODEV for an unregistered interface. An interface claimed by a
sibling driver keeps reporting -EBUSY.

Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead of the driver")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/devio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 101cb94254809..1491ba015bcd8 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2366,10 +2366,12 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 
 	/* let kernel drivers try to (re)bind to the interface */
 	case USBDEVFS_CONNECT:
-		if (!intf->dev.driver)
-			retval = device_attach(&intf->dev);
-		else
+		if (intf->dev.driver)
 			retval = -EBUSY;
+		else if (!device_is_registered(&intf->dev))
+			retval = -ENODEV;
+		else
+			retval = device_attach(&intf->dev);
 		break;
 
 	/* talk directly to the interface's driver */

-- 
2.56.1

