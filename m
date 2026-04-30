Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E546AF19;
	Thu, 30 Apr 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566297; cv=none; b=iMlE6CKvHn07mkb5r/Z92netJa0wvE4ndnxcvUKoI431z+xF12zM7EZVa2NlEOqlMOfFR1w8n2AKp1+byI1llguCqPWJDlAKipaWz9GaXhjJg0V4800Bf+SFAa8UwhqKabsQstvpYAAkiWx/RJzVi886hzIk54EFLf4tZoexnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566297; c=relaxed/simple;
	bh=Lofv0m2TVDTTvL1dhch4RPqqM1I+CGS49Izpi9Bn9Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CB9AdpmZffLkSxVdOH46P/d2YzfP9rbK5Ed9+z/hWB9LOEIjWPJAhTsiueK3/cmHWqaamcWhsBVaXOsWoS4Wk1XxggfHCDz+VerAzShxcPBi8cvo4xEDa6SsOr/Nm+RWBGXoP0mr6Df1dqf4ll36z0maqtw7vrDwYlhZO7xZ6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D5tGn28G; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D5tGn28G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qd
	4cKyzmhIsbMqkW+nUXtTuM7vNhmRU2nO8tao3v4TY=; b=D5tGn28GnSH66T3vmg
	ZiKxqJhWIwnvJrp/3G89ClRaXT80Q7PRsu6mZWaAXuFMBXiEsjBw3s8MB8S9UdKm
	qQh+w+t5vR01w271sFOIeQyuI32a2kT/2FgiIx+SYyWjlqkBc8DN8EtmyBjiDJ0W
	K78D+VQbx6Ew1P6BLLso9/Z3U=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Df0_gvNpcypXCg--.51103S3;
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
Subject: [RESEND PATCH 09/16] PCI: al: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:24:13 +0800
Message-Id: <20260430162420.42839-10-18255117159@163.com>
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
X-CM-TRANSID:_____wA3Df0_gvNpcypXCg--.51103S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF43ur13KryDArWUJwb_yoW8Xr47pr
	W5Ja1xJF18ta1Y9F48K3WkWF1YqFnFvFyDt39xGwna9a1Sy34DW3yFyasYqa47GFW8Zr15
	tw4Yv3WxGan3ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRn2-8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAAIq2nzgkBb9AAA3Q

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

