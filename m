Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A842AFA8
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816925; cv=none; b=da4BHWoRYimmSn9Hr+K+B4tMjIG4eJrK00E8HFeLzVD30m8Qw0rLHQc6WtxFKCJJE5XusFbor3Clw9xnlkeyEpQBATjW0E2Xm16BGmHSTaXlzdl5eoz/7pvn/f+NbhuHe0O4B+Tvr3rs3Q7GVlLa/QYrxKUDi1THTh3besr+CgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816925; c=relaxed/simple;
	bh=PKDwq+x+NOmYN7QbKKAajaz0VL8NafGdsM2UBpgp1e4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luVguGX+IHMoweM9jC9VDBEi7umDMBWOc6TVs5TlUBHbIqppDRm4d1Pg1eohvZXcQkkp0CmAGYYWJvC3B+1vjG+H0HQqkaldqDo2M2Iso2kNEBp2X0vMXg6eP19VMi/c5HTetxfoMoI1w018cp1nWZ2b5YZgdf4dP8N9XRZW968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTJIVpIv; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTJIVpIv"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf5e516e67so4217025ad.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784816921; x=1785421721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0Yy60Buxa1oln1foYGDC/ST2/TxbKXJmmCBtwLn+QU=;
        b=kTJIVpIv866zsA4I3x5WsvdGFv7IlGsb7zzeCT+9TTOP4PrsCnOL+ITwJor53qXv20
         C5rX656QB99HuqttNDLTJqTcCn0gGeqITjxdQYPoQatFQ0q7RTe5AGh65CLESb7SjUfF
         Dpq2qvheLhVQDrQHg7gekJ41OeT/JAstb0fSXpjbj7qLjmw2BkmPCv5D94Bh0S0Y+phJ
         MaeEXBdTaqUlj9rLT0dVUwpJShQBEdbvQlcViFWF2V50ZysyGWAirXPrE9Jk5Yk/AZho
         FblyzW7DTEJYTEf1SCTMsn9BlAwK1VgF6N+YaqlnS4maqH1Lvr8F63TlcQKY3XVBBkvN
         xoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784816921; x=1785421721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0Yy60Buxa1oln1foYGDC/ST2/TxbKXJmmCBtwLn+QU=;
        b=JQOEMIXA/9AXjzKXV00J/m3ez6zhpTwZI0IQmCQjsNWfcJF3M/RAaFRvfnHZnytY7l
         tlvvYYGdfiIiW5tL5EAzgt1P8vR8JUdDh39IJlgJsb89IzFAgSMZ1hrl+smNV+264EU4
         UOaJ+Og+D8i87pEVF434iARzEP1U/X0kxr/sqsROwK0ozL8Z8HXitaBB0NvczgU7SqsN
         gE3AY6wqmC0pGccn8+MS5Yy7JpO5hjiI5D3omb0OIYHph7P1mVB1Q0CA8JeqqBUrRSvB
         WjLbhM1jr/pJVZ5D+7J5kbgic2cJ+tS1Rh0mdjZq75Il7ZYBMAJljJm2hke+VBHdSzBK
         xiuQ==
X-Forwarded-Encrypted: i=1; AHgh+Roebww/K/8zLwQ9mfe6rhfJA9VX56EcHoHQN1fYxMv7Du8om3dLJTF2Z3BcS9uqwDc9yGs9KXvhGnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyoEKWTO9j0iqk3uAEcPeGfTyqmxiaPkVd3T4YpdVdlZBRMws
	qbfYvAx44koTILp1QwIrtyQDRqziEVIiuKMZrIdeLRRMDRbk78LZ+agI
X-Gm-Gg: AR+sD13029u4xj+Ugrd1xYH7wxWMpYcPgsJ7/Se3RnDgJU+AiuKn5goTAU/PEwmoJXb
	eP1IK4rJDIprtyj85wGOeXXtvN6GuGLL/HF+wjwiIP/JdApnTqjSjFelIRjEh7T07dU2QO+rH03
	IOO4H12RxpfEtY67MlzfRwiGISWRpXYGV8qwSRuCdaY8OvRSYJrMPhW7Pyj1rila7pIb3AGhAUI
	OQm7xkYpzCOHrOJ+FNJczOUmL5iIiZVcFVZf64tTNcFL1E41rnek3bO8NPiwZvvgzPAzb69MUeo
	Vz2OipCONsNKHuNvBKb3sYkNVhoWZVwxOEJ1hGNzsXeynAlYDWJ6nUtLUaIoQOL+P9lc5fWZjLe
	OKw2xklkL6Vlna091UNjXz36nASOBd9Qto+82SnOXu9kWeRjR8gLjPHq+ygSrCxb87uekeNoI4V
	IoM21IXNMh
X-Received: by 2002:a05:6a21:a394:b0:3b2:8685:118b with SMTP id adf61e73a8af0-3c44aff1d71mr3653312637.20.1784816921359;
        Thu, 23 Jul 2026 07:28:41 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9f2f0sm21575371eec.13.2026.07.23.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:28:41 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: daire.mcnamara@microchip.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	minda.chen@starfivetech.com,
	conor.dooley@microchip.com,
	mason.huo@starfivetech.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	alitariq45892@gmail.com
Subject: [PATCH v3 2/2] PCI: plda: Fix resource leaks on error paths in plda_init_interrupts()
Date: Thu, 23 Jul 2026 19:28:24 +0500
Message-Id: <20260723142824.726655-1-alitariq45892@gmail.com>
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

plda_pcie_irq_domain_deinit() now disposes of the intx_irq and msi_irq
mappings itself before removing their domains, so the msi_irq mapping
failure path can go directly to err_irq_domain_deinit instead of
disposing of port->intx_irq separately first. This removes the need
for the err_dispose_irq_mapping label used in earlier versions of this
patch.

This issue was found by automated review of sashiko-bot

Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")
Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Link: https://lore.kernel.org/linux-pci/20260718120701.DF4111F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v3:
- plda_pcie_irq_domain_deinit() now disposes of intx_irq/msi_irq
  mappings itself (see patch 1/2 of this series), so drop the
  separate err_dispose_irq_mapping label and go straight to
  err_irq_domain_deinit on msi_irq mapping failure.
Changes in v2:
- Added PCI subsystem prefix to the subject line, no functional change.
Link to v2: https://lore.kernel.org/linux-pci/20260721131522.594267-1-alitariq45892@gmail.com/
Link to v1: https://lore.kernel.org/linux-pci/20260721130034.560632-1-alitariq45892@gmail.com/
---
 drivers/pci/controller/plda/pcie-plda-host.c | 28 +++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 791f5c1cce06..fd1a11b4c8eb 100644
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
+		goto err_irq_domain_deinit;
+	}
 
 	/* Plug the MSI chained handler */
 	irq_set_chained_handler_and_data(port->msi_irq, plda_handle_msi, port);
@@ -485,6 +494,11 @@ int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
 
 	return 0;
+
+err_irq_domain_deinit:
+	plda_pcie_irq_domain_deinit(port);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(plda_init_interrupts);
 
-- 
2.34.1

