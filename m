Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2C3D9DCD
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169755; cv=none; b=G6ldsTp4yvX9E559aYmjm3fQggMurRylWRGHC/FXg16LQaT8qnkKibO8xYVNWyRRAiXljItnkiwae2qtNNGoln7tkqdmjIUnikt2HZ1UOPs/ipKdB6bEc3xODwBJBaF62qHPQaEmzx0a0aRv3Mgp8TRRLRJRPNrMrJ6C+lBF3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169755; c=relaxed/simple;
	bh=13qbqAzryTLcOBJ/NrIGKEz5d3AP9UnaGQRUX5OGeo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CK3TkH1TfiQTNFdFWbvYrbs6yN+3p14uno0qoqwOrZactvHr4vj4+aGaGfj+XfTJCm9LvAt+RyY3my//Fg9KurGuXwf+8M570tUMZJW4dyke3AIfcmDJmo+1tNhFhn2nwS4T8oksdiTKm1+2g5Arr2GZLpqZzSAJ/r4llqekm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cZmxDJLz; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cZmxDJLz"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2d032846c95so4466995ad.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169753; x=1789774553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArH91frdffOdQcxWygxWviJhRnyFFFtxyckVO+/C0bo=;
        b=ZRGI3XKZ5TKdneJqPYIyEZaJRqO0f6+uokg3CwjDVBYYYtJFONcv9t7xyCbs1n/a+4
         +3aCXO9tnG7ZKiMVWIXys7zEppjKcifkW2ez1Q4ZRxKaEIuPWyvwoXUluiaV9YX4gpVB
         2xZVfEYoETqV7EkOsEsASuBEmYTfSfy/wmkIe2HQBZKfOrwDgzBlR+nGW0WxJjtjgPH3
         w3X45TCZHHwt21k++jFSNgvMF/QjsDMA3qGzjrHA9I48bkVfIl2n/cpU8xHv3hifVJBB
         /T9Lx0ch19b+ZX3FxNjGKmHrhqU23iuYkXVKV5u0SCnWXOCaDDDVCIPTonTvotoTp05P
         HmRA==
X-Gm-Message-State: AFuF++n2tpAocsxalk0fwEpOstX8XeLGJG30JQPlVNxtlx7pkA0G6Bpa
	+TTjE9tudgaQBxWtrkhTe2IDBr35v4rAJA9Gs9EoDa0cOXZn34iu28XRXmIgA6I6Kd1DHoVlfow
	JHLMOEvfspYzvriu1U6umz5jHRk0NbcUBdnyXqc3itM42/dfHNNGAQkdUrT21HeT8LxGeO+1ARV
	bwL5iLvsQVMZbhHyxB1Du8xSv2Rd/xCum/sm/FJmMn8fGu+z/leiOKda7wg/eVcLFjLHxZvnja+
	lv1PqR2zVgkFrh1
X-Gm-Gg: AYBFou2hICortIsU7tsdoNndicUTpvvRdIf1SrP/ud1pJupkyiUiN2nr4LUej3j9QMl
	9iYK6VIo+jLbumjwBTufzGJzu+rMQ4LZyfbGVc7yBFxPd9hBtibKv/60JwtcI26Wt0ATR7vGPp5
	7kGPxMtEl3EW1bhVu8CGNcKJRFZwKWTSTIoDxn7yEtuLR3Wp1m+o0f92iCxLr5QfoSs5sviLr9s
	f9Rtf9M+gHg+9QWLmZl+lyCjPjDM4O3eaXNCYVM0NaBwRpuXOGx5H0axsZhpGCOE+foCQfHHB/q
	BuwkkkiEEsM+a9wiBZqAUiYUGapqJCE6wAuX5O+tFgpcCkY26KeDdytvIvQyMzWUVmpcLiU7ois
	2OP3nNt4HN5wHy2Ai/v4U2BakhktgZxUubVkBBrB5IUMER++4f4MtSi96ndJRASrt0k1OAk6kGr
	JP++vx45zpDLpdRdjUpTygXocT73wNIZpTpNQxYZ4=
X-Received: by 2002:a17:902:f691:b0:2dd:4168:7bd3 with SMTP id d9443c01a7336-2dd41687cc9mr45262675ad.12.1789169752984;
        Fri, 11 Sep 2026 16:35:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2dd2d0243a6sm1957145ad.39.2026.09.11.16.35.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:35:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530e39c5625so8216371cf.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169751; x=1789774551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ArH91frdffOdQcxWygxWviJhRnyFFFtxyckVO+/C0bo=;
        b=cZmxDJLz8MyaGqj4dnDFYQZzTmYD6G7tz4UL48J/V8iKWBFD253cl6ci0AHeb/fClW
         dclKPRnbUx/FRt5VCO+5KO3JZz5iHki7DXmnEkBhTV0zO1EmBoXskZBVEqwXJnwdcfym
         ZsuFIfZxlsYLgXkVa4fJHFOG9osHrHWs8wNTU=
X-Received: by 2002:a05:622a:164b:b0:530:b2e2:9038 with SMTP id d75a77b69052e-530c87b2e6amr91263121cf.56.1789169751638;
        Fri, 11 Sep 2026 16:35:51 -0700 (PDT)
X-Received: by 2002:a05:622a:164b:b0:530:b2e2:9038 with SMTP id d75a77b69052e-530c87b2e6amr91262541cf.56.1789169751039;
        Fri, 11 Sep 2026 16:35:51 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:50 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/13] PCI: brcmstb: Add Broadcom quirks macro
Date: Fri, 11 Sep 2026 19:35:28 -0400
Message-Id: <20260911233541.1650895-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911233541.1650895-1-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introduce a 'BQUIRK()' macro to shorten the calculation of a specific
quirk's value.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 47862569937e..bf002bcf6bd5 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -277,6 +277,9 @@ struct inbound_win {
 	u64 cpu_addr;
 };
 
+/* QUIRKS */
+#define BQUIRK(pcie, quirk)			((pcie)->cfg->quirks & CFG_QUIRK_ ## quirk)
+
 /*
  * The RESCAL block is tied to PCIe controller #1, regardless of the number of
  * controllers, and turning off PCIe controller #1 prevents access to the RESCAL
@@ -1627,7 +1630,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 	writel(tmp, base + HARD_DEBUG(pcie));
 
-	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
+	if (!(BQUIRK(pcie, AVOID_BRIDGE_SHUTDOWN)))
 		/* Shutdown PCIe bridge */
 		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 
-- 
2.34.1

