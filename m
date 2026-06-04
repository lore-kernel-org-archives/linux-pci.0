Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188637EFE2
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597285; cv=none; b=c0tdWE2t/rqlNrxLlj4l2cl9SUxyKsizfWBuJY7xMiH6bRJuLEclgV/DGbl6807XaTK+FTicRwsuURIViNU+tUeN4W5EpJQEBJqUlMaeIwg23w6NXj1UCmb6PWHO+a//mACd7YozuJrqlvY+0blGLa8PQPBjfpBXuUgB5mraiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597285; c=relaxed/simple;
	bh=Es1v8sdHF6j+zSSIs3uGcU7RSkCWnEMk56BnyfML4Gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q7nG/S3dvZlGyTpcxYPFzvyQVXoI9s1wnN6JXq3+2koCdvZ/PzSB0MxU3+q+YIGGIH8ZCQ4KijWR+KJh7i8m3zZBuj6vO/su40M+HlCVa/tsjDfHdZrSxywR5Wp3SsY3/WMUB+YMvJ9R/hCY0e58A9pR2iNLDYbQLav1JypS2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqHP4AWN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqHP4AWN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d97955899so964313a91.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597283; x=1781202083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xpzlsU/13g3vBsNTBir2ktpGFm/ePGN+o4IZaBkeOg=;
        b=NqHP4AWNiCHSIrz9wJ6yztw1lnsu5UZd0Us7yHI1b29/m+ci7MSHCTatBjlZcbn3RR
         +ZO2vkb7PMp/DGWTw2YjUZZ1fEyVGSygGaWG+WKWOpBTNtpSaYN/WaPc/3cWzC1OPS3O
         R9SyJ9zFKEb5G1D+77hifU160kSZb675TC5g1nNfz7zCtgQosD5N1S/JX+4hfIniWpRB
         7r5FiTWynvPjPzSGEHaqWlkj1hmQsumJ0tfudlq3hlO9+5Q+u/T8ZUqbw88/wkW8NLaV
         HVNqvXHGPDhIvWW2h3/R/EOws60pVwm99mZwML6IFIn1t3v0Hui+WwDeLkmTVhJT7OaJ
         mTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597283; x=1781202083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xpzlsU/13g3vBsNTBir2ktpGFm/ePGN+o4IZaBkeOg=;
        b=AoBjhFwHpHNW9YApm66EO4AyI0Afb8P+p+UUGMvC1OyCzq08wyPs5SAVTZwwzo6a4R
         9IfYACWLIleU2+nE+/5ZXlJIX38ANrck3v1je/69/ojsL7cPA7odmXZp5FQEiADwPj2B
         SGZzmN/lleO6vPRZq3EYA813B7WPG5oYqD8c8wXXSyvD/zfE00q81ywakUriV/P8DDHB
         kIzYB3KN75MxM5DpWAbKATvxUtfrZnpPA3MpssGvl/h980mTZ5TEtcvIjH9/MPEHZKjf
         qOln4JxmrylnG2jTuQr1Pt7Npxw5c6NlanGiQ3j9o+pJkJorRFnAkcPBKwN4MwL9bc68
         Q9rQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dA5//W5CmV94w97D0EZUzRye2PNiHcrIzOmlFy22yuUs3n3/9zMR6V/7H1vn/X9o6/Zw1c2wl2+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIHNbE5kDD/98q3qQtz7gNeFlUwGHvsVrz2C8nynekVZpiGdH
	Cb6X9OmldnC+ujFnOL9nls50jg+rTQpmCIdLcwLbY8ELGh/9bv9kr/EpOU4GR5NANzGiDWLRqO/
	wZg==
X-Received: from pjbmd5.prod.google.com ([2002:a17:90b:23c5:b0:36a:f1b9:c389])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b87:b0:368:b01c:85a0
 with SMTP id 98e67ed59e1d1-370f0b54dc0mr99930a91.14.1780597282715; Thu, 04
 Jun 2026 11:21:22 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:13 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-2-praan@google.com>
Subject: [PATCH v8 1/4] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..679a3c3c1d54 100644
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
2.54.0.1032.g2f8565e1d1-goog

