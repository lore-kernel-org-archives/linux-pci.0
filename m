Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB353537E0
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639766; cv=none; b=Mo2r5Vwx6BOMtF72LJqvp85O/c/q45KQEVu371I9sACLEb1BN6510A4nnEsQ4QrUrUSHVVwX8ZdWu6X5Sp9XneWHs8YfABMRpkrx6s+9Jqw3cJ2n4N7fecN30bmfHS9lXD6f8TxIVEhx0inUtPl5McsnfakLvKMAu37XBF3Fguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639766; c=relaxed/simple;
	bh=ShlZ5obsck/3HU07BN59h2dm0lLPILvV9svgtTgtavw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPav5Lx2YSPqFMDQtEceP3EXBdVDH8jlUukSfleyzTpDPM1DudZgdMV1ExCHWzrLpCctyYzVVU6QhXdD3Xo6spsudHh8ufGT3PJsbV8+Pfk/ltCsJDLF0HSok1OyRLvBDT5HSMjiphmhuHYKp4QoTLu3uZCrnyxGkLRpcUQDUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqyPuBLC; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqyPuBLC"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so13279035e9.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784639763; x=1785244563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYmx6dayCLYwlqwxf5du5VlxFHj5ZAoU7EJ7K2Lsb+c=;
        b=VqyPuBLCC3Isi9e4gGIeBTChPXTarQeYPoUKuV5msIxwhFo93ShB0S73rHfGkGHObf
         BAQ+9bxttN/NfwfjBtGLduUca0gohJpWBa626rD7Nv5CcUQ0xr4dtj2YifL6V0NJErfx
         GKFJ+hCxFWIGBpxwmGe8SdFEy1qgKCdNHVi12RMw/KUmbOSUwQSTXX48PcPQO2c1DOFo
         qssXzwEeT7bFcVgjoqcvP0dOzRcMqDaxKZo+vBSp39ew5aACdLROZ/zbpkwavZUGJE9P
         aBbsvwz+kwaswe5devxo/YmkihoTRGY26bMmloAQ389T0ISC2JEUTI5cwx2r5jACzPcL
         617g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639763; x=1785244563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYmx6dayCLYwlqwxf5du5VlxFHj5ZAoU7EJ7K2Lsb+c=;
        b=Hl5w6IqcjPQZFp7TJF/3Myhqkshq5qCZB3ZuEU0GLMBRAfAV8ENt5pJvzAz2WEADAC
         /8GPOUvVgjDgw5x9IZz4ZhSmnpyZOZc9RX4Z/LZ+F1c4xrb1hhCT99a9fEAxVKsh3LrW
         +HCrpnpp0wnWVDzI1sqGZLatK1TXv1sLl+2enqQ+/9+ZR+9pJYusegBBGhMf8IuWQcRt
         v/38kzQm+LgDzMDlbOTy/hCzidqO2TOcLx97+mfW1/dLCRK4if7uyHcKyDdo/ZM05o37
         R8CeTxKYK6kVBMErZAQq+ZTMNo07t5BEqwkn7gDSyYt8ILlBV0gnA3oPwf8c2HkYhNoD
         ZCHA==
X-Forwarded-Encrypted: i=1; AHgh+RrPO+bV+cyIer72pvz7IJAR2L1J7Hx+ZNmnI65xJNzXON74WxPawgcI3Bmmb7g3eNFe8bslp+2zcXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEAotyYreZMPlzcaYSDXHxLqYnbSGzDSAmYk7XaKXrvNXz2Nx
	O4WkGarjVV51aHLRppjsffmFOUeMivJncGtzVeD4Y7UMVRcDTlRQUV2B
X-Gm-Gg: AfdE7cnQAwxaLM+Y3u52bU2bUVTWXM6OXmJpCbWvcZOFi4pvxmGsH4bypEz1sIdvmEB
	rMfTthEtKlGC2xSeHfvxxj6KY+WHQdIpLmZfHz9s7uQMA1xFXw7Bk06gnN+N/qY5o7wMZLsEcrf
	wF9ap+GkW0ILWvxKhDcyu2mdCH30cIbYlF2fTji1q2uQRGlZ5LpHh0LKgYahKy+zRX8zofLIh8i
	aN8fd3HArKfewMwXBZSFehKmVGOiQEjEHg/8glrV7ZSZNtCOd03a+KgAvizl69Hx20LyhFT5EGT
	d9TkRrpghO8sqVk5Pn7l+1kwNsKm79og+9EXgebjlayh3htQlr6IIPiDdL5VVD9oPItlQQykvB1
	4egr1zRHue5AZRSbfRlJXplr/7vDdN2vii10ePD/piVqMb4tZqtEOgLFzX+UttRd0AEexdkcujt
	dcXvNYtT0g
X-Received: by 2002:a05:600c:c097:b0:495:5a91:8027 with SMTP id 5b1f17b1804b1-4955a9182a8mr118618585e9.5.1784639760966;
        Tue, 21 Jul 2026 06:16:00 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547323bsm70923635e9.4.2026.07.21.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:16:00 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Ali Tariq <alitariq45892@gmail.com>,
	stable@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mason Huo <mason.huo@starfivetech.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR PLDA PCIE IP),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: plda: Fix resource leaks on error paths in plda_init_interrupts()
Date: Tue, 21 Jul 2026 18:15:22 +0500
Message-Id: <20260721131522.594267-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721130034.560632-1-alitariq45892@gmail.com>
References: <20260721130034.560632-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plda_init_interrupts() initializes IRQ domains and creates IRQ mapping but
does not unwind them when later step fails.

If platform_get_irq() or either irq_create_mapping() fails
in plda_init_interrupts(), the domains are never deinitialized. If
irq_create_mapping() fails, port->intx_irq stays initialized.

Add shared error handling labels for error paths to deinitialize IRQ
mappings and IRQ domains.

This issue was found by automated review of sashiko-bot

Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")
Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Link: https://lore.kernel.org/linux-pci/20260718120701.DF4111F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Added PCI subsystem prefix to the subject line, no functional change.
---
 drivers/pci/controller/plda/pcie-plda-host.c | 30 +++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index cda8fdb088fd..a2d7079aec73 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -419,6 +419,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return plda_allocate_msi_domains(port);
 }
 
+static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie);
+
 int plda_init_interrupts(struct platform_device *pdev,
 			 struct plda_pcie_rp *port,
 			 const struct plda_event *event)
@@ -440,14 +442,17 @@ int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	port->irq = platform_get_irq(pdev, 0);
-	if (port->irq < 0)
-		return -ENODEV;
+	if (port->irq < 0) {
+		ret = -ENODEV;
+		goto err_irq_domain_deinit;
+	}
 
 	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
-			return -ENXIO;
+			ret = -ENXIO;
+			goto err_irq_domain_deinit;
 		}
 
 		if (event->request_event_irq)
@@ -459,7 +464,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return ret;
+			goto err_irq_domain_deinit;
 		}
 	}
 
@@ -467,7 +472,8 @@ int plda_init_interrupts(struct platform_device *pdev,
 					    event->intx_event);
 	if (!port->intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto err_irq_domain_deinit;
 	}
 
 	/* Plug the INTx chained handler */
@@ -475,8 +481,11 @@ int plda_init_interrupts(struct platform_device *pdev,
 
 	port->msi_irq = irq_create_mapping(port->event_domain,
 					   event->msi_event);
-	if (!port->msi_irq)
-		return -ENXIO;
+	if (!port->msi_irq) {
+		dev_err(dev, "failed to map MSI interrupt\n");
+		ret = -ENXIO;
+		goto err_dispose_irq_mapping;
+	}
 
 	/* Plug the MSI chained handler */
 	irq_set_chained_handler_and_data(port->msi_irq, plda_handle_msi, port);
@@ -485,6 +494,13 @@ int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
 
 	return 0;
+
+err_dispose_irq_mapping:
+	irq_dispose_mapping(port->intx_irq);
+err_irq_domain_deinit:
+	plda_pcie_irq_domain_deinit(port);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(plda_init_interrupts);
 
-- 
2.34.1

