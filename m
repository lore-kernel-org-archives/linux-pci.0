Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96003AE197;
	Fri,  6 Mar 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807698; cv=none; b=tsDMIMb3RbxWSPzWvdIsExS7nkTWEoupw8ZYG8urF/jFZqWxAObpNy8wqzPvFMdlPnU2cPpKYUZunQoHEtKnsUV4vpTW789t2ugCWRpRyIp2pAYoZ5GgL8e4SLJU8zfqvJS5yv115kBU6GD6OEkRdoJHJ1u0HQH6Z1GOo9aPEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807698; c=relaxed/simple;
	bh=JlOkbGg7cII2/YAO62WJ7j4GgxH79KZFMoyMtq4sDYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCpzYcs1B0uQjLmScdF4QlqcfAk2O4inYNPUP47x00LonjQ8d/Hk5FeBq3vp6p91lVjpzNH53Qb6SyhBQU2BMEfkH3yI/aIiWLsRnTiGlfmYuy/r9nLjXd5HH2vXucWnJxjS0kecTRsb13BuJl7QA+PqND8ljgVdFvHKie4ErIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: WxZssie6Qy2bxZL1SQKyWw==
X-CSE-MsgGUID: 7oxIWDG0SuyCxrQEyxYHiw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2026 23:34:49 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 21CB04009F91;
	Fri,  6 Mar 2026 23:34:43 +0900 (JST)
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
Subject: [PATCH v8 01/15] PCI: rzg3s-host: Fix reset handling in probe error path
Date: Fri,  6 Mar 2026 15:34:08 +0100
Message-ID: <20260306143423.19562-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
References: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect reset_control_bulk_deassert() call in the probe error
path. When unwinding from a failed pci_host_probe(), the configuration
resets should be asserted to restore the hardware to its initial state,
not deasserted again.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v8: No changes
v7: No changes
v6: No changes
v5: No changes
v4: No changes
v3: No changes
v2: Collected Rb tag

 drivers/pci/controller/pcie-rzg3s-host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 5aa58638903f..58e78fc52913 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1588,8 +1588,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_deassert(host->data->num_cfg_resets,
-				    host->cfg_resets);
+	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
-- 
2.25.1

