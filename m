Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EC4657DA;
	Thu, 30 Apr 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566297; cv=none; b=DHBEC3W87rOUCpN8WpMw4WhNkaHhkfoyveG/AyCVujbZWpbb+VsUrNF7qTp5dxlpz/hodCxZC2l0zJT6wKlNt0ZYccVx6TqumpmaF89YZso+CEzZWer1yuQIpkK1ap4pYprN+NbOc+ZNwtLNqYF0w06ebpof3/5l+CYtbmvG8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566297; c=relaxed/simple;
	bh=LyXom0aI8oDNr/p2BhEGgEUfHTYWhiQHz9+4J4UuULk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJLvd7U2RcAwAq5cCKPbG/XWzrfJiH8px35MjOZiyI8s5za7oxYSEeoh/A5+9lEtifQKfWH+zjxO+SurT+/MnLjwBlv+QxG+OMEUKtDhoAWjkdIeut90e/UjPUD9NYre6trwjozgBIcq+1plQysODGPkKWy6+Bc5sbM04y92fXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WO4IMcMT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WO4IMcMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=um
	eHWMzUl4hSLDTxJcBfG2g3uyThkvisFMrecN3+PaA=; b=WO4IMcMTa9WnYBmaTn
	Cqr8Ie7Y9j2+myzalTATRs2341UlSFTHtDj/tDedR/FQ3pPRvvrT5q9N4gFK4VOz
	9tSxX+91qq0ty3NtucJxbBNNNlM9X+wV+xH+nf6nf6DAAaTw/qg9YzHP40yfGhVM
	fTLejK4e/MRdJ+i7OMFJ0bOI4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Df0_gvNpcypXCg--.51103S6;
	Fri, 01 May 2026 00:24:34 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	s32@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH 12/16] PCI: tegra194: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:16 +0800
Message-Id: <20260430162420.42839-13-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430162420.42839-1-18255117159@163.com>
References: <20260430162420.42839-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Df0_gvNpcypXCg--.51103S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF4xJF18JFy7XF1rXrb_yoW8Wry7pa
	47tw4FvF1DJF4YvF18Aa4DCr15Kr909ryUCwsxKw1Iva1kCr9Fg395ta4FgFn7AFZrtF45
	G3yvya47GF43ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBpB-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wIIq2nzgkJELgAA36

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9dcfa194050e..3c831331338e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -872,8 +872,7 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC;
-	val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0x3ff);
+	FIELD_MODIFY(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, &val, 0x3ff);
 	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
@@ -883,9 +882,8 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC;
-	val |= FIELD_PREP(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC,
-			  pcie->of_data->gen4_preset_vec);
+	FIELD_MODIFY(GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, &val,
+		     pcie->of_data->gen4_preset_vec);
 	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
-- 
2.34.1

