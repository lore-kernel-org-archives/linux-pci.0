Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323373AF643
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321340; cv=none; b=O8Km1N7m6Fq1tnyIzigQtr+btTZB34bjgnaL7HFAQUYp3fGPj+AjgYGunQL+8QZFbh172bII8aWy2/Z0IV6uaJzo3T7aKQ7qoz2zuMzelrzwAlkd8ylI/+lqnV9k+e+r+Sjfz4JRcgDYBZ2BjO6+xTcsWfwZWdHZb+2gIh0TLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321340; c=relaxed/simple;
	bh=d9ra7+VpNlaICDKwllpNtvFlzWuKQw76LK9YtUjnPP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bp2C/G5KWM4pVA4CGmUR2hWZ7T/rx4BTBclzK9qxXONkGkJgVNunb4GzTpz0wAHOxiw+XU9Q3Eb6mkuF+3woVVfanESqV0oG8J5+auezB6cJ16igegBbMdxQMB5XKGVI8Fu+ZxrIkxSqrR5GWAj0mi1+AM9wRSZeTkD981WsaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9nfDmVb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9nfDmVb"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422875c676so1543898b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321338; x=1780926138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHVa4tUQPxfN3QUwaWtlq81eFxiSoG8gp/4WszuwXdI=;
        b=n9nfDmVbx1hVOgZ3EBQYS8ohms5iVe7exa5JVoacdptIuR+6W3sU+NvRvMUuNMqyXi
         CczINo+8dPWZXAQIDzpLbrmvyywP9yGZOqqmsnSoimBN+BYtSwiD4rU8NzNl69KAKB8F
         uJJux1Xd9dzhAVNWOwMvvliWSY+Rxj+5I9i49ltWX0ddpg9dfTNpMjOvZst2AjNHhqQz
         njiljyMmWRhIIoKSNPlSgfrNMVzcsjKp6/rhLXuAIIpc8u2uEEAbz8x47Z4IN6E4eAbw
         LfdzclxkmgzZMtX7qUPi1MYoQZcGWxeDyMYY2XkR8dwmD8WPZAjeZu85TIDiCZbn4cc1
         Z8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321338; x=1780926138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHVa4tUQPxfN3QUwaWtlq81eFxiSoG8gp/4WszuwXdI=;
        b=GQUiyfzrH2uUq+eYgOZiqeJ9ytqY/jsV/lZ8yQMWG50GOI/XR0Ify6DksDW0xoUFMp
         mfDVU3vFtuSO5HlUZErh+QMefiARfsCA2+XATvd0u+C3GoJuHELkup+2SWPgVANt6k6B
         GJPMb7qTL84VrHKZDwuVH0RnjDXjPcpLj9aiym21+YyZMWHs8Jpfp4wbT9KR0g/Hwtbs
         Hsk/BEZZowTbS4UIkaT7xOUbCo8TGSBo7vHpsINeAJYQ/qD04il4XqviRGDH94ivv+z9
         6cGbpVEbQRw8ibXXNq51X8z6oDFAqQfi5M8Qjcyee3Kr4uTTq9tfOJiyihjnZ1tOmdgb
         JeMw==
X-Forwarded-Encrypted: i=1; AFNElJ8Zre1GJmBAqE2DrSzWJLefnrxB+HSuGcLWF2SZA1BpuEDMFo+N5AQcdwyNnzPqssb03RmHXGDQ4OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2O6wp2HBWCSZAMoxCf3wWUG458l+kc8gL4+SpBkysthGzEsm0
	ifT6evMkJj552PW+QwnIjmZTWNkK+Rf3QxFxQ7x0uobOmgCxvlR4sO5mnJXgft298gAuor2GAZc
	2rA==
X-Received: from pfbdi4.prod.google.com ([2002:a05:6a00:4804:b0:842:3a6c:99f5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:278b:b0:842:4c2f:a576
 with SMTP id d2e1a72fcca58-8424c2fc01dmr3577714b3a.16.1780321338241; Mon, 01
 Jun 2026 06:42:18 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:02 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-5-praan@google.com>
Subject: [PATCH 4/6] iommu/amd: Fix Use-After-Free in non-fatal probe error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

When amd_iommu_probe_device() fails for optional features (e.g.
PD_MODE_NONE), the dev_data remains globally linked with a pointer
to the struct device. Since the IOMMU core does not invoke
release_device() after a probe failure, this could lead to a UAF once
the physical device is removed.

Fix this by introducing amd_iommu_clear_device_dte() to clear the HW
state and setting dev_data->dev = NULL on the non-fatal error path.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c3b3750d4a22..4ef6024c5a4e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -734,6 +734,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	return 0;
 }
 
+static void amd_iommu_clear_device_dte(struct amd_iommu *iommu,
+				       struct iommu_dev_data *dev_data)
+{
+	struct dev_table_entry new = {};
+
+	amd_iommu_make_clear_dte(dev_data, &new);
+	update_dte256(iommu, dev_data, &new);
+}
+
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
@@ -753,14 +762,10 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	pci_seg->rlookup_table[devid] = NULL;
 
 	/* Clear DTE if we have a live entry */
-	if (dev_data) {
-		struct dev_table_entry new = {};
-
-		amd_iommu_make_clear_dte(dev_data, &new);
-		update_dte256(iommu, dev_data, &new);
-	} else {
+	if (dev_data)
+		amd_iommu_clear_device_dte(iommu, dev_data);
+	else
 		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
-	}
 }
 
 
@@ -2517,6 +2522,11 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 err_deinit:
 	iommu_ignore_device(iommu, dev);
 out_err:
+	if (dev_data) {
+		amd_iommu_clear_device_dte(iommu, dev_data);
+		dev_data->dev = NULL;
+	}
+
 	return iommu_dev;
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

