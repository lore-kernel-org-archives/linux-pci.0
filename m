Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A834208D0;
	Mon,  6 Apr 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473017; cv=none; b=m2bpLBW3+AS7U0jFdvUOmNRMpHUpgcjC9CT1cHpiYH83BFzDEChnEPYR3KiuEGTmdWggmZ1x4HuADpGqDtrptzaTMtelY9qcYqQll7USMufKBAS/559jHCKnrT6ywPkXPj96VvPbHTNUBsc7+FcTXO9lO/E6bWrs8ESllPKJ9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473017; c=relaxed/simple;
	bh=Z8kylnjFJ+aJpwBQxW1tMwh37HUGbkbLY43b/JiLq7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auei8xkuVqofxm34xfYy6w7fbjyPITjgpCHLgEkJFU/0cpZ6EkQs3Vlh57xO9qt/Vw8J6/nJSXh9v3SCcZQH90h1mNZ1jM3mUpXIXcmun0y2EbYvxRWebO0xhIah4tP9FY60PP2zTVbOLjYlGwxtUTr1Nlo3T3fNrqgXzLqSZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jwd5zyCW; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jwd5zyCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xy
	Q+1ZInts2Kj8sOfqMzvAw8MSBQMrsqKvKzGRjW+Vs=; b=Jwd5zyCWHJPEY8akZ/
	NIbuNUeBSN1J6JX6oL5K7tBTLbAJXm1da5nEaMWh6pLoyBNsccjG/mZQB5OELknJ
	JicSvoarXdBY2Bur5PSCeHxtFfd/QaM5FXJvdwP0igY3mkDGK74U7rmZfz9aBA+u
	EUFTYukHPScItdAi6q7y6ZfQk=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC37wJQkdNpmdyZDg--.25057S5;
	Mon, 06 Apr 2026 18:56:19 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v6 3/3] PCI: dwc: Use common speed conversion function
Date: Mon,  6 Apr 2026 18:56:13 +0800
Message-Id: <20260406105613.1228673-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406105613.1228673-1-18255117159@163.com>
References: <20260406105613.1228673-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC37wJQkdNpmdyZDg--.25057S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWDZFy3tr4UWF4DXw1kKrg_yoW8AFW3pa
	y3AF4xZF18JF43uFs0ga4kXFyUXFnxGrWDCFZ8WasaqFy2yFZxWF10y34ft34akrZ2yr1a
	9w13JrWUG3W7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnYFtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxPHa2nTkVPzeQAA3O

Replace the private switch-based speed conversion in
dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
function.

This eliminates duplicate conversion logic and ensures consistency with
other PCIe drivers, while handling invalid speeds by falling back to
hardware capabilities.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 06792ba92aa7..ab8dee5d6c7a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -861,24 +861,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
 	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
 
-	switch (pcie_get_link_speed(pci->max_link_speed)) {
-	case PCIE_SPEED_2_5GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
-		break;
-	case PCIE_SPEED_5_0GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
-		break;
-	case PCIE_SPEED_8_0GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
-		break;
-	case PCIE_SPEED_16_0GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
-		break;
-	default:
+	link_speed = pcie_get_link_speed(pci->max_link_speed);
+	link_speed = pci_bus_speed2lnkctl2(link_speed);
+	if (link_speed == 0) {
 		/* Use hardware capability */
 		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
 		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
-		break;
 	}
 
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
-- 
2.34.1

