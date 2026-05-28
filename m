Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821B301472
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999840; cv=none; b=KZGH1uiJSZX9m4wB0nOCy+91pzv2CESHgSR0Q8QfuFrD3F/Uiu+lrbvBfuescd3elViXN+Uvvw0Pk/A0qaHhzWIxHNyzeJppwMReW5ed2Ypb3dTC+8dfLms7meXF3lnUR3Xc+4ZZJheB/yqIpRHaCzMf8bEwIj99781ntcRVhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999840; c=relaxed/simple;
	bh=6JPZRBT6suYUThuvCh6y+NiY5DV75TOqoNSPL+EfItk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aAr/8vPfuMQyhpV4jaIWedfLiotxgcBgIQ8LVayvTVpgBWZ4AdQg6+XxXNLlM4R6+7vNLfYv8APJ+imIUAnxtOpHC8CNZVE7iyWSYP+gruST8KWYm3j5t4RBV5PANxYfrGf0yCgUdchaTffMkMiq6RzN2jEuJaKs5oisFxu+wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGoFNj8c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGoFNj8c"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso8115664a91.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999838; x=1780604638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwbylVdF+O+8AihJparLUGU02SRqGSrn4Cd3mbYF5r4=;
        b=YGoFNj8csgKXXUq3hSOwz8usr620b/KV1l1sMFLzaIbJyaWGVdUnmsTrdpNHfcP99P
         FixGUAZa5tJM/yxrjvUWIIQbhlAOmhtXYA8E3kE6YCoP5qJ8swBqsd7pEbEDwlNDyvAp
         mw51qf1IY4KMRwb4ZSXXQ5uW2V40ZPlJOxpc9XBXjZikHBAK/Gq4Pa1gYYQQRRwootot
         DB8szYuIbidakCd9DveDIGHn3VZDhTIjX1/TXkXclIibMItaXs+NML2ED/XdHnt3V4xK
         vrGtIbLN0G5Kgt17qOSo9gQ3pYkeNNUGZk9PxZGIQF76pT+0FVTxCFRFmMQFL83Msi4e
         VxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999838; x=1780604638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwbylVdF+O+8AihJparLUGU02SRqGSrn4Cd3mbYF5r4=;
        b=Yk8J3wekzyWYkRlJHUde1cQHcKD8Kt/yXHEnuzMDFY6GQQR7uSif+qfHHKbcUbcx4v
         g47Am69Z+DA1/OKYdXuuPzk7RSw14D9CXvx9f+odLOxEiY6AO37ysi1kDjQgWsa55A5Q
         kl8mvc0Tdjpf0/ZK4kQQf9gsXfqj5yrJ+ktDp1WXkFTKO9GevPwN6pGcXyLnXqVJipY1
         WejnsZyOFSq8x8e6BA0M9MLx0hQuabno7f8A3mjarmXgK4kZEmZH8j/WSn+mpDzweUWJ
         XW08APvZClCqyWAZbxuGI+njjATAqIwQwjUyFt1cLn/AVpu/ye/Q3pVHrv+yLlrmI7Jc
         yF5A==
X-Forwarded-Encrypted: i=1; AFNElJ82zaDgBZakBIWsWB7ptc3YBfo6UZS8szzVXMY6CEy0QVE+04gFCWAQhYwGEbUsfyjGljUMwcdjEik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8zMBz1wJ2+9BZ20bZ2bVa/AYMS4CTZ6i96rgNSzGmOAUF5rb
	9pS1wLx//Z17KDF+NHKnpxAOQbun/AiE1NJVLh6LSU/r06UVARy6VlPoG4VvBJUX1N5R+/BxfdZ
	GTg==
X-Received: from pjbcu14.prod.google.com ([2002:a17:90a:fa8e:b0:369:9cde:eaa0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c9:b0:368:1088:bb1d
 with SMTP id 98e67ed59e1d1-36bbcfd9807mr90130a91.15.1779999837989; Thu, 28
 May 2026 13:23:57 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:47 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-2-praan@google.com>
Subject: [PATCH v5 1/7] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
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
2.54.0.823.g6e5bcc1fc9-goog

