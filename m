Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9C3C1973
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576175; cv=none; b=cuFBkAT8TVPDjy7Mj+53FVBw7TwIrNqNZaYoSWmBv0xyVPX9T7sD+MmxSYa+imMkwD4jy0tKpDl1sBtdk4XCq8aGDkKXCK8cLX6xOmcjbu+Ung3cgcSGFwtE7Sgo8ALeidLgkwH61g70jrE+xG5Wfj6t37gFqbOAYyH5SB6y6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576175; c=relaxed/simple;
	bh=LwF4g3GgiBopq5VLyCEXnqlJVDeMdGzjLGWlnJ5pbBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stzDRvGKn7W6L56rhTJVo8R6Jk0u926g3RPRbTOEZ5HdXdwA0yn5CnfP9LdQmoJk2pZrqaEmhFZZ8sE9AFH7DrboPLCf96OyUKxvp4nmEFj5jIeY3Ua/dxI3qhkJBhmXAcrpEF15JEi8eJxXwwHTtD/Q6LzSu2jPPx6X2DUfjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RI14z00S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RI14z00S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775576164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xf8VBa3s5TDbzdGc7YU+V5MBvNbOIU1Be5qZpIougPY=;
	b=RI14z00SUCmTWktqV8nC6iozWs4/m0AGXfWINzYopAH/1hgaYWUwBTo44xGVUgvaPRGOFh
	Y7EsFJX3iT5WH5VUzd/9BG+ZxpT3tjR21rHpunaDyGSruyxfHuw0Y1yFzlCV1OG22NvjSG
	nF+p+FA6o8sRpCTviyfjBXE76/8Sl9w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-EltgH6WzOTqdn50Q92ivvQ-1; Tue,
 07 Apr 2026 11:36:00 -0400
X-MC-Unique: EltgH6WzOTqdn50Q92ivvQ-1
X-Mimecast-MFC-AGG-ID: EltgH6WzOTqdn50Q92ivvQ_1775576158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1275418005BA;
	Tue,  7 Apr 2026 15:35:57 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.80.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCD97180035F;
	Tue,  7 Apr 2026 15:35:51 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Tarun Sahu <tarunsahu@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	=?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= <mclapinski@google.com>,
	Jordan Richards <jordanrichards@google.com>,
	Ewan Milne <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 2/5] driver core: do not always lock parent in shutdown
Date: Tue,  7 Apr 2026 11:35:29 -0400
Message-ID: <20260407153532.6395-3-djeffery@redhat.com>
In-Reply-To: <20260407153532.6395-1-djeffery@redhat.com>
References: <20260407153532.6395-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Don't lock a parent device unless it is needed in device_shutdown. This
is in preparation for making device shutdown asynchronous, when it will
be needed to allow children of a common parent to shut down
simultaneously.

And only acquire a reference to the parent device if the parent is to be
locked.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/base/core.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fabd17be1175..0fb2f3ccc3bd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4784,13 +4784,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	return error;
 }
 
-static void shutdown_one_device(struct device *dev)
+static void __shutdown_one_device(struct device *dev)
 {
-	struct device *parent = dev->parent;
-
-	/* hold lock to avoid race with probe/release */
-	if (parent)
-		device_lock(parent);
 	device_lock(dev);
 
 	/* Don't allow any more runtime suspends */
@@ -4813,10 +4808,23 @@ static void shutdown_one_device(struct device *dev)
 	}
 
 	device_unlock(dev);
-	if (parent)
+}
+
+static void shutdown_one_device(struct device *dev)
+{
+	struct device *parent;
+
+	/* hold lock if needed to avoid race with probe/release */
+	if (dev->bus && dev->bus->need_parent_lock &&
+	    (parent = get_device(dev->parent))) {
+		device_lock(parent);
+		__shutdown_one_device(dev);
 		device_unlock(parent);
+		put_device(parent);
+	} else {
+		__shutdown_one_device(dev);
+	}
 
-	put_device(parent);
 	put_device(dev);
 }
 
@@ -4842,12 +4850,6 @@ void device_shutdown(void)
 		dev = list_entry(devices_kset->list.prev, struct device,
 				kobj.entry);
 
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		get_device(dev->parent);
 		get_device(dev);
 		/*
 		 * Make sure the device is off the kset list, in the
-- 
2.53.0

