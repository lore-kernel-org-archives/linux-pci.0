Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36442E01F;
	Fri, 27 Feb 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206399; cv=none; b=mWdE/9rk6MfH1MRq6wmu5uY6OfU6vvQxCGghDIT6XGy30UWKZXpvkVk2Nwg3caLqsPqABEPI/VrbJbj3CXsUuWqYOJEov6rI3b4160gQimtpx0g1Rw4jXEAlZJe6slaCps58XRgw/djVkUltlZ+txeqA31igDluxMMP/6gUT5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206399; c=relaxed/simple;
	bh=hFRc2+bPouxnRnd3pvt5kXt/HvppvPLIcfPwpR8wkx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNhF7rtHH7RK+dOqD4uz75GwlO0c0Ev/ghNSDtIx45sDDDtwY07tMVXS55uoeVYyUdcK/lmSqInpk/LqUt/yJU4qz+0SOWEu8RE/StkIqeJ1qqJSDD+HuGrfddEfJkxYT2pH9AIZKK6a6YfdrhczqOtqa4pO5fO3Kv5ZEzPBiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: beDxGY1EShSvzpZ9gi65cw==
X-CSE-MsgGUID: 2TPu7APdTLyiiiGtaM1pyA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2026 00:33:13 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.57])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3351F4006C61;
	Sat, 28 Feb 2026 00:33:07 +0900 (JST)
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
Subject: [PATCH v7 01/15] PCI: rzg3s-host: Fix reset handling in probe error path
Date: Fri, 27 Feb 2026 16:32:21 +0100
Message-ID: <20260227153236.55988-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227153236.55988-1-john.madieu.xa@bp.renesas.com>
References: <20260227153236.55988-1-john.madieu.xa@bp.renesas.com>
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

