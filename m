Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FC390205
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132767; cv=none; b=Gq3tu1vD61GjoN3nC8370RTv3kvZOmKsxwCuwjc/MJc8zYVDPaHPJaTHwiRarHiaAvy8NbinmInFAYPgWylJ68+ukXV7wNdrSH19lIdF9y5CnGUq6pXnMCmUho76r1GCaM7MNrNLjFLmHGl7s0D7kX0kiHM+Dmq8Wlo9yQVvQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132767; c=relaxed/simple;
	bh=Hw2l+SM+6/7rTA3960MSyjQ7M8RDG1rDl0U21kueAxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa/XosJffu3p5Wln81Uol/Gy0hJugc+FNi0UqkLYxZPW/XYh3ctCkHbTJI1PdwHxxhsjEA0MMyE9idcxbQvbNDKGvYGAM5UOwl6sHp1j07dhNOyf+t5pChVD/UnGmSkk5k2DIfsinYC/BrcaIwUQ5ylewL7jQQ+w/DR8qR5YXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CT8o2J0Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT8o2J0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779132763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nqk72bG//fPU4sQo4pIFsdxIJ3sb1ha1IaNOs+/lbsM=;
	b=CT8o2J0ZeKMVznsnjiPhmkRot/zahqhH+ym2CMLEDu+fi5xfN3GHEJELNIGIn+clKmvaUq
	X6vr8pJyEMexF9Qna2CPqUtBtYDQijh01ZrwjqDIhZicMAV3zgr+tU3OtqzUVfdNhbb9G+
	fywy+ZeULAWyVoRakwLickGUeDECtS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-SDOxfBqpMNCBceTnGg7BLA-1; Mon,
 18 May 2026 15:32:40 -0400
X-MC-Unique: SDOxfBqpMNCBceTnGg7BLA-1
X-Mimecast-MFC-AGG-ID: SDOxfBqpMNCBceTnGg7BLA_1779132758
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F27C01956089;
	Mon, 18 May 2026 19:32:37 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.65.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D4E51800357;
	Mon, 18 May 2026 19:32:32 +0000 (UTC)
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
	John Garry <john.g.garry@oracle.com>,
	kexec@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 2/5] driver core: do not always lock parent in shutdown
Date: Mon, 18 May 2026 15:32:01 -0400
Message-ID: <20260518193204.14273-3-djeffery@redhat.com>
In-Reply-To: <20260518193204.14273-1-djeffery@redhat.com>
References: <20260518193204.14273-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Don't lock a parent device unless it is needed in device_shutdown. This
is in preparation for making device shutdown asynchronous, when it will
be needed to allow children of a common parent to shut down
simultaneously.

And only acquire a reference to the parent device if the parent is to be
locked.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Tarun Sahu <tarunsahu@google.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/base/core.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 127432248165..6e2c37115bc1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4795,13 +4795,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
@@ -4824,10 +4819,23 @@ static void shutdown_one_device(struct device *dev)
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
 
@@ -4853,12 +4861,6 @@ void device_shutdown(void)
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

