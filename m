Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB73546FF;
	Fri, 14 Aug 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716821; cv=none; b=mAzVI0PIPHOjSf/P1G9W2ltpLdIx59U+3OHNFvrUVhAlT5nWWI59zpM/fptY+jnFYPJgFaySw3P2iF7wbOw2jJJCTwvsXyIjDNE1spsBp0b/XfeJlvUOcnbZR2kFAjqvh/v/dNuQHFW5TFPRijEYz71p7nxSH0UeqPP8jND9qmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716821; c=relaxed/simple;
	bh=y9HWoxGfVhv9nuRUK37FTISHhR+iWAq0AczJA69dIAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzoOfMYbk7eQkqr8LVVQKH/g9YgTtLbsurwiWWMTDS04xWA9qz7g5CcTc/eCWVOEOUZv5cRHnK1AxUK8PiSe+SoaynohedujfHYKgXeKt66ORxy6rzawi5GldGZxUDqX9BGW7NP0/6mlvZmOkKF0MKlftbpUk3GI5tPkiox9jHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522A21F00A3E;
	Fri, 14 Aug 2026 14:13:31 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 3/7] PCI: rzg3s-host: Drop nop instructions
Date: Fri, 14 Aug 2026 17:13:08 +0300
Message-ID: <20260814141312.2947972-4-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index bbc5bcec03f1..3a28f5a15719 100644
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

