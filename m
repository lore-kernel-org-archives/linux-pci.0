Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C12ECD1D;
	Fri, 23 Jan 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176904; cv=none; b=GH50rQATOOL3UHPyazX1jyWRQoSeolLrnj/dWUtWVxJVzttX9CKmIoANUE5/12vO/kvNkuH4aJaurbHXdw1TaBGps2FvWw1cuW7np8bSfD12sVKxHhhAiC5EvozYDgTGF+1BnzLobNpqycvAl4UXy+/oTFF17eZ4BkYa1zPsr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176904; c=relaxed/simple;
	bh=myRWF7HrBVgiW3R/up1GqN/IxJPu2VHUVzTtShXYDqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMi4N8V+eFaEo6YRLYmI+eu7LhsCxE0h8ryBevvDrUFcUgSwHmI+hvtllALd3Rn62WWZH7Z9CIwZXBbUOYdDdb4dE1jRYFJKX+vL9AE8AufolLPKvs/l20PuXgtRBEwvJGxqq2JNgBxEpff1D6SpcWod0OM4RIghZRfMA6fiMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 56cIJbSOS6O1e/zLN0I4rQ==
X-CSE-MsgGUID: bW7z11+HSKyAM0FzG0Hslg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jan 2026 23:01:42 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.92])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81E5040703E7;
	Fri, 23 Jan 2026 23:01:37 +0900 (JST)
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
Subject: [PATCH v2 04/15] clk: renesas: r9a09g047: Add PCIe clocks and reset
Date: Fri, 23 Jan 2026 15:00:20 +0100
Message-ID: <20260123140031.94752-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com>
References: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add necessary clocks and reset entries for the PCIe controller

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:
v2:
 - Fixed clock names
 - Used assert-variant for reset

 drivers/clk/renesas/r9a09g047-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index 1e9896742a06..748339cd6d70 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -438,6 +438,10 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
 						BUS_MSTOP(2, BIT(15))),
+	DEF_MOD_INIT_OFF("pcie_0_aclk",		CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,
+						BUS_MSTOP(1, BIT(15))),
+	DEF_MOD_INIT_OFF("pcie_0_clk_pmu",	CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
+						BUS_MSTOP(1, BIT(15))),
 };
 
 static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
@@ -503,6 +507,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
 	DEF_RST(10, 15, 5, 0),		/* USB2_0_PRESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
+	DEF_RST_INIT_ASSERTED(11, 2, 5, 3),		/* PCIE_0_ARESETN */
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
-- 
2.25.1

