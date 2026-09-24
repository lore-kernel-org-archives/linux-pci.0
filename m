Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660449E149
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262155; cv=none; b=N5ypLWcZ/uF3fbDB/Y0OcsJtZelQFXKChtYt52JrisGZ+UPsN+gqJ5Q00NRDOWgg0bIvISzOiAUid8i4CKUqKWd5ShtDHHdzngeK553C8T/XfT+9ikmq/Iho4J23+KM00hPBRHYgJrgOrdFDIvkdL2o0T/c8GiIGVvOxqIdXTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262155; c=relaxed/simple;
	bh=dSVFMgBYNWS5F0FgVH/G2sJcIm/aUqTCSZVMKsCMKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sC0YGE5Ep4e9Bj0fqscba+XwLUFkWrqeSNRB3sURWnoK2nwLeWkPnxx4WubH/LGTU2UUk1+4SzrIR80ba3laZsz3tpFC3jgKutKhvrB8kIghJ7jRpm3OYYTkLHliCW0LDdM/UfOCAX91tAu/csYEQlQ80XzhuC0QVqgSXxyy1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=QrWyUEkh; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="QrWyUEkh"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so27221277b3.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790262149; x=1790866949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbp0io90tD3hLKOmsDGrt9wIS9lt0GeXuRra07vYj6c=;
        b=QrWyUEkhp4k1CScxiasUe0+8crFmEganHkO7zzka6KBNitcnC6tS9CW6pow2XyLVPA
         xR/v5tqYM2Gnars7P6jKSvhfGBfU8c1OehY2nR9ucAmfUYg77dLrLmf6PIerVqg/u9CG
         G/6+TC6g6GVKyr1kqfOyT/yfdlDL1GicL40633poNzXzrGHm2Nj/xfzkIZSkFreLoHNw
         Q3bFgbOxAnhzv1UzTzoYwnsMBeA4QHW3Vusn78hMD4RffPj/F1azaCZ7R/zGfH43n71J
         sr6dqI2DEDCkrLMxVfw7w4g4vWnf/btoQ1DlYBIVLpMFsx3lMRVHFUJsl5XeQKPl1JvL
         pytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262149; x=1790866949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tbp0io90tD3hLKOmsDGrt9wIS9lt0GeXuRra07vYj6c=;
        b=M+sbKP0cK18lQNMfh6C+PutrN0jU4PW0DIsCqBBkJ4gU02IxrRO7PEykC3F5J9ln2O
         OXbEkMtZFbMP5l6U1hWf1gSaIKD8YPEeUYk7SF6+1p4hlYnKMed0obR0V/czJI753B8x
         dHo8aJI6gm9lW5G8wX0F/haW075smVfylkiU7Dw2yDKNq2GnJ3tCo8TOMhy4DxIH/Wa9
         RsCPcnfwdDtaWXwzfsLcCcLw2X2q1q0FdR6TaJG4u7AgPTRW466Mt/Msg0+wwbEly3lU
         yCLgOVq0YcBYS376YSYoEkCO5OmgV6VPFnSJKm9z8Wodp4o4skMLcMztGtcJgA+gsV5t
         /niA==
X-Forwarded-Encrypted: i=1; AKwUvBzUHgkNgRUUgcXGUpEUDRWnyLV+h1/7fQ0at8N8ipihopcWP8amRE86hYqFWtISarwcayUpH5tJvTo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5UCtMZpJxtjtYNHFbrpYlIZgrH32kVS1/TcCmez2TyGG9xJrQ
	twRHRhiti4X+F+LxW3RJ27ygsHjobRbp47KSNa/8I18WK7z0Uit1Q5HGYWWpbdP7G03ly02f3Ec
	+WinQXt8=
X-Gm-Gg: AYBFou2mA2XrJT8sNx8BBhGbCMW7AwTM8G50vRt3qpFR0urOXHrMqlL74fVvz4RZGFL
	T719OcZLvgMIDOq0jK8veegXdYvx+B+mZdIqh2AdnSLmzNwEhyPiZI+UWwYG+Uik6J+lY02VwoW
	BbvG2Cj3QTYvUCaAY8gre/UXZ675rUIlLIR/QkuSRIV/hoClj3N9rPC27bld2VxLCwBTeaDOXL1
	TQX080RrS2KyW+/+vbdZf2xYHgQpZmfVcTDZN88prHogP7MmW0Exv0LLPYE+0w0n4oidiRrjmjw
	lwgl0xD+0UbKcMC8hPDSVPB6//uODILZFkUl0E6W23lBDiU606M0/U8/S8KRlXLvB5rkO5hAi4k
	SQtBTnkjv0xVZIrg1FAPfo3D/uEvYGSFqcwUySrPiMIwCyD+R0ZMju2f/5+Le62sIdw1X/l4UC7
	C3S4jTu0NgTAirRH0IUoILEmNt+fmLz/XTPmGKUc3I29TxggHzfZG8PPMQsBEUk50D8+V1C3Q65
	XFfdscdBG1TgA==
X-Received: by 2002:a05:690c:85:b0:8a0:e27e:8e75 with SMTP id 00721157ae682-8a64e5bf22amr14434227b3.82.1790262149073;
        Thu, 24 Sep 2026 08:02:29 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e24e458sm18438236d6.21.2026.09.24.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:02:28 -0700 (PDT)
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
Subject: [PATCH v6 2/4] PCI: of: drop the reg_num argument to of_pci_set_address()
Date: Thu, 24 Sep 2026 10:02:19 -0500
Message-ID: <20260924150222.1179235-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924150222.1179235-1-elder@riscstar.com>
References: <20260924150222.1179235-1-elder@riscstar.com>
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

