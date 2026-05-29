Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E23D090E
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053140; cv=none; b=p7WLjBAuk1dWz1CTQE4J2a8K3eep+qt37y3NU0QYrMfnCe9cdCT9KOaAxBbGYNHcCt4eWNuONE4hkK6TRQbwCu89r88ARwt7gujwpGYblIEzR3PSrC3w4IIuuQCvx/RdiIy5CbU+hVS4Yqg+9tjacyYRahR3Qr+epD4KPGr7E3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053140; c=relaxed/simple;
	bh=QMWF1Nn5UhAxAEgwX3QVOSlhArpqB7BokO3nvPMLRNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4ngmTVJOdAX8va5HvGFQ5pk4/2iCabBdQrM1/DNB6pkIe3T+xo9Kfv8Qj8vh/s4tfPEOpbW5dNnAVdhIwi1effQoxWGSDEEM2Ij2rYyGbmscsaX2/9MuSVQfMuQNGHi/HQvcMuWDmBB+bODvBTGyi3/oRuefZ2QtKEMJJYFYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4ZO5Kis; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4ZO5Kis"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2babbeff9e4so154495745ad.0
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053136; x=1780657936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1OhefJlO7SddiDjet5+3aQQ9KCjHVV2cUEJthb1Tt4=;
        b=H4ZO5Kis1MYZqmLHyWql4WPlWzWcSIcICNglPrLf9MdVyO9T59gKRvnWtu4auFdvl+
         QLtYdeqqQJ9MAGSTof7thaJIpsFcFOO3eQ/ZDddZLqMwC/1nFCB/Tykfseq6Rx75aInP
         8OpeXeVEjbYevf8yMs9doqkTwWI2G1qGnyoTk349ke+OKoAcGYThU4mK/dxO2lmmZuhj
         xiPu2ZMDYPkvSkpSwdDgZXPnpRaf6l1xFCAlH4r4FHtf5jY8PLSshVh5DUBHIsv4pvjL
         EkCZoL5mnnR2rHEinQmB0gILz7mqtRd+SbvVt9WYxgvdH0Qg1TR0xqaEmECK/9YUwx8x
         E8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053136; x=1780657936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1OhefJlO7SddiDjet5+3aQQ9KCjHVV2cUEJthb1Tt4=;
        b=M5i3oMCdjqQ+kgsbp//M8RvOV8g/bX0FxElVn2p2K9fHZHpx5b3ZwbCe0jBDPlTSEZ
         zfi8IS800cHPLxWqJPyhj2WQz26ibltwUXq5QUTcVz7DAJQpx91pH32Zsnn9gCDHyy1d
         kFIy9b2beeaYFlX6t4avVxYjywmyGfc+O8HQyUJwTN7ih58oKI9YQ7ZiuZHrXsj2OwQY
         LnQKOgq7XqswO2akY1zWjMbhXNag19KMZcbV79euzBmNfT7OUdV40mjR3IkRPqmuldTj
         syD4MngnVmduyWkx1PpaAR2NS1C2Yzjctsg2wYPUhqpMA8rBcEmrXPAON7cBep3XRE21
         K1Pg==
X-Forwarded-Encrypted: i=1; AFNElJ/nDld9BtMKAKO7E7CBpDz1BoJ0Ksnihq7Rq0uaBmbJiGE5F3J+/XakYiGcyst846G4zL7DxN56uSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVDUEQY+9/Twb70GIvScKYWKF5WSuswwcGE76C8RrD7J0Lq9f
	b/ibw9Hc/Yc1Jo4gDScZHnJmTq80j3lN0+mAkxcl10AHdzGHa07yBTLMHsDeSXbdA1DZrUBlWyr
	bbA==
X-Received: from ploe7.prod.google.com ([2002:a17:903:2407:b0:2bf:a0d:a7e8])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cc:b0:2ba:838b:bfae
 with SMTP id d9443c01a7336-2bf20dfae24mr24843145ad.18.1780053136322; Fri, 29
 May 2026 04:12:16 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:04 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-3-praan@google.com>
Subject: [PATCH v6 2/6] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

While every PCI Function that implements ATS has an independent ATS
Extended Capability structure with a Read/Write Smallest Translation
Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
driver to configure the STU on the Physical Function (PF) before any
any Virtual Functions (VFs) are created.

Currently, pci_prepare_ats() bails out early for VFs, assuming that the
PF has already been correctly prepared. However, this creates a potential
mismatch if a VF is subsequently prepared with a different page shift.

Update pci_prepare_ats() to validate that the requested page shift (ps)
matches the STU already configured in the associated PF. This ensures
early detection of incompatible configurations and maintains the kernel's
policy of consistent STU sizing across all functions associated with a
given SMMU.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 679a3c3c1d54..9cb23780093d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -73,8 +73,12 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	if (dev->is_virtfn)
+	if (dev->is_virtfn) {
+		if (pci_physfn(dev)->ats_stu != ps)
+			return -EINVAL;
+
 		return 0;
+	}
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-- 
2.54.0.823.g6e5bcc1fc9-goog

