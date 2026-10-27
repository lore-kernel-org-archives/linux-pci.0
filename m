Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104156;
	b=VZ6U2s2807qVRxRwptM4Dfpj49Y+5NTUFb+mQMXCPIhD80PpknZ8m2ZHRKX6qGFGMrCB
	 ot3HYokLchryGsEPPUHhtIrWRKCD8b2YkS6zovOrAGEhbn/Kpy69jURhzPSpBj69h3lzF
	 M9fuX0drG8s4fJ/HC4x3dJwczhjymECYY1HumZ2UoniNXuaDAzAwZEuGo59Cgv7eThP3R
	 brSHyxfQIgQJd1KIgX2Mh1jY7AS/bXS3lOprvVERMcTMCJXzaFjT4pUlW2iclAlRY1nH+
	 XT6vqJhT38t1mfLIAwQYBNzkjXpfeVN2DvPDMTrU8GBdJWRDDNdHcx3lNxs0PpK7IDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104156;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=saWYwAO+ESgTqoqpuWDp5pJj1fm4a4bUC7bN/MBxH8s=;
	b=XJlY2VTWYkprefnJdElITfIFLhmRxTFR4Fa2pHkc6NbS9MJIdNZJkir/gW294YIoyAro
	 AHMagDa8BXA16WXX5Oo/NRYplMsVZLvI3cRQAySAURBLCvYSckynR6L9JQi+3TvdgXtNH
	 BTbLRrxuKbSNV8zkwRMcD78dCfWJWb+qjh4+yYm+J38E63iD3j+rBafkcyo9WzChgUAfs
	 gY+jo+5kML4m4dDhsKMbHHTOMDE5YoACiEmHHDnPR09csJJVCx4djIzMrWvnUOi5ZJxBU
	 P70nxaK9m5/aqtviwfGMjUa4wpcOhwco9MDPZgfNvlRVFOe/x3YYOJ918mBiRIUi50w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XXxyUugR;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83D606A32E;
	Tue, 27 Oct 2026 12:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D83D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XXxyUugR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sa
	WYwAO+ESgTqoqpuWDp5pJj1fm4a4bUC7bN/MBxH8s=; b=XXxyUugRyVSO/VWHRU
	5foORZsJn70jb/MqKM1iUx1MIVHh1fjY7dqXqTvBihmd0iN0VBccCtph2+HbAO8M
	IhBlLQyW7Pl5hNKEfEx930OOzH9v9fQw+uwyvgFYyWSZAh+IWPJqomhspeVGcloa
	sQg/zYUqMwdB+nbqQJaXbfV3g=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S9;
	Tue, 27 Oct 2026 20:28:38 +0800 (CST)
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
Subject: [PATCH v4 07/16] PCI: dwc: eswin: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:18 +0800
Message-ID: <20261027122827.2725643-8-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S9
X-Coremail-Antispam: 1Uf129KBjvdXoWruF45Aw18JF1fAr1xWw1rZwb_yoWDCFX_ua
	4DCr9rArWUGF9Ik3WSvw4fZF9Fya4xZw129a4rAF9xZFn2gr1jvFnFqFWDAFy7uF1kJr97
	Jr1qvFyIkFyUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNHq2PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BY22WrgmPYZCQAA3h

eswin_pcie_link_up() is the .link_up callback, so it is called on every
link state poll. Replace the dw_pcie_find_capability() call with
dw_pcie_get_pcie_cap() so that the capability list is walked only once,
and store the offset in a u8 as everywhere else.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-eswin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index ce8d64f8a395..3d3275237f3f 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -84,7 +84,7 @@ static int eswin_pcie_start_link(struct dw_pcie *pci)
 
 static bool eswin_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
-- 
2.43.0

