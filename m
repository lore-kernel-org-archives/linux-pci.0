Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42F3D1AA2
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672625; cv=none; b=dficZ+k5RzublDk3PmUXiI+s+paugJLnNzesxCGIq0nxCjPspe5hn3HJ81A4Sh9vfckPATGDAYGAoBTrqzi6g6w7FDY6aekDjoGrNoDtS4Ig9uaotT1VFbEeSb8NxxD475fxDaSVPbS43sS5Gn/w/fTR4HHwEEwImwLw4j2Ynvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672625; c=relaxed/simple;
	bh=Q85AWLNgqcnljz2teM8bODhKb9R3SSUmpf8wLn2uxcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XK4zIi26joxsAkesCfKWQGGRWohW6MnIuN+p/KcD/BuJeIZ0zkGoVPcglbueu9ODMA0Eo5/rOKcgag/QkK36VtrBdEV/bb0yL7aDkwgCY46Y+4IeNEEAQ0AiNmg+VCRufzyERD7MoReaB1htw3zJ9Xo0OU+MNuP7VTiMmqG1G+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1ceVUBk; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1ceVUBk"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so8268145ad.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 18:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672617; x=1787277417; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suvqJCeCQhgoLkpZWaB5Gj2eD50qz+gC2/v02GoDQJQ=;
        b=Z1ceVUBkENS9W9Joh13kn8lX2Ijb0sOSuXS/v+tRPh2syaneubS4o5EE5yBlptWoap
         sQky1DmZO7JSmbCQvMv+QPX/DvWHGBizzMgWFZhNKN2Y8R9A1EUvKEM43AC28F6K7QY5
         A4rPY26i1GgVwoFRFK4E6lLPvj+gWg8T53jzlbf/rirHwyJP6ki2/+u5GsZnQyFQI5b/
         8Qin8YhQyPPwkP6lknv6+Lgag8Ma8qQzkbbB94LLKFP4P/RB77hruqzGN38ppcAkPGnB
         Ukckiu2IyxdrYOh3CCoBqQReIG4qsFQegVlf2h0ZUc8IHb62bLD7b9D17CztOxjSoWH8
         DS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672617; x=1787277417;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suvqJCeCQhgoLkpZWaB5Gj2eD50qz+gC2/v02GoDQJQ=;
        b=pWUi++ICQ7oToP2b1z8/62xRvwLZcKNBWDumL5abSNPpHUZKgoMT922FMAvOiiJuX6
         Kt2xAeJkNqUTBFFfhbx1+QP9hlRyxDtHTD3DV4mYq/ZVpJRnjXcmxo1EZhvdhwarli1v
         CQvvf9tUXkSKCoeLVeRMTUxwfO0KQzi8BVs+Hct7400FVvlRNUfk+4NQVFWh/n/E9Ihu
         4bEPY2xabIkaEgYBykyXHuhrIUGvCZNpEnKfAAcpH6nqlltyNDFDm4cEpCst8UCuUQHB
         w/rPCha/6GKlPhlCCiEqXG2qv9XzQTAWtaj2xuWIciHv9YOop8RyfD8vXENOj5Zt9ixE
         7EYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rru1rnuIlJeg5TnhalwlBa7PudVIaL8jfT3kakHGCu34IVSllICD5iIhcVMj0BKkedysAf/ggk8Z6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wCFRAok5Mv63jN5ZWgZRNNU4g9BzHrMwlc4Fdk5C/QhhlUJY
	JC4Ee8NidYwQxQGVpQUnMprPurdqa4Za13bRXS6BC6Tcb3LaVFqXSE7JsuI2T+l+WWT3On3GSyz
	Bqg==
X-Received: from plri2.prod.google.com ([2002:a17:903:32c2:b0:2b0:5538:b55b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:985:b0:2cc:9179:32e
 with SMTP id d9443c01a7336-2d3b0896781mr26039055ad.10.1786672617149; Thu, 13
 Aug 2026 18:56:57 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:45 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-4-praan@google.com>
Subject: [PATCH v2 3/5] iommu/amd: Split probe error paths to preserve IRQ remapping
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Split the amd_iommu_probe_device() error paths into err_deinit and
out_err. Proper init failures continue to call iommu_disable_device_dma()
while configuration failures (like PD_MODE_NONE or ATS mismatches) skip
it to preserve the rlookup_table entry required for IRQ remapping.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Ankit Soni <ankit.soni@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 911a95527d74..808011a700de 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2540,8 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_disable_device_dma(iommu, dev);
-		goto out_err;
+		goto err_deinit;
 	}
 
 	iommu_init_device_caps(dev_data, dev, iommu);
@@ -2554,6 +2553,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
+	return iommu_dev;
+
+err_deinit:
+	iommu_disable_device_dma(iommu, dev);
 out_err:
 	return iommu_dev;
 }
-- 
2.55.0.691.gc56d675ccc-goog

