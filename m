Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9121F4C8E
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198820; cv=none; b=AEjPM2sQqiOdRqrZATceio1aPNlpoyzmaTQ+5EHHLyXcpLSPh6RadfKkGXaDcXM/MQXdywYFp79/ryWZ0JHdR1Legp5aBqhrxpey+jL6pIrE8cB/7Qim00panz+8+wMHodtTKbwNWZTYsp79QDsCflYjHp0tivJ9mf201Kiy1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198820; c=relaxed/simple;
	bh=CwFF+RiM5QuQxYWpLDlViY1A4N1Wc9d+1x/on0eEkbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGRwIuvpaHTpkQFkk6t3ofmC9VIflVVs13s9sj8ee9EpkEdJkMCFWJvDyFsNl4Ykbze1jASxbMsBZVpdEejgvPLVjIbxuW5zEtsCRkn4yCroBgQrMKm7e5tKcy7lVdgGeHdZXeyhTH7zewZM1H69mKzdbnThqMY0KPPsXCL6aAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqVSse/m; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqVSse/m"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82726f7b0bso1790439a12.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198818; x=1779803618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWBOwL+HKQFniymTwRy/QPXq3vFl2Ebh684Oe2Ka/N8=;
        b=LqVSse/mKQVWkRxGWvWJNbz3ctK76PfSnz89Q5yjj6DmVjdKitUYtdJtmvfGZKfa5M
         jaKneMzKKK3LEG6UYxm8ARutdnWJO0Bjf3zi4KJNzlYppeJLqQopZfX7N5HKCKf8/PJG
         idmRdBIwhwe9tneZBASnMfmTM+7O2Ku7wzKhnLiz4iGxTV5QXafRkOmnx5MQq02uebQS
         7LNVfuL7rmmR+FBC48seXD/JlkosfnVW5mpDZPyRzJI5t/ebpoL/EhorTHE7GXPxuBr1
         EC/OIxxbPKGoNRHA1DFPyuWoekw2BhBzlR0eeAWQdA6UIWJYzzgXxAax0ZZ9h7V9GGV4
         AgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198818; x=1779803618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWBOwL+HKQFniymTwRy/QPXq3vFl2Ebh684Oe2Ka/N8=;
        b=gDYFJE7ORm9EV3R9bp70Tx2D5MGxXOhvOo2cTIEcj3naln6akoTKpfcrX1kcXSpJpA
         Al0Tn2WiUkbbX5od5/D80FYB4vj2YV+cI2fhBM46exYrY3skOr79EdYPbfB3slzjorMu
         3OwLr8CxM1tMZF/i8Bz/V5ES8Ff8M6lV1irGd6p7+YxoIE3TsIpOuc401nkWlOVdA74R
         4bTKARJFO2pGd7pZ4yXhVTBsXk2hq4CLyQgYsGJVqWQxZQ0X9PAwGZKuCSNMu8qxjxrM
         +iNIS+Dgla2g4TiKgD+R6mdwjf5NNb9wFVXLhvJvB2ckqic8dp0R2F4eP9kFHgzZT4v7
         hibA==
X-Forwarded-Encrypted: i=1; AFNElJ+EL7oNer3yy5avW18tORPgbpx6ialxwH2c43VifF25OqUtnWTbAmQ9X+CfGSf6uuspHzpieHh0nJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1bJ3aydElrlMPcJJRbufIga96jqcyxcDSg/4Nd5Am/Cc77Bx
	VlcU1A4nUdewMEBGtZ251cxFtFJW2LrvPggLnhwksXHrth21jWCXWEMdcq9agqgcwnWI+NJ2nPn
	Zqg==
X-Received: from pfes8.prod.google.com ([2002:aa7:8d48:0:b0:82f:a396:2232])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88d1:0:b0:835:6bdf:c87f
 with SMTP id d2e1a72fcca58-83f33c3353bmr18880796b3a.9.1779198817951; Tue, 19
 May 2026 06:53:37 -0700 (PDT)
Date: Tue, 19 May 2026 13:53:21 +0000
In-Reply-To: <20260519135323.1558777-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519135323.1558777-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519135323.1558777-3-praan@google.com>
Subject: [PATCH v3 2/3] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>
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

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index a5fa7745bce8..54319854bfd8 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	if (dev->is_virtfn)
+	if (dev->is_virtfn) {
+		struct pci_dev *pdev = pci_physfn(dev);
+
+		if (pdev->ats_stu != ps)
+			return -EINVAL;
 		return 0;
+	}
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-- 
2.54.0.563.g4f69b47b94-goog

