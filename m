Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD543E9DE;
	Fri, 27 Feb 2026 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206454; cv=none; b=Gl8LGo0TWWH/fWNjADV26bqjeulogNpXJWRdih7UyCBnsJT8TZWjWW2boRrI4VqXYYrlh8dwGnzhdcMYeoIlAsPHY3NN9hrATx5DehlDyn2NMWm7dYq9oPk+Sm059bDZlk4JeaSJD+OspScphn1EvsxgqzvOOLuBiGxhOC+NrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206454; c=relaxed/simple;
	bh=Qoev3ngKLU8SI2t+DOFVyrCoP/0UY8kenmX/CMkPZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5xBcO146W2YmRWE6Zb3HYaC25xgs5QzCj0RFl/8nQkWJQSehLbU5YAVhlmKeqLaXS8YErPL0d4FWaMCEiOvzKHhTxQzHVWEzjhQ8fnSGrKFYDW2Bt0XKSgzeqc3pOJ+8VaPl+Nz3+78XxevTYQzdX0Lr3aciRN5BMrEdHC9hQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: NdjMi1e0R7+ThqkTjS0auA==
X-CSE-MsgGUID: WIyOxOfHTMWsV467Dw+0BA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2026 00:34:12 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.57])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1F9AC4006C61;
	Sat, 28 Feb 2026 00:34:06 +0900 (JST)
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
Subject: [PATCH v7 11/15] PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
Date: Fri, 27 Feb 2026 16:32:31 +0100
Message-ID: <20260227153236.55988-12-john.madieu.xa@bp.renesas.com>
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

Extend the link speed configuration to support Gen3 (8.0 GT/s) in
additionvto Gen2 (5.0 GT/s). This is required for RZ/G3E PCIe host
support, which is Gen3 capable.

Instead of relying on DT max-link-speed for configuration, read the
hardware capabilities from the PCI_EXP_LNKCAP register to determine the
maximumvsupported speed. The DT max-link-speed property is now only used
as anvoptional limit when explicitly specified, which aligns with PCIe
subsystemvexpectations.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v7:Fixed checkpatch 75-char line length warning in commit
   description
v6: No changes
v5: No changes
v4: No changes
v3: No changes
v2: Collected tag.

 drivers/pci/controller/pcie-rzg3s-host.c | 26 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index bf9dc76fe975..44ce056d62c6 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1004,8 +1004,9 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 {
 	u32 remote_supported_link_speeds, max_supported_link_speeds;
 	u32 cs2, tmp, pcie_cap = RZG3S_PCI_CFG_PCIEC;
-	u32 cur_link_speed, link_speed;
+	u32 cur_link_speed, link_speed, hw_max_speed;
 	u8 ltssm_state_l0 = 0xc;
+	u32 lnkcap;
 	int ret;
 	u16 ls;
 
@@ -1025,7 +1026,22 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	ls = readw_relaxed(host->pcie + pcie_cap + PCI_EXP_LNKSTA);
 	cs2 = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 
-	switch (pcie_link_speed[host->max_link_speed]) {
+	/* Read hardware supported link speed from Link Capabilities Register */
+	lnkcap = readl_relaxed(host->pcie + pcie_cap + PCI_EXP_LNKCAP);
+	hw_max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, lnkcap);
+
+	/*
+	 * Use DT max-link-speed only as a limit. If specified and lower
+	 * than hardware capability, cap to that value.
+	 */
+	if (host->max_link_speed > 0 && host->max_link_speed < hw_max_speed)
+		hw_max_speed = host->max_link_speed;
+
+	switch (pcie_link_speed[hw_max_speed]) {
+	case PCIE_SPEED_8_0GT:
+		max_supported_link_speeds = GENMASK(PCI_EXP_LNKSTA_CLS_8_0GB - 1, 0);
+		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
+		break;
 	case PCIE_SPEED_5_0GT:
 		max_supported_link_speeds = GENMASK(PCI_EXP_LNKSTA_CLS_5_0GB - 1, 0);
 		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
@@ -1041,10 +1057,10 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	remote_supported_link_speeds &= max_supported_link_speeds;
 
 	/*
-	 * Return if max link speed is already set or the connected device
+	 * Return if target link speed is already set or the connected device
 	 * doesn't support it.
 	 */
-	if (cur_link_speed == host->max_link_speed ||
+	if (cur_link_speed == hw_max_speed ||
 	    remote_supported_link_speeds != max_supported_link_speeds)
 		return 0;
 
@@ -1631,8 +1647,6 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	host->pcie = host->axi + RZG3S_PCI_CFG_BASE;
 
 	host->max_link_speed = of_pci_get_max_link_speed(np);
-	if (host->max_link_speed < 0)
-		host->max_link_speed = 2;
 
 	ret = rzg3s_pcie_host_parse_port(host);
 	if (ret)
-- 
2.25.1

