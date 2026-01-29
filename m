Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12690361DCC
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721954; cv=none; b=bzqD6hhghnfzokiW7hXLhyX7UxpE3FkA8fT8BhmA1g/4REm/wCciQElomknHtPr8nbXB9apA3v3bOKz94TQRPXpZgjOfy6tyYRydi/2i+o7+yc1NwZTMPQiN3MfJ0k1nrNgtj2rzVRgwy3RG3PNwtAkguhJ/DV90OU99srPvqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721954; c=relaxed/simple;
	bh=s2EF+0wW+b5BmyDvXoLeRzuJ8QMd8hJHZ8kLYdzRY0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vEP7th+1UILTeIKAYfe3JiCSdghEJEdVHl3ujkGOoFNdkOGYVTio1zinO9BZ4/M5tx+GhZtNvuona/rZpv3eb+Bo+9UdetYsasK8wogcawNogGvE+/QRk1wdmeY70kro2h5e5W6hGlHBbN/YKBhONJuqlvtHpJyV694Cw/9Lj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjNid7Wr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjNid7Wr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0f47c0e60so31869295ad.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721949; x=1770326749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVUDzL5NEoLRiR0kq4rtjTLHEzT2c4a+QSQgWmkEpoo=;
        b=MjNid7WrOyEJT1IuYZdcgcGfdihVHcDFOUlYLCAAuNkFKHRth/gQaAA5frJ1KHYwur
         kM5Z22z3Y2+cE4N4p8JS27nWJCBRsTo15KFDUdzKxCnr6PYbR/4o9j8xOK8jCAyIoh4A
         KE1IC+P4h9JuZCG5aOio+d3OVeBq448eX7STBsLxM839FCDNyTuzboldeBZWoY/cx3EN
         N/RyJkYmSyCdlyGvL3fffoA8tswrFrLYVO9wRG1b1ygGrn4YWuT4DmmqPFuE/rKfHO9c
         kc2UW9GgqiJvZcyH9VAK1bNVrAQnAM+CshOPTrugIaT00cEpaW/uHFdi20QfcdmEl8bA
         Ovrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721949; x=1770326749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVUDzL5NEoLRiR0kq4rtjTLHEzT2c4a+QSQgWmkEpoo=;
        b=GIz4I3hYBD+lr7RMPBzdQLek4c244NvxHXIgMsoKLPCkWlBNW+uAbMezbYk8yNlVsL
         jmR6y86E8c5rbLEvQsk6XSj9QLek07Pzze5b6iErlFiAVMMUMa98oErVS3iCsy+cn4bH
         skk/F8D+cNFzt4jp0QtO6ctmtmK1XbQyupvMVDdinoOZyz1NgRUx+SYo3brxzfS7x+rw
         wPDYF0JW9kZXZyEO7Bwn8TmHZvkBahu0oufnr/COUBBLNek1eY0q4828+jX9aI3YVxAU
         C2TYu6wp9D0ZPZe9fkvgU6UJgbR5M4ZtGfYk7EGRGSUtz83bIpZLzMGUyX4Kdv6btRR9
         /6KA==
X-Forwarded-Encrypted: i=1; AJvYcCUeBjgaez56oqC4M/pTzTcxMvs8/er4EsEYDk7HgPF76j9smhx7XHz7xIcv7FsIt4lY+0so3IlIP7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgsvIZqOcKPf31tQeXctA8KLXBxTFKadYe6OX1astNRZ+9PGZ
	SdROiKaphifrdsI9FrN5RiLlCz9LA5SPJGrVw5LOS7TzH2OfxaG6p5pTeF2KbC4Lc5Ht1LPAqq7
	p/jEk5C7XWhj9Mw==
X-Received: from pllm10.prod.google.com ([2002:a17:902:768a:b0:2a0:a0e0:a9c3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:124c:b0:2a1:3ade:c351 with SMTP id d9443c01a7336-2a8d959a4bamr5657375ad.2.1769721949051;
 Thu, 29 Jan 2026 13:25:49 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:54 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-8-dmatlack@google.com>
Subject: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Notify the PCI subsystem about devices vfio-pci is preserving across
Live Update by registering the vfio-pci liveupdate file handler with the
PCI subsystem's FLB handler.

Notably this will ensure that devices preserved through vfio-pci will
have their PCI bus numbers preserved across Live Update, allowing VFIO
to use BDF as a key to identify the device across the Live Update and
(in the future) allow the device to continue DMA operations across
the Live Update.

This also enables VFIO to detect that a device was preserved before
userspace first retrieves the file from it, which will be used in
subsequent commits.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 7f4117181fd0..ad915352303f 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -53,6 +53,8 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	if (IS_ERR(ser))
 		return PTR_ERR(ser);
 
+	pci_liveupdate_outgoing_preserve(pdev);
+
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
 
@@ -62,6 +64,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 }
 
@@ -171,6 +176,9 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_incoming_finish(to_pci_dev(device->dev));
 	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
@@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
 
 int __init vfio_pci_liveupdate_init(void)
 {
+	int ret;
+
 	if (!liveupdate_enabled())
 		return 0;
 
-	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	if (ret)
+		return ret;
+
+	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+	return ret;
 }
 
 void vfio_pci_liveupdate_cleanup(void)
@@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
 	if (!liveupdate_enabled())
 		return;
 
+	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));
 	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
 }
-- 
2.53.0.rc1.225.gd81095ad13-goog

