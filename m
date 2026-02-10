Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78740A59;
	Tue, 10 Feb 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723188; cv=none; b=MqaaSHmLGhO6br1ZmObjSL7jWzt0P+CnNYftlLOpTQiXA7KCcq/H8Mb5lIgOjFeDlrBkXOdWic6h3xJDYeRfIKmyt5DwEPkwzUqZ0XFP+nj5VnBQ9tECBrtSspNl1HClJXmfYEZtPyzg+BGzU6pzVp8FVjO7GKd+cBoHTUhkp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723188; c=relaxed/simple;
	bh=gyD2GddNRbRndZTHvvcPWERZvEYMrh+98j+N4x2Cj8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4I5paJSrHBlN+Uo5blKvQ/3GtQM9S/WW+3snTOBI219j+uf4RTreSGVUusFo3z93/LU6jAXG7upDZ/0XO8dGgl93uPx1MaZ7GUc4oWiN/ueOzoUDc5TK9fgujHqo4QdqnXAOngDNDLUoEF1LWcxgpY/p1Cw4leZFZxwGffFZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: XSZ/40ryQkebgkqcw6spdg==
X-CSE-MsgGUID: pjN9xG4wQBORudTQfSYuWw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Feb 2026 20:33:05 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.55])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CE73941A1194;
	Tue, 10 Feb 2026 20:32:59 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v5 09/16] PCI: rzg3s-host: Reorder reset assertion during suspend
Date: Tue, 10 Feb 2026 12:30:33 +0100
Message-ID: <20260210113041.138430-10-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210113041.138430-1-john.madieu.xa@bp.renesas.com>
References: <20260210113041.138430-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder the reset assertion sequence during suspend from
power_resets -> cfg_resets to cfg_resets -> power_resets.
This change ensures the suspend sequence follows the reverse order
of the probe/init sequence, where power_resets are deasserted first
followed by cfg_resets.

Additionally, this ordering is required for RZ/G3E support where
cfg resets are controlled through PCIe AXI registers (offset 0x310h).
According to the RZ/G3E hardware manual (Rev.1.15, section 6.6.6.1.1
"Changing the Initial Values of the Registers"), AXI register access
requires ARESETn to be de-asserted and the clock to be supplied.
Since ARESETn is part of power_resets, cfg_resets must be asserted
before power_resets, otherwise the AXI registers become inaccessible.

For RZ/G3S, both reset types are CPG-controlled, so the order change
has no functional impact.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v5: New patch as per Claudiu requirement

 drivers/pci/controller/pcie-rzg3s-host.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index b3b7db93298d..2cac4b68c0cb 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1662,31 +1662,31 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 
 	clk_disable_unprepare(port->refclk);
 
-	ret = reset_control_bulk_assert(data->num_power_resets,
-					host->power_resets);
+	ret = reset_control_bulk_assert(data->num_cfg_resets,
+					host->cfg_resets);
 	if (ret)
 		goto refclk_restore;
 
-	ret = reset_control_bulk_assert(data->num_cfg_resets,
-					host->cfg_resets);
+	ret = reset_control_bulk_assert(data->num_power_resets,
+					host->power_resets);
 	if (ret)
-		goto power_resets_restore;
+		goto cfg_resets_restore;
 
 	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
 				 sysc->info->rst_rsm_b.mask,
 				 field_prep(sysc->info->rst_rsm_b.mask, 0));
 	if (ret)
-		goto cfg_resets_restore;
+		goto power_resets_restore;
 
 	return 0;
 
 	/* Restore the previous state if any error happens */
-cfg_resets_restore:
-	reset_control_bulk_deassert(data->num_cfg_resets,
-				    host->cfg_resets);
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
+cfg_resets_restore:
+	reset_control_bulk_deassert(data->num_cfg_resets,
+				    host->cfg_resets);
 refclk_restore:
 	clk_prepare_enable(port->refclk);
 	pm_runtime_resume_and_get(dev);
-- 
2.25.1

