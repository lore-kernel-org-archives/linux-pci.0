Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C261EA65
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999841; cv=none; b=BRTVWrDUgrmUKEP3JTosBAjTRLMrxroE37nIAYXRUJ8Q4Q0VO+5QFjoGkYZwZ3V7YEkRsMnACWVHsytafBzueMZk7NFxa4jZAqvoGTOqqyaIk9GTacW7yomM+oXkDiWEHeCOqJI2J0SNM+y4txk6oMT5x2hU1uXOgZj0HngAJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999841; c=relaxed/simple;
	bh=F6ojs5rWNCGgcIvYOOYdZlatLwDA9SzzUTg4lrzHeVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQ+qibXd542v+CvU0g1fjUWC+/DOqYsTNIHequs2gprXa9dPzNf6H/Ypt4yXlS0eIg3LR+1HyX9UvCCn4QPhKq8Q41/pqBk0XeuBCGiPrjEQdJt2ojgjzUCVCPUE2iu0QXTocVh0vzCMjWGqmQPw9WUjPOnFOLJAZ61qMVVoCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvSwoyyN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvSwoyyN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82ba4715b6so14148022a12.2
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999840; x=1780604640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6562tSqUW4FPLuBReRttsQP9VRgygDGjnIRvKk2fg8=;
        b=VvSwoyyN+GKnZnCoQFZG0a1ZwAKS1K2zKhN2nrM5HO6J+qyYKHRaJtqKj+iL1RD8Ue
         2RXNCLkIvVxoNaNRUTFCNH44BN/gPeWxH+pwJX7Lenq9ykNnWrUlduirnvjXaH9vADBP
         fn/RjH2lYPSbZPZ8oaA7uH7Y2JkJ7y0k1wWFntwTg+VjyW27NBb9+Mb5+otHd/6tvRwl
         z3bJADsocc8Z5VSa+p3WwkPSpWiAwKrkIlpcuyFpQjZ9+tyTWGqMoR/5LrqL1v9cnQGp
         d5Bb2M12OGAn8nzLOO68CkqobAxu54MZ9CmKkmCuHSAhPaWajaugDyxp3lBXPFq5ZK4h
         LTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999840; x=1780604640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6562tSqUW4FPLuBReRttsQP9VRgygDGjnIRvKk2fg8=;
        b=IZj9DFESyce17TSvGW6pQgT7yUqgbnObVv7EJgZ1Ae+vXLnn2Wy/4UOTeZjBayxqPP
         F/h0+46BGwMBVgvdbjUVK4wC5YGwi/fqxC2H4ckXoifUHfssoE+i7XtJp/nWWwhrwYzk
         sDn4rrNE7C2GB0HVrxhTwoXVcOsTCQGQ5GqgBBJXbptqdbdU0CujdJzwDFNJrdHy9qS7
         SgSEoyD5GCcLSrhJQyWiGI7epAOrfr8YSSgqKLyFzeLbzbPEMZVnnjf/USw1rzn2fLgU
         MTUeWyCdBGjBisAWlzE+CubTzKvIxaxh2vSuLTTtYkRC1GIsBCfdGmXt9THSmepiRQxm
         G1hg==
X-Forwarded-Encrypted: i=1; AFNElJ/TsfZsZ4qqCLUEjXHIZDlg9gJ+sDGGElEB0tw9x3sMFI9I9AaI74sPm1PvUy3l3DRLjl4eBTDOCiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrnQ3eg6YEsS/EI4awVLy1iC5kCUXNjB0X2PqY2PbMMhfIxcpZ
	TXTWKRNkKk6vM1fVH+Fsn9jLL7XF9F/K///W4nVhrFozRQxXKGAiFmo1R+MVwbFJZHTjEfO13pm
	8cA==
X-Received: from pgk38.prod.google.com ([2002:a63:a26:0:b0:c76:9c2d:449b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:648f:b0:3ab:18cd:7da3
 with SMTP id adf61e73a8af0-3b40e2c7eddmr314116637.1.1779999840003; Thu, 28
 May 2026 13:24:00 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:48 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-3-praan@google.com>
Subject: [PATCH v5 2/7] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
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
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 679a3c3c1d54..8057c24b0469 100644
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
2.54.0.823.g6e5bcc1fc9-goog

