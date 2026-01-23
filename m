Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733E4964F;
	Fri, 23 Jan 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176939; cv=none; b=Fu926UiOlEsFx0edQad0Od5D6AMMX/bdMxHlWYO29OhTtug+2kU88UHE2jhkRNAoLFTBP27EcaaM+YKzrYAH24JU6orNyflkfxo6jodfgmTwfz0bLuWG99WHWHTPodvm8/AY13Ds1HIo4KKJGLJytHfol1UrOJLfnvIXvKjrQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176939; c=relaxed/simple;
	bh=zIlQXtYrqln68IQipaMCYF+ccLUSLR863oJ1QWAuA/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLCe017ZpqFHziqy6fLawmDGyA/Ho3ojakuqiZcQltZrG2+qAeh56/m9BDxBOmZzhokVFSaj9llUUvduM116QS/sqSUuWEQ/WLtsFPVkdenhnV1URuBB6WnS2tbw7WC86hqdqnB3CUtDGJj7bg1405VJ1fpIxk8xf9z84lbZSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: l90cLd6aRROPIdQW5SOx/A==
X-CSE-MsgGUID: S7BVljH8R0iZS9FkIE+R4g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jan 2026 23:02:16 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.92])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3341E406E3FB;
	Fri, 23 Jan 2026 23:02:10 +0900 (JST)
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
Subject: [PATCH v2 10/15] PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
Date: Fri, 23 Jan 2026 15:00:26 +0100
Message-ID: <20260123140031.94752-11-john.madieu.xa@bp.renesas.com>
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

Program the class code register explicitly during PCIe configuration
initialization. RZ/G3E requires this register to be set, while RZ/G3S
has these values as hardware defaults.

This configuration is harmless for RZ/G3S where these match the hardware
defaults, and necessary for RZ/G3E to properly identify the device as a
PCI bridge.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: No changes

 drivers/pci/controller/pcie-rzg3s-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 15ccd9095a3e..76f6d940ba45 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1054,6 +1054,7 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	u32 mask = GENMASK(31, 8);
 	struct resource_entry *ft;
 	struct resource *bus;
 	u8 subordinate_bus;
@@ -1077,6 +1078,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
 
+	/*
+	 * Explicitly program class code. RZ/G3E requires this configuration.
+	 * Harmless for RZ/G3S where this matches the hardware default.
+	 */
+	rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
+			       FIELD_PREP(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
+
 	/* Disable access control to the CFGU */
 	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
 
-- 
2.25.1

