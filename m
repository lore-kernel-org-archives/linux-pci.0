Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320245104C
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849164; cv=none; b=BA91OQ4+0zrSzINTRUGqaM+8dRJlBb8lQ8/tR95pR1Iy0LCxE8ch8Phx0ir7MJPMAfrqcNw0VgDYzdXpS+PUKnpsODv0S1ui3qDk3UKLng4vS+3ldbsB1rQi7DJxjjiwkiPwgpfCMZSMe/wcKg25RJLm5bf/O11FOfZ8XoDt+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849164; c=relaxed/simple;
	bh=eN2CSRe1cj6SX7Ets3J+ttDAxcMnHhwhYnWMLkppr0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8uNrH/7ja+NEgvoDrA46gCSA8bsPr1HDHvvi67OCunnTwAm1C5zojke1/0r/PD67mHk9NUGGtXROvS0nCUr0Gt7R1KoPUHghXWzpXsWRYAytICVGxOi1lNsa9FPnZLGxD1CLowxXiISUFgdbumUDJBDYJ9oMKJZagddJbh7uAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6BYahzU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6BYahzU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c149c5722so12197011cf.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782849162; x=1783453962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCIb1sRY2uZibdnrFf+JjGAvdQfDmQTgUaE5fwgc6LY=;
        b=b6BYahzUL8DBuO/aAKVtWpG12HSNGllVagwLvk43NudG5tFrCruYKXyhWZR0oNGEAv
         +UB5qiRIDVtQfsOAFw1V/7FLKYu/9dFA9IO5b6+t5x5yjzh41oSqWb0PSJ1QupKWdZ/W
         Zhzcl85yhAQmBZ++0TEBKhhTWvypXr6cT9vuIPY0TiAcCvAr0vBlvlzQ7yU0wfyaBZP0
         DPNhzNz6V7HOgnq02I9lmPdfmtxYb5+4Eelkbb4zWronQdof9cM4oKvD9tY5LBQrOCgr
         9MLQVckmKXV0kVtU5PzsJo0+kpFpJqo/HVh0KghkK0AhmMHC72rl+f+up2sCf1WNrNK3
         /gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849162; x=1783453962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCIb1sRY2uZibdnrFf+JjGAvdQfDmQTgUaE5fwgc6LY=;
        b=oJvlIpgHKtcyQfVpEqonf3SaMq26J/h8d4HimYQNSpSmWeTZacXq9aSMgWwwI5FSth
         ZG0qj7tN9uCXsOzBZCP6E3yYWcu8qyRvqtQGT/zYo2gffly8BvZGHRSHgO5b3FxZYCa+
         RbG6sKu5AXhfyaEgKNwf7omxHTL9A+7uJeFsqvSxaICl1kpTf5ky1mW9P99SfaaDcTEz
         DMRn2HA98hdGBjSklgNSvKzqdmVdED+ec5M/SDh2IxIpZAe8BiOsX97VLRD6jCj2F4/0
         wWG4J1zsz7EHqbUzngXg4tDRj2uBI5CfWTVIZhJsPRKQPigY76QH43sktxbqmtmF2fEg
         BigQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LSj1TgXWfEOipslnPkPZs8Z5cLlWSJMaasnr9KXm0m2H+hMiQp7yBWGIP8+uSMgUtKIblZJC1X30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5Vq1i6wlnWxletRL6/zMT75Ek8Djx5W9Npc48lL3LnEEI0gE
	5lTzUXUSSgYqT2VzDVAfGL6krehIl0cA75ethLNaQmzPfoAfAVBuC9FSKjff35gf/aA=
X-Gm-Gg: AfdE7cmNFPr95JN3m+jxiQdAyz9CckrYYywjr39AzZL4PMES87cWAgCzpWtSn7/vbnD
	uXNN0E7QY2g6LVCegnk0RArS8YEDYW+SIJ03ZQdRTG/CZlhW58iWdTa+g9MIocw/hW9zR7Mdz0g
	/eW5jVNymQh2aikQ0UjBfI5+q1gLPBKGs0BQZf3exNS2bdY6xmUQDoIi5WDJPA+m3WEvDhxgz2y
	Vq5X8ZxGFGYCD5zmdaKkJ4mKwZ9qXRKUCLMJcE76w4VWPiTuDMkWZfhycVSs00dfCU2hkhMzoLI
	sRtWLQT7B/Ozv9U8LFfv+Ucg2BPuYQ0gb54K54m5G3lUpCOeP48ztUVkW3xL9HE+2cCQh8if2Rc
	9g0pu0K0ckQzxmjkgRxaEiwN/ifkfELkTts0mxqNZnRpDJJ+N2Zxk5KaVJuZfkYvKKLq0EQH4fp
	wJDnOdq8OAJhTU+SAJAiWx44rLC/PNnyg3Nu17iCmX
X-Received: by 2002:a05:622a:1212:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c180050d0mr37857701cf.41.1782849161772;
        Tue, 30 Jun 2026 12:52:41 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32c0sm31330786d6.29.2026.06.30.12.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:52:41 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PCI: xgene: Drop unnecessary OF node reference
Date: Tue, 30 Jun 2026 15:52:34 -0400
Message-ID: <20260630195234.1871951-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgene_pcie_probe() stores dev->of_node in port->node with
of_node_get(), but the cached node is only used during probe by
xgene_pcie_parse_map_dma_ranges(). The driver never releases the extra
reference, so the node reference is leaked.

There is no need for private OF node ownership here. Use the device's
existing of_node directly in xgene_pcie_parse_map_dma_ranges() and remove
the cached port->node pointer.

Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index b95afa35201d..83c9a2930eec 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -58,7 +58,6 @@
 #define XGENE_PCIE_IP_VER_2		2
 
 struct xgene_pcie {
-	struct device_node	*node;
 	struct device		*dev;
 	struct clk		*clk;
 	void __iomem		*csr_base;
@@ -526,7 +525,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
 
 static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
 {
-	struct device_node *np = port->node;
+	struct device_node *np = port->dev->of_node;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	struct device *dev = port->dev;
@@ -612,7 +611,6 @@ static bool xgene_check_pcie_msi_ready(void)
 static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *dn = dev->of_node;
 	struct xgene_pcie *port;
 	struct pci_host_bridge *bridge;
 	int ret;
@@ -627,7 +625,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 
 	port = pci_host_bridge_priv(bridge);
 
-	port->node = of_node_get(dn);
 	port->dev = dev;
 	port->version = XGENE_PCIE_IP_VER_1;
 
-- 
2.43.0

