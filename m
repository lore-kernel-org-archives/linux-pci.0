Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513520;
	b=pvlmfyABNaPpKJw6F4W14fPQUeB8MOUfMtkPl+e7AeCrydgPyO71V/z9AveTdGRAEB3I
	 J4erDehahUbGZjbUaRJ8gvf9XsVkw9TOI8J2+MwHupfRnf4ldJjhylreHF/PStwTJvb5F
	 JV18cmI0yCp+7zoAuVwL+BraiPUSX4hcw6/epd+GJzndS8JhQCTulFXvSeaoDuY5nZV/S
	 //v8cYK1sfrkNCLoe3+uKJoSnFjvGRmnLOa3c+IF+QnH24WPgQ3rayssULTGRPDfCccFd
	 lNuzeGlkRJXbupZRvgim1W9ca5OQrsUj7L8bPZrMnQzdwrtikqERLMBVaFeBsRjFEng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513520;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=svn/2tWKkyjohVxB7EW8S8pN30sPScn5Y9r6tebxa/E=;
	b=zUBaYdAShhQsVmspgBF/RZBIOC/7eUz8C7KX0wS8I21c456/wGNe1KtJthhRYS8UKw21
	 dkxGZ+betPgkjyz3N2iqRmDLtD1gzhevJEgIUXEq/n8Swc1wUfuMnE/iSjShEIp4YktGp
	 +5AhAVwNR3HbyFMqJ+WKf+7tVYb2KZphdrnFvI4Bhzmh/iHW70BIOTweLmi6ysqU0eH7x
	 cGrrXMnCByNCLBmkdtnBEKU4dBOZcij1aBV8CgUH7cHMM/f7YYtT2X9igSNJtcrIV9Mok
	 P7OvOlotoiPIqBiMwLWmDXcmmiMMt3M66uTOqNNRuJSZk2632pqBs/lpHk2rKD8WlLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SE6n0SZi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63860606A699;
	Tue, 24 Nov 2026 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SE6n0SZi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D81F000EC;
	Tue, 24 Nov 2026 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513520;
	bh=svn/2tWKkyjohVxB7EW8S8pN30sPScn5Y9r6tebxa/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SE6n0SZikYr18MOSYTqx2qWV4bBXH7EHUcwaO6oIs5IIGFzsXHvGEH8qjHPl9jMLZ
	 hM5sxH3eW4DCiGQZp4kno+U6UsaWD9K/FAnkXMKvRhF38PEaYmO6Su7KHY6/hCib+u
	 WT4/p7FAo4o4LKee9bQNPGC+pa6iENb2cn2OVgcDNp1W+hBzZ1ng7KE8J9U1IcixSJ
	 A6O0LW1oww+Hj0TIYqTBOx+I0gDuuc3VaI3eRpjtBy1e/msELEiBWUKn0m/HkYw/lv
	 6334qjjisT7dEJxb9OrDpuOkKaR3pzRWslFdJYE7jqg1EKvSQcKh/qbfBuHJGwql1z
	 wtdF4e31rMOnw==
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
Subject: [PATCH v4 16/33] driver core: Add a compatibility API for manual driver attachment
Date: Tue, 24 Nov 2026 11:43:47 +0200
Message-ID: <20261124-device-trust-core-v4-16-037eb0d17b1f@nvidia.com>
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

Manual attachment can race normal probing and removal, releasing another
probe's resources. Callers cannot always acquire the device mutex under
subsystem locks.

Add device_driver_attach_unrestricted() with a binding mutex shared by
attachment, removal and deletion. Trylock it to reject competing
transactions. Supplier-status reads must avoid sysfs lock inversion and
private-state access after registration failure.

This compatibility API must not be used in any new code: it prevents use
of the device trust authorization infrastructure. New code must use
device_driver_attach().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/base/base.h    |   3 ++
 drivers/base/core.c    |  32 +++++++++++---
 drivers/base/dd.c      | 117 +++++++++++++++++++++++++++++++++++++++++++------
 include/linux/device.h |   2 +
 4 files changed, 134 insertions(+), 20 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 866b2beb6baa2..61f49fc142f45 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -105,6 +105,7 @@ struct driver_private {
  *			   dev_err_probe() for later retrieval via debugfs
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
+ * @driver_lock: serializes binding and removal, including compatibility attach
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -121,6 +122,8 @@ struct device_private {
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
+	/* Taken after the device mutex, except by compatibility attach. */
+	struct mutex driver_lock;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
diff --git a/drivers/base/core.c b/drivers/base/core.c
index cbe05197d4a0b..92d25bf4f8632 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1315,13 +1315,23 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 					 const struct device_attribute *attr,
 					 char *buf)
 {
+	struct kernfs_node *kn;
+	ssize_t ret = -ENODEV;
 	bool val;
 
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	if (!kn)
+		return -ENODEV;
+
 	device_lock(dev);
-	scoped_guard(mutex, &fwnode_link_lock)
-		val = !!fwnode_links_check_suppliers(dev->fwnode);
+	if (dev_ready_to_probe(dev) && !dev->p->dead) {
+		scoped_guard(mutex, &fwnode_link_lock)
+			val = !!fwnode_links_check_suppliers(dev->fwnode);
+		ret = sysfs_emit(buf, "%u\n", val);
+	}
 	device_unlock(dev);
-	return sysfs_emit(buf, "%u\n", val);
+	sysfs_unbreak_active_protection(kn);
+	return ret;
 }
 static const DEVICE_ATTR_RO(waiting_for_supplier);
 
@@ -3609,6 +3619,9 @@ static int device_private_init(struct device *dev)
 	if (!dev->p)
 		return -ENOMEM;
 	dev->p->device = dev;
+	mutex_init(&dev->p->driver_lock);
+	/* Driver callbacks can bind or unbind child devices. */
+	lockdep_set_novalidate_class(&dev->p->driver_lock);
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
@@ -3889,6 +3902,8 @@ EXPORT_SYMBOL_GPL(put_device);
 
 bool kill_device(struct device *dev)
 {
+	bool killed = false;
+
 	/*
 	 * Require the device lock and set the "dead" flag to guarantee that
 	 * the update behavior is consistent with the other bitfields near
@@ -3898,10 +3913,13 @@ bool kill_device(struct device *dev)
 	 */
 	device_lock_assert(dev);
 
-	if (dev->p->dead)
-		return false;
-	dev->p->dead = true;
-	return true;
+	mutex_lock(&dev->p->driver_lock);
+	if (!dev->p->dead) {
+		dev->p->dead = true;
+		killed = true;
+	}
+	mutex_unlock(&dev->p->driver_lock);
+	return killed;
 }
 EXPORT_SYMBOL_GPL(kill_device);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 52123251965de..6ac1486b9fbb5 100644
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
@@ -545,16 +560,85 @@ int device_bind_driver(struct device *dev)
 {
 	int ret;
 
-	ret = driver_sysfs_add(dev);
-	if (!ret) {
-		device_links_force_bind(dev);
-		driver_bound(dev);
+	mutex_lock(&dev->p->driver_lock);
+	ret = __device_bind_driver(dev);
+	mutex_unlock(&dev->p->driver_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_bind_driver);
+
+/**
+ * device_driver_attach_unrestricted - attach a driver using subsystem serialization
+ * @drv: driver to attach
+ * @dev: device to attach it to
+ *
+ * This compatibility API must not be used in any new code. It prevents
+ * devices from using the device trust authorization infrastructure.
+ * New code must use device_driver_attach().
+ *
+ * Callers must provide their subsystem's existing manual-binding
+ * serialization. This function does not acquire device or parent locks.
+ * Binding and removal are serialized separately; an overlapping transaction
+ * returns -EBUSY instead of waiting under the caller's subsystem locks.
+ * It calls the bus or driver probe callback and publishes the binding without
+ * performing the normal driver-core DMA, pinctrl or power-domain setup.
+ *
+ * Return: 0 on success, -EAGAIN if registration or probing must be retried,
+ * or another negative error before binding.
+ */
+int device_driver_attach_unrestricted(const struct device_driver *drv,
+				      struct device *dev)
+{
+	int ret;
+
+	if (!device_is_registered(dev))
+		return -ENODEV;
+	if (!mutex_trylock(&dev->p->driver_lock))
+		return -EBUSY;
+	if (dev->p->dead) {
+		ret = -ENODEV;
+		goto unlock;
 	}
+	if (!dev_ready_to_probe(dev)) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+	if (dev->driver) {
+		ret = -EBUSY;
+		goto unlock;
+	}
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
+	mutex_unlock(&dev->p->driver_lock);
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
+		ret = -EAGAIN;
+unlock:
+	mutex_unlock(&dev->p->driver_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(device_bind_driver);
+EXPORT_SYMBOL_GPL(device_driver_attach_unrestricted);
 
 static atomic_t probe_count = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
@@ -1035,15 +1119,15 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
  * @dev: Device we will update driver info for
  * @parent: Parent device. Needed if the device type requires parent lock
  *
- * This function will take the required locks for manipulating dev->drv.
- * Normally this will just be the @dev lock, but when called for a USB
- * interface, @parent lock will be held as well.
+ * Take the device lock and binding lock, together with the parent lock
+ * when the device type requires it.
  */
 static void __device_driver_lock(struct device *dev, struct device *parent)
 {
 	if (dev->type && dev->type->need_parent_lock && parent)
 		device_lock(parent);
 	device_lock(dev);
+	mutex_lock(&dev->p->driver_lock);
 }
 
 /*
@@ -1051,12 +1135,12 @@ static void __device_driver_lock(struct device *dev, struct device *parent)
  * @dev: Device we will update driver info for
  * @parent: Parent device. Needed if the device type requires parent lock
  *
- * This function will release the required locks for manipulating dev->drv.
- * Normally this will just be the @dev lock, but when called for a
- * USB interface, @parent lock will be released as well.
+ * Release the binding and device locks, together with the parent lock
+ * when the device type requires it.
  */
 static void __device_driver_unlock(struct device *dev, struct device *parent)
 {
+	mutex_unlock(&dev->p->driver_lock);
 	device_unlock(dev);
 	if (dev->type && dev->type->need_parent_lock && parent)
 		device_unlock(parent);
@@ -1104,6 +1188,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 	bool async = false;
 
 	device_lock(dev);
+	mutex_lock(&dev->p->driver_lock);
 	if (dev->p->dead) {
 		goto out_unlock;
 	} else if (dev->driver) {
@@ -1111,7 +1196,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			ret = 1;
 			goto out_unlock;
 		}
-		ret = device_bind_driver(dev);
+		ret = __device_bind_driver(dev);
 		if (ret == 0)
 			ret = 1;
 		else {
@@ -1149,6 +1234,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			pm_runtime_put(dev->parent);
 	}
 out_unlock:
+	mutex_unlock(&dev->p->driver_lock);
 	device_unlock(dev);
 	if (async && !async_schedule_dev_nocall(__device_attach_async_helper, dev)) {
 		put_device(dev);
@@ -1285,11 +1371,13 @@ static int __driver_attach(struct device *dev, void *data)
 		 */
 		dev_dbg(dev, "probing driver %s asynchronously\n", drv->name);
 		device_lock(dev);
+		mutex_lock(&dev->p->driver_lock);
 		if (!dev->driver && !dev->p->async_driver) {
 			get_device(dev);
 			dev->p->async_driver = drv;
 			async = true;
 		}
+		mutex_unlock(&dev->p->driver_lock);
 		device_unlock(dev);
 		if (async)
 			async_schedule_dev(__driver_attach_async_helper, dev);
@@ -1374,6 +1462,9 @@ void device_release_driver_internal(struct device *dev,
 				    const struct device_driver *drv,
 				    struct device *parent)
 {
+	if (!dev->p)
+		return;
+
 	__device_driver_lock(dev, parent);
 
 	if (!drv || drv == dev->driver)
diff --git a/include/linux/device.h b/include/linux/device.h
index 429e39f647cf9..5433b2609ab30 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1314,6 +1314,8 @@ static inline void *dev_get_platdata(const struct device *dev)
  */
 int __must_check device_driver_attach(const struct device_driver *drv,
 				      struct device *dev);
+int __must_check device_driver_attach_unrestricted(
+	const struct device_driver *drv, struct device *dev);
 int __must_check device_bind_driver(struct device *dev);
 void device_release_driver(struct device *dev);
 int  __must_check device_attach(struct device *dev);

-- 
2.56.1

