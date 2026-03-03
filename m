Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A483CF68F
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572540; cv=none; b=TZl7FnZb+cU0VM5juInzKpY1qkNC8Nj5PL6YLszaa4alImdQ63k/O1jCFk9PSooUZ8Fe67d++VDgSwJDCcB3T/XJyjS3VhCv98lfJs8zYnvT0KkELIdSSd3tGsD//CtlJEWzpuAGwR1B5OSz1d2Caj2sjHwrLKKunVhSSwUzb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572540; c=relaxed/simple;
	bh=WKMW8HVlmZaoyJE5jsAXtcRs0N48w7Ua2f/NenCBzOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vp8sgfIe752Uriu6J+dJbGB7C7iBvhYLFdYgyyifeEHxq6INI0adz8NZbek97dmwmSq2gvufYeTjH8RUNddphOTCDKpb/JBuA3mrimriQ3dHgmplUmCur8nMD3z1nvpx7c0+HKWKlKw/fALqG/h5ABlOcVgN+3kfZfTCab9Bdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCESQA4c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTJQV5ya; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCESQA4c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTJQV5ya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772572538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irBf4YUdN1+vibh8PKUSXKnT1yGXKOqgKyvxp0mJGPY=;
	b=OCESQA4clh8Axb1EjczquFMRnGOxVQ0eJn0FXweTVNSIxFkuzc2tNJ9bFvcsjNAOLNxk9z
	Tzwha96xnUDt8Puun9MztQK61kbNN+O9W/1yep/mDbg01mbH1wtQMk3u13R44FXdv7jg+o
	TRHQ8bldEBnrh6Kg+VGFCL1XExIfl38=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-B4eVtBfSOLOjAY2HfrT8zg-1; Tue, 03 Mar 2026 16:15:37 -0500
X-MC-Unique: B4eVtBfSOLOjAY2HfrT8zg-1
X-Mimecast-MFC-AGG-ID: B4eVtBfSOLOjAY2HfrT8zg_1772572537
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-506b4bdde91so469737601cf.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772572537; x=1773177337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irBf4YUdN1+vibh8PKUSXKnT1yGXKOqgKyvxp0mJGPY=;
        b=HTJQV5yaVlnDZ5xdll+PAyeLHEytyuDfg1D/1OB49HfeULjVhaBBEvfePuBR8sLkcQ
         95wQt/Wj14ZOBv5RT1pThdbZzjVvkqGok4+2iFXnXpkaEI3GNyod9Qk5n6neeeJhqTzD
         9Dbm1Kn8HDTJq2BEIzNTUGyFcqoLt3/XAWV9sfCNHQvjYwnC0dNhIacds0rEzyEJUq8K
         qFMGWZZm5Sg0g7X88/8FdMWJiFMmlHlP1JDAIWR/WmJFKGnxfCfwSCywEXFxstokE8m7
         plBBUXte0yTJ3AfAx1Hk3YCvoDukHeIQaCzeuQGeRKr8Rij4er46OUfg3HGt2rT46q4+
         8+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572537; x=1773177337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=irBf4YUdN1+vibh8PKUSXKnT1yGXKOqgKyvxp0mJGPY=;
        b=D1owwHxuRV+WGY7QPhVHRJ2qaax+OD9OWAo1BvGW1HwrgEcZ03vTUHBFag3mtR9ePP
         SfgPYMqE4ymw34OTL1KyCvwIwqKKPsYoAp4sT2JGjgOOApUh2ybeECBw3KX/KIbRc/AY
         LNzgjRsREa4pS6+43V8VIQ+kKCWhZyKqsmGwR2w/KOFTG25pGallgbrhhY+jSN0LuduW
         Hc6PxpptVDbN9sJm8xhxBdYj8G5trfQg7gTw99tZp1WrVMDr5mkyOzoMSHrgi4uab7JQ
         zvpt1CV38Yd/i6rp60iLZETcrJXgZFqf4VeerqGRbfimQgN3HKuBehPvG6uFhnKm3yCA
         XzuA==
X-Gm-Message-State: AOJu0Yxm1EkOSaymaJUUAptonRz2iR+Mj6vkwYr8Ek5B6PBh8kIXzm0k
	kqhIFDVKqTiVnjap0IMYXTRbSOWPjON6t1LD3g8BNHDd7pqJzpZaRKDWkxUFqUF0vAm1JMGbTUZ
	ZSeEt2+Uft7GenIK6y0Net2VBsheyzB0juVwzVNkRhaSd0DDjltUnMjNIxO8Dbg==
X-Gm-Gg: ATEYQzxB4J+y9rQAarVxvppV+Oc9+K3ICSGOJZ9wi/xAeOnuwtmOxyKKOc5Jm6+qtny
	p5f4prLIALR2OiG8AQhy49DyNaE+njs1wuVchh61iCJG/3dsXlEs4zWBXCAarZ2pzAcBCGhjHGQ
	lQuMkIiFJMYwHp0QIpJdhiiEUtYWm7f9OVPz7seh9RGJ7uhak9XkirZHPj54+GqeJOtc9s2lJUv
	z2enm6u3xGApQ1U7qlV8uvh5boJ5RLj3pKohNlP3u9qztWbsVm5+QyBkaky/DitdNe3Oyl7UOi2
	lL+pU220YcT9UaOstBEve4UccuOT0Ze73JHs0TvJJuAzhWXRziDXK9opMqxI1bjqzXVe6QzdIVi
	cvug0dLX/SbTDtDeuglD09idzxw==
X-Received: by 2002:a05:622a:1891:b0:502:9abb:c919 with SMTP id d75a77b69052e-5075287910dmr225478041cf.10.1772572536422;
        Tue, 03 Mar 2026 13:15:36 -0800 (PST)
X-Received: by 2002:a05:622a:1891:b0:502:9abb:c919 with SMTP id d75a77b69052e-5075287910dmr225477351cf.10.1772572535732;
        Tue, 03 Mar 2026 13:15:35 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e3:9a00:3c7:56c2:f819:96d2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm156286991cf.0.2026.03.03.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:15:35 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Tue, 03 Mar 2026 16:15:22 -0500
Subject: [PATCH v3 02/10] fpga: dfl-pci: set driver flag to disable SR-IOV
 on remove()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-rust-pci-sriov-v3-2-4443c35f0c88@redhat.com>
References: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
In-Reply-To: <20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 Moritz Fischer <mdf@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
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
index e25205c6d8f00cec579016acade28e743812c924..2410e6f3efe100a635eebfdb21f28f62a3759890 100644
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
2.53.0

