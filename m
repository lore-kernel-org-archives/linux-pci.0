Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381C3DA5AF
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344958; cv=none; b=Te9OrqLxhzZF8H+VRjQw+3sFSuJfs1O1aDkDlLCkTH/eb3Z0qNxier+fezetoWg6W8WQwnjbcM8lSZBpMHytoI8IheWtGyJ3xGF5seqSbDclbzOWzZUc6nZM6g22tw7AHSGjVfCsgcjDZYH4cPuZ1lLlV1CQvLy98lsQrlrlqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344958; c=relaxed/simple;
	bh=7CAaYJuR45ZASJTU0EHeJkaCKmoj1cVH0wx7SlCT+eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhJPMMzWuv2ZP2O9kzUqQrmpCXCEM8sFhUwwGXwi90qDUtw2wf48LY5a9bVQ+cnNl/uj3wK7iulVPNwNDOxGK5VnMHxWMjkTkHxf5UCoBJ+M3iue7awNSFFVVA/sHGQLeZSROoYwK/3AHvDaUd6lHYBuWa5Zf92PgBJKeP1OXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bXitWiRT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bXitWiRT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad617d5b80so34719795ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774344955; x=1774949755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wNRdSzAgBmj3W1HLVnK+M5XPg8WJUDMQukRyAUFTZY=;
        b=bXitWiRTa80rajVMeNmzY3z/8BPgO8spRvNAKKN6DXnJaQn6ZZNcpHjtoprhqE4ZpW
         E+9Q+KgjTbwNcnnvNdXPP0Uioz+2/nrBXXzv6KqHpuzUAc9eqaWTgHbFpMKTS+ZX9xIw
         V/+gkeoah8v8FfwBiM1raz6J/Z5rx22tS9UeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774344955; x=1774949755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wNRdSzAgBmj3W1HLVnK+M5XPg8WJUDMQukRyAUFTZY=;
        b=RSOreh/QD+VlgBVvyKjvmAMRM1WxHPaet/2lJsL0E0JqqQqW0Uluyz/lc9Ft1OyVjF
         dZDpb4J/xwmaNukR4Peghj4HiHOZmcx/i41t1b1BX7ckcNTrteADXBKRpTsuktXl9wT3
         69gGlYj0czoDIXN9HRfgKeHFeSwTRtPmkpEmLaU2ZUOfsCAyjrvXIHfrBNfzc8qsV/Ea
         eLGSwjJ3B4D9Cc3X76DoTx4h6QsqUt4BL0+Gs7g0iN2HzAvazPLt4Ou7dCtN3Dik7h0x
         u0a1j15aXdZ1uwbhIswN+RLV8W7rHhxvcjwXodAAY5vNR8P5pXuiJc0lX1FeZiQpftQp
         XoBg==
X-Forwarded-Encrypted: i=1; AJvYcCUxfnG+AZ72jk1I3/NG9HEE4/wo+KNieFrQSRw6NMHWiInBSqfb7vlfi+HATKFkJM2WnRhJz28UmRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghXU2EWRmqpbQgptYNOtulo6BmLwHZQXTEDMYe1eK+aqk5g5h
	F+1AhZU+QsrxZBE3yxoBLWHj8uDaEBET3/6XtH7GbYs8zkdHJbmdr5/3ss90S3uYCw==
X-Gm-Gg: ATEYQzyQ9I6rSZikjERkX/Ut2PDCeo/zusdvOOBxGhzU+45E7Zw30756LY3RhEFgVKE
	ocRD5nk2OWYudt3xmuVA6GVx1PM3J7Ogj5H3nmTsuUH5m6/RoH1noyZrgR+1oIAUrY/6HclSeBt
	EsMeuByRWxPMvpw4BMsTxPuqHE5iF+elLKimRlOhJOfgGJKJXEwrCw6hYxLAmRetp8DFTSqZAOF
	Tk+mZKuu/0Kxor55fLeI93AxQELI0+NaeWOsT50Hh4Waesg0jLJR8c9TUNIdgoGUUPPXtHWKypl
	G88Y2dmbAHzSu0P9C0Ka7d87cEc7yKZXZXfyqgUgtdO8m7jDq2nDEAyHaIJWKHfxMB+29kVRwg6
	rMXLJkCJNkWfCTEH2dDr8NChOAhtcX93tbWCOG6HF0CwMT/vyZY6ixT4y1NHMxSRQvPdCA5ubyD
	eVQnGCP8VoJ0rnV/9hSo5uKCSp4sf8IORBXVv8kvcdnBprB6T8VZxOzXC0a/kJUgoTvnp3f+uAU
	0zg69kq
X-Received: by 2002:a17:903:2288:b0:2b0:5548:7d84 with SMTP id d9443c01a7336-2b08280c1ffmr147273335ad.48.1774344955576;
        Tue, 24 Mar 2026 02:35:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083679867sm163785785ad.65.2026.03.24.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:35:55 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mediatek-gen3: prevent leaking IRQ domains when IRQ not found
Date: Tue, 24 Mar 2026 17:35:41 +0800
Message-ID: <20260324093542.18523-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtk_pcie_setup_irq(), the IRQ domains are allocated before the
controller's IRQ is fetched. If the latter fails the function
directly returns an error.

Instead, reverse the order so that the IRQ domains are allocated
after the controller's IRQ is found.

This was flagged by Sashiko during a review of "[PATCH v6 0/7] PCI:
mediatek-gen3: add power control support".

Link: https://sashiko.dev/#/patchset/20260324052002.4072430-1-wenst%40chromium.org
Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This was flagged by Sashiko during a review of "[PATCH v6 0/7] PCI:
mediatek-gen3: add power control support", but is otherwise unrelated
to that series and can be merged independently.

 drivers/pci/controller/pcie-mediatek-gen3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index a94fdbaf47fe..2f9365930d6a 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -890,14 +890,14 @@ static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
 	struct platform_device *pdev = to_platform_device(dev);
 	int err;
 
-	err = mtk_pcie_init_irq_domains(pcie);
-	if (err)
-		return err;
-
 	pcie->irq = platform_get_irq(pdev, 0);
 	if (pcie->irq < 0)
 		return pcie->irq;
 
+	err = mtk_pcie_init_irq_domains(pcie);
+	if (err)
+		return err;
+
 	irq_set_chained_handler_and_data(pcie->irq, mtk_pcie_irq_handler, pcie);
 
 	return 0;
-- 
2.53.0.983.g0bb29b3bc5-goog

