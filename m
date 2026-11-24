Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513495;
	b=dpK/0gR3SJ2lDeKM7GIdTYznJ2TW8yO2hcD7Cu8SpbVoTCdyIeMkmMo5H8S9j4PHe3XH
	 JS7ouvbNhS1wJJAXyQJaCRsPyKQ9vaOMrC+4nu78GWak7WwLIlJ1uCzq0HOApDLZNDEaf
	 e2ZtH8u6K7IKV/5mffusCbWitEUxGX8eP4sBuTMYD/srKI/yoJIEtQ5CaNYbXmCtapI9K
	 4wMuCp5W4sZSwyheXjxpsALDLj2NHYQVC/saXufD6OyCSdWT5qspgsnKJx3+lgRDo1Hc6
	 W+L9taSV+zpvDkGs1d/QE+tUA9hUVRwhP0YvPzw2hMruMfGnYzq0PIOInyYzUW9Gd2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=wbkmNHR1nRw2+5k8665nB5tZwQXzmDpbNKqdau8pHu8=;
	b=0mdLsCD5NuGBThJQ4aadyX3nRYgbSQzEbnF1Z1SppsBHxcL4Q2lJYWL3nqD1pgdkvdTj
	 y8bGQ3HVZQGp4eMACJWy+pCExxqDrL+wG1WgI4uvD74sjcmr4qO4er1rGYgY5N+Gcc1fb
	 12mg/Cr0FDtjX6eo6j78clxkMvkiwMeM77XSxatYOT2HtRU6FGg7otPHluyaotj3Dzoqy
	 ZCiX2OfTVMbdgNlgeH5sbSBtDk6vvy/xi+UwxZ4OKAVse04Fh2G1zM4R0mUDnfVKSl/2U
	 y9GPtOrt7H7QiDt7i26/J059Mg63lvzNdUIrxnYgi5QO9tf/8Mj5FNPIn/bhq2KFOtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+QwfXHX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0FC606A687;
	Tue, 24 Nov 2026 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+QwfXHX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485151F01571;
	Tue, 24 Nov 2026 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513495;
	bh=wbkmNHR1nRw2+5k8665nB5tZwQXzmDpbNKqdau8pHu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+QwfXHXS5IG/odlN7brAQZlVr9TWZPj6Yyuy8/tTE/qaCY1di8E6SrkCocdW5eUB
	 66hebez9PG9t8U7vHZzgpBLcRFAJsjPZNGyEqePG4zJVBVsI2X78KC0jXx6oFV7V9W
	 b4VTuVu5FlipZkB3tdxH+5vgHGa3B83MELw3qtpsh8lmqzZYsg0tHCSFUNOGPqtDDK
	 rCzqEkFMC+8dnafvXqe1q9QTj0sIyI3CplwTgprrvhcBOTxp/8wc7gQ6p4hRfFWp5Q
	 8KdggQ1IZ3wgRq1aO4Wiwij8L/KbJL4h6VTyEpopQcdLbPfs6rE38OCm6dOEHEW219
	 pm0sO2Ye0Y89Q==
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
Subject: [PATCH v4 05/33] USB: Reject claims of DT-disabled interfaces
Date: Tue, 24 Nov 2026 11:43:36 +0200
Message-ID: <20261124-device-trust-core-v4-5-037eb0d17b1f@nvidia.com>
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

USB core skips registration of DT-disabled interfaces but keeps their
objects available to sibling drivers. A CDC-ACM control interface can
therefore claim a disabled data interface: manual claims check USB
authorization without checking Device Tree availability.

Fixes: 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/usb/core/driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e1de348cc0cac..735ae3310b45d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -28,6 +28,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/of.h>
 #include <linux/usb.h>
 #include <linux/usb/quirks.h>
 #include <linux/usb/hcd.h>
@@ -560,8 +561,8 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 
 	device_lock(dev);
 
-	/* reject claim if interface is not authorized */
-	if (!iface->authorized) {
+	if (!iface->authorized ||
+	    (dev->of_node && !of_device_is_available(dev->of_node))) {
 		retval = -ENODEV;
 		goto unlock;
 	}

-- 
2.56.1

