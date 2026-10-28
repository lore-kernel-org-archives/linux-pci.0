Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156884;
	b=CVAvN/17CxogrWHq9wt66lm9toyUqIjd+sMNzTtjf2BnrCMjfNYeX1Y9b0hIfwZrdyHp
	 L0qL6SP6FxtUr24XlrAlAgYCu2y4C3QTpUWLUBXwV5BfVrfMjnaocMNgIQbDc5fO0pbIg
	 mTKQDquPhZE5p/Q08qEWLfjVz2xNKdKhzGl4O1bf1R49DVyAm8TwFaL81js4Oif0T1/Tk
	 Mwld0PtGqIgUznKcb0CTcobj4H+vKUc4DRPST+029jJ6ZRy4xnHSlzn5KjH8WwdWDF8mm
	 HJ9whLWTlHEV1SsHSGeUdfemRwOSKSKiTKIRd89hzKYB4c8zZjpxwiDEFFFXhsqLqSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156884;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=uGOww8cTZ+dmcRduWhvlBtmVa5S9Xqh7rcDtCCMSFaU=;
	b=IVTFTu1LOdT8mocFyr2+hYjfd5dTv4LO13kZRjKtVILdrlvs+Cslnr7cfGStFijgUhPc
	 adcpezR7y+LfShGSKzaD8JCbQxX9NvMhXu/beVGwqzSf+btPNSOVbkV4UyptywrxQqE6w
	 oyzi4E1m9d/oCYRuggSWpmBHDOrswW64qiJZ9N4C4xxo7ih+ZXo6pRsDfWogsKj4Aiznt
	 O4K1dxT0sWmqUgYFUOzqUYe9kOc4/CNT35kV7jCUGGZlBiIzw8D2WdnKegxos0XdSWGjt
	 wpeZYSbmDrGEocFoYeOSh+wVNgZUPX/3/wbg757Sv//lzTaOyOBuOzKjVGajoQqW0hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RSwjLMSz;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC672606A325;
	Wed, 28 Oct 2026 03:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC672606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RSwjLMSz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=uG
	Oww8cTZ+dmcRduWhvlBtmVa5S9Xqh7rcDtCCMSFaU=; b=RSwjLMSzAQnxak8cmk
	7cG9+kuYA6fM6xiN80akLhw8s7Dr7paowbfmps8cOdj+m4q4E3/iC+HYPXjScxR7
	CJJfX/W9z09f3QH56i8pO5ywPoHHyAS3UdLaxVepcGDglSHUjPxK4SmXu7KmviBi
	lwzcQRd5cGDFhgdUvc+MwLEC0=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXT8PnZuFq9rwVDg--.12376S2;
	Wed, 28 Oct 2026 11:07:20 +0800 (CST)
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
Subject: [PATCH v5 16/16] PCI: dwc: ultrarisc: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:52 +0800
Message-ID: <20261028030652.2917756-17-18255117159@163.com>
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
X-CM-TRANSID:_____wDXT8PnZuFq9rwVDg--.12376S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr18Aw18ur17KF4rWF47XFb_yoW8JFy3pa
	yaqr1YyF1kJr4Yyws2ka4DWF12q3ZxAryDJan7Kr13ZFyakrWUX34vk34rtFnFkF4UKr1Y
	kw4FyFy7G3WrXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirWriUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AnmimrhZunUcQAA3o

ultrarisc_pcie_host_init() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap(). Since the lookup is performed lazily at the
point of use, the driver no longer depends on any earlier caching step
and the offset is always valid here.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 523f454c6c524..915305bd88df4 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -56,7 +56,7 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
 	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
 	dw_pcie_writel_dbi(pci, TIMER_CTRL_MAX_FUNC_NUM, val);
 
-	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap_exp = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
 	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
 	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
-- 
2.43.0

