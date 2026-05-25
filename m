Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AA3793CD
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734635; cv=none; b=Ewaz7A+Vo5dXPvZJJjZsbBtIow9zp2XnLjf1tR9CO7xK77rAzBoECPD7MqxtTjzpOvEZ6IsZ0YBalF+Lqt3Jo3rQcJpkENtyhcQ88lagkShorQKvERfUWeDJ5XzUiDM9lsj0gPm5KRWxTdWKtUO2bqouOXyhCH2kzeAH0KnLvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734635; c=relaxed/simple;
	bh=4rSy3o0s1t2X0KnAOSHjI7mBWu/hrM5yp05yahxxfi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdy582oQKHCYUhKIT82mYnOdnuoO6YS0ZXIg3Hw4msO1zHCqN5KaKdBGNs0PkXYAwIg1RFjzIZjfYrikSU6jEAWGUirXlWDhlLrBe8bbmZzne9mJYbyijanfBL7u6Jw0Eb4MA3hIWAk+A2UZ7Rb1pFT2tq1oOgfedElnkztleiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kL2y/zDJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kL2y/zDJ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so8888872a91.3
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734633; x=1780339433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U//oE56krJ8X0dzRdJlpBkAz8D7rzP/0SvFlnQu6n1U=;
        b=kL2y/zDJ6ZW2nmn2JEOd7oOVt/ya/6HQJ68z/THwPCNwIxD51nV1o1ojV4aTxJBVdP
         wFykh8gGhMlBM3z1T4Mnc/Pyh7gYxkKyjzf7jX3RLYHFUcvGz06AZaUZEJ5/23ndK8uI
         4ADWxJZeSKvDGlnTct8EotKOm9n+WNHNMFgMA0auN4E2nPgg5F72maakOihLtRN6bXVR
         X5tIAQlgqw/AnREGYz0jD70u/zTpwFrrRauvQLepi2q/sL5NfWSfJ2PcRGehQ6LevWF+
         KNiLc0n+/IZ3isnRXAbSsNWrgOerHH4TFYZk9Yi6FVYJl8rj6qhp3qPfQQ2B4NbMfmEV
         yiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734633; x=1780339433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U//oE56krJ8X0dzRdJlpBkAz8D7rzP/0SvFlnQu6n1U=;
        b=eW7KouHXnzmQuv2RT4YC+nNu6PWFlKUSYtXgvqFbMAhayeyOSDtO49PwOB0xNNd3r2
         fQdhiiVf+TTP1xX5uL3f0jy6cp0fJeqL+MaGnvlHqcNfYA6k+C5kVDEnETQ4LVBugPHF
         trhaM+TV0Vq1+B5G0LvUnp9XDCR84x5SBXOJKaSaTUGsSJxK3Diaif1KscqPN76FZBOd
         yHvswXmrt6UePzyGcOSmMf2UE6jEW16Y1dA9TZzK5/kgkoFVUqS0S1Cvy7zr+IJGOZq9
         0GCg4xF4EosrVm2TxrrlvmKebuLczXILUZIEa4iRv2l69rR06ULJJAV+jtp7a0Oh8Hmh
         LC2g==
X-Forwarded-Encrypted: i=1; AFNElJ+MhR1WLD5s3nH1U6D7rEBNcVvcK3btTVCsZplUszm4bfak05wgiqL++TdAogdryv4+L8y/4hJNNJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLb3A2ZEJAhRSPLT2RFKi99OrYud90njiMyZZLL0qPCUtFG4ey
	okUTidJfrBuRF9ic8fLNXwX906s+rDAmaG5YAiwPoNR7PUME7EHA5B6WqdPPytStTDVLYrmeaiT
	KTw==
X-Received: from pjob1.prod.google.com ([2002:a17:90a:8c81:b0:369:c5f0:e8f6])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c8:b0:36a:f612:e695
 with SMTP id 98e67ed59e1d1-36af612e947mr2150738a91.17.1779734632985; Mon, 25
 May 2026 11:43:52 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:43 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-2-praan@google.com>
Subject: [PATCH v4 1/5] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..a5fa7745bce8 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap)
+	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
-	return (dev->untrusted == 0);
+	if (dev->is_virtfn)
+		return pci_ats_supported(pci_physfn(dev));
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
-- 
2.54.0.746.g67dd491aae-goog

