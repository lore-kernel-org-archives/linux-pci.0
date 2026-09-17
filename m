Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197A4F5DE0
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663088; cv=none; b=Ju0jK03JLsZxWcI8b3k/7mQjhyCsYmhMLH4E8vSbLAbuRcxLgSueI5FCGAAQBfGfgnoLpsICgca8VO/+brhU1B4n+jFMUUBeMruyN5sCbrWt0GEvIWVT7cVq3gtpf2ezmCNTZs0rmgIB4Lwf77tw1A9PJnjWqgVWFsdcOqhhQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663088; c=relaxed/simple;
	bh=CvVkhhBXZG0ZDrJsnmBXLSGYgGyIZi2GM0825+aHLdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qArVY5lM3XViTasoaNs1ZvhKwmGzvo1OPoxE5J4IZJMkzVaihpPtHFOXl2DNwvNzy+7F0Z0S5JrygkrC/iPjzNCPcMX389ouSUpUWxhlaFcqmmHRaJLvwNvIH5tM2F0d9MLPt7F6846UWitJmv5GbMTrlxUppyS49aon+GIKNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rmpjcppn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rmpjcppn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4w5b49VFjE4E0AFoA0Qcj7jylDcxSilk3hvFC5nqKA=;
	b=RmpjcppnVLH3j9FcHtxu5IYYZh1zGH/YRjIlg3Ip1A736b+/yRbXHliJItTFvNZuBm2l9S
	Kq9hG+zvFn3x3Q1/264ydeFHZO6+fzBrP5WjV/7Y6jrCr2a6xTuIYTqX18LfQsZwei8sWT
	M6o1n422YPH6izmMSmBqGb+4k8ZMc9U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-bOGKzHNkPFmH3dTNlkqmpQ-1; Thu,
 17 Sep 2026 12:38:00 -0400
X-MC-Unique: bOGKzHNkPFmH3dTNlkqmpQ-1
X-Mimecast-MFC-AGG-ID: bOGKzHNkPFmH3dTNlkqmpQ_1789663078
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C6221806D31;
	Thu, 17 Sep 2026 16:37:58 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.rmtusga.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1189A180035F;
	Thu, 17 Sep 2026 16:37:53 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Tarun Sahu <tarunsahu@google.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	kexec@lists.infradead.org,
	"Ewan Milne" <emilne@redhat.com>,
	"John Meneghini" <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	"Bart Van Assche" <bvanassche@acm.org>,
	"John Garry" <john.g.garry@oracle.com>,
	"Jeremy Allison" <jallison@ciq.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"Pasha Tatashin" <tatashin@google.com>,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 1/9] driver core: rely on put_device to free dev->p
Date: Thu, 17 Sep 2026 12:37:36 -0400
Message-ID: <20260917163744.191748-2-djeffery@redhat.com>
In-Reply-To: <20260917163744.191748-1-djeffery@redhat.com>
References: <20260917163744.191748-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Tarun Sahu <tarunsahu@google.com>

device_add allocate private_data for device and assigns to
dev->p. If device_add fails in later steps of the function,
it cleans up this dev->p which is not necessary because In
the next call, put_device free it anyway (if reference to
the device is 0 which will be unless someone concurrently
get the reference to this device).

This avoids unnecessary races introduced in system. After device
is added in device_kset->list by device_add and later steps in the
device_add function failures occur, it will free dev->p manually,
while in between there might be a user of device_kset->list will
take reference to the device just added by device_add. and might
try to access dev->p. So relying on put_device to free dev->p
prevents such problem.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/base/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..83263e3fa5d4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2618,6 +2618,7 @@ static void device_release(struct kobject *kobj)
 	struct device *dev = kobj_to_dev(kobj);
 	struct device_private *p = dev->p;
 
+	dev->p = NULL;
 	/*
 	 * Some platform devices are driven without driver attached
 	 * and managed resources may have been acquired.  Make sure
@@ -3828,8 +3829,6 @@ int device_add(struct device *dev)
 parent_error:
 	put_device(parent);
 name_error:
-	kfree(dev->p);
-	dev->p = NULL;
 	goto done;
 }
 EXPORT_SYMBOL_GPL(device_add);
-- 
2.55.0

