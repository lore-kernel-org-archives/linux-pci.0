Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030054;
	b=swbt8Rf8R5y7JT5XlP9blDYDg9/iiltw5w4tZXnYBf1UUQvIKCmoK9jD0sf1Y7k03KUs
	 sAnjZMZU4f8fVK5oDw9ZHaoGqr39KT5KH0MEnnWTGR1gQeSYVuIUrcKjc748q6FYMXFTZ
	 B1+6YhB3X+AFNpzvPxH6VZ2PHtYjJOM9Hb3oWVjCZ3n08NmLk05HZce1kvRqZK9JmvqlV
	 vzLFq1HBFfgIzuFKW39AnR8fVAlLkr7fvW6w3VJTE6so7qg/qsgt90WHC1OChqyHAvwQi
	 nc/pde7+wwkLkKo0Sxnel//FdcdCqaGt3cAJR6iMnKLM1Xb3wMwMqRsdRDrdpGTcZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=wbkmNHR1nRw2+5k8665nB5tZwQXzmDpbNKqdau8pHu8=;
	b=RIQZPKzd7vUqm+DW8i6+zWcsSjSoE/DjfwCssOK/kS3WDkKJD5h36uqYayyxYvU7/ccP
	 qim0cCfMUFpOdPjX3qa9xvDtxFsVaigFGSHZi/oUmz6ZYu+jYOGSlZoBYdKXRSinK+0la
	 JzJEa1DKo6Ms6sgpm4EZvARfhZiBan/hwdqZhX6/mAXvvkzxpER8oCY/tdsMCMkwobrmY
	 r/Nj9Wrzlm8Sol/WIfNYm/vo1ZnUON8bC//JkI0dnY7OoRFY+G2O0lQQQHiHh8jNAUTEt
	 XVtqJBJzlcBj/aikaKSb20VUAf3f6CVZUIusP+XzB7kHgpGzvXtNcDy9PZmp0SA7hxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESah7qvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50B60A262F;
	Wed, 18 Nov 2026 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESah7qvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E321A1F000C8;
	Wed, 18 Nov 2026 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030054;
	bh=wbkmNHR1nRw2+5k8665nB5tZwQXzmDpbNKqdau8pHu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESah7qvOosG2ghqBoGmhIkOOsmLSoZIWc8X+J2VjFlIO/JhUEfs2YSLYquqnLtK4J
	 /wWLdsUxxEIy2bkilx5EZc7sUtKoysLv1QPwiM2Mur7/bgAsvdm9YT3TwgbEVfsMa/
	 PTHsPUlQjRijmWAoSnfYY5YZD1gK/h7NLWV+IaTN4c80wiqIqpUeyMtHavWsP0uDXl
	 /qsccpHGKQq5NfDtwfOcTtWX45kSjKZGyE71zpGz1o1BfVyNImykqcNpgtuGFVfjoU
	 U2XbQced8/s022Y9gGnWenlrlbm9j9SW/Wi2s6TIT9BrSoYCkK24VN/ZPHDXbJN2ZU
	 gjMI+mfq7R32w==
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
Subject: [PATCH v3 05/31] USB: Reject claims of DT-disabled interfaces
Date: Wed, 18 Nov 2026 21:26:35 +0200
Message-ID: <20261118-device-trust-core-v3-5-d655875c4bfb@nvidia.com>
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

