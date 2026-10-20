Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514727;
	b=qm9SoBDRjPKW7avGqPNPYBNGyxt4T5A6CcIgLkTy6yekcAItalesYyhk0lkfFpMSWjM9
	 bMqXSMwI+v9Bw1C5pWNt9hWpSrNabxk3R5pzM1ViO/onhudyVPx527euPGsN2TVVp0Gai
	 j1nvN0bCljBoGQN9HBeEhHEbBdaeUYKuH5gdkTVO56MS9qlS8RuA3IaX1KyxhJo2aVlM7
	 TXpgHrKPjyy7+Rhl7wSkwvFO1lkI0FSASN+ccrxgHmiUAdRWSKwlqqFUq0fsYXHmsQmtq
	 796jP/12HfvPP/8CaZpVG4mJeqT9Zq+uP8C62xeRSNIM/JwJoNTDSWEPkE8MLiSWiFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514727;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=exa5f/DcwNCR5E0w8unUqAO11f1n98HF5VNU5M/lSuA=;
	b=e0Yzr27WyFdFxjmAvHwNnTxgr2Pd8VvpcZmqnpMbe8NO5NrPp7lcGy0WIqMhYLrUZI/a
	 nStKKnIRYHeiWQk2LNrB/V9SUXIhzmmhzE46bGSrh8tlbB5fR8mKo9B0kbyxpEXsa67UR
	 86ooFuYmzAkY6uS79q6Lt71qOhJk9BX9Q61Chmuw9BhR76kmPmWrbmA+H7OTFajL/8hkd
	 J7C7sp/kkEYWWxv2LtA+kBfZt80kyvRkYkk/h+rruH7PeRq4DzKw3fiQ0cY3LRF9LhTrm
	 9DNJ1T2q7hr6sGwIRe/uBWP7G1TX681jYfuU7cVrlzZHJW9guLz6bpg71xCBJnmNGJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KVaqRBrN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CF60A6F69
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21CF60A6F69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KVaqRBrN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792514725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exa5f/DcwNCR5E0w8unUqAO11f1n98HF5VNU5M/lSuA=;
	b=KVaqRBrN4QNNbYzBRizJVaZchrrNJaI0gPi/PF3HZbpO+RKK7DXZEujfeng9mLD3Y7X/zv
	b8hSCshIaLrgtV7kHUSY67cXYJ1t4xKu3kDhVu+gOY2hE/S5rZrvA8EKuMofz5NceU3E9+
	5q0o0eWmZcYD7KB9AUb/9SXLmrmEh1M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-JrlojP41PRiJLgF9H6qwug-1; Tue,
 20 Oct 2026 12:45:21 -0400
X-MC-Unique: JrlojP41PRiJLgF9H6qwug-1
X-Mimecast-MFC-AGG-ID: JrlojP41PRiJLgF9H6qwug_1792514719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19F7D195C25C;
	Tue, 20 Oct 2026 16:45:19 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7DC830001A2;
	Tue, 20 Oct 2026 16:45:15 +0000 (UTC)
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
	David Jeffery <djeffery@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 9/9] scsi: Enable async shutdown support
Date: Tue, 20 Oct 2026 12:44:35 -0400
Message-ID: <20261020164435.80499-10-djeffery@redhat.com>
In-Reply-To: <20261020164435.80499-1-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Like scsi's async suspend support, allow scsi devices to be shut down
asynchronously to reduce system shutdown time.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/hosts.c      | 2 ++
 drivers/scsi/scsi_sysfs.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index e72055c1ebbb..75592f41ef39 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -272,6 +272,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	pm_runtime_set_active(&shost->shost_gendev);
 	pm_runtime_enable(&shost->shost_gendev);
 	device_enable_async_suspend(&shost->shost_gendev);
+	dev_set_async_shutdown(&shost->shost_gendev);
 
 	error = device_add(&shost->shost_gendev);
 	if (error)
@@ -282,6 +283,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	get_device(shost->shost_gendev.parent);
 
 	device_enable_async_suspend(&shost->shost_dev);
+	dev_set_async_shutdown(&shost->shost_dev);
 
 	get_device(&shost->shost_gendev);
 	error = device_add(&shost->shost_dev);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 9480432f650b..52e1e38dc027 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1387,6 +1387,7 @@ static int scsi_target_add(struct scsi_target *starget)
 	pm_runtime_set_active(&starget->dev);
 	pm_runtime_enable(&starget->dev);
 	device_enable_async_suspend(&starget->dev);
+	dev_set_async_shutdown(&starget->dev);
 
 	return 0;
 }
@@ -1413,6 +1414,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	transport_configure_device(&starget->dev);
 
 	device_enable_async_suspend(&sdev->sdev_gendev);
+	dev_set_async_shutdown(&sdev->sdev_gendev);
 	scsi_autopm_get_target(starget);
 	pm_runtime_set_active(&sdev->sdev_gendev);
 	if (!sdev->rpm_autosuspend)
@@ -1432,6 +1434,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	}
 
 	device_enable_async_suspend(&sdev->sdev_dev);
+	dev_set_async_shutdown(&sdev->sdev_dev);
 	error = device_add(&sdev->sdev_dev);
 	if (error) {
 		sdev_printk(KERN_INFO, sdev,
-- 
2.55.0

