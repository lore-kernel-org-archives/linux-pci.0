Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE34A2073
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529576; cv=none; b=KYIErbFlSAaAY0UO7Hf9BVS9hT2GUk7Ky9dqyVkI3boHrPMaF9jn/uAXrABU5VJl9w/vmTWhLZCf8WSPGZUTVwOkYwNimAIVvhQ5bvply98ozfCGY8d2529WbNxGZY0e+TMbeDeoqT9IsjGvyqXk7kYVJ+GPDrmPQIviulpEFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529576; c=relaxed/simple;
	bh=qsvHvr0KAaevLVLkT3vf4bhPnfL4fka0jjcShl0SAUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYefQywe9XS2LzloFW1LHrzYhCOdYvSmZ3uR3tGxfLplxhBZgcbhGYjnidJtapPKjQalegkGJ5/hyDj6rJSsSJ+qCwLTcKG2/lnV1etILsoFBlSpZDR3K9+QCLzyUVguTysWPbM7N5iTrSY3Mg0lk9gs6ppMO6Qm2ROSAoLAO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=pLbOPtA0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="pLbOPtA0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93905b1dc65so75967185a.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788529573; x=1789134373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LewW6w2wMuYs1hjrl9EfxjaqOnpI7soa/xK2a7NCBI=;
        b=pLbOPtA0ajCFEw/z2Ei4jIQVPT4cSFcNKQgxGO0SwpY8anKsWCpM9gHISyCH0FxcYM
         yKUaMyOKTqo67wQdiWcZuABhvys9EXr1b/G+/3mOVFAtC2ItGC0Ds/+s/ev2XrbIdBJf
         JdxufQfo/bDAUe4BC0m1Lf1/X74MXRbOAqBNnj3y456NTtdaZIZUezZ8Ne+CRX6T8IBr
         UNi1jyzy8L9uGkvWju+ZA5GC+zQ8Jv+GvfomVNbK1aWg7BdsWMaDCJvvT/AH2Se1+Ulh
         2q6sWiOZfvaJuTvhRGiQlhcTUvC3atBGsOVAZtYU5RtIA/G+fm85fzWSZDFvRkpNqmLY
         MLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529573; x=1789134373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LewW6w2wMuYs1hjrl9EfxjaqOnpI7soa/xK2a7NCBI=;
        b=SKmffkn2ijAL/GCDMLbQdKr5Or/P/ZLJiYGDP3F9FqM94NLYYHY9bGxCYhkmDsypBi
         0SZ//yPCaN6kyIFnCSDrVIzRccOT6/dGsGBZ9Ro45YHmfFScvoelL2cLDnW8+NewGvyu
         nUjcTc00YDgAFwoSs6J0RjFpDCdC5m8wNZsbesH1V8Uvy1CczXjkQR9ICAVTnH32/sdv
         1ojWtdMzmhppXo7XM8lmsGCqecafIWXO3nazym7Y5XNHy/z7DU9IMFbKKm3KhODcJbpa
         wnuumIm3N2rzsYM0IBidfTj4rpuKHd3+Dc3GrRReLFb6FmpWzdgBtz2Z1Dhr3rtu12tK
         wiSA==
X-Forwarded-Encrypted: i=1; AKwUvBwuaBgvt1cUUPlBnx4OsAeI/C9N48IYWCnnCSuz3EIfWjmxAFzdSe0EtU6cCbNbAYZzjZgYlsZsi7U=@vger.kernel.org
X-Gm-Message-State: AFuF++kFJBwpH3Mkfjb/JoJmWsZK6LOGCvroqTo3hGebkCsGimNA4JPh
	YIkt4Ov2m1CCfCf2u/52jOF9f1HkxfJufVEkpyRPd7VnLsuaKA8Z9ofK7vY9Y7v9+NA=
X-Gm-Gg: AYBFou0Qo1+t+mIQEOoEhw6g4GfBz6sRVHsusRyoBfniQneXlCpw+ZuUxFDCKFnqfs1
	7Gc7dlkpkIR1Po8X6JD7rGwNWr4RpbiE8EyxDj422hxM+rQuNtqQI6bW9yMhQ/6Vxc4QkYK46yg
	NVJI4Z9ZdJ6kyrCysMmBO5r4zXNfbZsOJNwlUg+kzk45z0Ha75si8W7QY4nI+7BLvZgoZYkwuHn
	HlJRzXgiUcUoNfQhpISalRYvdKVvdPpX8/xDfHc18gXbj0t9WfjhuknVwG5n6yirPemd334akt0
	kyJg29a7GcQL93tgvrajRZhQEa1smowYJL8ddgzkUKDF+B7pcOYN6AlQMA+87fCqwTwx4z4H0zJ
	DN5egp2a9HLKPoW5vxlKxDnvvnYqtOhCfLbwnV6xj0WHd763HPfpp+b83+SPOIa0d5mLdTa9ZyE
	XhU8hLGTgN/4U3wTHeiRcmE7XR846RLFIR3e7GwTziDcWloVd9WfrzQDR0GP6H+dAX
X-Received: by 2002:ae9:ee06:0:b0:936:e938:b07a with SMTP id af79cd13be357-9398032898bmr454562185a.8.1788529573342;
        Fri, 04 Sep 2026 06:46:13 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fafc3a7sm211613885a.14.2026.09.04.06.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:46:13 -0700 (PDT)
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
Subject: [PATCH v4 2/4] PCI: of: drop the reg_num argument to of_pci_set_address()
Date: Fri,  4 Sep 2026 08:46:04 -0500
Message-ID: <20260904134607.1856121-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904134607.1856121-1-elder@riscstar.com>
References: <20260904134607.1856121-1-elder@riscstar.com>
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
index a0632f932b5c6..8131aa1b0b3c4 100644
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

