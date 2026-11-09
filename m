Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209683;
	b=Y1Mpyyu/18XzItb0KBe1OmtIPfmqf62NNGBN32vETTb+ZXvqW5bwJ8qIC9TOpgSb1pN4
	 L/M6th77zj83FdwBGgjdQOkhY/aKAODw6VvupkwHDIN+IIusjpR4FNSlz6RMxEHOYAIm1
	 xu/UBeq81LxRadteuC29vCwVPIKFPpXDhaF2p2H0zWjgu5zxkrxzJtDGsXut4NTnaK5hD
	 XX5fnmCMNw0f3IgJ+610R1tdCAHjpf5dVDSQfFdVF30OhVyX6SVTru30WMCaDkj3E16nr
	 Vzrb+oonmQl7+m2hwJJa0HotFbvGgVFUSW4xvBIYjUs3nZZS1M6eLlFDnx4GPZrrY3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209683;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=MpimnCg02HZciFk2g0S8/wZfNZukhRQXczEg3LroMuI=;
	b=MQZ8IN8nL8er0qkiGpObIn1danznM2igVNBoi6zxn8kAx05lGpyPhvyiBYGY9wd2TiKk
	 z85ctYbFIG/jXVJvAg7uxAmhsOavVvlDdZO172GlBhI5Cloj0xkgCR1U1K+vp0goO8PW/
	 4LhSuw6iTVPTtsEWjIQLH9YMQFeoBm1dRoLW9lKSqLzFUCh1X8h15kwQ+hJPMG4ThxisT
	 9Sq+pbKiWx7yMFq7qLLhAY7HQjvcar6EZZHia3H+ywPpzdRzcDmp0jsDXpQjlc/KccSSt
	 UqBcioA4TRFUpxyJMQzk3cQmiuhxY41Zl6W4nsXUBiT3TwbFK31NofVTIwzsj+yhyFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKr63xQC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972A60A6F7E;
	Mon,  9 Nov 2026 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKr63xQC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FD71F008A5;
	Mon,  9 Nov 2026 07:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209682;
	bh=MpimnCg02HZciFk2g0S8/wZfNZukhRQXczEg3LroMuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKr63xQCZG0Kx/uDf562/8osJmX+c3VIP3ZLP2fy+N3p2uMLmr261yWJN04SAid33
	 4qJxdMBJEuJjdAYJgwhRUQoVw6QBjlAGGjoc7Y54KLCCEhufLWIW048UgQ4IzodCVv
	 wU6UbWG/JabptBOI2k3O1pXRAAZc3jfaVJ1HMHVghqwOsOIlcicfIxkciYOpZyn3mj
	 QotY5+kzCshox9OAqzDTEATR1ApsmuZxkEzUdHzUfiOkCIjb/ySQqk81vs6EyoFaZo
	 bdSaWl9jfQIvtVJDkJZBmj4xW209iqY7h7Bs68bjZ6U9e2NDfpuBJWxUOIjNVD6CXx
	 F0QG94RhDBeWw==
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
Subject: [PATCH v2 08/19] driver core: Add a compatibility API for manual driver attachment
Date: Mon,  9 Nov 2026 09:33:38 +0200
Message-ID: <20261109-device-trust-core-v2-8-3b12d9a9f861@nvidia.com>
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

Existing manual binding paths probe drivers under subsystem locks before
publishing their bindings. Normal attachment would add device locking to
these paths.

Add device_driver_attach_full() to preserve their serialization while
centralizing probe and binding cleanup. This compatibility API must not
be used in any new code: it prevents devices from using the device trust
authorization infrastructure. New code must use device_driver_attach().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/base/dd.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/device.h |  2 ++
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 52123251965de..0f56c3d825731 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -526,6 +526,21 @@ static void driver_sysfs_remove(struct device *dev)
 	}
 }
 
+static int __device_bind_driver(struct device *dev)
+{
+	int ret;
+
+	ret = driver_sysfs_add(dev);
+	if (ret) {
+		bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
+		return ret;
+	}
+
+	device_links_force_bind(dev);
+	driver_bound(dev);
+	return 0;
+}
+
 /**
  * device_bind_driver - bind a driver to one device.
  * @dev: device.
@@ -542,19 +557,64 @@ static void driver_sysfs_remove(struct device *dev)
  * Callers should prefer to use device_driver_attach() instead.
  */
 int device_bind_driver(struct device *dev)
+{
+	return __device_bind_driver(dev);
+}
+EXPORT_SYMBOL_GPL(device_bind_driver);
+
+/**
+ * device_driver_attach_full - attach a driver using subsystem serialization
+ * @drv: driver to attach
+ * @dev: device to attach it to
+ *
+ * This compatibility API must not be used in any new code. It prevents
+ * devices from using the device trust authorization infrastructure.
+ * New code must use device_driver_attach().
+ *
+ * Callers must serialize attachment and removal using their subsystem's
+ * existing locks. This function does not acquire the device or parent lock.
+ * It calls the bus or driver probe callback and publishes the binding without
+ * performing the normal driver-core DMA, pinctrl or power-domain setup.
+ *
+ * Return: 0 on success, or a negative error before binding.
+ */
+int device_driver_attach_full(const struct device_driver *drv, struct device *dev)
 {
 	int ret;
 
-	ret = driver_sysfs_add(dev);
-	if (!ret) {
-		device_links_force_bind(dev);
-		driver_bound(dev);
-	}
+	if (!device_is_registered(dev) || dev->p->dead)
+		return -ENODEV;
+	if (dev->driver)
+		return -EBUSY;
+
+	device_set_driver(dev, drv);
+	if (dev->bus->probe)
+		ret = dev->bus->probe(dev);
 	else
-		bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
+		ret = drv->probe(dev);
+	if (ret)
+		goto clear_driver;
+
+	ret = __device_bind_driver(dev);
+	if (ret)
+		goto bus_remove;
+
+	return 0;
+
+bus_remove:
+	if (dev->bus->remove)
+		dev->bus->remove(dev);
+	else
+		drv->remove(dev);
+clear_driver:
+	devres_release_all(dev);
+	device_set_driver(dev, NULL);
+	dev_set_drvdata(dev, NULL);
+	if (ret == -EPROBE_DEFER)
+		return -EAGAIN;
 	return ret;
 }
-EXPORT_SYMBOL_GPL(device_bind_driver);
+EXPORT_SYMBOL_GPL(device_driver_attach_full);
 
 static atomic_t probe_count = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
diff --git a/include/linux/device.h b/include/linux/device.h
index 429e39f647cf9..42e966ebaa2d3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1314,6 +1314,8 @@ static inline void *dev_get_platdata(const struct device *dev)
  */
 int __must_check device_driver_attach(const struct device_driver *drv,
 				      struct device *dev);
+int __must_check device_driver_attach_full(const struct device_driver *drv,
+					  struct device *dev);
 int __must_check device_bind_driver(struct device *dev);
 void device_release_driver(struct device *dev);
 int  __must_check device_attach(struct device *dev);

-- 
2.56.0

