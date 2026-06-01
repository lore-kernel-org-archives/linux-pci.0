Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72723B992A
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324619; cv=none; b=WeSngQYmDsX414ZsBYrt23SzmSSnnIhYgnP4iHABEg8rWdOW4b8XcEUPg+Vv5dNwPesj9BXiF3Dwce9iW4Hl+UyaygKgjjgPg8PgUERoALg6J93sXPVBzdqiE75AwkQ4ygfj+ZZVL/hY9grix6teWxu70WChU0XEkbCMqi2bY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324619; c=relaxed/simple;
	bh=QMWF1Nn5UhAxAEgwX3QVOSlhArpqB7BokO3nvPMLRNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YNFMPi3LrHP9D1WCmJMGnS1xhBI6KCogHDSDsiPsUzHqtbeewuCeftdy2Tph2Pb4kZZzzN5ctcjDQMIaBNEWfgaaLTHSZP+m8iyG7jFnq6zeQfWVl/4FilRTpjWdjsa+F0JWM0PV4x7HaC6LkFmlPTKBAR9YFIKxgLeYNn3AxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVCT+JHy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVCT+JHy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c32faa62so26773565ad.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324611; x=1780929411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1OhefJlO7SddiDjet5+3aQQ9KCjHVV2cUEJthb1Tt4=;
        b=eVCT+JHyenGFqCgVyc/4CTD4IFnXkGAa0S8CSPEtkwOTHyOdMb0DYJF45+sDfj6Ilh
         C+5LxLVvHWomwYV9LqXq8Da7jSnBINC9l4bdtUbr3BbtUjC+tPCRnJzRiYlkIBLZM7F3
         tHz6yfj3vQW9ivz5P8PVryq9qf2eg9AVVx3izJGsUseNFX0pknhzlIul/Kf5D1KffO9V
         Bo/jTiHrfgVfJv029T2BAlF4WBa0MRPVyR5+1kLdygQi2X4vq/rZI4I9MAWsPIlpwuI8
         nrkcCEX5jqyq1i1CB9KD+J/C+p5mqZulQkNvCIaisppk2RCjbWayiyumc27HjNdogX0w
         EmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324611; x=1780929411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1OhefJlO7SddiDjet5+3aQQ9KCjHVV2cUEJthb1Tt4=;
        b=sxXDPlmTpwCkbxLfPvDDvBZ0eyUtlOSTN4usTzSumZJOMMIXzAtQKpChkGSiRlNbDb
         n3ZTI+aTDyUFXLACN2JhyB54xgLHT3npUri0bUfSKIMIeUN94lccfey/B7OmrLPk1Lo3
         R4ziG/nClZwKgWibgfi5FB/a3/M/0YvVNpQFb7yuX1YhlIh0JKzBn1I38992e93V+CdT
         xS3P1wAR0EeP+4m+FeNdjXvEChwmixEQCIusPpTlS+1TEfzkhsMDhPqIepoe2rOjzrlJ
         HuRv+JPFeKXYaeSecz3VnCT/pRNqZZO2R9Q8odXkuqmawD5R5S0/314J0CrLG5svw9Pw
         838w==
X-Forwarded-Encrypted: i=1; AFNElJ8xNvfBeKGoa1mwRHUIDkxIys+PKAsrp50AwhAfkD/YizAuyPGJFjoM0aA0U06zRWaLwcuGC0Mkv2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKyG9WQxweTL/cdSIvHx6dzILESaVfxHDOSu3B2sDXivOvHeU
	ub3BI/HHajIuVSs3wdSK6nBQWFTfPCOlU4t5lG2CkXYmr6w7/8uStUdQL9+ZfAGZAvP8WwMIdpA
	EyQ==
X-Received: from plqu9.prod.google.com ([2002:a17:902:a609:b0:2bd:106:8ad0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22d2:b0:2c0:a360:45e9
 with SMTP id d9443c01a7336-2c0a36046d6mr119940385ad.29.1780324610786; Mon, 01
 Jun 2026 07:36:50 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:41 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-3-praan@google.com>
Subject: [PATCH v7 2/5] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
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

