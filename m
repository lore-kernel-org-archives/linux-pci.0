Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2A471CF8;
	Fri,  2 Oct 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939405; cv=none; b=WB8NUtMbjiQOxfLy8PYiSTUowEjW9ussovTVqrjGdI9SKwbVTnfrSIAjO4M53jl1mDbI8+dkuHCWpAhGLYjEkHDZ5YArSz3O3E01Id3dqkJXaxD1nXLh2v4Y2coy7FsoxHIOVrThN8I4Vrjpme9OtXpyz1EavkZr1DF+BEl6CXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939405; c=relaxed/simple;
	bh=vRmft4ep/ZtH95Pix6bKYSE8C9H7pDPfT7cVduxXM54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFDVPOmFrdPy7ulMSlbWb6Gih808jyFyOXmaMW1nfs4+EjGURASNm44UCSmjAXKXVNLiLR7GBXDFgU6bwLeKxrN57sMRcghD5lTzHi7l7or7D/fMGIvX3z5OjUbMTgJCH/PuMtjpz/RfeTyg5bx9l3ZB6RI5PVp1A6Jpw1NWyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHFGpLsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHFGpLsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980671F00893;
	Fri,  2 Oct 2026 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939400;
	bh=ziqblg3NCEyxfR2UhozdGKAoh8t0WTmxarHyRhz3RIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OHFGpLsVCIM4n/GCPxtiudURjsVGKrkV9fXDKniq8Z4koSzZE+z4f33MJPJucKTfC
	 cz9ozXdt+i6LC04Bju4qa9pStgj40n5S5mTJ8qKIis6yntFSibCX1N0vnjzJlYmwRk
	 BCvCxKinjKAHuAQwTMepN3JhaiybSYUGboUFA+xhclVRx5frD8DA/F6R+rKn8vCr4B
	 Nk1eitCLnGwZCCTsH8onUZ6IYy7HFHjlczvd6O2xFfxhu1dBlk911qYMWXVvuQWEXe
	 EmhjShuToCxtZIMi7X1laidI5LvfDRZUxO8hZiSpLRcbUnI0ArK7g/lirud4vM73qz
	 WDbXOISOCqTgg==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	18255117159@163.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 4/9] PCI: rzg3s-host: Drop nop instructions
Date: Fri,  2 Oct 2026 14:09:30 +0300
Message-ID: <20261002110935.2004349-5-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the RZ/G3S PCIe IP variant (which is similar to those used on the
RZ/G3E, RZ/V2H, and RZ/V2N SoCs), access to the PCIe Type 1 registers
requires setting the PCI_PERM.CFG_HWINIT_EN bit. Since this bit is not
set on the code paths where rzg3s_pcie_set_max_link_speed() is called,
the writes to PCI_EXP_LNKCTL2.TLS are nops. Drop them.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- collected tags

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 0ef49bb5ab1a..362aa923978f 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1144,11 +1144,6 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	    remote_supported_link_speeds != max_supported_link_speeds)
 		return 0;
 
-	/* Set target Link speed */
-	rzg3s_pcie_update_bits(host->pcie, pcie_cap + PCI_EXP_LNKCTL2,
-			       PCI_EXP_LNKCTL2_TLS,
-			       FIELD_PREP(PCI_EXP_LNKCTL2_TLS, link_speed));
-
 	/* Request link speed change */
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PCCTRL2,
 			       RZG3S_PCI_PCCTRL2_LS_CHG_REQ |
-- 
2.43.0

