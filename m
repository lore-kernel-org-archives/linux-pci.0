Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11243DB31B
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958700; cv=none; b=EgFq5/8h01Dw2e2tGJ+NHoZ2TITnkSWK6G4vsqV3NqRu6CoHTZNZnsrRyy+9ojJ64IyL7quyfCILVKdiKUiLgx2xXAxZOsObNyOLLqXrwDQBw1wj4snAr3V0VYBtix3LrcG8/JbcELN4lEAqJ/QhA6v3SC4tlyMxKHMiCfHbwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958700; c=relaxed/simple;
	bh=vhxRWR/Pb70EdKPz+0km0N4lX8vkU+xU0leGRr1oomU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYQqKtEYaPBLrNOYAQmEiFHAdgBMQ9NFamTerVviTbTRt+DdA6H1fhC/H2wbT2kAcVtpuXRu1a05kGoYqyd4siBMwxPA0nH1+W3vnaeawypXG1lA5IARdTEQxLts15st5/++8aT7Io9x4OO+bZqmenaQL0/A0heKDZgvySaga5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5VQgeVQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5VQgeVQ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c998fd549a8so2321344a12.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786958698; x=1787563498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/nzGeNShMj6yapcm+ZpWnrhl/q/0I72+8BKRHk/PxZo=;
        b=Z5VQgeVQE3qHoRgehXdp/PhPVYGAhhiU1xoNPCs9wDOeI2SmwPnORJBKhJbBdTxrVh
         /CnGAsRLNw/q+2AAPJm2/ZmPmuCXTCaXbLtzQKzpj2nj1cevJu9Th3DEJLKLUM+qpxUh
         oaAm/j6p+U0hzT7KZKgEtH7a9usIefgWBs5FakWg67BJU0RqjMd62ZuuBuDcAf6DePIL
         GLDpRpIviCE9H7KP70tnqloaphRNaSu9kb42+SzmFgIisbF0L1Ppdt8uXZnOo9PRb214
         X4bqEfRpyfOv/6M+iRSOd94oD5W+/wS9Ci7SVerq5uEx8kMvF2jMg8cXLpsgZB3AxYA1
         8ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786958698; x=1787563498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nzGeNShMj6yapcm+ZpWnrhl/q/0I72+8BKRHk/PxZo=;
        b=caVsrmDogWImt/XH3QMHXwh8sExO5LW8U9NiCpnf8Kjn0UK8Lwg8APdQAKINJ7nhme
         Z24jZfbLOz5lld87vfcqXuf9xMb5k5JZ0v8d0rIb18maVzJ6h94gALOcgXNMKZrbuAgO
         aRN4gsq4plkLoCS2euBqKU9UYYb5Fh3nX+X4GhuvpRdhEt2nv0fjbkwMMjo7GjylULVZ
         CJJ1V3adANHXVsNlailTfKBiLajcRkAn2VuDHVxInnqgkxAkWdeJfKMNpaNhKF9aBHbT
         2y+4iLleZme4hIPUU26g+MSxX3XCfAeHLSMzRX6QhFRXZG1bIqV60Id/Tz9Aac/SOA5l
         mzIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmjWUXVIIdruQTIrYfmknkdwK243PGfg+bVJMIFTYvkkHP80hbRJThJqgXYhrSCjLOnOdMsYMT2a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16oFCLrPGwyBvYqhaui2DsgkzyAiR5dZ1irR/Vkp176w2xIap
	Jc+imXUqANZ0jIq+bFjPTBWKI9A3p4/QCqUVY9sTJ+WvdTG64mTD5ndC
X-Gm-Gg: AR+sD10fWmwBRy7iAuYUg58qkAvZf6pQstXmhy2Q4jR+1SiYOo1pqgTZAMRgq+6zKD1
	8Q4PrPILtxtgQIbywAZNPMiFAIPSkvL/+Bh00P7ooTY0sJuwpGMWQj/P+cZffdBgZ8xYN2Y25yk
	VKapTEgyPJ+5M+rXHKf2ckMXZF6DJbEK9OyS4yqxYRBnJ0SH2IKhcqM+PZb3MMjbWhsqkkVweG+
	tU45ZSSfjtqnfGISmpNrVkljKDpbCIhISV8f00sczjKpK/D/L87VoPIZpfboyC1M/rX69DN7BnY
	snvQMY4rIhActswR6/0mmcFwZr1nsVi3NXtxxtgPRGEi9di1i+aGR1sKESg7zJ9CGfuBYwAr9oT
	/feRRnf46LIPR8pSwtfR4WtSwg5WrkqWLk+p1MzkdOF6+MrYM79KofWrVQBaPrPGwrAVHUvefgx
	/+l33XHq49nH+sdtO2uEYVNxnzsoqCOvnJ8BrOE8CLPkdHqJ0N+lmaqfjpbUcMpAb3Nt5LY2UGh
	SNaVWA=
X-Received: by 2002:a05:6a21:3204:b0:3c3:9a7f:7309 with SMTP id adf61e73a8af0-3cc71f19334mr25436483637.26.1786958697843;
        Mon, 17 Aug 2026 02:24:57 -0700 (PDT)
Received: from kernel ([45.251.35.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326794c0c94sm9181038eec.9.2026.08.17.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:24:57 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: alex@shazbot.org,
	skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in nvme_disable_and_flr()
Date: Mon, 17 Aug 2026 14:54:47 +0530
Message-ID: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
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
boundary and it can cause a page fault or kernel panic on architectures
that enforce strict MMIO boundaries.

Fix this by increasing the mapping size to include NVME_REG_CSTS.

Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..ed03892cc960 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
+	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
 	if (!bar)
 		return -ENOTTY;
 
-- 
2.53.0

