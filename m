Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55EB2931E0
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785708714; cv=none; b=N7pzpyEntKn3M8EeFmHLz3pT+IU6Nkp7btfu6WFCySfk5CtSf5FhEi+g/y5yKsU3jwf2ShrCmK7X9MZ60ZhEF2qiBEEp7DMdU+nncKdlgPvwEYWAGfc+FaG8aBFebzOaCZ/cRo8jS++KcJy/lvZMyNHZdKdFsABkMf6BwIPB+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785708714; c=relaxed/simple;
	bh=bOdoGyy9FIE4++qSK2iP4efegXnNinlInPOn6hUTm+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laj3R9hs97gHcrczVgWebG8yH6SDi/KEDlPD8l/gM9mKvdaLQ6zydaqYc5ebNEYHWU6yo/opNrGB6KADUJrC3/I03GShrclOl7Ub67nX4IYeEbMKOchKysZEC6iHkOb+yvBs+JF5eS1pWoe0wlt1S5L3AMhpjJsrsVrWol3DSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdEa1Knf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdEa1Knf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-517dc520840so19081841cf.3
        for <linux-pci@vger.kernel.org>; Sun, 02 Aug 2026 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785708712; x=1786313512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhU0lksOjQ0TR3P146OV1hVStSVy2GPBLJL11UWPwxI=;
        b=EdEa1Knf5Xuv049Q6pRuv1JldsL5PkUxy2MZlfjxOiyFFb4yBmCqehNx88WLVCwEJB
         s88azh4fA7H9So+GS5itubZQOajwgLgPaGqPqe2V8zSlwcWSaxhKmgTgO14+t/JkaiB4
         WgA/7lQSigFxnIni+/7gScflPm0BiCfXpozfllEa3BirsGrdzknkdEg7XddbL8O4/Cxl
         7wXLnrSlLe7MzfllAZZfYZxHuHkbUAYXPOFtuOTApDGpOW1zjEkFNi+N5VK/9w2yapK9
         0hjLF7XPALj8kUJNwsehcUmQ1Q1jHjL8VdSD6fdUKg9zhQRaKLXctlIKZVGRfHwRLmto
         3wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785708712; x=1786313512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhU0lksOjQ0TR3P146OV1hVStSVy2GPBLJL11UWPwxI=;
        b=oaVL9epd1BXdjdFcr8jwP3tENI0Wuw2vZ/SaYfoMNLhstFi0wyuJCN1RCDJZSjvulC
         sV6EawKCpApU0kYzJyThUNRLavb4xBG5TFxFQwwVetf737Gye2WEgbGJ3RuopRWEHEP5
         goQ2QAWN2ZMY0YSny9UlF1Tu0ZvVdFrGwzG3MG9TiNHGY7bS/6duupI1hu7GWrM1YylY
         3/1d0SJ/vhIbpLEoEs1rTtURY1Ixb6Eecgx1LuaY0/nPkHUZWJ2Le89zd1bjb0ylBewc
         E8jKytPw9NJu5rhicLJ0MEdy5XcR2k+U2JzmxGNzCgRgD9U1yf5JizMl0M1lx0AoGH30
         eJrg==
X-Forwarded-Encrypted: i=1; AHgh+Rot4ofzWJSrDJEdmAXSPXY/YKFNoHU/5MLUNAbVqQj+V+tQgJe8liVwlP5h5z8VCHb/hrU/RVYgu6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuFD9PQEaUGlmxVSpLNBuBtFZbKYha2k0nLgekA0m7UkMVIBMi
	fxAxBnJ8QMCA047rzm8aXqfX32lsBYUjme81R9FgWHuyULmKHE7Bh52X
X-Gm-Gg: AR+sD107jAL9OXXIVx62G23L8PzY0pPY3d111YfxQUua+wU6JpzmdvXrbj0yA8HVW1W
	OqTFVfRRK9dF9TIr459Cbbj/vUJlnaYA/oMqfcaGF1MLSCMjHe2Vs/XkNtTTAtrW0xDCWvajNbb
	ZcaSb+gtEWj4/XK+eFG9nMhs/y9kt0r+f6sFkBArYfRXVwK17sqfrYZU/XRTDJJx9qPjXew9Bq5
	ckwNBCvP+LzDGAJrY1zej51Z0zA7iYWgKAs5vDTO+crQCp9YncEtPV7eUqOCCJ/E9otcBqEe6Zp
	fIBwBG92p5oKA2gRVjns7uaa/n7WtMCfamHuMkiKF2QV8i3Mpjp48Hqw9KvfsD/J2NSMTZdHtfY
	wsFtnR2bijvLDqRXdMYNueOEQgDq3A7Nih+wd5iwNNYkgxfGE+2H1FwrIXSsFGZDR0laPATgDlx
	dwEL4+GIIgb10kIIAhnq/Hj2937NhpEKis5x7QUNGvUmHWqXNUj1py2MsG/YjkmTZjUy4PKnW1b
	NZ5VPL1/gnjQDyUGQ2qqj81G55V3mHqxQR1HjAfNWBYAABIv8fD+apdm+9m3Bw=
X-Received: by 2002:a05:622a:1f95:b0:528:3142:d466 with SMTP id d75a77b69052e-52b567cdee3mr154874811cf.41.1785708711652;
        Sun, 02 Aug 2026 15:11:51 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e7edb3fsm49573231cf.4.2026.08.02.15.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:11:50 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: toan@os.amperecomputing.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PCI: xgene: Use managed clock for PCIe controller
Date: Sun,  2 Aug 2026 18:11:46 -0400
Message-ID: <20260802221146.573233-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgene_pcie_init_port() obtains and enables the controller clock manually.
When xgene_pcie_setup() or pci_host_probe() fails, probe returns without
disabling, unpreparing, or releasing the clock. A failed enable also leaves
the clk_get() reference unreleased.

Use devm_clk_get_enabled() so the clock is unwound automatically on probe
failure and device removal.

Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index b95afa35201d..4fe3581b9372 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -321,18 +321,11 @@ static void xgene_pcie_linkup(struct xgene_pcie *port,
 static int xgene_pcie_init_port(struct xgene_pcie *port)
 {
 	struct device *dev = port->dev;
-	int rc;
 
-	port->clk = clk_get(dev, NULL);
+	port->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(port->clk)) {
 		dev_err(dev, "clock not available\n");
-		return -ENODEV;
-	}
-
-	rc = clk_prepare_enable(port->clk);
-	if (rc) {
-		dev_err(dev, "clock enable failed\n");
-		return rc;
+		return PTR_ERR(port->clk);
 	}
 
 	return 0;
-- 
2.43.0

