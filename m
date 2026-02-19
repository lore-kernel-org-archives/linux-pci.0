Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6B30BF55;
	Thu, 19 Feb 2026 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540617; cv=none; b=uDf+KQESkV5XrugeY2iESajaFMNpn/tD2ypDOAW3Ypy9LndgHuLAP44zfPb60gh/pRWAFh68wLghdubfHdGZCzd95ekmC4I7W4OFN1XVSrbljtBiuDfBfwhqgrZxOxBP/CrQ4kiRR81hrE85Rj/jv72A5WIvcvWtaLsZh3bGwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540617; c=relaxed/simple;
	bh=QaGBvWi6zfYf/624cQ5E1W2BOWVf/3aiuNhpfj4TD8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAp4nwc0JcGaJ0fxrynpjRJbCzHbtgDzTDArQbJVCCtvrnPgcUutNJuLxK0a41G1NorQGVp2U9uw7gAMgpoAGYXWVkjRqpx7YlR0GZQ7w+uFqehSJqAlwNodj3njNfnOmWKA0ndrYrStLOx+1bE8EIP5xG0jaUJP+yTdNVvJLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: ML3FU4nhQ0OHr9VQi/XjMw==
X-CSE-MsgGUID: csJHVVsaQIeVbreRAxImXA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Feb 2026 07:36:54 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.22])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 319BE4010DE5;
	Fri, 20 Feb 2026 07:36:48 +0900 (JST)
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
Subject: [PATCH v6 09/16] PCI: rzg3s-host: Make configuration reset lines optional
Date: Thu, 19 Feb 2026 23:35:35 +0100
Message-ID: <20260219223542.6364-10-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoC variants such as RZ/G3E handle configuration reset control
through PCIe AXI registers instead of dedicated reset lines. Make cfg_resets
optional by using devm_reset_control_bulk_get_optional_exclusive() to allow
SoCs to use alternative or complementary reset control mechanisms.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

changes:

v6: No changes
v5: No changes
v4: No changes
v3: No changes
v2: Collected Rb tag.

 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index a90487610b37..338d135154c6 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1172,9 +1172,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 	if (ret)
 		return ret;
 
-	return devm_reset_control_bulk_get_exclusive(host->dev,
-						     data->num_cfg_resets,
-						     host->cfg_resets);
+	return devm_reset_control_bulk_get_optional_exclusive(host->dev,
+							      data->num_cfg_resets,
+							      host->cfg_resets);
 }
 
 static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
-- 
2.25.1

