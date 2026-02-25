Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE930F555
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004176; cv=none; b=IRusc7YjMHudjKVrq8NSWLFWqA7PicbDepOmQP+pnNAtXjptxea/xxYwxpD0N3NCuBPSUBDlgaAbIls0DuCfa+3CB0+NfV5OosOXTnEYNBpm4Qfb1h5j3/xJz6i8vFAU5QC+iw8fGevPJRAQlUXWiGbKdh+x93I3nAovx6tjo/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004176; c=relaxed/simple;
	bh=Sy39ajZQihbl7RlFirt5qjuCLJ/gL92X1DsDY6o0ANQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYsvRmHRQICuJ70NJ4yJFjK3N4AC8Pi66MTt8yMvGzWidYnYbUA10JB0bZxOitaBPSzcxBkKV0XXeJA0yAuilLUxMU4CqAxIghUbL9KcKj6ODoOboEbrwUbxt0MmKEa6h+Ad9Zfy2QVuTnMOHR0LDxedwK8rSM3N52DrJvVWLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=heW0eD6l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="heW0eD6l"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad21f437eeso4719355ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004175; x=1772608975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5DXCfdvJ1l3iaiyIVD67Vr2Fhjn3yvdCNDjCKNCXps=;
        b=heW0eD6lik+bNgzr+hAI+XS3GxAsiyaDrAvRZLeugXILPN61H95juZx6Euln6jMpAg
         MnS0pqKGP1+ISCY5mvFaBqQ2rV0tMK3trDTMmt2rYWCrL/dC42YKhVQAhOrIqgZ+BbuC
         kfngZkp22mX4jlALSs0KR+rJl3ikyQ8vnWvxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004175; x=1772608975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5DXCfdvJ1l3iaiyIVD67Vr2Fhjn3yvdCNDjCKNCXps=;
        b=FGTdTO6NuztfZHRsaK0gPGYbcDQV11blr+gjTujQIrXmWpwdT5xbuXbwwe72UvIZu/
         BPbnlUXD+vTD5ZtNRoREuCfbpM/7uoDaN+B42UcIenTJefDvM+tReY+TaT4z7CTG5p2v
         4k8smTy0qOREp0yflxIqTlaueOhgbZz3uCtrgTsQjVAhY5O2/JLezueF8J91vSVcLB91
         bnW9vJ4iqISG1Er2kLiBpcEgpzTWLX3XATHUIRwd8tcXVrhpx7MsFWoJeD4zMksGzy2S
         5UrmGqABevraeahYgCRlmqSl8UfxXJo7sSS41Nwk2pEltkETzq+I8buqcFY03oU11MYv
         yGlw==
X-Forwarded-Encrypted: i=1; AJvYcCUnXx5itsnmaFwLA2wDoxA1vtniY9evVNBqSSoj2qlEEJyn0zsaGdcQeNQpWXHU2cvj9r2ZCcDZdBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtpg/JtQFQhQEbT0qpzyR2RdRnlRHUUuQ68mpFRmSD7WpK+vSk
	o+fu4nyqDnfE+l1prDc0+p2JvgcNEI9KKhRDLny1E4F+EwADKpcjsfDwV4B5wY/41p87wcCoExf
	+2h8=
X-Gm-Gg: ATEYQzy5AK6YX7K1EMeykAgBUttLlEn+l/twvhz1xtDZ6RmcpJfGKKijkX7BKvER9ne
	t2sgDGzsTLNrOdY5GFTtrNxTgUtRWFE7kdpvwRTqhmQkGyg9c6Fbn7G1/a0wsBUaTbyg5FQdI5/
	N6f1vy8EnsFVHKEfSlzMK1kaJjLrrEgLe1QTYWwXDy1B8IAX6mnpOl3R0kMxhQMR0UcjKewijJC
	etS0KSbHO7fQpJY0rTC+vRAvffkEquSlq35Ybv4tLjyVgpc/i3CjgkYSooH5uxVMfX2tCK71zES
	cc2QvfxnzGYxwQbDeGbQVjs+kb8f+kH/wI1kc0F4MVIZbcpX8l36DxltFgNPvV6M/O//b82hu90
	R5VJ9QNOVfk2yPBYLpr8li3eA3ZiDdmldYQqYjxHsP3mFvFleu7nr49sc9wW8xWj4gXop7iMmsj
	uWmuDg54EBJ/xpNSWTcIveBAs4yOblv5QrasD4ULvIbBP5ghHxiivq1C3t2hrqKgJ5W9G7VuE8Y
	RMbAV1fqcjZL1Ve
X-Received: by 2002:a17:902:fc45:b0:2a9:5ac3:a925 with SMTP id d9443c01a7336-2adbdc3eae8mr23994555ad.3.1772004174956;
        Tue, 24 Feb 2026 23:22:54 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:22:54 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] PCI: mediatek-gen3: Add error path for probe and resume driver callbacks
Date: Wed, 25 Feb 2026 15:22:19 +0800
Message-ID: <20260225072225.3345307-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225072225.3345307-1-wenst@chromium.org>
References: <20260225072225.3345307-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe and resume callbacks currently do teardown in the conditional
block directly. This is going to get ugly when the pwrctrl calls are
added.

Move the teardown to proper error cleanup paths.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 1939cac995b5..f2bf4afbdc2f 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1189,13 +1189,15 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	host->sysdata = pcie;
 
 	err = pci_host_probe(host);
-	if (err) {
-		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_teardown_irq_and_power_down;
 
 	return 0;
+
+err_teardown_irq_and_power_down:
+	mtk_pcie_irq_teardown(pcie);
+	mtk_pcie_power_down(pcie);
+	return err;
 }
 
 static void mtk_pcie_remove(struct platform_device *pdev)
@@ -1301,14 +1303,16 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 		return err;
 
 	err = mtk_pcie_startup_port(pcie);
-	if (err) {
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_power_down;
 
 	mtk_pcie_irq_restore(pcie);
 
 	return 0;
+
+err_power_down:
+	mtk_pcie_power_down(pcie);
+	return err;
 }
 
 static const struct dev_pm_ops mtk_pcie_pm_ops = {
-- 
2.53.0.414.gf7e9f6c205-goog

