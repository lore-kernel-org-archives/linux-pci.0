Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF83AE185
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321336; cv=none; b=Yb3N4SfMEvnLIlJADYvztCCj+2h26sZIAs4E8jR1YfHemv/bEOrA+MQ65rkLgZaXc9WtP4cSmf+Xsv/IKEUcitIL+2MSYwj2tMpg4tLlhZpzT/4D2/bzrnuHLkBvVleTpiTX606U/7HVI2qeaPwNhy3pQHtnFF9d/4/zAPuxyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321336; c=relaxed/simple;
	bh=b85lZZdAEpendsttCqpo8oWZqe64dF3AQ7gsmsmlFcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G3HccEIhD+CNfKZS+vyLfnsvm4W/2rsZ0SBHorhRveK2pav2nRuNRFzl5PQciiJEMJGb6o6PSgNtxHR3AKPqAhQPV/vGOrJc5w/HsU7pl36DC2ecIPRbrp9t68hCjUz6vhWrFsaU9qn92AL3qUw4ln2wP8lHCKVJLNaY9Fe6cPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iG4li94A; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iG4li94A"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c857fa2706aso1214929a12.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321334; x=1780926134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxfBWSy/eY/9f0RcQZ6Xq3ck7ox0I1FIw/EK+42VaI=;
        b=iG4li94Ay/MRRPsmQR9pTixVzNmReXxsLGr1RParZychkrVJz7MEPWqe2+RoL3cSgy
         rpcKwd2nWddDS99DG+nxU5jLXsD5fUuYDhq2rMn/EvQQWCRWG9zVRzy3oE00woRdqU3Z
         yMr+6x4K32298IT4phtw+Le7jjqkefEgpDiA+bEY78RVYfCHbRMpc9meAn0ysHWAUshW
         xMWV2Vak0OKoRBGpglAQFck+j4JHGzO+yFTKmwTynpmzFoyxXEsrFWC0uemufDEyS7Pa
         F07wIqO0L1C0LLwZypFYhjZS0UEJRF3dqaW5iI87kfj4C+r04pceCaQn2OkHN6MZUjgw
         hycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321334; x=1780926134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxfBWSy/eY/9f0RcQZ6Xq3ck7ox0I1FIw/EK+42VaI=;
        b=Z2K+cXa/426/N7Cn2WzJ6LYs0aj5jMIVGCZQVHudlj308LVoWOOkPXT4J/Qbs/ikz6
         Gnzp1b4LJncq5Y8+hMo/W261xXnlC60JxXBXSKmnVUK+ag5AYxQqdt5h0VOodACsnnV3
         JZ+5Uw909E2zxoi3QDxthyGJTX8gYTffvD6zTkGmQVztmE2umre7cTLRPl19zAHPAmTQ
         bKNtTdUn4V9owsc4mq4jms8CRghGXKZ1MxWWQsXDbXf1DqxGKQpjBSLr8cdDrmgeU6N6
         BF4++1pvkipTSTPWTJIHlrqnwmwiqVaYLvusL5UhrJpR0S6PIVvjlTIUiEadrmr2hfO6
         nCJw==
X-Forwarded-Encrypted: i=1; AFNElJ92QBA1xEYVloWvs0aasTrCuis0Q0ZmVPUxnfY4qbUtTGAKMRfarRJdr3QXwtCtIgcVNQhhAIR1zV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22J2Qe9z+Roo7D6ZUIdz3wxrmELr/lwBYmm5RoaIYzql8TX4d
	nKRtB2Q/MilV3ThdXFpRNRYqEhL1/bh7ubhG6gJh0EkFpzxvXPQ0+WrYFnDkL2Y2rGi1rR2qCVz
	/Lg==
X-Received: from pgaf27.prod.google.com ([2002:a63:381b:0:b0:c79:65ab:b3b4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:489:b0:3b3:be1f:c89b
 with SMTP id adf61e73a8af0-3b42823a7e2mr12624173637.22.1780321333571; Mon, 01
 Jun 2026 06:42:13 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:00 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-3-praan@google.com>
Subject: [PATCH 2/6] iommu/amd: Clear DTE with update_dte256 in iommu_ignore_device()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The iommu_ignore_device() function currently uses memset() to clear
the Device Table Entry (DTE), which risks torn writes because the
hardware reads DTEs as atomic 256-bit qwords. Fix this by using
update_dte256() to perform a hardware-safe atomic clear when a live
dev_data entry is available.

Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a94de66a885e..9b5861e241d7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -750,7 +750,16 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	setup_aliases(iommu, dev);
 
 	pci_seg->rlookup_table[devid] = NULL;
-	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
+
+	/* Clear DTE if we have a live entry */
+	if (dev_data) {
+		struct dev_table_entry new = {};
+
+		amd_iommu_make_clear_dte(dev_data, &new);
+		update_dte256(iommu, dev_data, &new);
+	} else {
+		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
+	}
 }
 
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

