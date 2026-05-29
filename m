Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845293D2FFC
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053142; cv=none; b=uCIIAHx2pnAKYaRusH9NEBbveNWq05X3a214zNSmcPlMhKSGiMSl2Wa2o5bghpmuKUoL8pNMkcJX5TU5MlcVwNmDARDyBRMOtjx1pBbKzBFox8n6ym0lQ+v9XilCdjwZw+jUeeOAYtxH/PrSFtLhqvD3gZtb4j8LWhJMmVqAS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053142; c=relaxed/simple;
	bh=utNKQCvUkPmBqehTN/p5pEe6fKwGdjlepuYbZLj1XUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kr1XjJo2bmPhUUDPRKiPO5u7CvJBd24/qIdqM8ZiN3GzraJrP5etCUPcSp5M28pdsIB1eCTDW6DlYs2U2FGfGUf7nJvqG0tRhxNEhtZXghgdpgq3+Y8GWRVT4ntAc/pCYhyl+6+JzmovqLs++ber8snkOBzHc1V6MDUljqZK6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUfGjDGa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUfGjDGa"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828ab3b033so17110536a12.3
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053139; x=1780657939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwPPE5/66gX8tYQEwBiFqJ6gT9Mjq1jN4WhTwmvmXVQ=;
        b=dUfGjDGaauOsq9z3Q9ltvS3ODxPjCyjr2Tm4j4bk+2N3iZfqqI6x5T5zmwcH0S8D3O
         qyCkLT3C9nf5xuYQfsdD8vFXHgRFYQVIp4Ume7XSD3yJxHYYiNQYcnHm9vF15OD2GsXi
         OWG6ehFqzbZq5zhqa3I7sdcB+gS7ADitd+lhOV4ijn2zGQA4FErvN9w6Ysb7jDLWd/OC
         OvHxNuD5OpDQ9ZPFMnSAc/P2bnmrdgoSFdPiNLJNLTJWbmNa187Z6SyZwfuv7nJhi5jR
         obmj0+gUYC2dqO+oOOlkn1lcUpcuioUAtNBg5YUc83Lp7WTPDjg27F+kIyfo5VI5MKU2
         yqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053139; x=1780657939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwPPE5/66gX8tYQEwBiFqJ6gT9Mjq1jN4WhTwmvmXVQ=;
        b=Fkrg6bja9tfOp1pGJBpc3PesqaZ3LzMXI/aaIfjw/p3nzd5D/g/IJPCDIpoT13s2bN
         RBMjLjH4wa6sd+4oKcgXuHN0ncRaDJoSAKWd13h1f2Nr8U0H0jL4XM9FVbFUvRrF2dYj
         GFLcVOAuxnPVT0iICUe7C7bYntGq5Wx3o5Jd0FZP1lpCy8WtsooBq1x24M9tRgl+ZO7I
         L1YrqZrscYhQ7ZpXupVQ/Ck8SEG/pw0fDZ9xXXeHbjhk+rqWpCeyhzs3uwlg2O46QS2z
         VHmfFxKRFSIR0GOVYE5gNEZfLuS9n/lp8TozwF1krzIOe2o6h0IN7b+MeUeW4tVzRJsD
         uyDA==
X-Forwarded-Encrypted: i=1; AFNElJ8kVRhrbjRT+bMq6mcJS4z5EDsBCOEXgTxU/yLPdgh1TwZ/Mk8nAHAUEZKXbp/Yz1GSfPFB/OahYg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfs8gc6Heuu/D5wccnWGgFk0f+NFnO6DGEZj25sZYjWRL3Sdh
	x5wLlOUduTQwWJXliAj/K4OUU7m6IWfJQBn5bVS5gD1S5oB3CPdllOOZcrg1ZxU3ile9AXFKXgG
	z3Q==
X-Received: from pfbky33.prod.google.com ([2002:a05:6a00:6f61:b0:82f:b6a3:3dbc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14d3:b0:842:994:93a7
 with SMTP id d2e1a72fcca58-84212a7f6a0mr2674296b3a.5.1780053138377; Fri, 29
 May 2026 04:12:18 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:05 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-4-praan@google.com>
Subject: [PATCH v6 3/6] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
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
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_prepare_ats() internally calls pci_ats_supported() and
returns -EINVAL if the device does not support ATS. While this provides
a silent safety check, it conflates support detection with configuration.

Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
the function supports ATS.

Update the function documentation to mention that callers must verify
ATS support (via pci_ats_supported()) before calling pci_prepare_ats().

Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..f1434f86ac40 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
  * @ps: the IOMMU page shift
  *
  * This must be done by the IOMMU driver on the PF before any VFs are created to
- * ensure that the VF can have ATS enabled.
+ * ensure that the VF can have ATS enabled. Callers must verify that ATS is
+ * supported by the device (e.g. via pci_ats_supported()) before calling this
+ * function.
  *
  * Returns 0 on success, or negative on failure.
  */
@@ -64,7 +66,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
+	if (WARN_ON(!pci_ats_supported(dev)))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.54.0.823.g6e5bcc1fc9-goog

