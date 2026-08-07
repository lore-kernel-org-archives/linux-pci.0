Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D80345CBF
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131667; cv=none; b=luU8Wph03z3y9qcuOl2UwhlOGKmRa0ctvvdZeknWy+C+fqD8Vy2AAaIWvlcqtpeARWJmsqzoz9G5UBnNHCqSRLNWKieBd9FjYC6wF8jmibDJItSAWpKMixwnpK/bJf3fj29CIfDuvuko4Cam9aTUv4p/AKcQoxl+eAIxOFiatPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131667; c=relaxed/simple;
	bh=6MU93lD7oPCvVgWA1NeStXtYPktufCBo3mj6HDbyAGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbfRXt2YmBgtLhq/nwbvZ4vmTB1w8qTTCUe9pJSnsO8K15TeC/bKzDeTEaNJHBXiRmXsLzmqU3FHkilWVdJz87OobjToamHexTcfXlO5ZI362WmOiIW3gdRry805YqF03W2znq4yPpc1q0PJ0t1lR35TyYuy2D4JjfOuNrWKFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=wUNpIoqs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wUNpIoqs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93108a3c326so163712085a.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786131665; x=1786736465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y08cvUPAERT8DtacgubgZYXObs4Ve5NXsThRcrzdsK4=;
        b=wUNpIoqsqglIHJWespfQvDI+wIzIueSma7+g7/CuYQcYlcbJCgQgH/upekBdu2pR5Z
         yT5FShjL2dbUziGTtDPjB9rC5JEGyiBDAhZrAfsb6Yi+vZUktlynnW3wcXJlRRKkITmQ
         Fv4x5AvdvFd9bq2ChPlU0ct0st17xUyNmdd/gkYIQdiAAONKlTL+PAHGr53Rvg6h5AwE
         fniFjAvZ4V/M39C/QfRXNy0S3FoLN9ZzdiTaJDfMcykm2uakjqREYAGnF/NtGseExAVu
         HImC/D13CuRTGRDC1w4ISttWy9kJ1s9GL8/98TH05tBbXeyRFKrM/ie1Fuj87P/nVSyS
         70HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131665; x=1786736465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y08cvUPAERT8DtacgubgZYXObs4Ve5NXsThRcrzdsK4=;
        b=Io3KDFq3bpnVK5Cc3g09Xkrz/utqegbi2HmxL+Apc1l4GufIt2xZayKwFgRdrntPGA
         X+kxpuutsPrvCmthchfZJ8Wu8YLAJfuVlzhDMgxGFxvtlI13QCuh7zzUg1DlPWBpfLcB
         bb0fUhG/BQQn/6rwGj9A+0xp8Tc34RH0UTs1tk5wXAH/Fz/lZfAUFtuyCxB176OwQlt8
         CVcqa2o38PJ9Zr44h8ojeBXMFpeBuZ/5VVfhtUj2UfmWfTCYX6/mmjXRAtEsYR8a/4TG
         gAtnFB0CxdSyVJP+TaUnz8W1I3s0Puvqs2TJv7Nxf6Y8XDIOVNtilfGZ6hpyHQjBWqrH
         /3Nw==
X-Forwarded-Encrypted: i=1; AHgh+RqjaNIOarLvtLlRmx5fO3war+cGv4JjzTbX2kKcsPhobrCn+2SokFQY52vnSB7zTO919BIVn4/G6KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4ZJa+KMiAgYzaPqPyAlp4YTmGdVtauasqIlEMI23aT5g9bgk
	sAO6UfFMkrZrbT12pIlKs5oFd7TlTyHp6DhSg9/Cwisv3t4gldDdvAbfm+J+YS8ASIc=
X-Gm-Gg: AR+sD12w4JhQTWqcyV52XvBDLJVI7+h6wnUB8I0iqFjKqT5272toDAbwtNc6jkvO0Wy
	cd+pqL6+NuzkWhi8gzc/Aod/0B7etLK0667+YfJbBULxdDf814BgvsuX34bxWb/yO0ta5nh/gVA
	N3Q2tHGfIJXJYdKjlTBRyMYXxy1Vtei/7SsGHib9qh/Q0A3tsVjxAm7Oxtt12U2xH3XZBjTEU2b
	WfFuHyXyVdJ98pPUseaeRcKK00B5CXn7Z5G+mzEwMwfYFJs9xs5m3D7V0Z0kMDYRKFyutXGqFbO
	colIxjKjs+h8xGKEAgmlU9f/K5jAZ96jVOIsdKugcZhzGM5jDZfY8KSzoXwdfbvljqVrOkmBD/1
	BqPaaS47xoYkz8av8C+CsaKv4v3T/iuJM9WXMmiKQlJDOVACRm3FE6bpaTmGVjCH1WL7/bTvxKy
	TV7n261gzJkT/30CLBf3TlEFVDUujV2nXsc/fwRkS2WyLgGkQQ7RvLcYt2s+yAwMiT
X-Received: by 2002:a05:620a:400f:b0:918:7e9e:de74 with SMTP id af79cd13be357-9367b699973mr103767585a.17.1786131665023;
        Fri, 07 Aug 2026 12:41:05 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03aeadsm219786585a.3.2026.08.07.12.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:41:04 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/4] PCI: of: drop the reg_num argument to of_pci_set_address()
Date: Fri,  7 Aug 2026 14:40:55 -0500
Message-ID: <20260807194100.455599-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807194100.455599-1-elder@riscstar.com>
References: <20260807194100.455599-1-elder@riscstar.com>
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
index 75a358f73e694..505226b876c56 100644
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
@@ -458,7 +458,7 @@ static int of_pci_host_bridge_prop_ranges(struct pci_host_bridge *bridge,
 		/* PCI bus address */
 		val64 = res->start;
 		of_pci_set_address(NULL, &ranges[ranges_sz],
-				   val64 - window->offset, 0, flags, false);
+				   val64 - window->offset, flags, false);
 		ranges_sz += OF_PCI_ADDRESS_CELLS;
 
 		/* Host bus address */
-- 
2.53.0

