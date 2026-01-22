Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4468317715
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093638; cv=none; b=FZgDqAKEo4qpHR6Fuf8gQMH5GSjk1MQ/rJ/Aa9QqGgpvvJwgL19n7r51bkbYGckM5iM9hg3c+r76LtKz3Nzkpobij2StVHKEO85w5RCGPxMiKtop9qDRg+DmgaPwS3aJHwxS3Ds+DvGiF6cUZv2LcbOW1TItST/1MYVojFZmQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093638; c=relaxed/simple;
	bh=dqtWNzfpeZHZxeHHMc5iXQXjPyWQDqjMRAyCL4NwOew=;
	h=Cc:From:Date:Content-Type:Subject:Message-Id:Mime-Version:
	 In-Reply-To:To:References; b=N9n3cnfHqzRr39k2OimXQCyOrAbe335ZfTubdW5dorjfzs6Qh5nIxK+OCrnGNlxQLuvG3KY8HtG/Gz2bD6O+spM1qefTD8GcuXcifPrGqMIx0IYoWhZjgYH5X8u62GpS/bFpzUl3py3GoqKTSyWoOGQ2hz45YXgU+R5IdSqlS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YZR16OUi; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YZR16OUi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1769093631; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=L9L2mUXKRwXuM09p6XvQbq2cHnY/3KHPcitXOfGDdIg=;
 b=YZR16OUiKa5ENzeUHyydGw8+hSw1gl9jWwDjkmzp2P71P6w0kqV5Mtm8xCOAcWeHGebLox
 3V/1vJdP70BnNRmslHLoJ2z5btwrwFbeQFoQHeiVKMQxCKgN5+AwPq3Dvlkavw1PnrstQD
 pXAc9Lg3B6KaFgVJCmlpCGZ8zyCfEgHLKwcbjR6XVTa34q23MKHK2p+a0hVRLbd1OYTnhK
 42lNI1nLkiGdXOvyHVkr2BtzB0+ZNQzuGLmAB2XqHSp/uC18rjr2rOsCRfMZVzj+1YVXkr
 fmZjCzqWZ1hLZ5lj5ckv9zaMW63JDytvPMxAVeUABgpH6UiJsuW3slovZYEVCQ==
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Thu, 22 Jan 2026 22:52:07 +0800
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2 2/3] driver core: Add NUMA-node awareness to the synchronous probe path
Message-Id: <20260122145208.1013-3-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2697239fd+c1b877+vger.kernel.org+guojinhui.liam@bytedance.com>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: <dakr@kernel.org>, <alexanderduyck@fb.com>, <bhelgaas@google.com>, 
	<bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <helgaas@kernel.org>, <rafael@kernel.org>, 
	<tj@kernel.org>, <frederic@kernel.org>
References: <20260122145208.1013-1-guojinhui.liam@bytedance.com>

Introduce NUMA-node-aware synchronous probing: drivers
can initialize and allocate memory on the device=E2=80=99s local
node without scattering kmalloc_node() calls throughout
the code.

NUMA-aware probing was first added to PCI drivers by
commit d42c69972b85 ("[PATCH] PCI: Run PCI driver
initialization on local node") in 2005 and has benefited
PCI drivers ever since.

The asynchronous probe path already supports NUMA-node-aware
probing via async_schedule_dev() in the driver core. Since
NUMA affinity is orthogonal to sync/async probing, this
patch adds NUMA-node-aware support to the synchronous
probe path.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/base/dd.c | 76 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b6be95871d3d..a8d560034abe 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -810,10 +810,56 @@ static int __driver_probe_device(const struct device_=
driver *drv, struct device
 	return ret;
 }
=20
+/* Context for NUMA execution */
+struct numa_work_ctx {
+	struct work_struct work;
+	const struct device_driver *drv;
+	struct device *dev;
+	int result;
+};
+
+/* Worker function running on the target node */
+static void __driver_probe_device_node_helper(struct work_struct *work)
+{
+	struct numa_work_ctx *ctx =3D container_of(work, struct numa_work_ctx, wo=
rk);
+
+	ctx->result =3D __driver_probe_device(ctx->drv, ctx->dev);
+}
+
+/*
+ * __driver_probe_device_node - execute __driver_probe_device on a specifi=
c NUMA node synchronously
+ * @drv: driver to bind a device to
+ * @dev: device to try to bind to the driver
+ *
+ * Returns the result of the function execution, or -ENODEV if initializat=
ion fails.
+ * If the node is invalid or offline, it falls back to local execution.
+ */
+static int __driver_probe_device_node(const struct device_driver *drv, str=
uct device *dev)
+{
+	struct numa_work_ctx ctx;
+	int node =3D dev_to_node(dev);
+
+	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node))
+		return __driver_probe_device(drv, dev);
+
+	ctx.drv =3D drv;
+	ctx.dev =3D dev;
+	ctx.result =3D -ENODEV;
+	INIT_WORK_ONSTACK(&ctx.work, __driver_probe_device_node_helper);
+
+	/* Use system_dfl_wq to allow execution on the specific node. */
+	queue_work_node(node, system_dfl_wq, &ctx.work);
+	flush_work(&ctx.work);
+	destroy_work_on_stack(&ctx.work);
+
+	return ctx.result;
+}
+
 /**
  * driver_probe_device - attempt to bind device & driver together
  * @drv: driver to bind a device to
  * @dev: device to try to bind to the driver
+ * @in_async: true if the caller is running in an asynchronous worker cont=
ext
  *
  * This function returns -ENODEV if the device is not registered, -EBUSY i=
f it
  * already has a driver, 0 if the device is bound successfully and a posit=
ive
@@ -824,13 +870,22 @@ static int __driver_probe_device(const struct device_=
driver *drv, struct device
  *
  * If the device has a parent, runtime-resume the parent before driver pro=
bing.
  */
-static int driver_probe_device(const struct device_driver *drv, struct dev=
ice *dev)
+static int driver_probe_device(const struct device_driver *drv, struct dev=
ice *dev, bool in_async)
 {
 	int trigger_count =3D atomic_read(&deferred_trigger_count);
 	int ret;
=20
 	atomic_inc(&probe_count);
-	ret =3D __driver_probe_device(drv, dev);
+	/*
+	 * If we are already in an asynchronous worker, invoke __driver_probe_dev=
ice()
+	 * directly to avoid the overhead of an additional workqueue scheduling.
+	 * The async subsystem manages its own concurrency and placement.
+	 */
+	if (in_async)
+		ret =3D __driver_probe_device(drv, dev);
+	else
+		ret =3D __driver_probe_device_node(drv, dev);
+
 	if (ret =3D=3D -EPROBE_DEFER || ret =3D=3D EPROBE_DEFER) {
 		driver_deferred_probe_add(dev);
=20
@@ -919,6 +974,13 @@ struct device_attach_data {
 	 * driver, we'll encounter one that requests asynchronous probing.
 	 */
 	bool have_async;
+
+	/*
+	 * True when running inside an asynchronous worker context scheduled
+	 * by async_schedule_dev() with callback function
+	 * __device_attach_async_helper().
+	 */
+	bool in_async;
 };
=20
 static int __device_attach_driver(struct device_driver *drv, void *_data)
@@ -958,7 +1020,7 @@ static int __device_attach_driver(struct device_driver=
 *drv, void *_data)
 	 * Ignore errors returned by ->probe so that the next driver can try
 	 * its luck.
 	 */
-	ret =3D driver_probe_device(drv, dev);
+	ret =3D driver_probe_device(drv, dev, data->in_async);
 	if (ret < 0)
 		return ret;
 	return ret =3D=3D 0;
@@ -1009,6 +1071,7 @@ static void __device_attach_async_helper(void *_dev, =
async_cookie_t cookie)
 		.dev		=3D dev,
 		.check_async	=3D true,
 		.want_async	=3D true,
+		.in_async	=3D true,
 	};
=20
 	device_lock(dev);
@@ -1055,6 +1118,7 @@ static int __device_attach(struct device *dev, bool a=
llow_async)
 			.dev =3D dev,
 			.check_async =3D allow_async,
 			.want_async =3D false,
+			.in_async =3D false,
 		};
=20
 		ret =3D __device_attach_driver_scan(&data, &async);
@@ -1144,7 +1208,7 @@ int device_driver_attach(const struct device_driver *=
drv, struct device *dev)
 	int ret;
=20
 	__device_driver_lock(dev, dev->parent);
-	ret =3D __driver_probe_device(drv, dev);
+	ret =3D __driver_probe_device_node(drv, dev);
 	__device_driver_unlock(dev, dev->parent);
=20
 	/* also return probe errors as normal negative errnos */
@@ -1165,7 +1229,7 @@ static void __driver_attach_async_helper(void *_dev, =
async_cookie_t cookie)
 	__device_driver_lock(dev, dev->parent);
 	drv =3D dev->p->async_driver;
 	dev->p->async_driver =3D NULL;
-	ret =3D driver_probe_device(drv, dev);
+	ret =3D driver_probe_device(drv, dev, true);
 	__device_driver_unlock(dev, dev->parent);
=20
 	dev_dbg(dev, "driver %s async attach completed: %d\n", drv->name, ret);
@@ -1233,7 +1297,7 @@ static int __driver_attach(struct device *dev, void *=
data)
 	}
=20
 	__device_driver_lock(dev, dev->parent);
-	driver_probe_device(drv, dev);
+	driver_probe_device(drv, dev, false);
 	__device_driver_unlock(dev, dev->parent);
=20
 	return 0;
--=20
2.20.1
