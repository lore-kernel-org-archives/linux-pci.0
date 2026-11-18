Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030145;
	b=exDsZ2nM8Q9DfTqvPMcrsdxDEsYfIvra8lmElynlq5NqkbmFrNn2IpbppP9TiPxFJtIf
	 ox4/j/L2RfU5pM2Ty0C46urO11zQW+D2vV0zmezHz43OXG8isrT9lcQCtbKOeKbLYzLXT
	 QXdOTqjfgPtxWWKiYkNWLmuOi/hoaDjSBq3AoSeeq/oaXc0m9x2Rydl3zo96NwHJTVosI
	 TNpxZJiX6H8zvHl6abZQhiFKuMbJo/IfCDCcVvUlIlRfu292pCEZtfj6Yyep2QAhHOedQ
	 aaT7pi0HbiEh7Te0n9cxeBkcAAj8Fi1EKEF9Lj9hEXWvFUEaG4VADRa8xdtWk6NxmUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030145;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=1V5OySgH+ZSszge5UvHlymL+jckhu9tpr2xqgdevGuY=;
	b=C+4ATZwl7GkABMD52c9Xh1rbKLI+SIQ4Lm30+NhS/HMKFfyYJCD7PFtqLhTecsVzAS1a
	 Zn2h8C3xfALll5IckLAAgJe2tqCvU6TwEr4coKHK3ChjiR9qlzpf+2pBL1uJeyQkHs8Ho
	 8wMk0XC4FdS+O1ImNa2SAIXcdggZX+jvUD1EqHHscGMSIG0KzmGijW5Q4haW4pzK+erMX
	 O9xG3ektIrSE05Pn8/Cnv48dADVooBnDYS0xUCvPgx7zw015AYo+TVZaMml1LTzJ+87W7
	 FLEDi6DdIMEEpAo82zhSzLavXIJ+NCuYnFyXiSdRJNld1bNxZgHJGWMF++XVAl5bzcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVYon4HH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414E606BB5D;
	Wed, 18 Nov 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVYon4HH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D601F000C7;
	Wed, 18 Nov 2026 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030144;
	bh=1V5OySgH+ZSszge5UvHlymL+jckhu9tpr2xqgdevGuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jVYon4HHntgw2K3s3j0o1jJjWdeJxstyXtRmoG8gdDVdsNKee6TP08bVAQQko85sY
	 xYcCCuP1mnI7Pn6KQhsZVptc7Yfy14sPZxx56wIBJUe8P3gOIOOaN54ENf43Rs3tDl
	 YthiSHBr8ioKEq2skaQhcz6SbKMdhVFi1Y5lIE4sAhagJ+4VRZY+1uPaWuEvTQiCOO
	 LDB8wfceU38Wp3XpuOpuDbPbxvMlEqAWghC3I+KG0o3pUov+qLxcakw1xqOvFCuuxB
	 GFRk69toorsTOfSyuugDgS0ciwp2k7hTKuxH6qko3hW1Ah5MF68b2duGEGpWkRpTL+
	 Q/374NS5keUGQ==
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
Subject: [PATCH v3 28/31] driver core: Allow driver attachment with the device lock held
Date: Wed, 18 Nov 2026 21:26:58 +0200
Message-ID: <20261118-device-trust-core-v3-28-d655875c4bfb@nvidia.com>
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

USB authorization needs to keep driver attachment and its configuration
result under the same device lock. Dropping the lock to call
device_attach() would let another request change that result before the
authorizing caller can inspect it.

Provide synchronous attachment for callers that already hold the device
lock. Keep asynchronous scheduling outside the lock in the existing path.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/base/dd.c      | 34 ++++++++++++++++++++++++++++++----
 include/linux/device.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 4c4723384dc66..2f45b53e5ba91 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1222,12 +1222,11 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	put_device(dev);
 }
 
-static int __device_attach(struct device *dev, bool allow_async)
+static int __device_attach_locked(struct device *dev, bool allow_async,
+				  bool *async)
 {
 	int ret = 0;
-	bool async = false;
 
-	device_lock(dev);
 	mutex_lock(&dev->p->driver_lock);
 	if (dev->p->dead) {
 		goto out_unlock;
@@ -1265,7 +1264,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
-			async = true;
+			*async = true;
 		} else {
 			pm_request_idle(dev);
 		}
@@ -1275,6 +1274,16 @@ static int __device_attach(struct device *dev, bool allow_async)
 	}
 out_unlock:
 	mutex_unlock(&dev->p->driver_lock);
+	return ret;
+}
+
+static int __device_attach(struct device *dev, bool allow_async)
+{
+	bool async = false;
+	int ret;
+
+	device_lock(dev);
+	ret = __device_attach_locked(dev, allow_async, &async);
 	device_unlock(dev);
 	if (async && !async_schedule_dev_nocall(__device_attach_async_helper, dev)) {
 		put_device(dev);
@@ -1284,6 +1293,23 @@ static int __device_attach(struct device *dev, bool allow_async)
 	return ret;
 }
 
+/**
+ * device_attach_locked - try to attach a driver with the device locked
+ * @dev: device to attach
+ *
+ * Synchronous device_attach() with the device lock held by the caller.
+ * When called for a USB interface, the parent lock must also be held.
+ * The device lock remains held on return.
+ *
+ * Return: 1 if bound, 0 if no driver bound, or a negative error.
+ */
+int device_attach_locked(struct device *dev)
+{
+	device_lock_assert(dev);
+	return __device_attach_locked(dev, false, NULL);
+}
+EXPORT_SYMBOL_GPL(device_attach_locked);
+
 /**
  * device_attach - try to attach device to a driver.
  * @dev: device.
diff --git a/include/linux/device.h b/include/linux/device.h
index 3db6657dffe41..05b8f4af36873 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1337,6 +1337,7 @@ int __must_check device_driver_attach_unrestricted(
 int __must_check device_bind_driver(struct device *dev);
 void device_release_driver(struct device *dev);
 int  __must_check device_attach(struct device *dev);
+int __must_check device_attach_locked(struct device *dev);
 int __must_check driver_attach(const struct device_driver *drv);
 void device_initial_probe(struct device *dev);
 int __must_check device_reprobe(struct device *dev);

-- 
2.56.1

