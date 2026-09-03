Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD1381B16
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453992; cv=none; b=HkN0j3iC/vy9iS3gsTDt4QEIgjfidEQ0XRlVbXqbeOMarjbi9rkQiv0FFyzIAlGMgN4Zno6RwEW4uZ/fzr64N2rcdcxN0HVp46kShW0k0hwpH2lHRrunbdtI65A206vTIzvZCLH0IAePtYQSoOp2vKaSfYR5E6N7WgZwntNu2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453992; c=relaxed/simple;
	bh=Yb7aozIWbhfC9RlhVeAQwGbDEaom6NMXRd+O6Gx9Lu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrpnKCnR0BiPSypLd59/EpBIH1tl8I6MxpOj0lu1PfoUMDI2FUsYS9XA+QU2ZytgGlQYqgdEETLfazkkXpzXRjJCsmVzzd4VREhIZe4LFZD6Uyb8xSXwZHxvjdpMfFwtp85N5AwkHEb+CTmJOoVa0Szc8gwCktrKGTwR7YzLfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1ZjMGuO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1ZjMGuO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so56790a91.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788453991; x=1789058791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nbtg5A9tMPTALq5JCB/R2RWYnV0svBUsA+9JJg47pEA=;
        b=k1ZjMGuOeaB0LgOoaVPgt/YewX4KhPgvNOHuKR0HdKUnL3q0Yb0TpqaOn8GgTlijze
         I5KHNKKgGwH6Aw4HXnFjKdEw0ofPEXc+Qs5/XwTitHulmg0X87tX2vi37LESIDuRkicd
         H45X94mCCJihfqjw89a51L9JXJi6rXB2bKxFzO0WdXq/ZM//wpoyfwFnX/cEjuFjiELm
         GuIuSPCOtKi+B/j1XySJJn3tGIkxbTk2e698Nt0ybt5V04QALRF877mGH2sgHvsXQZXS
         SXeIpg/dOBoomFWB9AhC0KaMOB6svGssNigXhP4gKd+0rgEKN42/ege68bH8w19gDVsX
         Fiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453991; x=1789058791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nbtg5A9tMPTALq5JCB/R2RWYnV0svBUsA+9JJg47pEA=;
        b=G07lw356yC2ZEMZeSTrJJwRn27IfNrOGFHHarMVRZ6O1MEguZoxa0VDoPRtJrnfDIX
         VtmbHfJzG8E6/RzztSiWB58WbB5bo+IG4sIVoNKR6MP5OTBpYjYWIzRq+U8ZuCUyvPHd
         BcsEu09aJh8w1+JU+fNdq/3Iz5JWuS18AJhpNDKCfpsH3fiKf6xGcqTg1lZIjKSuvf7f
         Ct1YYWdBQcZfECzWLWdNxqEHajsDj1tk7iy2LBF5hW1i5hQMUPan7tPUTstfXSiK7sA+
         SJMqoMrI1Z/tNB8pqXZBJ1VRwo0LbLaBBlGSiGKUqSvLg+ek0tdCyftZNk5X/fQ2iBsk
         XaSg==
X-Forwarded-Encrypted: i=1; AKwUvBx4sl5aHCjiFN5V2ZtxWu+gZ2afEWXvE6TEaDj1Dc+bZ3FtuIcwNIMYAziMfTswTbwxhMlE9SxgYak=@vger.kernel.org
X-Gm-Message-State: AFuF++nxqK/+XB8X5FikEini8n3N/kF+ecLBsOJc2+1c6NAQVvNPbcfY
	KaydXWxfBn9wYEABezecwvWY9X1H/kxVKnyz5QqKKO9QOWCA8yPzwpap
X-Gm-Gg: AYBFou3QGLRvoh+p96tSR8U7JDXeopP6ggl3O/i17xJJ4KK9gSnzaKjLDLqCNWRuthW
	a10O4jXzANUJydSpMrXSyEReLIwyLy2HaQkB2R4WDjKUDxUHYXjD48GbSF1iX0aSWug1xs8Aj/0
	l0NB5jUiRyNhGQFxjuZkfXvj2lzr4UfL3sZsICHbbim9g7NfrRpRgGihCiV97P+qQznp5cIrHJx
	oBbOac1ulK1hDgAaKXJfDBKjGSkL7N94vV0M1JctRewHlIIuKYzIHF1kjKx3mfSee33oVeCRv5j
	RkgCXYHn0dmYsdX+kDdtiOnN/ukG56RvfJqFD1Va/TKWcQ7P1HXpvgvN13DoDKnS5SZEpITPQcA
	+Y5+bGYYRbFWHJplHwaoeoq2HnnsyNUhoTxFMkYKFqn6178W+tfzMR4gRka89PT7A2wdZwQXsWf
	Q1JeWqY4htSLnyglVxDcujPOuyEy68Vhcws9VqE7MDh8Ya0/Fu7JvkstvDFmfLC9C9Ql54TsuHe
	GD9LtnQMebRsTlh2Ww=
X-Received: by 2002:a17:90b:55cb:b0:398:c0a2:8f8e with SMTP id 98e67ed59e1d1-39b087f5eebmr8125570a91.26.1788453990512;
        Thu, 03 Sep 2026 09:46:30 -0700 (PDT)
Received: from kernel ([45.251.35.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm163664eec.30.2026.09.03.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:46:29 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH v3] PCI: quirks: Fix out-of-bounds MMIO read in nvme_disable_and_flr()
Date: Thu,  3 Sep 2026 22:16:15 +0530
Message-ID: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nvme_disable_and_flr(), the PCI bar is mapped using
NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)

However, the function later reads the controller status from
NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
boundary. This violates the API contract.

Fix this by increasing the mapping size to include NVME_REG_CSTS. Also
change sizeof(cfg) to sizeof(u32) to make the intent clearer.

Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
Changes in v3:
- Changed sizeof(cfg) to sizeof(u32) to decouple it from the mapping
  size as suggested by Alex Williamson.
- Updated the commit message to use "violates the API contract" instead
  of "undefined behavior" to avoid overstating the risk.

Link for v1: https://lore.kernel.org/all/20260817092448.4395-1-raizudeen.kerneldev@gmail.com/T/
Link for v2: https://lore.kernel.org/all/20260903040049.5460-1-raizudeen.kerneldev@gmail.com/T/

 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..06436a96db30 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
+	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(u32));
 	if (!bar)
 		return -ENOTTY;
 
-- 
2.53.0

