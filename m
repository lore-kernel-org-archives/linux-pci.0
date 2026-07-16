Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0C33F8A1
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256110; cv=none; b=ks+tj0fgjyxPg/Ie532loc57LA1fuxIoyCxQNheQ5kDKn2yP9XaxRuRe+eh6hWrwuM+WyaSbO7oZwrSbwE/TW8bz8j8Lh2ii9kmTxAy6JLiJZTSPju6S3c2len7J3q+G/Aakn95znksYVNhF6fFm+d5ukha+u9J7y+gFA2wWM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256110; c=relaxed/simple;
	bh=84Dxy+IQXZ+Io/tsnEE56Nrw1ZiDroBdIIccATE0oog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ogfLZGPzthhr69z3DAaRhasYip6kEd0yeH+THvhOTM4IYtB3p+H3832LpvDXbE/IpkOfsdbI61Q5/fs+A2nfulmbsb09Gtde66o7jO2huDliCTNNaLGcMe2P1+/vvJaxIAap5US9NSjg49CsIfwWNcN3ifwzOp6ensATNrmgVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aV0NDUUa; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aV0NDUUa"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-474170b59dfso4182357f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 19:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784256106; x=1784860906; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9ZzsR0v39hzEb6iXWVS0iiD5j1ThrMppOubfeQ9NoI=;
        b=aV0NDUUalJEVRuA4IO9jSbMXoB0AMDr5fprzU6ZVzx4b0dY+r1xs0R2RMJ3nK2BLYi
         /LNT3fkqTSK++WOOs1JSFn2RtDIq2rxcJDu+GJH0bfZTT/lBeaiCShtFuEKGKYLPhVkK
         mLeU+xBayM3jnah645b69Q1tO3LRPoCAY9UchHrPN8ZQWH7+uSj7+Mv7Jt4uSdZRzY9e
         k4lB3izQeu0KJ8QPRegQPmPvDN7AhSPzpZeiS84voDXN/PfS9SGu/vJ6eDc1hpHH3TGw
         l8vhDj+GzqJ1lWlj4GYjBPyT7IGP4Oi3FJ+CwMM1F5gMihaG+eUxF8nuzGKxTl1DeUR5
         IIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784256106; x=1784860906;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9ZzsR0v39hzEb6iXWVS0iiD5j1ThrMppOubfeQ9NoI=;
        b=eves5ykCJL6prAuPmQvipAv9MtUy+txUN67XWuxLPemJykAsf2Nr0scHC3rDBBEtD0
         GxBafXOj+zoLGudvhqQiDSXIqzzXPbRgHwo062qvqs5aQGmomNlSHqc32SH6xPjZ5DdJ
         f4bqRpsMqebPtVpXd16PgGMXSJxhw1X9Q8cx8qo2fnY4WF6sHD8WVvBy0ivrDcmwep71
         yWX6jQvyk/1rDzc8LGfmhxyyps0Ttzxs3pmW9JiG7QrQ9Ig/BzehzVqqfmPFIe3PkwIE
         6h0qUe/AYPUMjMgdYLMr6PEQOwiaThFR+XqT1+lTLw9gydEO2uxpNtTDc+UctAjNaGM+
         WQIQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDHIcy3CTpFb6IA6D3jYlDugDnTpUtrcDSAQDZf+M8jzeC72+CF20x6kc8lL0g+UwJErlrKS+YRBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQCCk6/wkudYH7te0bwZLieAUS96HdpSe8nNTu7M2Sa5yXhQX
	JFItd0oZHOQPdS13M4qTHSo7i0DmLhMYa8QfaAFMLVTHfg9eJvVgt32aQKbupTT7VytJH3p/E74
	Qs9GvhsBacqa8nMfWHA==
X-Received: from wrmh8.prod.google.com ([2002:adf:e988:0:b0:463:dd19:ae30])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d12:0:b0:475:f0f0:9f04 with SMTP id ffacd0b85a97d-47f6235475bmr740733f8f.59.1784256105583;
 Thu, 16 Jul 2026 19:41:45 -0700 (PDT)
Date: Thu, 16 Jul 2026 23:04:07 +0000
In-Reply-To: <20260716230411.2767394-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716230411.2767394-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716230411.2767394-4-tarunsahu@google.com>
Subject: [PATCH v19 3/7] driver core: separate function to shutdown one device
From: Tarun Sahu <tarunsahu@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: bvanassche@acm.org, john.g.garry@oracle.com, mlombard@redhat.com, 
	loberman@redhat.com, mclapinski@google.com, dmatlack@google.com, 
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, jordanrichards@google.com, souravsgl@google.com, 
	stuart.w.hayes@gmail.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-scsi@vger.kernel.org, David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: David Jeffery <djeffery@redhat.com>

Make a separate function for the part of device_shutdown() that does the
shutown for a single device.  This is in preparation for making device
shutdown asynchronous.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/base/core.c | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 78b90326addb..82a7af1f3ba2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4898,12 +4898,48 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	return error;
 }
 
+static void shutdown_one_device(struct device *dev)
+{
+	struct device *parent = dev->parent;
+
+	/* hold lock to avoid race with probe/release */
+	if (parent)
+		device_lock(parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (parent)
+		device_unlock(parent);
+
+	put_device(parent);
+	put_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4925,7 +4961,7 @@ void device_shutdown(void)
 		 * prevent it from being freed because parent's
 		 * lock is to be held
 		 */
-		parent = get_device(dev->parent);
+		get_device(dev->parent);
 		get_device(dev);
 		/*
 		 * Make sure the device is off the kset list, in the
@@ -4934,36 +4970,7 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
+		shutdown_one_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
-- 
2.55.0.229.g6434b31f56-goog

