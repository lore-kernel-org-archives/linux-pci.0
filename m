Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0E3BF66B
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324610; cv=none; b=GUKWuYA00JZ4LC8kNiVaNhze3EedqwiWteynzEVM1MWkjbx7s3wWrfelBZgvmh+LWAUMzhlWMf+m8cMOfn87vdI+G8arzRsFGps2rd2eY01PaXEf6/v4LEzR9AwgkZ4FiE2e+W/2WYCoSgRucPo8XZ7wjwMksxj9HlDyhqcEfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324610; c=relaxed/simple;
	bh=zLhKJQfxvv+d9aNsqJrU4irOe5OKs7/A2799Tf2JNWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jo0abAn1KIMnc4wGyKGscy7BYJzKGwN2UUgmrnOGK4f+ANvbwrzC4lz5egLdzEeUTucW/ojZYhy55jhsQJpD/bkn75sniZkfgs8WlEPnht1u2jZZ/w094C5blTu4hcthBFXltPOsv2Qk7sTBp7nwJIoDIQPxsORjJ46yOxf+Fso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o86A/2+d; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o86A/2+d"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so18642455ad.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324609; x=1780929409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=o86A/2+dhHNysWMSV7dnGUt4JeucHi4nygMBcNXIqvXfXlfoAYu9/S/s3fTM+qSFCV
         ouKaVInfWoUqTa5pX8xVCQw26ij7C2GvzLmVjI01salrBw9moknHYqAo3l3vIByMpKEj
         qcNmu8neQpGrx2FrIhpKWSa/xLnig5q0Ww5AznQIDkscL386Vz+lE2Tv+JM+vHBasT3Y
         NbSRCdnlvTACMNf2nDtAnWj8Gxubk68Y6LeTdysdRE2YEV1+DivNm0uhyJQ2ZkFcMDgp
         xB1RuUKBPHqCzAsNwudeJ83ad0tuLFZNsPUpmlA4nj71+TAU0VHBB1f15ovtZVzQKqIv
         T3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324609; x=1780929409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=GMm5DjNI3oMDXo6sLMxlX4feHir5LcVe4AdKP0klJZqzQtreRtqukpUSbYvWa53JEB
         vQph6HzCJbUfgOurV7GEx4td9Ew1BuXkr2zrqExw30uvl6xe0TKSsjwkW535L2Ba/6jc
         IoP3TVfaAdG/T4EPlWm9gOUTYsvEWhPOvBzzfEJIksnRubvaOyxcfXx+iizDuRVNyc+V
         O51gU+OeLNu7At7m7YTB6XBjMXhetvre7dgUogntIAFZ+iqnRn3hZbRQRBs/Jz9ciO1B
         7Pbvyl6Ukd0OZ9QgqzFveb8oFC+yGUFKSd05L+gxQGkr2b9rverskq5Gre5ALtDf7IMO
         9GXg==
X-Forwarded-Encrypted: i=1; AFNElJ8gl40j1S28gVxeEQ2w6dp4yltxfmnnFX73BkU0353gv3p3oyNYpy1N0MSyGQrMlmgEsh8HiL8xl4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0gu289mte+CjtkR1aV4VQc0MBYYYKEpxArtdAr8R6KnXlXy/
	pO5b4x355zQGGxyoOERmCuBci/Q5nmAgnDkzkVtQgJEB5lVOlxsccFD3cPnh5Wp3JMeeNTpki4s
	Pyw==
X-Received: from pldy13.prod.google.com ([2002:a17:902:cacd:b0:2b2:a70b:98ea])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b07:b0:2c0:b6c7:2273
 with SMTP id d9443c01a7336-2c0b6c7267emr92934605ad.3.1780324608765; Mon, 01
 Jun 2026 07:36:48 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:40 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-2-praan@google.com>
Subject: [PATCH v7 1/5] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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

