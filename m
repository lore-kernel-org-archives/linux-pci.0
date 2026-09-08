Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8431498932
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903308; cv=none; b=HZY7O2U+DFBIF5frTMBkkoJxbpiAlRKw4dJwRf3NW8XZ59muQ2afC2zPi2gBrhhNKXz5//5NxoYKiHovYSJngZX7IB5dfBruGnHekNW9TUZYhfDRtfgncUZq1lJsHgKzIty6UCvufreqBvy0JyXNfaJ/E0St6PrQ1wKykKd7Yxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903308; c=relaxed/simple;
	bh=dSVFMgBYNWS5F0FgVH/G2sJcIm/aUqTCSZVMKsCMKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+4XfrIdYBglQcegNY+LK0tlDDFBkC3x0bLoF7DkFzm+7BkKmLd/+wwSZmBEjE1nTjD7oDCttX4LfgYQ/gEr9yivwpZBwOhxRtjdzySil7S3NWkOTJxW3F5rtN+AVWJlYvN1s1dUe9ftrCR1rFQgSpiKw277ecizypw9KaUIlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hzGNbWvq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hzGNbWvq"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9399798ca61so353224485a.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788903305; x=1789508105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbp0io90tD3hLKOmsDGrt9wIS9lt0GeXuRra07vYj6c=;
        b=hzGNbWvqQdA3RLBIXdrv8A8irGa6WhQiYcnlQ879HmC2FD7momMTDkshU9Em6schzf
         wi7d0OK4sSa/Gg3fj0e2gBPOKSdM0jlN7yHHTJ+eXzKnHNKjccoLQ+812GHueiZ7dJzD
         XONmiXZ0Mnjk4QSDANfTA/Wu1HH8h9JN6+bSwv3eTr5hFAzWjCNYklqcEAbAyZdyAOaf
         vIJol0Ba7l7UcOL/Q10BQMv7oDU+7rswPlxAxGWM1117MdKyV/+5ZtJhcFaBCRup0y7D
         a4ppzISlbW+EW6eY+7QNDlWNzTnm6afNqSkwezJtq/jSIgjFTXSKJV/pAptkc3HAUktx
         xudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903305; x=1789508105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tbp0io90tD3hLKOmsDGrt9wIS9lt0GeXuRra07vYj6c=;
        b=EVdj9Ty+jyp9dsAPsa83WVtgadK7VJfHxk04n5gC4DH+A6U6bqV8iPCLcB29A5qzOp
         +2Kng9eLGJiMV+GNZmC3+RIClnp8J2KPwxue+D1VCenfZ81aUGDVYChce5wPoDWSrnu+
         IbrDQhrdqYGDesz4RTpiLsasAnAx+RIr8cVnaXBcj+/wwy30fdbul1F62AYOzTrWkotG
         KwaGdVrnTNHQaSSpW0Nwj1+yN5x9B2egzxe/eocYs/BH7SueJ3pnrr/HVFKbafSvJy2h
         YK4zXUt4ymrRon6ieRzqnHe1mwPdj3WGplcj4NnNttEEcCQ3quL9/sBsU0ng0UFlMo4o
         h00g==
X-Forwarded-Encrypted: i=1; AKwUvBx5XMccOyMlO1xY4aHtFUPNuIvJApDczBGDY/RglFUeWFndnKI/AELkgTjo0pPedfC2c2FNzr9c5Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++kAOg7WzRN5C6qSjP7c0WA8Nz/jvq2tiLEyZ1k8Nsf4+Iu4s/su
	XxdfyDDsDbluHCIwazXmTh4xYN33kDbuD+1Rue+vJdXeleK90agqq4XpHN24oP8o0TA=
X-Gm-Gg: AYBFou2O24qnkFSaLTveISArS6MaCf2ZTK3DrfjtjYY0F3bqNd3hYpWC+aQz0E087RI
	vvECc2OJsTJJHS/BAnWe3P+BywLSkmlXeupNWu+qtvCAtzmIPlTxUxi+XwTIOcBwWkigKuer/Uc
	6Gs3HnkoXNjVawEnQiUxWedMOZaRcMQbLAuf/GqEwpZiFDc2hSHrAy6Nkh/FXwtzjaaYwg9y6Wx
	t0l0jWnGn4oAHm8kGUkSSxvX0S+JPS1I0IJaZjnnSnE/VcqXQCmcGBvNeDIs9JwZSGFaeb1yOP5
	64J6ABZkeBk5NK/dSzuop5bhAbvqWreWBdVrlfPIE/n2gTnAsnwhSE9JQyjKgqXVqLvaxmsEwBm
	eXFDzOJOGdDWiwSl3f+KvBDRnz95hQg5LwCcRYgFWrtgcZ/sQQTJNGxAKfiujnJjOawM/20jrtt
	/ZoAdZTHkB1Ncb/HfwoKRLEzaVwCtWQeYOperL4A4k8lBbQdeaT5/ct34Axr/OXNq43KHinqvIQ
	go=
X-Received: by 2002:a05:620a:8083:b0:932:df7e:b31d with SMTP id af79cd13be357-9398034162amr3348906385a.12.1788903305398;
        Tue, 08 Sep 2026 14:35:05 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm1250497885a.4.2026.09.08.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:35:05 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] PCI: of: drop the reg_num argument to of_pci_set_address()
Date: Tue,  8 Sep 2026 16:34:56 -0500
Message-ID: <20260908213459.2519059-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908213459.2519059-1-elder@riscstar.com>
References: <20260908213459.2519059-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reg_num argument passed to of_pci_set_address() is always zero,
so get rid of it.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index d66c702218081..1caabbd4c18b5 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -52,7 +52,7 @@ enum of_pci_prop_compatible {
 };
 
 static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
-			       u32 reg_num, u32 flags, bool reloc)
+			       u32 flags, bool reloc)
 {
 	if (pdev) {
 		prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
@@ -61,7 +61,7 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 	} else
 		prop[0] = 0;
 
-	prop[0] |= flags | reg_num;
+	prop[0] |= flags;
 	if (!reloc) {
 		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
 		prop[1] = upper_32_bits(addr);
@@ -131,7 +131,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 			continue;
 
 		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
-		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
+		of_pci_set_address(pdev, rp[i].parent_addr, val64, flags,
 				   false);
 		if (pci_is_bridge(pdev)) {
 			memcpy(rp[i].child_addr, rp[i].parent_addr,
@@ -164,7 +164,7 @@ static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
 	struct of_pci_addr_pair reg = { 0 };
 
 	/* configuration space */
-	of_pci_set_address(pdev, reg.phys_addr, 0, 0, 0, true);
+	of_pci_set_address(pdev, reg.phys_addr, 0, 0, true);
 
 	return of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)&reg,
 					       sizeof(reg) / sizeof(u32));
@@ -467,7 +467,7 @@ static int of_pci_host_bridge_prop_ranges(struct pci_host_bridge *bridge,
 		/* PCI bus address */
 		val64 = res->start;
 		of_pci_set_address(NULL, &ranges[ranges_sz],
-				   val64 - window->offset, 0, flags, false);
+				   val64 - window->offset, flags, false);
 		ranges_sz += OF_PCI_ADDRESS_CELLS;
 
 		/* Host bus address */
-- 
2.53.0

