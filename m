Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B7418343
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574244; cv=none; b=WUKTEfhxjU32yc8Dbbtp2R6GrfEYIlAFurerzljxgVgXIvBXockVIaG8GG1QM6YSWyaLC/b7RXST3aGdvZ/goOMh18AitW7h+JT/Lnv+ULYW2nLIFppHi6PUbhfhtYSvNdmd9CWu9P4Qnw3JkSQML4nwh5Q7+tL6wJEbxzj0B/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574244; c=relaxed/simple;
	bh=I60yTaMjb5bVKB+wvVecyXVEeYAbub5ZMoYnTj+sZEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XC8BLuld8PIFfuOs4nyTh8knKsp1kOs2KUKfjyBHaATS/EQte7uQWuhUTF53jTzSc6uuDF7Lvaij7Tw7tpjFD/j6Ccw1pazbnCzD7ag8ZLn0OcYN4m76fYggXjk4ps1mRL0UfbtC99Lbvg7lAwo/7brL+OMtl2oA1Az2qL/Hh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjPnZvU1; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjPnZvU1"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacf17c7e0so55178265ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574242; x=1788179042; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfAbKSbfKhboyVQcKl7Sv1k2EzxFQ1LM/Y8jps789BU=;
        b=hjPnZvU1H9vFua83K/jJ0kJP4CznjuS5+7nBcslrYWf/jEEjSWzn5P93q2QrORISSe
         b5AK3s4eeyEykiPmHJ5f7Vf2eLyN6P40+chXuZPYQmpknwG0N0GjFFFqdz5yR2OJmkDS
         3vcbvaXHkOG7E8q6SSMvRjbM5zJFQiYF7kpUECHcPIgiLUf7oybNbzU7IQJ6H6SG7Hma
         W3FEcVA9205ehjRrhqrZRj5OO0O39D4pQsU38AR0+vHZudJjErr7ElIZFr/aam6m6HFq
         dL5dNb5QNlcSw4H6/Ngn6HYx4Aodg3x5fyo9hFJrThef4eX3g15sOd2gfgUjs+k6BXuP
         cKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574242; x=1788179042;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfAbKSbfKhboyVQcKl7Sv1k2EzxFQ1LM/Y8jps789BU=;
        b=fab86IMS8+vGiOdY1UnCebpjAlGV+8rhW+tM8B7Szm89f24Wo4Dl6voRQcAE8JS8sK
         qY4s4WH1lR/LrZ1b7y8Wm2gwG6tehMp4Dpe9h+lnRSErIcTz50FTFwxF/smOPBqBabHi
         hwZlr/qZasAJI+it+2tsprBq/Dy7JF+ZHB4H3V0qKxCvUox5hokP32S/vhpn7LQI05+Y
         nL0uPgODRE+F75aLe6R4MdEQH+eoPYMn3Bj4YGoIhX2cJrsuYx/ESzRd8tmZ0zfPy/Ni
         pYJlKW6D2ZKNzZTk+gW1yg/MubCqOCuWGqPXrnL4v5yjSf53K6k/LaYOHHrMTfrXSasc
         j0RA==
X-Forwarded-Encrypted: i=1; AHgh+RrZ2LX1tysVPPrLoSPchfy6fx4c+LAJGPMCPFt9t/6U6nNe+gk9v1mjBt3a5k7ks0lA7olOYXaKbAU=@vger.kernel.org
X-Gm-Message-State: AFuF++nRbtHS8ZU4Pq6VuokCoubwDRg9E8apgje8YYeEVRJDD1DLtO3o
	ti1A4Lk166WOJ08A1G8ZWyLSsM/YUaDZkwuYAQ7UnGYgzX3W5BQi/iYsYEVotDmk04jwfAPo+xf
	+yQ==
X-Received: from plbkq5.prod.google.com ([2002:a17:903:2845:b0:2d0:1ce9:b121])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e546:b0:2c8:2808:3ec9
 with SMTP id d9443c01a7336-2d64b0c4e5cmr412549775ad.12.1787574242094; Mon, 24
 Aug 2026 05:24:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:45 +0000
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824122347.1588592-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-4-praan@google.com>
Subject: [PATCH v3 3/5] iommu/amd: Split probe error paths to preserve IRQ remapping
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

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Ankit Soni <ankit.soni@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8e382317709d..ed336bca1a2e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2540,8 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_disable_device(iommu, dev);
-		goto out_err;
+		goto err_deinit;
 	}
 
 	iommu_init_device_caps(dev_data, dev, iommu);
@@ -2559,6 +2558,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
+	return iommu_dev;
+
+err_deinit:
+	iommu_disable_device(iommu, dev);
 out_err:
 	return iommu_dev;
 }
-- 
2.55.0.766.g2966f0265a-goog

