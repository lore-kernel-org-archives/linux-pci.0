Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B83486B95
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726056; cv=none; b=rg+RcsblMeUCxRiXGamYS5FqS5EAI4X9R8vhGyvf4cr2XOrwRNzxfkE91Hk0f1zQaL6vn07NxEITK1OUSL5nB7xnHPjyQs2oFFTUaGxk9vA9lg8kiKGhflqlnq+NPkk7hxTBtraSjQXGAy9ArPHLA+5OL77gpE7un8pO9Lwipgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726056; c=relaxed/simple;
	bh=TzR1L/lyZ+ga6FrG0qQTDtTkygcFG0DxNgqBGPPmtEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUoss94CWIPVUUtmb54gt6Epf6u32+k6X4O/KmR8OW9VMYuCBGcd4LiH+Fj0CXjMa6htOmJCISTpffivGov+MpCnjsM2ZRCgF58qaSwCrkU9FW2JWuQf5GLCFgmW6KK+X86nBoaRfaxJbEgMBNS7wBm1kp/UUzGy1hcli5xi8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qubQVm9j; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qubQVm9j"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso766458a12.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786726054; x=1787330854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lx+HAe9Z4pJ0/UaGAjwikJz7f3N7XmaHmU4Zb04KXQg=;
        b=qubQVm9jpa81i5OIv3Y8Ziu3mACzF42TujgBk3whtEU8LLK7PcQ/EBKDHiUWoUpLZG
         WenOxaBwB9KmzRDjcD1MCBaAQeQO2LMn07tt2+G1YggqT6P+J9kz3w7LCc4RvWqyG7Kk
         AvednhEJsU3E5I9/4zvPVnveuwMRcATrVF541FRCAqyaXajzPff8s2O2YX0rrKTAunPy
         nIGpRIrRDWKTjAiZ8Sm87cFyvXuOCzyrT92902ZJIk2+4vBoCrxMdBTYeMysUqn4VqBV
         JNSSzmaSvPhhb5aqfQmpgDlPV5L0U5Km8IMv02n8NU9BCkscHdxsnxOmSihAkBr9LJRD
         7qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726054; x=1787330854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lx+HAe9Z4pJ0/UaGAjwikJz7f3N7XmaHmU4Zb04KXQg=;
        b=RIPKn2gVdR33n0Tjlpyxs4tFDwJl3M9htOvgCIhPO8VnFQTzuQkGQWZadwBAmHJ/2e
         XXl2ckuPMgnDPNCy85mYRajZPzyjvinrHOvnlydW3jYB1LEjqbzUHkm2+7mUIwD7Hctk
         KlwPxYr8yXKUYfYx/aNlBPR76lFBpyMHBiJKo1FAsxUE5Q6WeF22QwdE3osc3GYEQEKr
         X/k4XpP6yTZhdecTAzO9D2lH4Y7iKtU8mmk55HF/w8wK2wH3AuZA1/gqag2B02q4X7Qv
         vgZztruCmOPnKUgdIe5fgI617wYj0zscdv1BWiEtD8xJEvhcvnBKW1vjhCHSZCrE6doR
         be0g==
X-Forwarded-Encrypted: i=1; AHgh+Ro7oM+LxXXzHNfTQNik4KTShnMnVVNws5i+ZxKYXN0kCc4lYu9XmWISRsasKyuzST8kgxpZXTqbPF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnsoeoHwVk1y9M7We8Z6OxPh7fChIq+KzziRmxif48wUWd3yj
	GePEYruhdHwdZwAtO/J1+NNx5Gw09obQW7Gg6fPo802i1NR3PmFiQkjK
X-Gm-Gg: AR+sD11OngY4XhSVqULjqqZK1uv38ZE7Qydc7hWF55XmVYhUAxRrOe22KhdNfc3c7O0
	GurmeKC9vDj+ZqNJeNPQLP/cNu/0SFzmIQAoqc+wT3CWEQ+5A7FByQfBqGQeBM999eJ+QT5zVvN
	jCCfi59qviXZrn977j29De4hi03X+eumWl9oFlaOrGJyR+xiA0jRVc+z3X28vQm7lz0ztzosTpj
	kdxHcjYmL/xI6Oj7m8PvUCT90kQQAtqPgCHMnNQWACmQZvhjoW2MESaStTQVkNBKXXXmovSF7h1
	XnYt+t8Zkbyc9t5xIxY3JRvoqKwUp3/+T9TP3pfUncCDt9RrrgwZlcd5HePmbiG5DbPu9FoCbSd
	bPvktlg6ai6cGgtij1nd0OHOt4dqxbebDJUrniio9Uzm2szjeqd+4yg0+psvxjDGi7MfSl9MleZ
	/+4fnT0wYvrtas8/zMCXGJVLkVy/ftBLBYVWnJOijnccxr39OZCJhDqlPFumDwuU0nj8mwvzMuz
	0sOXAaw
X-Received: by 2002:a05:6a21:e8c:b0:3c3:954d:279a with SMTP id adf61e73a8af0-3cc71d8eafdmr8355809637.33.1786726054287;
        Fri, 14 Aug 2026 09:47:34 -0700 (PDT)
Received: from kernel ([103.219.206.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea8fe3cdsm6196544eec.28.2026.08.14.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:47:33 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	yinghai@kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH] PCI: probe: Fix 64-bit limit truncation in prefetchable window
Date: Fri, 14 Aug 2026 22:16:52 +0530
Message-ID: <20260814164652.43501-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pci_read_bridge_mmio_pref(), the code checks if the 64 bit base
address is truncated on 32 bit pci_bus_addr_t. However, it misses this
same check for the limit address.

If firmware sets a window that starts below 4GB but ends above 4GB, the
base check passes. But the 64 bit limit is silently cut down to 32 bits
and wraps around to zero. This makes the base larger than the limit,
causing the kernel to silently disable the memory window instead of
printing an error.

Fix this by checking if the limit was truncated, just like the base.
Also, update the error message to print both the base and limit
addresses to make debugging easier.

Fixes: 7fc986d8a9727 ("PCI: Support 64-bit bridge windows if we have 64-bit dma_addr_t")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/pci/probe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..0cf2d1d35146 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -479,9 +479,10 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
 	base = (pci_bus_addr_t) base64;
 	limit = (pci_bus_addr_t) limit64;
 
-	if (base != base64) {
-		pci_err(dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
-			(unsigned long long) base64);
+	if (base != base64 || limit != limit64) {
+		pci_err(dev, "can't handle bridge window above 4GB (bus address %#010llx-%#010llx)\n",
+			(unsigned long long) base64,
+			(unsigned long long) limit64);
 		return;
 	}
 
-- 
2.53.0

