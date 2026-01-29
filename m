Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE4298CC0
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670959; cv=none; b=u+/pkTmW0ufbllNbB5yKnKrC8PgD5/Mg4PDuR+6TGX3BLMPOAU/qo8bvADB6/KpdnIbbUI9vUa0xPjJG/+PTGqFaNdptPPH6dPsYF0m8+tF13jPZ1X3CrHPjQa3Z2D+ZZGJdJl7xcrsCDR3CDgdWe6YTVdVtSzw4fDqybVPsVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670959; c=relaxed/simple;
	bh=hdbt0KpHpLnZ+wea257k0KkCNlvLUHzZoMEnZliGbVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lqs+w7BiEVVkv8DYmuJCWSXzQs62idNt2Kc8V8GYfYc5m5nbJ/M2rjI7YaMHxhGluVwmiZAR/a/qscf2af8GXtPc/Ujl805AWlVE2DGlyUDs6e7809ms/PEsRV+ZWbFgBJATvt9knI1w9uKImkgxz+l4+ajC8uIokmwYUOxEAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so323374b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 23:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670957; x=1770275757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJYYjMdlOHZYjFAFO/sm/ocfavFCyx7F3uAXbE797SU=;
        b=N9p3wcxnPHNFnWcKSlQNpDBGXHFocRdxRQeuhVvRQ7bQQT3H35BDgbznbK2NqUJINz
         ZFVoHwd3yCYhlidu4zLpYYc1pgje5K679U00kvWy5h8pJ/RrpmBJM7pNVqJJ1gzACBoH
         DQkN38zw3ZUAccP4T1wgbN6JGlMh0muLnb2dx6dgHdejhFFYuDltprswD0tUsD6vr3N5
         VY9QLJWuAZg7zVHtnga57e4QMNPf5Kjtn5Nh8HSDXF5YM3uprQUufDcffXqQ/vd6P6Vs
         UKUTgKyJwMbs2Vb1hNTfE72t9KGnbFXVVhH3nm67JEHyejf8e9raGtrFFpvyUi9v2Sqz
         gBwQ==
X-Gm-Message-State: AOJu0YzSw9BIRyh7hslLY0j1coyL78kSvSOruJr8w29Qe0qCAKpuLeae
	uQdgoflUiGN236S4tHWSbEF/+gd3a0Gksb9PItsrteNHROF/KT8O2M2S
X-Gm-Gg: AZuq6aIwiQ8hpjKvalwj5CcqG3K2YEXU6ffKzjbvQHmFudBiNvOzSHZ96KcbYly+2sb
	kru3jEfUvrvlyaFCd1p5lmAP6v9991uLfTdrE40Il4QBVB6PWMNX2RM3s8gWzIWDQUkAVSjgL2P
	cHjNFdUAc781ZuI10lbP0RaZL/oZ5/qaOZiDVfvIxuBTBuyb4735f0nW7pO9gh6f8GtzuqSIK6W
	DYwKMkuRPqDouJndHp8BZk1+lS/2rsrhwpVG9DCRhj2UGPauCrjjoolfBYTFL0JMIpFn0Brw6yB
	u8xdWeROViHLnuix3qqPKVRY0MVS5CJZHbb3DwYYxaId7a4+CtHBRMa8db3tPNdNw9i6yGP+RX/
	b8P9/Hbxfm8uJqlwU8XlNB2cfrmggHivm8hQJeaUfi79KLVYNqfC33UMva5EOMd9b+NZPa1xO9E
	tAsk4FMIPRfWBDrEiL2bcm3tXjcqw=
X-Received: by 2002:a05:6a00:23c2:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-8236913d770mr7251181b3a.12.1769670956703;
        Wed, 28 Jan 2026 23:15:56 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd8d3sm4527128b3a.38.2026.01.28.23.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:15:56 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v1] PCI: replace msleep to save waiting time
Date: Thu, 29 Jan 2026 15:15:49 +0800
Message-Id: <20260129071549.425033-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pcie_wait_for_link_status, using msleep(1) to wait for link status
change.
But msleep(1) can sleep for nearly 5ms.

ftrace shows:
 0)               |                pcie_wait_for_link_status() {
 0)   0.500 us    |                  pcie_capability_read_word();
 0)   0.580 us    |                  pcie_capability_read_word();
 0) * 10292.26 us |                }

 after changing to usleep_range.
 ftrace shows:

 0)               |                pcie_wait_for_link_status() {
 0)   0.320 us    |                  pcie_capability_read_word();
 0)   0.480 us    |                  pcie_capability_read_word();
 0) # 2483.980 us |                }

 So fix this by using usleep_range.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..151364cb767d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4484,7 +4484,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
-		msleep(1);
+		usleep_range(1000, 1100);
 	} while (time_before(jiffies, end_jiffies));
 
 	return -ETIMEDOUT;
-- 
2.25.1

