Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156866;
	b=Bk+fZUS1fyPvSOD4apoZGmXEtasPQNNBI0ybzQxiDpOOQoGMWuQ/rGYvpgjQZ0Zoq11x
	 tWvsEXY9YkNpEK6mitdYHO4gIIZGkeb1rXxSxV+yDSNbkT5LycTHey8483iSFzGRaGAFz
	 oPU+XTdorG2QgSCQ/5V7S++vvBWQI54+UKfacmjtLn3ZB9JJY15EnPLTtTmnZ0ohWDq0O
	 A7vVKlO4PTHErskoMiVvbA13z61VZu2tfITe5uw28YYfmKuHQfBVyp5FxKa1sGBbZ2Dxa
	 LClaqTxa7fzYN1Nytv0rnjMK6ceStWUpVCVuBvuiFKkoTwECBpodHjA1A7gd2FkPekQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lAmxH5StbC92YG4VwJJRjtxwLxu+DmfhuOFV/GCQrHU=;
	b=Pbn6tqDUnEK5mpNnkwRCYji1d4Ct4qOO4zMr58z5F8eB3Z1JoYetdbUsOyxLQb0xyJ3C
	 W5iGig1vsX682bCQ6ZU2B6HIX8uvnrZMbYl2TGIrKK6vRiG45PPA9MLEDAMmap0zrBqnM
	 Ig+dby9xIjqY5PRalr9NedW2O2vBV7akXzHNBRjvg/l1Ua4OQl6BV99rMpGKBJZDe5ukW
	 LiR36cRis5NfllTHECdxeC63sPDgPEsAjBsAHi/BvxCs1dSz0tDYGIecW/qm2nkVgZSlU
	 kMgeafwoSqJwLNoqcuY2e9c2dURdqlr4JAijUCKO9Z55SgHDrzbHlqQuhwe9Spqowpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IQAGmgt4;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAA60A261C;
	Wed, 28 Oct 2026 03:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DAA60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IQAGmgt4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lA
	mxH5StbC92YG4VwJJRjtxwLxu+DmfhuOFV/GCQrHU=; b=IQAGmgt4PNZWbso6+V
	pffK2rsO3R0sJtHr69fYShXhUdAZQYnX+4I+/tJXe36UNjjKRCZS8pASyZkOJqZw
	5wAgwiIxCroZtGVTERPriDLYCOVguaN84E1UpII75b3Y/1GlQdZMPZiBlolV1mrd
	meokRbdBJrzjJFIhQr1h7lQwk=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S8;
	Wed, 28 Oct 2026 11:07:15 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:50 +0800
Message-ID: <20261028030652.2917756-15-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S8
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17Zr17XFWkuFW5ZF47Jwb_yoWDCFXE93
	s8WFnrAr4UGFy5GFnFyryrXryYva4fWw1jga9aqFZxAFn7Xw1kWr92qrZrAF95Cr1DXF97
	Jr1qvF4rJ3y8KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM89NtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7APkiGrhZuPTEwAA3N

spear13xx_pcie_host_init() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap() and store the offset in a u8.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 01794a9d3ad29..6e4c11b497d45 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -122,7 +122,7 @@ static int spear13xx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
-	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 exp_cap_off = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
-- 
2.43.0

