Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082B39C00C;
	Thu, 30 Apr 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565633; cv=none; b=ugU7GfcpHCwJ3rFB0uHmGnMyYo5MogWSSgMWUf/1kJi160n+CxLyLK7ULKxpQZWkKxZegKp+FZLvjd+VKcFq4fVuSBClEqMKHJ1OCE00rUUuXh6j9VVge2XIFbL+vrQgCetVQiu4/4KM76gIDeJL9Frm+VK8m0tjACVxw21Gz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565633; c=relaxed/simple;
	bh=srG+yZobwtkFs3Ykezmyljr7KjBdK21EgkvzAZGf7oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBh83z8Wofo3MyzWQYloe82KUrJTmw/EGFew/BSslVJJc1EZf2oVQt3575vFSM9fNvP06J14e6G2AVuTGhiUoPmDsfuRztLHmjeyCVBTfMvj0QCzSljnaYCBgkx0Eayorb6y20ALapTF3mY1QmVRoWM6xhiX46RN3Y49pYVkza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hvXzZo2Q; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hvXzZo2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5+
	p21yOHzM6HhEIEW/ME4J11uHV07Opa5IXiJKuYTnA=; b=hvXzZo2Q0zewptnF8B
	mJCwTfwJOSrBaVTI4fKyjgYMPUpXy2jwVg/zbiq2eMUj/oVUIYODcqtZcXjPSq7E
	ktWwj/hqKqWquK/3iMiHVe+7wEDOv9E1OkQJKq27hZn3kzt1eJc674Qjwvuzhv7e
	QPjUEf/s6Rat4EVx0eaG6Zh7s=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S12;
	Fri, 01 May 2026 00:13:31 +0800 (CST)
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
Subject: [PATCH 10/16] PCI: eswin: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:48 +0800
Message-Id: <20260430161254.40278-11-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430161254.40278-1-18255117159@163.com>
References: <20260430161254.40278-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S12
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr1UAw15tr13GF4kWFg_yoWDAFbEvr
	yUCF47Ar4DGrySk340kw1rJr9xA3Z7Xw40gas5tFs3ZF97Kr15WFyvvrZ8tFy3CF1rJFyk
	tr1vqrWxCFy7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiFksDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwthBWnzf6v2WAAA3M

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

