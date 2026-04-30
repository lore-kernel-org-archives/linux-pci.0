Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B63E314D;
	Thu, 30 Apr 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565632; cv=none; b=UnzJWZ3h5iWJyuMb4D641c/5qVGx75neSJNBXQ7HEYP6v1ULQddZhmNAd/vPJfKrBJxHVOcQ6ZEp+g5CtVnMjIxneBJuBautzapQmo7EezdQI1ncE0qnG5hdp0IW3zC986BK2DMF88+NEOHV0YqUP640Qkd/N3+10fsTWxbMF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565632; c=relaxed/simple;
	bh=//g/gfYin1BYZPPEXv047fnhk6hs7IC+Kacx/LUCRgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJsX1P1PojqhZfkhb3SHPpz8BcIi2XP975Ao70Q8+vwYNSgxxFXhz3OG1rXu2udyiaHFZ5Gb4S5phhjp/tRPVjhzuvFUY3HQxNEM3H1K+lJug4G9nwjrJsuS0z01Zh6ikwJ/gMvB8wJ5T13pQS+vCgRpGfJ76LKM1rzreHdYZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JAecVmDY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JAecVmDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lQ
	fUqpcdUHp737uvF57WjW/GDdEjm5esbQrm+jqJ1Bw=; b=JAecVmDYLJp79ogwO+
	XADTkEiIFyOt7v9d1d7Z0q0YYAn27PJqpXpzqJXdL83I9ktgKCG48RB+HmaHGyoV
	zr7VfgLFidP+5rZYNbWRsHcSujJ7VV4oI+XTwnSCdgFDb7HmbHglThJWYT5ArdcT
	wxs/PN0U1twbxHwfWED3HQAvE=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S5;
	Fri, 01 May 2026 00:13:27 +0800 (CST)
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
Subject: [PATCH 03/16] PCI/IDE: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:41 +0800
Message-Id: <20260430161254.40278-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr1rWryUZr47GFWfXwb_yoWkKwc_ur
	y29r97uFyUAFyxC3Wakr1fJr95uw4qqa1rAa1DtF1Sk343Jwn5WwnYyry8C3y0gFsxZrW5
	KrWDXa4rZr1jkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRleHDUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwdgBGnzf6f10AAA3H

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/ide.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index be74e8f0ae21..beb67b8fb5c5 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -170,8 +170,7 @@ void pci_ide_init(struct pci_dev *pdev)
 		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);
 		if (val & PCI_IDE_SEL_CTL_EN)
 			continue;
-		val &= ~PCI_IDE_SEL_CTL_ID;
-		val |= FIELD_PREP(PCI_IDE_SEL_CTL_ID, PCI_IDE_RESERVED_STREAM_ID);
+		FIELD_MODIFY(PCI_IDE_SEL_CTL_ID, &val, PCI_IDE_RESERVED_STREAM_ID);
 		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
 	}
 
@@ -182,8 +181,7 @@ void pci_ide_init(struct pci_dev *pdev)
 		pci_read_config_dword(pdev, pos, &val);
 		if (val & PCI_IDE_LINK_CTL_EN)
 			continue;
-		val &= ~PCI_IDE_LINK_CTL_ID;
-		val |= FIELD_PREP(PCI_IDE_LINK_CTL_ID, PCI_IDE_RESERVED_STREAM_ID);
+		FIELD_MODIFY(PCI_IDE_LINK_CTL_ID, &val, PCI_IDE_RESERVED_STREAM_ID);
 		pci_write_config_dword(pdev, pos, val);
 	}
 
-- 
2.34.1

