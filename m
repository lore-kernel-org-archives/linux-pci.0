Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415342BCF4C
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638878; cv=none; b=QXniTpId12rFjgL3KRfQchAl/4ThCg9mlL6cJFUBCWyvB5craS1grCSNanfrEiJtV/FYD/EOrvNvtOZxo7m6or0GdfAiHKjyOfR5Qhykq0gVvUP+3IjuN98AXbbdLZc90uBTK0D+vtRfZjY6ijt/EG/CPqEEkUBfHfENlhPRYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638878; c=relaxed/simple;
	bh=KuuEpbTst1n9P77orwaO7ugukPK7pW0UmKogjRLG0ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KO/cq8UaeEXf+kSSkLQk3Ad5SDtG8iffjleg3AkLi9IqJXR0fkveuZE5cBLG4BLvy9g8xtX41yCJZAEo0OQuYwYF3meb4Vgvc/EO11oB571/tRdI3qzun9GqbUdyqYI6R48ol84XsB7DaJ+qqiix20Vqt+/zf/Nv8KfeOUoRt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEGrUJrb; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEGrUJrb"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso3329671f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638875; x=1785243675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXsaj5sMjmALSo9ZqMQjjSEH9mwAn1wAoVJp06uCuZg=;
        b=VEGrUJrbw4o0FBqf8pal+OOgUEfttjaDOYMVj9loWmtsmi3SIXmUF2hoydZJYdFFmy
         kY0w5vSUtZGIKLw0S5LFLFkqJRGg251zzVu47VjGj3fam0POAhWQSQwcixFr/GvVynVD
         ds0EZhVVhADcfHXxH8l6ClizKQ8kBd7ToY9WrDBJw017F3vle9+1nyki2uWLv5tmaRMD
         s9eqvoGp7k3Ojvw9PHanHOa9gZQUYnj3d3qFjMg78xQbWv0mRnKqPjsWwg5a6vEG9BMH
         Dxgxt+9rvXuOF0WvMS8ME0qHeNINLRwal8s0kekMybkVx8HXhCpQaMsiDVrJjSkt8Jm8
         18eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638875; x=1785243675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXsaj5sMjmALSo9ZqMQjjSEH9mwAn1wAoVJp06uCuZg=;
        b=EW1NKsAZz/f6oKQVwVY1XuLkRZkJ1ItXfUx4boqLZki1fxjpDI8A3Rdyxaz/gSJct0
         JWhTPw8Rb4ZCulIfcF4alFPOOCEZXJWPLKUVtL0lySmNXqCoka4evix8MvNkzpvz5yJM
         gN9/A9Hf164Jolwdy4beSwou6sWmb3c+vVqO42lKPdsdcHfHc0kCn8OZUi15koYdd2ZP
         YnW6XwWDIg8aJtTTIXwv+MokRgfCh5xMuznpGsuX+cA4yJBE5YfDXkiGcasJ4TesWuNX
         yKaVbk8bHX1e6RaHIAuObysNw3IWHsfdS3uHP6/qkwG+Wwqp1AXyejwI4YYtXM20hvQV
         pmeg==
X-Forwarded-Encrypted: i=1; AHgh+RrmWBb6r68OpbPzLH4BIk9WBaVjM15LbXQqFnxeoFlODAIBHygtblIX9dSC4cNIN01X5r/ArtNCyWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0DawJf+4ZieVRIp1UMLta6wmyxlUdFWXjmKKLqSUN5LY3PGT
	j4/xvqySsiTimHYOXr12JqH7nUGF0PTjM6VI7vvJKUC1JJCyGBNxE9QP
X-Gm-Gg: AR+sD10uxdY7NhYFqmySxaR3+xhwl4o6IHh+jQ87mHLI+bQS/y615Oa3NdTixBEm3Pp
	qrkDMDetsSa7uH51guMxuBUAohGivtIt8pTaVcGfHdDKKQVAWYazULSsv7hOdHoZybHOhYQPj5l
	zxNHo7gGUP8mCsfqshZG4Vh6XTYu1TX9tHdyDGDPIJ8u/LuBN+m6jqOdWwsxHDdAKiccu2q9x/D
	T0fiXwMS4T5wWAKcIOCDlfV+ZxdT/pt3FXlse8BQnAtU+L/fFGNqRO7NlwYUyfMFzYU6NMUhWfQ
	Y/FMZ+wv+p1BCCHlQ0btzRtt0bkVXXa05q47wZYqhKTAI2H5mVzHhfEvoGNkQLXLJ5NJGczJfzz
	l545ND7h5Ti4QZB2XTCB5mVcJOWtdoTJW1AlrtXWxXBQRv7X2Dgueh8CpBvCgb6eIiVcYZTUbUI
	rclrwd/U4=
X-Received: by 2002:a5d:59c1:0:b0:47f:77e4:37cc with SMTP id ffacd0b85a97d-47f77e437f6mr11752032f8f.1.1784638874842;
        Tue, 21 Jul 2026 06:01:14 -0700 (PDT)
Received: from workstation.. ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e519f4sm37252791f8f.14.2026.07.21.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:01:14 -0700 (PDT)
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
Subject: [PATCH] Fix resource leaks on error paths in plda_init_interrupts()
Date: Tue, 21 Jul 2026 18:00:34 +0500
Message-Id: <20260721130034.560632-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
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

