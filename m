Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349D3F39D7;
	Wed,  7 Oct 2026 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351439; cv=none; b=e8VoS7B2Yjf/mObxrS27hJa8wSXpQJWURaBS2rszh/TYxKO+D0BGIsrG22PlsrBFPQOXT4mGnqyAME97zjLF7TDPwrgsAk1yKILL2Sbe+eV/QWIHPtcmlKoZUSRAEAAaak69X8qQwQ/+Z8ldGiNPBV5KXjWphrJeKOrS0i5Am1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351439; c=relaxed/simple;
	bh=XQNXnCVf7n2bmLQBj03OyyfVImdd/3IIX96Vz4YgnjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBsArKJtpY/o2wDML0gfWNj+VywsnMV4iiSktDtSHFejfCxmt32MoYuq7Dy+OrKynYX3SVNjlS1pQ+bGQSHvLtlCarfNTWKcwtQN6/JV9B/1l8jHFaI9n33LoTGmPOLWTPoaSkXQXQXB7CGHCpG2NzWAGSDhdpmhUUBw3Abqe6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBKEIp5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBKEIp5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B038C1F0089C;
	Wed,  7 Oct 2026 05:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351438;
	bh=Ve9zZxCSI5k6t+EOId6x396Ln4cMn6b8p4z+7qTzyeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBKEIp5tVcbXfcevgIEy8FxAVHn3vqpDvT0iH/Mz1x1WJM2Kbgs2Uop6kYKVV2ayv
	 AQowA3Kc/HKRIW+TkcgVzIaX/4jo296IRgqVd5vOdm157w6Hfpju5+PPeA4uQYO0pd
	 YK0RJlIds/8l+e3ebX5PaXpVWRQLtvSGIP9io9xSPxRxxyb7exopK+wsor2kFkE6GN
	 ucF+3LPLsMeYiZrVMwg71EwVyl2W4UJKClv960Flu7L+2QocNE2YlbXm3fyaKM6bdN
	 3D1sFAX/FhCOlLDum1wBn+NtjnxdG50NT/BU8IYygH3pMxOMaUI3wzic+iP1X2E46G
	 1Nb5e8vm+ZlHg==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 3/9] PCI: rzg3s-host: Drop nop instructions
Date: Wed,  7 Oct 2026 08:36:39 +0300
Message-ID: <20261007053645.1391545-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
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

Changes in v6:
- none

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

