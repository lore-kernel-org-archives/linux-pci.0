Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13442048;
	Mon,  6 Apr 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472470; cv=none; b=c0ryuj5qrjVbHVr1L1PjGWa1ZIoDYNPX9fPnJRaY5NEpDHcQyBwZUOuD/NzOHHe4c/dg7FuXmr0/mKWXZaEg6fQM+EDgYjs3YYcG9P0zV8G6ndXxugAorfF3zTJa9RBgD1L7N6JdbgWz5QRG7rumFLdpQ9xhSVEXIorl9aXMghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472470; c=relaxed/simple;
	bh=S2AriIuBuvp30fejzWifk5ycdL1eaTUQo96fmsrDPw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxNJCW7YbMFTmETfNc6jG9/8MewF7UXjr/NHG1yHnJg9ZPy5ht+NygJny9nN+BZZ1Kx7ONXU7E8rTdBBD0EuU6GbGNRN1DIubqAMgJX5HaMPG25SvcbCOeOeaKXmarvuFP1JFcva6+BV00NcWZa1ILYjVg79y0uIxmCZMYSc6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=egnCr7Xa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="egnCr7Xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rz
	1RVpHgELYtDURXbx4h0IiL7ZYeCIBnAb166C8nHmg=; b=egnCr7XaJdH34zQFQL
	Z7iiOUww5aGG6WeyAOAxKKQl/4WV33/f6GEvYlar5skg/yfbJgcOXPeatYhTgRnn
	c9/9RpqL7TAoa/ZL9SoDq0goKctUYcDlNkuFJ8vyk57Go7vtCfgQf1pPDZIKobuc
	lwDy3l1nHVV1H1lt1M53bWHRA=
Received: from Precision-7960.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXX3Qwj9NpKHYUAA--.1246S5;
	Mon, 06 Apr 2026 18:47:19 +0800 (CST)
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
Subject: [PATCH v5 3/3] PCI: dwc: Use common speed conversion function
Date: Mon,  6 Apr 2026 18:47:08 +0800
Message-Id: <20260406104708.1218648-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406104708.1218648-1-18255117159@163.com>
References: <20260406104708.1218648-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXX3Qwj9NpKHYUAA--.1246S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWDZFy3tr4UWF4DXw1kKrg_yoW8Ary5pa
	y3AF4IyF48Ar43ZFs09as7ZFyUXFnxCrWDCFZ8W3ZaqFyayasxWF10y34Sq34akrZ2yr1a
	9w13JrWUG3W7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYXdbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BdA42nTjzf69gAA3W

Replace the private switch-based speed conversion in
dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
function.

This eliminates duplicate conversion logic and ensures consistency with
other PCIe drivers, while handling invalid speeds by falling back to
hardware capabilities.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 06792ba92aa7..f2dd5da69c76 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -861,24 +861,11 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
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

