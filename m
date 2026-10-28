Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156859;
	b=ywEjmE+HWYrBS0ML1x3dvMd6vjtA9IN0BWdSGJDaEbpc6URjWMhzYBEntFtdrhzqos0i
	 zzHfjxOpJD+E9eFxMIvfSeKICnDu5UQG4Y6ZkRPCL2bGnV07Nr3EIaR+oO1UATQpzc6hO
	 3yCbiM1EnGj+Zq+2sSe3LNtN8DfF/YQH1K669DBwJudHVz25VjRD1mPulZ0as2eF9d2pz
	 IpIBnWP0E3u5+jOBWGF+6EvC1/uJtfjY3gzhVBnQGPuttD40lKlv91Kr1F2lO9PjjWuBS
	 2YNYdBKY2vRd/4sWJkdCEIZG6h2xuWeBM0QAoHy2TTsqSyKNzSsO78m9KxzLIr40ttw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156859;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=tnof3xP7PItMivWd2BFSiA/M5yZlXFkryB98XPi7W/Q=;
	b=k9GZwsW48B57Za592wwoeVzT+zZ9avGw+R7XXIgMkX97vcIBwRo5Mmkx6A0B1NoFzpRb
	 F70upOdbId0bmBMw8oQ2x94CvcXwFhzIE+dijRrrF0brSPwneLvuM5acwTcRK40GSykzk
	 TInvzMvydW7D5NCDEGDzG5JLomAOBOqATQfCRuj7Yy+N6xPNASnR2tWb3eYojFsD0UXvY
	 SudN4L0ztgL60Ch6LaeCGW5BAqVNLg7MXUWzxHDkHfu3HE0/2cHGDnWfiDLd3sx3QFAyi
	 tMs0PS6WqerLYTTazGiST0IpYOks2As6cxBxotSrVtNVTz9bP7ZL67+JgVa8Jv9vyVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bIxsEJpf;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F694606A327;
	Wed, 28 Oct 2026 03:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F694606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bIxsEJpf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tn
	of3xP7PItMivWd2BFSiA/M5yZlXFkryB98XPi7W/Q=; b=bIxsEJpfxRkV2FpHly
	U0V/n13hcy4H+VcXsozQLSJscEqHzeRDNeppX+qjrcGJCbh7yI8KnZss+KFFvylM
	9UYtdi51n0Ci6fj2DZqcQL0YOgtVJpeyaTOjoYSs37QnxdNq5wh3rIa9hrBiAOL6
	soQ9hKHVWath5V5n830zknt6k=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S8;
	Wed, 28 Oct 2026 11:07:03 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 06/16] PCI: dwc: rockchip: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:42 +0800
Message-ID: <20261028030652.2917756-7-18255117159@163.com>
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
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWrXr4xGF4kKFyDXw47Arb_yoWkZrbE93
	4UursrZrW8GrZYkan2y3yfXF98Za47ur1jga9YyF9xZFn2vr18Xr97X398AFn8GrnrZr97
	Kr1qvr48GFW3JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNMa0PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BjihmrhZtjP5QAA3P

rockchip_pcie_enable_l0s() is called from rockchip_pcie_host_init(),
i.e. from the .init callback, which runs after the controller clocks and
resets have been enabled. Replace the capability search with
dw_pcie_get_pcie_cap(), which reads and caches the offset at this very
point.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bd86e32cc2b15..6d87da43cd6f0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -374,7 +374,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 	u32 cap, lnkcap;
 
 	/* Enable L0S capability for all SoCs */
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap = dw_pcie_get_pcie_cap(pci);
 	if (cap) {
 		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
-- 
2.43.0

