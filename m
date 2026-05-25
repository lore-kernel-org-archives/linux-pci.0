Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D237C10A
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734637; cv=none; b=THvZMONW+UcDXSESvvph3P62cYtMgIqatzj4FqLm2SnreUIfIveGXzWRHFpstgFP4zLTpn4aFWvBVvtNDjzoczQj835MnY1Otm1CnlhNhjAR7bLithcpYoshhiRHZxnR6waOE/KvA8GLQWcDVZBDakJaXtmOl4bpOGHlQBfb43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734637; c=relaxed/simple;
	bh=By2955+3i/9aSqhHbbWD/5u7eCz9r5l5gY9iiYCu0WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P98+wrIGqjS81p94tev0T9BRH/74ntzWQ3FuCqEWnst2MAKzpQKtFF1i4p/jnNM7nicJSAnctahYMD/hGl+jANGkZXAPICYRi5G8+adeKj4g+UQmSMSkw8kDymsoDyJVMochRro4MhD3cLH5nODUp2QG/TfNbBGPjhmpK0PWWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsZ440nM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsZ440nM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365fd467cf6so8137135a91.0
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734636; x=1780339436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owlSh2MmqvAnTYupb6o8O6jSpQ6Nv1/iuRHiC459FvE=;
        b=YsZ440nMIpJUIvBIUyPDbNZnWtCs43b5qjDXCzQ7M7/NdhkWEZLHt9DZqwPHhmpMLW
         moaP26DIiiyr7XDDV17im3AxSezLHH+DZsAzhMnYQiEE5JO1eq8dO/2TKJFLr8GxRUmW
         1BPa7YMvkQgcJqUN+/ugGqGhiRyMezAqMaIfVsgNyHqkiawf9mNyYUTxQOY0waNSJ4mo
         ME85lau3mY7m1DEPny4mGTJwRRAzakXZ6SwcRqZHWVG7qRYIrKFNjVEFmUbHnt9sBfgB
         4EJdbWF9SJYdo96o7HSmcdkbMoqjjCElAAIJUDCh+aPQvIGsDbLNf1SPhLo4JF9hlSu2
         fjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734636; x=1780339436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owlSh2MmqvAnTYupb6o8O6jSpQ6Nv1/iuRHiC459FvE=;
        b=lrABWpdELZ3/5Zvir9lgyqrBD71bUTiACnRkhUAPBg6kzG8JulnSqh2f6Jkr0dMUN+
         N6hpsHasDwpbKJD4IA64y/ryaGszBoOsqn8jw0PvNYeHdadVHgbfJoQ/sVl3Xd8rqyaY
         auiAKP2acbVzn3mB2/nb8pnhg5U1+0OVVpbTJ+X4GLFle0hPYvrq2B8WE++FgHXvIsql
         M49jcGMdnLWyJ1z1rCnV4Hx5JD0pcIryJaPzyX+Z0XtLjHOTZug3h3niW981pfd4Q6ZR
         iTYN5C5itOY25Iuzjf9U9drGD8dFAqCSoNzuE+GwKETB7maD7JxyPhIgfoAuBsNJBvRY
         ooyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/13MKK3A27xi1SR1Z/BMx7WUZ9kifyd8LIM+3GlePQJVFb+cxiInRllhqXqOYyOCwrPWmjT0mCnMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+sn+tqkgyvJbRI2Ucwu2mONaOBBsUGcBe7Mwk9Hr9tcvHB6t
	7Pd163wc/K0Ct8llQY9TJRCwGcsVWf2oM+chgs0m1VIavPqxtLhjwAXSF4Hi697f37EXKUYRkcG
	LNA==
X-Received: from pjbos3.prod.google.com ([2002:a17:90b:1cc3:b0:366:4086:51a7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b52:b0:369:7421:75cf
 with SMTP id 98e67ed59e1d1-36a67508574mr14714152a91.16.1779734635610; Mon, 25
 May 2026 11:43:55 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:44 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-3-praan@google.com>
Subject: [PATCH v4 2/5] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
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
2.54.0.746.g67dd491aae-goog

