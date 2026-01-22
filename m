Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288B2C0F6E
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093621; cv=none; b=dgxpj++99SCtgwDo8Bn33AOyvJ9KWH6M2M71DZBC9CaXihEoy+53apBWj8M0ejyKhpGStMxYdtv5s48XKZbyT/tw9Zj+BdQ5Wz40QrKbbncogZYX4RHv6S20ZPA9z6lIjqgzwynW8m7yttpBnTeMl1zS8JLc6QHJSKUsmbTZSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093621; c=relaxed/simple;
	bh=IZkV4tTavSfT0g6OInPIqtFpbWh79RvTO5JIqAwXSUc=;
	h=From:Mime-Version:References:Content-Type:To:Date:In-Reply-To:Cc:
	 Message-Id:Subject; b=Af0ZbGDsqZmmbYf9aREPLt56nFzJc9gr3tMiGbOSKTvXTJXVi5KxGhFWfyzZub9GbUkukM76rA2yUUJKYkHU16wSy41bDUB86wTsAvqL2VMSucOVTJ6VmTz2rkHe4uUau6WgeuTiTkp6QUgV65uC4O5ktTO/iO5xmzp+Qr6F530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e+Gm1gTt; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e+Gm1gTt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1769093606; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PNn0c27rEDDAHeW79wncnlC/NSoB+XCUipsvkMRyvlw=;
 b=e+Gm1gTtfj0Sc6ZHC9hh0q/ZAA/fkzl1afhIVmi5kCJOl20f9xFVwYCLBA0E/fKqLQK9AW
 wsvIIJnZMfVk9PabIAjN+WKoQjHUdEJf1YRTj0h4rlUf+qOzpMXto+Fb9D2OOW7Sv1mmUA
 MyDsjTe7oPlG0tFlELpXRYB3GvYxpC4LzelaF1zsl/ulm1F6qRLDqVQWN+ZfCxUIcDNVZU
 3yKZAe21j/1Yq5HimG9wdbBVKi3S2up9OpISaz/1G4hB8ZEYjBw/RcgfEA0796Edyiq77K
 PXFl3oyWnyMRfLsXy6tixLrxgwMx5fgQ+BsljIh3gUOQUqueXoqXi12l6Wtk6g==
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2697239e4+f73917+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <dakr@kernel.org>, <alexanderduyck@fb.com>, <bhelgaas@google.com>, 
	<bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <helgaas@kernel.org>, <rafael@kernel.org>, 
	<tj@kernel.org>, <frederic@kernel.org>
Date: Thu, 22 Jan 2026 22:52:06 +0800
In-Reply-To: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
Content-Transfer-Encoding: 7bit
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Message-Id: <20260122145208.1013-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH v2 1/3] driver core: Introduce helper function __device_attach_driver_scan()

The logic responsible for managing parent device PM
runtime (get/put), iterating over the bus drivers,and
determining if asynchronous probing is required is
currently duplicated between __device_attach() and
__device_attach_async_helper().

This patch factors out this common logic into a new
static helper function __device_attach_driver_scan().

This change reduces code duplication and improves
maintainability without altering the existing behavior.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/dd.c | 71 ++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ed3a07624816..b6be95871d3d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -964,6 +964,44 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	return ret == 0;
 }
 
+static int __device_attach_driver_scan(struct device_attach_data *data,
+				       bool *need_async)
+{
+	int ret = 0;
+	struct device *dev = data->dev;
+
+	if (dev->parent)
+		pm_runtime_get_sync(dev->parent);
+
+	ret = bus_for_each_drv(dev->bus, NULL, data,
+			       __device_attach_driver);
+	/*
+	 * When running in an async worker, a NULL need_async is passed
+	 * since we are already in an async worker.
+	 */
+	if (need_async && !ret && data->check_async && data->have_async) {
+		/*
+		 * If we could not find appropriate driver
+		 * synchronously and we are allowed to do
+		 * async probes and there are drivers that
+		 * want to probe asynchronously, we'll
+		 * try them.
+		 */
+		dev_dbg(dev, "scheduling asynchronous probe\n");
+		get_device(dev);
+		*need_async = true;
+	} else {
+		if (!need_async)
+			dev_dbg(dev, "async probe completed\n");
+		pm_request_idle(dev);
+	}
+
+	if (dev->parent)
+		pm_runtime_put(dev->parent);
+
+	return ret;
+}
+
 static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 {
 	struct device *dev = _dev;
@@ -984,16 +1022,8 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (dev->p->dead || dev->driver)
 		goto out_unlock;
 
-	if (dev->parent)
-		pm_runtime_get_sync(dev->parent);
+	__device_attach_driver_scan(&data, NULL);
 
-	bus_for_each_drv(dev->bus, NULL, &data, __device_attach_driver);
-	dev_dbg(dev, "async probe completed\n");
-
-	pm_request_idle(dev);
-
-	if (dev->parent)
-		pm_runtime_put(dev->parent);
 out_unlock:
 	device_unlock(dev);
 
@@ -1027,28 +1057,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			.want_async = false,
 		};
 
-		if (dev->parent)
-			pm_runtime_get_sync(dev->parent);
-
-		ret = bus_for_each_drv(dev->bus, NULL, &data,
-					__device_attach_driver);
-		if (!ret && allow_async && data.have_async) {
-			/*
-			 * If we could not find appropriate driver
-			 * synchronously and we are allowed to do
-			 * async probes and there are drivers that
-			 * want to probe asynchronously, we'll
-			 * try them.
-			 */
-			dev_dbg(dev, "scheduling asynchronous probe\n");
-			get_device(dev);
-			async = true;
-		} else {
-			pm_request_idle(dev);
-		}
-
-		if (dev->parent)
-			pm_runtime_put(dev->parent);
+		ret = __device_attach_driver_scan(&data, &async);
 	}
 out_unlock:
 	device_unlock(dev);
-- 
2.20.1
