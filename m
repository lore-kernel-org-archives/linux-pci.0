Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D347279B;
	Thu, 30 Apr 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565637; cv=none; b=s+r922hD6lUNlOvbkLVuy5EaCW2SVZAm6A/TxPQx5kl56GgB0wcLw4Vgvcuke2yVghc2xOmUiNj7xoLa4I+E/ZITfsxP0AtlQ+rr4iP/1bct7JFMA11LuWzndgZo7Q/6tSJADimdrU2XEQb0M56/fxx8F1Ax17FhqkpvkRpnTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565637; c=relaxed/simple;
	bh=Lofv0m2TVDTTvL1dhch4RPqqM1I+CGS49Izpi9Bn9Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8cvfGOYFjyKPNhAb2ZiZEK/wrQxgAgHlg/MW+oOUg8iNTxqQH/nbzUKd2G2M4f2+R63M9cpioKhmfUsjCbnSSUyC4XZpj6Ae+2+dcpdMKuswjiJtagMk4XIImUkSvFM7k4QIBANVtAmnnKf2Kj/JXpwJ5bhpOkG+Zu/y5olGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FfAhrNzc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FfAhrNzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qd
	4cKyzmhIsbMqkW+nUXtTuM7vNhmRU2nO8tao3v4TY=; b=FfAhrNzcOtjoVjQTKl
	v7NziKjRXaA9pCXIHXIubmq5jC33sW0AAT8Hb+wgRpUJN6z/CKij9p05bEdE5/KW
	AclF/rxXWHgAaRLuilTWaLOZccqKYakOjpnKnOLG7xQD9LT4nFPDCW7btuGr/rqr
	pWpzjIUN+otmSylZ1aosELo24=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S11;
	Fri, 01 May 2026 00:13:30 +0800 (CST)
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
Subject: [PATCH 09/16] PCI: al: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:47 +0800
Message-Id: <20260430161254.40278-10-18255117159@163.com>
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
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF43ur13KryDArWUJwb_yoW8Xr47pr
	W5Ja1xJF18ta1Y9F48K3WkWF1YqFnFvFyDt39xGwna9a1Sy34DW3yFyasYqa47GFW8Zr15
	tw4Yv3WxGan3ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkOzsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AphBWnzf6r0TwAA32

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-al.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 345c281c74fe..ef8c8ce7c78c 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -253,7 +253,6 @@ static int al_pcie_config_prepare(struct al_pcie *pcie)
 	u8 subordinate_bus;
 	u8 secondary_bus;
 	u32 cfg_control;
-	u32 reg;
 
 	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
 	if (!ft)
@@ -285,14 +284,9 @@ static int al_pcie_config_prepare(struct al_pcie *pcie)
 			     CFG_CONTROL;
 
 	cfg_control = al_pcie_controller_readl(pcie, cfg_control_offset);
-
-	reg = cfg_control &
-	      ~(CFG_CONTROL_SEC_BUS_MASK | CFG_CONTROL_SUBBUS_MASK);
-
-	reg |= FIELD_PREP(CFG_CONTROL_SUBBUS_MASK, subordinate_bus) |
-	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
-
-	al_pcie_controller_writel(pcie, cfg_control_offset, reg);
+	FIELD_MODIFY(CFG_CONTROL_SUBBUS_MASK, &cfg_control, subordinate_bus);
+	FIELD_MODIFY(CFG_CONTROL_SEC_BUS_MASK, &cfg_control, secondary_bus);
+	al_pcie_controller_writel(pcie, cfg_control_offset, cfg_control);
 
 	return 0;
 }
-- 
2.34.1

