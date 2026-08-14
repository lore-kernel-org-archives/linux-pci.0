Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62233D5647
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672623; cv=none; b=ePwo3U2LjZYlP/y1U4oNjenpJh/M+vST4IuIq8EiSdbzasbTqWYqLV2JM6F5+VKE6RQ8/AY1jjAOl6QzpRWMWz1vOj2UYLWB7RLbDmLyMWv3XBb7cSqD64ZqhB2tyLxYiZl0AOOARJGUm2P6n7u9gViECdy2f8SpsftADZe4Coc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672623; c=relaxed/simple;
	bh=RDhxRkj+fQC5GkdMmEU+HuM/xovB5ghQohfAA+HLkWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hw00QXoeOW7d8lYDkT94jJ2ahTucOyn9qXfoKgrFA3+6j0fcg7fnEKNgxpgoAnZ4Pmky9M9dcQBsDBfe1eENcQpFJlb4GgjBG1Ho99DGZrA7DGSU648XAseP1vf0glQq/PhQSUnlJIJo/Vd1sXwRDY37rDxcgVeD1ZeMXXfijRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkPxipM5; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkPxipM5"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486c3411c8so561200b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 18:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672621; x=1787277421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8ere0bszt8rYKCYre9UsvLcJK/9XFe3pK0sfX5UEzk=;
        b=nkPxipM5HJZ+RFFCXK+ClENYFguueu5+Yh8Plp7eYWnrw3278nflqXT/vlYQDQyyuo
         mmjsFOIwBFAlbGFQ/GWejNB74NDma+zhh2Zu9FbE5bxO6nJ00crextUOpbwxy1Rb9xC0
         mIe6y+dsZISosz61uPpEWU91E18LaDo2R2rW3sUa75rj4uXw2NmcUtllEODnQtxDziry
         7yCdLTUNt0D0LfAfXtDaL89EGL47jrM9NsWmFt2tTUoZeVWvaba3TGH3AyTqwdk+LL5j
         3u6G6hjAiRMBVfwW4E/Bxn2AoQsBnf90HmRBd3aLg4gtMs1/n5VgQxQRJk7I3EkJm/cD
         4Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672621; x=1787277421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v8ere0bszt8rYKCYre9UsvLcJK/9XFe3pK0sfX5UEzk=;
        b=Df/zcfbEeSa/3d/XsJyhwcUN33aYZm//cUO3WmZzW2J2oSuMqgux3EKT3oDOV7BojM
         xo0qXyJB/etpV9rYEd/OBXKAaXZitJ+COlFORGBlWMDX7ytHyLX6XVmAN9PR7wkoZ2PT
         XLwr4SjS+dDRbMervxAvEmOgb9QKucaaAY6n4mcEWmC1s6iz7GzrfI4cJtxCL+tLlGo5
         sZJHwPGuB4/1Jog7uA5cw+/CLtTITyx/QmA89/cW7ANrQUJrcf1OSMnHkcxJ5imuB9Wg
         iK+QTXlim2/o4FW1kwHvDv6cAxE0KyaI6Ah8/981F4RjsUpCHR7dBAZN8+O6ScfG/JmX
         g+cg==
X-Forwarded-Encrypted: i=1; AHgh+RpKlr8XYcTuvGbFQoJbmuMqqu5TzoL1/j2CKZK5z+3y233R5fQrg8ESgThhG/Ja0j0G9OkxBhjXY1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrsiPW2wqdF7aEqSm6d0lfSiVmB+wNOOr8oh2UpcybE3q+YHn
	HWOYFKQiFRZ2VyCmLOox/W2jmodtq0v8rUSZumP11LIvSQdlBaLsZkhW7qMW6Iv5ovGrgjfpc/c
	Ocg==
X-Received: from pfbfx11.prod.google.com ([2002:a05:6a00:820b:b0:84a:37df:a3b1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d24:b0:84a:6540:3389
 with SMTP id d2e1a72fcca58-84fddfdf59emr2209051b3a.10.1786672621113; Thu, 13
 Aug 2026 18:57:01 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:47 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-6-praan@google.com>
Subject: [PATCH v2 5/5] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..f18c06b73eb2 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -53,7 +53,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
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
@@ -61,7 +63,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
+	if (WARN_ON(!pci_ats_supported(dev)))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.55.0.691.gc56d675ccc-goog

