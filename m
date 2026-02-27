Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4CE32825D;
	Fri, 27 Feb 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206436; cv=none; b=ELcofbH6zfVdXMnzjc00c3b+QpJ8HxQM96ANIeXgXznc8zpIlqdfCzYNL1DPE4IhhhJsmdkP27Rkp2W1QWFbpoj+OESMzfXU5KbCMA5NtgUy62A91uQF86bascA/2U8LznhFTlh1lyV+70aMzGWqdc9w3BTdWp+2u1lzZszEIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206436; c=relaxed/simple;
	bh=DmRXm0syIz4FTQwjGB/yoCjmkhZm36rgHCK1oJXqZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LP1KqvHNlpbbgyux91uMWjkKlaEwFeJi8Lv/fWCOtDV0Nl1sd7NlUX8itQIk0+nJsQsXxAo0jS6PDkczNrj6gNfmi/irqqGCUkpaWx/t9dn+MFEwU0IJcPcLnkbk9IGx/47u85tEcmOismpgKKKCIFkhvERIy8E96mR3sGiFCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: QrqoUFb3Q0K5IAwNZaHADw==
X-CSE-MsgGUID: GD/OqLBDS9OBNF2SX7RTOw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2026 00:33:54 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.57])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A8E9A4006C61;
	Sat, 28 Feb 2026 00:33:49 +0900 (JST)
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
Subject: [PATCH v7 08/15] PCI: rzg3s-host: Make configuration reset lines optional
Date: Fri, 27 Feb 2026 16:32:28 +0100
Message-ID: <20260227153236.55988-9-john.madieu.xa@bp.renesas.com>
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

Some SoC variants such as RZ/G3E handle configuration reset
control through PCIe AXI registers instead of dedicated reset
lines. Make cfg_resets optional by using
devm_reset_control_bulk_get_optional_exclusive() to allow
SoCs to use alternative or complementary reset control mechanisms.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

changes:

v7: Fixed checkpatch commit message line length warnings
v6: No changes
v5: No changes
v4: No changes
v3: No changes
v2: Collected Rb tag.

 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index b8a3abf7b6cc..c741d5ac2594 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1188,9 +1188,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
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

