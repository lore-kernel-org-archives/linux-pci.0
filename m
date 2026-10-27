Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104169;
	b=oxPSD5EkmNCsiqWD+cdSKZp8GUKtaipzkOUsZKjKevzz28pd39X4VCidFENfL4oLX/RF
	 XCakhyi1vDW0egB2Vk95VOkmR4x9zBciNWHsHYcc0Sg7N1Gy3tY6NhEOmjd773fs3d4C2
	 NjRNv7RT8MssCEhHe/4+T5Ft+qnow4Dskqw8GcqHa9RTBqZFfb/CxbrL5HpbiuqV4VLug
	 mynrO35uByTxKNPBBwTh7zl2WmHuRF/xagJ5CJRh4+gVh53eRfgPg0PZ+2X2G5yHYfgzV
	 5VaogpxjgaV7j80yCMSNdlVa3VJ1SAt5e1fT5ODQLhMmIaaUmonnyLsTbHjSzhZ+FGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104169;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=tJKsjbxpCgR/MpuZ6mXUaOQY924DVgW1gFjR2gL0Omg=;
	b=hucL0E0ubeFgrxgMT3X4CzSsE5wBSMAPE12vgfQJHps9GMrO+PqLIiQVW6iBbXmKzKSU
	 yJvxPNZwEoeFNj1FdK89TGOLIdCYT9gJM9X5kmH7dSR6X3Czb5ApycRItDJOjfqbIC7g8
	 O31zpVBDb6N2ir+6C+82f/9z7ADCPM5fW4AP8gYEpYtGJji0qiRx2aTU49R+GlHpzbJHC
	 ZycCIDBRn5QleyUFz2B8W5QdMX8dvg/4lychWDc2D8DwgUSB9/R/VUzBPIvvTOHr6ziMK
	 2e2IxDV+jSCNMxYWGSRJRUBl+wus5LG27hIAUY5HbmasJLwUP3OGV0fRQ6S4c9jKhAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m7ZY+dLc;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F6606B252;
	Tue, 27 Oct 2026 12:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 963F6606B252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m7ZY+dLc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tJ
	KsjbxpCgR/MpuZ6mXUaOQY924DVgW1gFjR2gL0Omg=; b=m7ZY+dLcUEYc2TGiO1
	IlPXXho+HNCCQCnBvx4vEAizikJPinHmprvmSdpDKXPUajAxbG6N1yhz8EYI1yYc
	20mDQmvgHvoeSz3j/nmK0Ec0+xpIOnZbeyHKODlHxnrRnVzyrjvCB17RrjXSdHh2
	qKu49tZkMIbdqtxGX+of9Gi94=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S6;
	Tue, 27 Oct 2026 20:28:35 +0800 (CST)
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 04/16] PCI: dwc: layerscape-ep: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:15 +0800
Message-ID: <20261027122827.2725643-5-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyrXr45GF17AF43Cw13XFb_yoW8WF1xpF
	Z8JF1Ykr18JF4SgFn29a1Dur13GF9xArW7Ja97K3WavFyav3yUG3s0yryrtFn7KFZFkF1a
	v3y5tFW5uw4rAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimLvJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xM12GrgmPMXzgAA3t

Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
ls_pcie_ep_probe() and ls_pcie_ep_event_handler() with
dw_pcie_get_pcie_cap().

The probe reads the Link Capabilities register to save the values
configured by the Reset Configuration Word anyway, so the offset is
cached there. The link down event handler runs in hardirq context and
can then simply reuse the cached value instead of walking the
capability list every time the link goes down.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 527c57114dcf..113be247b01b 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -84,7 +84,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
 
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = dw_pcie_get_pcie_cap(pci);
 
 		/*
 		 * The values of the Maximum Link Width and Supported Link
@@ -268,7 +268,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
 	ret = dw_pcie_ep_init(&pci->ep);
-- 
2.43.0

