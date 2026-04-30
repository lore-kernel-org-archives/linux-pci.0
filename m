Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD6477993;
	Thu, 30 Apr 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566305; cv=none; b=HDUY+3wMYw8PoVNrGrAlb/ca4wyzBCnwEkdTi7q3HR0x3pDjd40HPHak18ttq+hCX5c1gy0dKNofDDBxLyH1JbYw+PgWLXNqdK88WnKZwBEe+j/IqyZHqggygsVEYDYs8SNjs2XrqUbmFLT17HNxMqv/MNC19YIOqz7z+iVl7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566305; c=relaxed/simple;
	bh=srG+yZobwtkFs3Ykezmyljr7KjBdK21EgkvzAZGf7oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abyv/3zXASgrYkx6pxSYfwN7k0LYpgLRCq+/lyh3gPcVhQLrGNbeL+onTbPyFQD1xLrbB37khRkyRLNxp90j8Fn54Cjt5kWqPHLTastLAKI2KIvBq3V98zu9+uIl9fd983mJU+cQfmiI+jxkbygHudxyNd25GG1a0SA1ufnjdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lMatsQ1+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lMatsQ1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5+
	p21yOHzM6HhEIEW/ME4J11uHV07Opa5IXiJKuYTnA=; b=lMatsQ1+P+mAVueFhx
	ByTEy3KOKqteAnvPjQJ4Z6oAZalw018QcnCu5PD0T88nMiY4+Dz17iV+q/p2lag8
	IpWGuxSIOSsuqIoqG3hRRrnYZGKPZ2wQ+vqugO+AmWzUjRzeZ6omWktxwsm+SdfI
	B5Le9VMAm7sMIWCZDzb8qDFAs=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Df0_gvNpcypXCg--.51103S4;
	Fri, 01 May 2026 00:24:32 +0800 (CST)
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
Subject: [RESEND PATCH 10/16] PCI: eswin: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:14 +0800
Message-Id: <20260430162420.42839-11-18255117159@163.com>
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
X-CM-TRANSID:_____wA3Df0_gvNpcypXCg--.51103S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr1UAw15tr13GF4kWFg_yoWDAFbEvr
	yUCF47Ar4DGrySk340kw1rJr9xA3Z7Xw40gas5tFs3ZF97Kr15WFyvvrZ8tFy3CF1rJFyk
	tr1vqrWxCFy7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_O6pDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wEIq2nzgkFEAQAA3V

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-eswin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index 2845832b3824..ce8d64f8a395 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -211,8 +211,7 @@ static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
 
 	/* Configure Root Port type */
 	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
-	val &= ~PCIEELBI_CTRL0_DEV_TYPE;
-	val |= FIELD_PREP(PCIEELBI_CTRL0_DEV_TYPE, PCI_EXP_TYPE_ROOT_PORT);
+	FIELD_MODIFY(PCIEELBI_CTRL0_DEV_TYPE, &val, PCI_EXP_TYPE_ROOT_PORT);
 	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
 
 	list_for_each_entry(port, &pcie->ports, list) {
-- 
2.34.1

