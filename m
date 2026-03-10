Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADB43CEF6
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134404; cv=none; b=WG7GTbKlRZFQaw7UO9UqfAjjifTIGwkVDrlWBR1pBgos9rgIsie48lbYt4/RP2SWKmScmyCeS8AIKe48yyp3/CKms/9C5A/1ewNpcice5jAy7FMlWhlobTSR3JuX3NdZMwYiZ1hJUgzLHq+BWUg+GEixqodcKpcoU5lc2mc6QVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134404; c=relaxed/simple;
	bh=Wj0U1ds5tnOHTv5YHW1mT+V8EiMFt+tECNQnEdXijVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS+e1MCF6jJUYKpV106NHdo/2RW9qjl+m3eWsXtkbubyvsJPVHVZ4EEk79wMJFFUwrqEn5gaW/k8C1+05kVfQ/VNPgugL3dXXgwtRDEbAxcXDGX6diAjz40S3/UdBfBtUFzpBJIta/f3GiHM9viuOMhASx+Ku0Qsxt9BD2LT5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fnid4vXS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fnid4vXS"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8296d553142so3024449b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134402; x=1773739202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m2X60AbRiPH6OZp8R6Aq2XdXF8mhqQvbj4ZWhmMt60=;
        b=Fnid4vXS4xZDnRuwOGeJ4+bLvWvkMe+/sEaYJSB9upuBoc6ws0n+s0GUgFEoYPXFFJ
         VNuFmdf48zEodW/lyLPFC/BOFpqhBpsV6wyu1FMHEkXjswSHDhqTBZEme0YkINblk6tS
         lDsJyXanlvPbemBX8wrWNvY6hPl8ziMPrnjbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134402; x=1773739202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0m2X60AbRiPH6OZp8R6Aq2XdXF8mhqQvbj4ZWhmMt60=;
        b=seZaZ+OJ9b9g8G862EcJa5j8fWOKY78TG+kfkap79cKSSm4c0FJOQZ2GiMmwTgVpy0
         /UXxLaMxv33b9F1ftLcXxAHC2X1XoNwRlYplNXVYIP/f5jL7iatZ0JHDeiThzf87OGdi
         0ELZq0RgEpuyLKdMaZ4XGB8mi0tGXFEzN7acHzZ+ukT2hK3HIjwvdqQjT4GHn7MkqkFo
         +0iih8Ves6fmm1AQWFD8eR/k5wUO72I7LEXAxnUbu7gfg2AjxhEb9cSWfHgxK2ksrTY5
         e95yaCJN8FX3f6T/4zdQyqd3uKUsbCW1Fl1M+1ER8Y6Ni3UovGxGSgXTTwsS/E22tnHf
         OCaw==
X-Forwarded-Encrypted: i=1; AJvYcCWo6hlnk/HmWq0lOp74fC1ChldF4g46TBASNhvYcIclf1906AvTPKUtfDIFFOvkkw+4gmcVCaC39G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfVbUJlSsmutdjGKhP5PcFQeUw1Vrv+qLaqQk+3mekWLNxbdj
	DyfWfgKg2QhqgIY8IYs4XD05H/Hk75xD5huVCtgVXmBt+ccuSEtem8of4i/7L3aDUg==
X-Gm-Gg: ATEYQzxtyu+3sj5q7+rAX3U7rJ4R9tKmkY3LMEnC02kEsPjiCFu+gvjKOEH56NgjsDg
	Z37TXwulTIV5B6BlQrQ6MOwGUSc5OLNY9Lk6X36Kbfl58DLf8IcXMpOk8f1t9wFHn4Dhmg4VUEj
	wDG3NyxAfMyNlJ3DnJaCwbOa+1KsnVTq12XPUf1j8v6shehioeQ+Shw94QSAjKl6JPWC2tHK3gb
	GfqJo/gWsY45TLJmwoZnQ0aqbuDDkuNtsmNaYefusWy7pohB2kmbE0cSzWdmCGAIq4q3JpBet3f
	EyPpo9gP7jS9LSWXLO9Hr+0JlAXYLGp1nRs4gZOO96TnQXB1LR8Kwem61Bk+K/y/90bmXnmkW14
	0FtuQTmlADVMyMX9jv9fM4iRrbiGKYrbHAJyV4VZ0HRzOlHDVUQ2caTWskHdis9Yssc8esqt3ST
	WAs6bx8qFPswvtKalJ0ip/ATj6l6uDdJ6vTFi+AUJRH04zs7H9JH0gUCd89AGmq/2C4GcNOyjaA
	BXBFaT6
X-Received: by 2002:a05:6a00:9510:b0:829:7ee0:1a44 with SMTP id d2e1a72fcca58-829a2d86b38mr12332941b3a.4.1773134402170;
        Tue, 10 Mar 2026 02:20:02 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:20:01 -0700 (PDT)
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
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v4 2/7] PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()
Date: Tue, 10 Mar 2026 17:19:41 +0800
Message-ID: <20260310091947.2742004-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260310091947.2742004-1-wenst@chromium.org>
References: <20260310091947.2742004-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_pcie_setup_irq() just sets up the IRQ domains for PCI INTx and MSI,
and chains them to the controller's interrupt. It's not really related
to the setup of the actual PCIe controller.

Move the mtk_pcie_setup_irq() call out of and before mtk_pcie_setup(),
and add a proper error message for when it fails. Reorder
mtk_pcie_irq_teardown() in the remove callback to follow. Also create
an error path in the probe function.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Link: https://lore.kernel.org/all/20260309215056.GA603013@bhelgaas/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- New patch
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 1939cac995b5..04ae195d36c2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1152,10 +1152,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	if (err)
 		goto err_setup;
 
-	err = mtk_pcie_setup_irq(pcie);
-	if (err)
-		goto err_setup;
-
 	return 0;
 
 err_setup:
@@ -1181,21 +1177,28 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	pcie->soc = device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 
+	err = mtk_pcie_setup_irq(pcie);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to setup IRQ domains\n");
+
 	err = mtk_pcie_setup(pcie);
 	if (err)
-		return err;
+		goto err_tear_down_irq;
 
 	host->ops = &mtk_pcie_ops;
 	host->sysdata = pcie;
 
 	err = pci_host_probe(host);
-	if (err) {
-		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_power_down_pcie;
 
 	return 0;
+
+err_power_down_pcie:
+	mtk_pcie_power_down(pcie);
+err_tear_down_irq:
+	mtk_pcie_irq_teardown(pcie);
+	return err;
 }
 
 static void mtk_pcie_remove(struct platform_device *pdev)
@@ -1208,8 +1211,8 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	pci_unlock_rescan_remove();
 
-	mtk_pcie_irq_teardown(pcie);
 	mtk_pcie_power_down(pcie);
+	mtk_pcie_irq_teardown(pcie);
 }
 
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
-- 
2.53.0.473.g4a7958ca14-goog

