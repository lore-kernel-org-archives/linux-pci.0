Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514722;
	b=WpTUt6XW7HwApsgNUHaoyarMnoV3eoRQQHfamXN9z/fZm+yrdCLfayUTpJhBaJ/MRlHH
	 6nGxR7T6r880ru7YriEWcM6C0Ywst/ROLYLJp/Dtdxj0mFdpFJw0ZvHpEeL7i6QAlhU7k
	 71bAqMeyVSA1GkB9MPvQm4lkarrDCKmHjTY6WoSI3lgw0o+tEt1hLcASxMfNZklpegmrz
	 YqOGP8Fk09heKUy+jVliX6MKPsEyh/WstIvNgqPu5F49Av42Qo6EMFUWuyIbs1z0anf25
	 nAM76jOt86qYahsfy/tC2486tx1ND3h96XeSMkzplA/FyZa0Cwf5XArBoJpNKdqscXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514722;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=J5XvO9ED1PnQW6LvxI91yeoYZ/9/NbKN8AWis2OJ8FM=;
	b=2GehkXQmaRupJI+Qsy4UJuo79a8qd1dST3SG/Z2yN0hX8ef3OYI7qc3JaP/L9ksx+jew
	 e3sOdjmS9NYGS9uKJNe48slOtCDRjSLeBdwznkyVWDy3fNwHFAZHy5R6praMULnfF+kne
	 f9IGt0hWIdAnTIbBI7YuIbhmDMflh5o/R7uxWtIeWUbbmBulzBI75Q90JS+7jqm4597q7
	 lKTX28X32AOBr+AY4Haw+x++e3+Pnj7O3t3JA96D2Wa16yuVLlbmx+l4WL8i9aSpJ757K
	 HCP7j7oEaRgyIPpKn+u5QlZ3r2d1Pvzsz7c3BmfFg1z2wYSPPCPu/KLBz8twJfR982g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q4zqFChA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398560A6F45
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E398560A6F45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q4zqFChA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792514721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5XvO9ED1PnQW6LvxI91yeoYZ/9/NbKN8AWis2OJ8FM=;
	b=Q4zqFChArWpk45SZD+drQGBv1fw7OfXloVMFHRL9U19QDI9KjMdqZrlPp6xISzWDkTtidM
	eoqfremzAi6lE2kkQys/x9IC5l4oKytp0kiVplarMnEpllyfmYZiqiVnQDL52lgmxDe4al
	79vl7Y1SrOqBJsKNNU0qOPCCC9x0kPQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-TlZSv--DMT2Duq_tJQJIEQ-1; Tue,
 20 Oct 2026 16:45:17 +0000
X-MC-Unique: TlZSv--DMT2Duq_tJQJIEQ-1
X-Mimecast-MFC-AGG-ID: TlZSv--DMT2Duq_tJQJIEQ_1792514715
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61072195C25C;
	Tue, 20 Oct 2026 16:45:15 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA14130002CB;
	Tue, 20 Oct 2026 16:45:11 +0000 (UTC)
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 8/9] PCI: Enable async shutdown support
Date: Tue, 20 Oct 2026 12:44:34 -0400
Message-ID: <20261020164435.80499-9-djeffery@redhat.com>
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

Like its async suspend support, allow PCI device shutdown to be performed
asynchronously to reduce shutdown time.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..101a96718acd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1038,6 +1038,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (err)
 		goto free;
 
+	dev_set_async_shutdown(&bridge->dev);
 	/* Temporarily move resources off the list */
 	list_splice_init(&bridge->windows, &resources);
 	err = device_add(&bridge->dev);
@@ -2748,6 +2749,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	pci_reassigndev_resource_alignment(dev);
 
 	pci_init_capabilities(dev);
+	dev_set_async_shutdown(&dev->dev);
 
 	platform_pci_configure_wake(dev);
 
-- 
2.55.0

