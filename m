Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104157;
	b=hsC1twIPR9D2ttxbEIlrhCmm3J4iWWrDYj27hetzc4221YNJ+ttxHRuFefCGJVZcFvbN
	 GmeEQSRfymx3YZlKtrHgMziyLQKqEyPOuZrEYMNV8IkeUt6DvQuAYmbQhC4VTej2jHN5K
	 WFYNbv1LI1QkHQ5oc00AzIt8DVwNG7yPKisggGVw/0EsLYen+ZfDFY5HtBsN0Oo7LV5Mg
	 00pMYFaLFtqb0NQpDzIF8LJfeXHQeWRxcfz6jNP/bJq61+m0nK/sQS/Y0izbFXHINGH7f
	 4Z1g8sB9EuXxoPoo9JPR1vzU6Jzs3b0lIvM6ah0D+Iy0Z35MgUbEbTfElJl0aKw9K/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104157;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=65SL1AewKqVdtWsrwvYT4s2cwkDMClnNUoT1ZS12Abw=;
	b=cd/XjspIDVAisqV3uhKqFhoP2oZglTjAYx4XRGKayRCUAz4JHfe7QvAuXJq0rK6HBKwv
	 Y+lKzSE7Rl9cDO3daqKXFh4mRp+NxT0M4NujxRRi3EM0I/Z2mgyC8SrGMS6Gau8arMFjc
	 Xf8cmNaGonSazKHGaCYgAeU6Mf0I8LtpsH9hzOpgS9eJM6G1d8hEq7hBjFQU0v+2q6kfI
	 aRUj6Bw1Jn7spiiuNiMueTyn9sIFyIB6psqnmVZYtmVCuCN9tJaU9tpFgbTDz6Yj0Tr4d
	 rEhwwl2bQmzfe0X3htB7jI0kzpFboOrTUKevBjAnUXe9NHOLMhwlStN8Ryb0FCGpzWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SW6eIvU9;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89C60A2604;
	Tue, 27 Oct 2026 12:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B89C60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SW6eIvU9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=65
	SL1AewKqVdtWsrwvYT4s2cwkDMClnNUoT1ZS12Abw=; b=SW6eIvU9RZVRZrWTx3
	fWDG2za1mcEzzxVI3Fm2x9CiqdlTinhGUJLAPbHRqHHxMJ9CpFeSefPVf5VXadvU
	eJNlkXEcQ8GBGWgZjpbWDSDm9/ZcLG4nymativHlFeBzailRI3KCeZ5r8fXfVNER
	TEktLmFnflzKXz288j1Rpv5nU=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S8;
	Tue, 27 Oct 2026 20:28:48 +0800 (CST)
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
Subject: [PATCH v4 14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:25 +0800
Message-ID: <20261027122827.2725643-15-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S8
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17Zr17XFWkuFW5ZF47Jwb_yoWDCFcE93
	s8WFnrArWUGF98GFnFyryrXryYva4fWw1jga9aqFZxAFn7Xw1kWr92qFZrAF95Cr1DXF97
	Jr1qvF48A3yUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNuWltUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AE53GrgmQEa0gAA3S

spear13xx_pcie_host_init() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap() and store the offset in a u8.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 01794a9d3ad2..6e4c11b497d4 100644
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

