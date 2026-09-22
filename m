Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659C38F93B;
	Tue, 22 Sep 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088411; cv=none; b=k8VGRhzahqsIdZu2lUNMoXyZWCy9nlaisWJOSRrXDP+MtEL437i+wgmbghbDIGMoV9YyjGIKx5m3zEIf/DEnshLdxW6ZTqC8AAjirIv6fbpuDUP46oUWu3g0G71EUWQ9SA9VmiS+xyGGXS3mtSt5lk/B0HGTsaO5JQT4bnOEZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088411; c=relaxed/simple;
	bh=wwufuLELSds9wVTxto/dkja2RbQ8fZWFw747b6hTBaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLorIVwmyY4fMCgaLgb/TKPW+xz3GvtFr/nI4CoSYpI1f33cghWoBXhFVNjZFf9endLG2PoTQdwH55m0BJNrcs1GHoPfnbDfUZI+s8UOli/BbaM5vErSUyJ253m9oYIcGyJ9oytIzaalFrvYdkWj/w/nXcqv92ZIzmWXOKC0aP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijqDtvNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijqDtvNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB13D1F00898;
	Tue, 22 Sep 2026 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088409;
	bh=4TYtF8vLa45WgaHozUCIJlTCj/3EIrIVec6Tu44b0Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ijqDtvNn8KedVa8AGAV4J9pvnyYZufE2KXSg8oKE2iYsgB1nVJcnTjD1Jda9/GYzR
	 9tSMFK9nppZYvG7NjXhEoiHG0lTj9XGprIJA6vqLAUtZOkMruugajYJ3af/GOidp+Z
	 OxVU6Ja3EBp2mPgEtrCu2la39sse9a6S42oic6wgE58KrWFQt1gsK8pk1jK+eCJ5XR
	 KAnk0NP0+1574EbaAhzLikmOS2i/EQkAEYzroGKATaT7OecVukpSnz9h3YDfdCindc
	 8jJGxmnFt7Q76TwBFXOR2xp+V7Q9ES9Y83TdvQmmlRGnRLZTphW3S+UqfBQ3kBrFJ6
	 1AknoAGFznSOg==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
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
Subject: [PATCH v4 3/8] PCI: rzg3s-host: Drop nop instructions
Date: Tue, 22 Sep 2026 17:46:23 +0300
Message-ID: <20260922144629.586997-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922144629.586997-1-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
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

