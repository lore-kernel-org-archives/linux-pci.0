Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269E328B55
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325229; cv=none; b=Ujo8hWl9hfCrShtBH5/zBGVgvbnFKS4coCSNNAsmEy1l6danwMq23Msfp0YVlqELWNOa7Y8rZpG1oGSmk/yvoZovQAStefhuoho5bcoOrLW7kF0w76yyy5m7FQtbbMzI9jpooecIQH06ELGTDpAoHwabMsGuR5LGLyYCWLsDdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325229; c=relaxed/simple;
	bh=rV6qi9tLa8BSeGhd9naq45rlh6qRoKLszIak7MQlwuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZSLWJO3CzaWDDYKPNnevfa11+iAhA7bZCRSEQHyqSKx5S9tgd/HGjQMQjOlzc/qlHZdVtQeZ+ak+yoYmQumtu8yM1zXGVQ7uRMoJOeu6ilARA+/Z1mJdjR7yMexFnF2s4OtmYLf4Ezu4cbPxGc0jtj7biP5jpQP/vGF423ewEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObNepT1m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNQUL1jP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObNepT1m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNQUL1jP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770325228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bysblly79RF2LtPRkhZUIzq0xEXxTiQQ0zgHTCq8A+8=;
	b=ObNepT1mq8yMfb1Y/UcuH4xLRbyrUjhiIjztVdQUGbRKBYOJ3byMsVmGvWvmcz1f46EPQW
	d/uTJGFOhioYa+LTxUSanV8Ih/GRJAyGtJPPguNxiruSHutFrTfQhWjHb8VayRgUZTc9t2
	DYsWYWm/OjIQQIJ88kf0YDQeAtLJNjE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-sYLwig-yP0y1LaDP5V3eig-1; Thu, 05 Feb 2026 16:00:26 -0500
X-MC-Unique: sYLwig-yP0y1LaDP5V3eig-1
X-Mimecast-MFC-AGG-ID: sYLwig-yP0y1LaDP5V3eig_1770325226
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89462dd72a6so52555736d6.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770325226; x=1770930026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bysblly79RF2LtPRkhZUIzq0xEXxTiQQ0zgHTCq8A+8=;
        b=iNQUL1jP89zrmBUwVLtCf2XcxkBYGOCQKW2q/yXbwaOEhhuQ80Nj3Z/A2848uKzAWg
         whmXlMMeybeaoFBrQWWQHAVjVbaUWqWetgo7ORf3w75UskWm7vAYuPGVactwqscs3+9Q
         kIQtJ4yLCz6XCLkrymSYCJ72ma92TpElJ5rF2vk8PpvqD5slOfKuFH5UBhiB83hr6j1K
         6IFQBdK8yz48V+KnpdafVuHZwXFppsyhAZ2Kj2VbwJfCXXEdx5JnFT5kc2xSgh/D8rhl
         QM3H5nQOIL153PPCrb3bTpZj+UlbNpWKnGfjbntBrJkqkGwn7xnifOwBt6MaBbJ6OAZH
         Emlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770325226; x=1770930026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bysblly79RF2LtPRkhZUIzq0xEXxTiQQ0zgHTCq8A+8=;
        b=JXJ9N2iWv5YII4VLyuMzjrcyPDHwvCV/yGO698GbBaWAxXOS2lSs31ByqDzQzxrg1d
         lxdAsEcHhlVMNoUajw9zTuPunX+JE4D6l3tB1MMWVBKxBCkjQKooIqMPxNe5W57FagqP
         LS+s8/bRyn5sGmAzEWfyB395ze+jpfoRXSSCa97xm/7BDxJo+5WAE+mEXXwud948475M
         URX/5AQnsjLqWenlHtz0jj5EVHyOVYub4dTZ/AZ/oLF9htbB/JCjayAzAlWjpmOxXDaz
         9kzJEJ2ZU3PLME05ds9Cxjp+S9vb8DDFlmhM2E4rUucKCLzkyK9q86yrcuy811NRiVCl
         bbJg==
X-Gm-Message-State: AOJu0YxpfrWCPGnr3Kn0lpYefen3Dnst5lrvb5mbZZ4q15bz+WvPZlHL
	6CyiE9NW6GFGzBMrrTUEiWmPZIO54g8p/p5tfEAvk6ZfzWbJaf7/JF2rYsmY0q9mak6fzbRQ1gD
	s8AqL5lWqXlAuZ07PaoSOLpKEFPMc8eS/OP4kOupfx7I22dEjk8VdK8aWJj8/BQ==
X-Gm-Gg: AZuq6aJLxjjnKjzTE2ScxKVen9f9VoTpAfOtYlop1Pt/tI8mad/oYjmfy5mDr77paCm
	K4NZPTkaelcS3bv+lDbqxmz1Pnnaeiqk46I9oAuhh6iA4hhoXQr0qprSQL1IzHMTF4tX8OxHwwh
	ojEyKOpuwzNdq4nGLSCFiwft8uSCtFbI+QtcAo1rcPx5V1k5vInSt/BypLHgoM3pE30CCDy89aM
	X4UiTOx5OW++xP4PPFj67fclQRdsL+sxM3OB8Pww93mLeCEOwPQyd92Ih5AhpaNmTcj2ZsfauQy
	KYL83T84KdWlfrTFVzVWQqD5oqYjZXiL5qe/hiZoPYhmqToOii+ItHwqQonr8ArAa/nA/XT3mWD
	P1OZtDOrGb+JzNTs=
X-Received: by 2002:ad4:5c45:0:b0:882:6cd3:7f64 with SMTP id 6a1803df08f44-8953cc8c1c3mr6670816d6.44.1770325225668;
        Thu, 05 Feb 2026 13:00:25 -0800 (PST)
X-Received: by 2002:ad4:5c45:0:b0:882:6cd3:7f64 with SMTP id 6a1803df08f44-8953cc8c1c3mr6669906d6.44.1770325225055;
        Thu, 05 Feb 2026 13:00:25 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b010:9000:4c85:f148:4c91:943a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdf692sm17571285a.44.2026.02.05.13.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:00:22 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Thu, 05 Feb 2026 15:59:49 -0500
Subject: [PATCH v2 02/10] fpga: dfl-pci: set driver flag to disable SR-IOV
 on remove()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rust-pci-sriov-v2-2-ef9400c7767b@redhat.com>
References: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
In-Reply-To: <20260205-rust-pci-sriov-v2-0-ef9400c7767b@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, driver-core@lists.linux.dev, 
 Peter Colberg <pcolberg@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

Set the flag managed_sriov in the pci_driver structure to show how a
PCI driver may opt into disabling the Single Root I/O Virtualization
(SR-IOV) capability of the device when the driver is removed.

Merge the function cci_remove_feature_devs() into cci_pci_remove().

Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
Changes in v2:
- Demonstrate flag managed_sriov for dfl-pci driver.
---
 drivers/fpga/dfl-pci.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 602807d6afcc09af9e1d53368b41460ef86545d8..7965c307f9b79bdd2c2c3277d519ab2c4e701797 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -125,15 +125,6 @@ static int cci_init_drvdata(struct pci_dev *pcidev)
 	return 0;
 }
 
-static void cci_remove_feature_devs(struct pci_dev *pcidev)
-{
-	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
-
-	/* remove all children feature devices */
-	dfl_fpga_feature_devs_remove(drvdata->cdev);
-	cci_pci_free_irq(pcidev);
-}
-
 static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 {
 	unsigned int i;
@@ -425,10 +416,11 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
 
 static void cci_pci_remove(struct pci_dev *pcidev)
 {
-	if (dev_is_pf(&pcidev->dev))
-		cci_pci_sriov_configure(pcidev, 0);
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
 
-	cci_remove_feature_devs(pcidev);
+	/* remove all children feature devices */
+	dfl_fpga_feature_devs_remove(drvdata->cdev);
+	cci_pci_free_irq(pcidev);
 }
 
 static struct pci_driver cci_pci_driver = {
@@ -437,6 +429,7 @@ static struct pci_driver cci_pci_driver = {
 	.probe = cci_pci_probe,
 	.remove = cci_pci_remove,
 	.sriov_configure = cci_pci_sriov_configure,
+	.managed_sriov = true,
 };
 
 module_pci_driver(cci_pci_driver);

-- 
2.52.0

