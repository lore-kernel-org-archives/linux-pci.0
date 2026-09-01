Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034639A07C
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225232; cv=none; b=Q6f8TbvSiuK66VUk0DJhICRhCmwBqr8ztf0RyE8JmesJN4ff7wg4+SESDx6O3AFZbgf6CaM69XDJk4Fn6D+BdpumPMcP8cvT7/pdHJ1uvKNZYBm0cbcSKO3UHkkq6EtY13FGqz7u/LgIAgL8iJs1ZzGrgArsbQ+8a8YkdC0D7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225232; c=relaxed/simple;
	bh=WKNiEu5bb54kPNb9BHttsHup3tUYWbXtGShP7J3NSTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI42OHEYxaHPwYz0oO7ikkrTxka+iki8wIp5j3pd0PTuj5OHPT+ThEksvjdoYx8kP2HirY1t66ZeQWoilJBR6yAVZ/SLldWxpz4oUq5yslSCzJO1bm7nb/Wqbsoe3fmDMI32+T97Pz44MB3fsVLYUWMO2cG34CFgeQ/6TmIEyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=LUkh9QB1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="LUkh9QB1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e55b62640so259565485a.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788225228; x=1788830028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3KMFnK7MaewcQgkI6RfHvTFLlVRVgXCbhr3VFJt6MAI=;
        b=LUkh9QB1qbS5Ebdef1hnPz1YpFe912bhC/nANz2FQNEbW36eEEKyImMKVyf15go/IE
         LR0EO+1Dxf1/Bu+UIoyXk77Dp0aNsi40PHAbMC7uIM+bV5K1fjvAGCGGrDY2WSiwb2Cz
         t44RfbAk9QrwviAtzEmLVXJ7+bt+lGOuyleDY5asm4B+iW31N+3YlQ+nKLCKRYecCMJL
         yAC6jl/qCqenleubmFXnTXipi8J/QKLDcckwyC/eO9YxRMiSyec6JZxThWa9guzJYdzn
         Q4yjj3Y4HMX0HF5kC8JAAtB7gEN1/b6+cjjTlrZkHOlS+yfTXDMMp+o2S8EPA5go4gNL
         fAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788225228; x=1788830028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3KMFnK7MaewcQgkI6RfHvTFLlVRVgXCbhr3VFJt6MAI=;
        b=bpgErRztzZzcdnxtDMP96HphLux7sjuG3Ngww+F8scaXg5bzsf5GtiOLosGiL5om0g
         RkVhlC1AFnsvkDiGrRaLog3vaxC1MeFYtCntcu3y5hCin5oWHoxXWq2Jh91N+smqDSWL
         JnnE8PouLUu9TzbAN+EFT6tY2s6PI0EeZIEFvmazg2wfV6DNAEn4gxDgF2W0Ok2Oyvm1
         SOmnPxnrYbRaSi10fFNauaLY32baF+RoT7eJ4tCL4Y4586LlEYZykJ2ZUIv8sga4eePa
         NI9div0rQoBm7+8W0759LsWpgpd5agqLEo7aySPe2wB2db0GqfqeejRCxU8ovBDzsPxU
         /ZDg==
X-Forwarded-Encrypted: i=1; AHgh+Rr02PjTmWHh9y3dvPJu0W5oBZWo2F+Yuh3bnaQ+3L8hX4X+nX5sxduBz5dCiL3DdjwME/Mi290IoIs=@vger.kernel.org
X-Gm-Message-State: AFuF++kiCkxf5s/dToLJjvDGRVKQUOSzeuECQcKLUQTJ/R1ctvu/GmUQ
	icMuIFxkBFFjOLcc5YC84yfz1ezIu7PPs3ZjRngw9lBRtXW9wvL+hHK+By5ZGjTSaqZV3ov4R/I
	oPTp4w8w=
X-Gm-Gg: AR+sD135GQk+szNvTCv2G4RuJaTBIc/5+AnO6fRCJEqRXPeKuP4lhsdqiOtSdhM1ZpI
	+fOG4X042EKafPFK1MLrVuZb9m/xlEIFob/03526quBLqITvG+Qi0AqDtKNtglrebdMYUxSc1eY
	ugKbJ4bUS+HM5I1CUkiLHK0euGXWrJOF+WB/ZgLiQic0ZKWM6ZCQVfiqraDLNrVjjEKBTMOHj9v
	mcQEa9YkEX36a3N/MA9lsx7j7IevJ4AEMXDdZ2KxgSlW+sUIOvRxT5W/x/PmtySri9+YOLff790
	b2CDul6TbN+ztMPcxPK69HI2zQPMz5PPio2YpRb317ceYK0y+vUAYskvcsTpaDMw51CfMym/oF1
	WBKjBsGafEYI8AwiJIRuf4A1Frs3Eckw3KcZFvpoBbKLBzKdnHVHtuf1w7hzpP8MkZwOybu4bI4
	WnGEi8P1Bmh3dQJSwh7fqJjuamrMVs++p8XqItsSg5iHTESjgHn2/DzAPk9ltZJZU1S0hm9Pwnt
	mY=
X-Received: by 2002:a05:620a:40cb:b0:930:b4f9:f327 with SMTP id af79cd13be357-939138df3d1mr3066774785a.33.1788225228344;
        Mon, 31 Aug 2026 18:13:48 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740a307sm581347285a.42.2026.08.31.18.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:13:47 -0700 (PDT)
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
Subject: [PATCH v3 4/4] of: address: kill of_node_is_pcie()
Date: Mon, 31 Aug 2026 20:13:37 -0500
Message-ID: <20260901011338.1323243-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901011338.1323243-1-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_bus->match function for the "PCI" bus type is fairly liberal
in what it accepts as a PCI bus devicetree node.  If a node has no
device_type property, it even allows a node named "pcie@" to be
accepted as represnting a devicetree bus, though it issues a warning
in that case.

A recent PCI commit introduced of_pci_verify_node().  When a PCI
device is added, if it has a devicetree node, that function checks
its device_type property.  For PCI bridge devices, if there is no
device_type property (value "pci"), a warning is issued.

That warning duplicates the warning made by of_node_is_pcie(), and
there's no point in that.  Avoid the second (OF) warning by just
checking the node name directly in of_bus_pci_match().

That leaves of_node_is_pcie() unused, so get rid of it.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Added (new) in this version of the series

 drivers/of/address.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 499d37ceae210..ee2eb44884d85 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -134,16 +134,6 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
  * PCI bus specific translator
  */
 
-static bool of_node_is_pcie(const struct device_node *np)
-{
-	bool is_pcie = of_node_name_eq(np, "pcie");
-
-	if (is_pcie)
-		pr_warn_once("%pOF: Missing device_type\n", np);
-
-	return is_pcie;
-}
-
 static int of_bus_pci_match(struct device_node *np)
 {
 	/*
@@ -156,7 +146,7 @@ static int of_bus_pci_match(struct device_node *np)
 	 */
 	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
 		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
-		of_node_is_pcie(np);
+		of_node_name_eq(np, "pcie");
 }
 
 static void of_bus_pci_count_cells(struct device_node *np,
-- 
2.53.0

