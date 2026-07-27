Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42CC3F58E8
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146333; cv=none; b=mLmkoPdD6EaID2aqDEEG4xjXVvRCHAWf2JNeAOwkDSVJCLhNYltSj5LiXsHkvEa15z5AuLCPzaU3TYXDv1W7BOM1inS/Uom+6zmOOB5ydTJVXSphW6iDnKs9GjmVIn9sMTa8dP9IHIXyaRntqHIoErjzNmtggxob2EH6TCXFH7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146333; c=relaxed/simple;
	bh=pw9oD6T8ziDz5AocQMGcjo0IE2svVURl/d7HMaclxQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVQ1mkC4j5YQjfRhwB90MYcLd1UpiXvPu+L+EWx+57jyzwc2A+Z6K1FSHnMpp1UQHdo6vwuXy+UBBb+GVNuTZUZF8R7E34vnS8IKNiq6aZfBzCa4Zf+e5a/okzBs4c56R0a24TcdbI3Q+DqE6YhJzwWviqAUc+plSq4VO+onKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrLdeVx5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrLdeVx5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1568637f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146330; x=1785751130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWJlDdWHxmS1QqPm+cNMQ7ctsiEfAw9CC6zmRyAodTQ=;
        b=DrLdeVx5dL+qr9TOy6BffyKxdqTAxlxPzpCVdg7NAJFv3MdNh5Pagr9YZ1NzFTqnix
         cv+ZdOvf26XckfZ7/51+TkfRya9t+XAYdh7anwBgTZJMYnJOWktPLMZPcQDxZertbc9U
         N3oiOP7MfA6kHad/EQ4rNh68wfHwZe9Cxmr16RFnBW5NupD+2AuZCx+mZDKeRZJTv7NQ
         W3Saj7/E1ugItFbrTnUJAv/cUaiAo2RHCB5qPp8ETz6lpD6J0a83U/PCKJ31qfbyoSui
         kInM9FElS+5IjYkf2JuVgFX5VZ5afnuQVsHrzuc43XNHuBw01zBYRoUxLaSqpjciOaja
         8EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146330; x=1785751130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWJlDdWHxmS1QqPm+cNMQ7ctsiEfAw9CC6zmRyAodTQ=;
        b=ROkhOBECgYajp1kzHzEoVfH9doNyyh9xZUPP4k5c3aSVTJYT1x3BNcBWlNKU1yg6Jh
         P7BixFeQsPJ1JyeHUQmx5ZcRS4TZd2UZGCBntH+OHz6QL6diNtRAKlfkcUSUc8qIswI1
         eQsKVqC8ktKpICVUjgfxt8jbjiMPB3m7Hjhnt0k+/cpnF+yuA3vHLDzo4B2w1mtjyDbR
         pEIj9p6H0MaXroJQLu7RbRLoi/tJFy8KexILQZZ72zRMBdoSdiIkrvMQ9bxqUmy3K8zO
         pGG/X40b+hqJ3XdZ/Ee/4OngZvLldxo5sJHxYiwwRpuy0mni6vpsXVjU/9E3kOjJq466
         X9Fw==
X-Forwarded-Encrypted: i=1; AHgh+RpyyHM9FPQ5+7OYLfczQTZJqr83zBoMxAlHmztD8/MFXJXjbBI4ENL7CNdM+sF3Gece8tKpC2y4DkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOX4TEe6zcUv9Vo5V0ft2AwBtM5b2xwRJE/B9xJBsOV5pCnoJw
	XEDw8SztfE3w03Lqyh/hTinNhmA/VpII8Tcg2uncSkZ18D92HEkgd/AI
X-Gm-Gg: AR+sD12lFxFj0G4jhhm7/fpvI6cFzeg5oe9HQQzdfaU2sgNE9N50Mu9Lo3QkmzOxtR3
	3uzi8l+ydT8Ehaizmle12RzrmjMYUV8txDakDBzDDrcU/z5RYOpbJZMXiMJmZMxK6Beb6Si/f1h
	VkCKwujc59jgqZgczlI0xW0ZvF2agTlHMGXhWnSJU1GUdmg+JQ1SeOYaQca3m8e2cuvV0z+nGLp
	86hz0LcPZ2UjaHIOU3Me5CbvrKlDyvxGYTM2tWU/dJ4OWxtnyQ6cIG6hpg4dAQVCJyGQIN0BjzM
	r8oUU28KbZYyptwqNxFYtBEZZiD7Vl6J20IVLd2/T8NKsFdX8XJmfPhS16Os8jpsSawew4+BlAJ
	o1ySz301Ns3GeRNw5cW3NR+uwLJbxdE7B/QNAQktPyfoTixFqnyCVSxfCR43qfzJkT128v9WcmI
	wBEy8zYoRhXUCAcuvs+0W1zNbszhOuZ6rVbNsSQ2JPahW1xekG664eRuyXO2UxK0lvHyOfE0VxT
	0D7REKwNLwdXxS8
X-Received: by 2002:a05:600c:1c05:b0:495:607e:5ed6 with SMTP id 5b1f17b1804b1-496b6a31f1dmr94038395e9.31.1785146329650;
        Mon, 27 Jul 2026 02:58:49 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8281:5343:33a3:cac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b842691sm238346295e9.1.2026.07.27.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:58:49 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
Date: Mon, 27 Jul 2026 10:58:43 +0100
Message-ID: <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
parent interrupts before creating the INTx irqdomain and initializing
MSI support.

If any subsequent step fails, such as obtaining an INTx IRQ,
creating the irqdomain, or initializing MSI, the error path returns
without removing any chained handlers that were already installed.
This leaves stale handler and data pointers attached to the parent
interrupts.

Fix the error path by unwinding the chained handler registration before
returning. Also clear the chained handlers during
rzg3s_pcie_teardown_irqdomain() so that teardown fully mirrors the
initialization sequence.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Restricted the code to max 80 columns.
- Moved calling irq_domain_remove() under err_cleanup_intx label.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 49 +++++++++++++++++-------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index f51b5d7c1998..70f1faf7e422 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1006,22 +1006,35 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
+static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *host,
+					   int count)
+{
+	while (--count >= 0) {
+		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
+						 NULL);
+	}
+}
+
 static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 {
 	struct device *dev = host->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	int i, ret;
 
-	for (int i = 0; i < PCI_NUM_INTX; i++) {
+	for (i = 0; i < PCI_NUM_INTX; i++) {
 		char irq_name[5] = {0};
 		int irq;
 
 		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
 
 		irq = platform_get_irq_byname(pdev, irq_name);
-		if (irq < 0)
-			return dev_err_probe(dev, irq,
-					     "Failed to parse and map INT%c IRQ\n",
-					     'A' + i);
+		if (irq < 0) {
+			ret = irq;
+			dev_err_probe(dev, ret,
+				      "Failed to parse and map INT%c IRQ\n",
+				      'A' + i);
+			goto err_cleanup_intx;
+		}
 
 		host->intx_irqs[i] = irq;
 		irq_set_chained_handler_and_data(irq,
@@ -1033,21 +1046,29 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 						     PCI_NUM_INTX,
 						     &rzg3s_pcie_intx_domain_ops,
 						     host);
-	if (!host->intx_domain)
-		return dev_err_probe(dev, -EINVAL,
-				     "Failed to add irq domain for INTx IRQs\n");
+	if (!host->intx_domain) {
+		ret = -EINVAL;
+		dev_err_probe(dev, ret,
+			      "Failed to add irq domain for INTx IRQs\n");
+		goto err_cleanup_intx;
+	}
 	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		int ret = rzg3s_pcie_init_msi(host);
+		ret = rzg3s_pcie_init_msi(host);
 
-		if (ret) {
-			irq_domain_remove(host->intx_domain);
-			return ret;
-		}
+		if (ret)
+			goto err_cleanup_intx;
 	}
 
 	return 0;
+
+err_cleanup_intx:
+	if (host->intx_domain)
+		irq_domain_remove(host->intx_domain);
+	rzg3s_pcie_clear_intx_handlers(host, i);
+
+	return ret;
 }
 
 static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
@@ -1055,6 +1076,8 @@ static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		rzg3s_pcie_teardown_msi(host);
 
+	rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
+
 	irq_domain_remove(host->intx_domain);
 }
 
-- 
2.54.0

