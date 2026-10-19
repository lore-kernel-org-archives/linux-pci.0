Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37C487CC1;
	Mon, 19 Oct 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392720; cv=none; b=GPAn1YxpVRT/neUTcGtBk3f2zaqsVLsDxwljeyIT2eM/lNq0eMK5u8zfYEdLpgVK0zFV6kmH8u96wRchirsgHxy/ELwSsIHN9/E42P/2gnn1BFeaLvyIrbWhCkbMI/Oydu+6jwJUgYGOg3JcywknLrubqtqXchWbATW0iIH7554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392720; c=relaxed/simple;
	bh=yQ1/4buObH9/Pf6EbjMB5Js0ptPofF00DCJ41+kxf48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAuiIPn8Vxdfk0pZ8jvbcGUmq6isGJ6awv+0kHCY3TNDuEawaDIgmYz6E9GlVhuOV2avzWBhcX3C+7HslxaLL8h71EcffO9PpWepcheW1WTXghHmZt2tNa3FABALW+Na2H0krWtDTs9v03+CDmrehE00y/Bi7x2YKUifcL7pgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwTDxoJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwTDxoJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026731F000C6;
	Mon, 19 Oct 2026 06:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392713;
	bh=DBOoNA27yc6K/EDLNlqXb1EKl8EEzL/I3KSxYepZIHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwTDxoJ8U+EKzFs0SF3+itWG8LM7ojGXEL6huEjPzo6SNXQdqkVT6l0ppeiWAiA0O
	 kS+krytvqiKI3xYJlaxpIl0LyMKFGSLiqVWwAn5gr6EP9CK4me3e5iS4Ds4FkPf/N9
	 TgDFl5BrbSVpNRDHRkCAx5c8wxmm6yMxWPzX5v0gsiYuUFaP6rFmCNXcqaVQghSZjP
	 dmEOe/t1o48N3NPEK9UJ1LUS1Q7+IzI5wu7dgzdnEsGjynFScu8HMxG6dE5eN5q2LP
	 8BxSkc72Orsk7GYzHWBNT9csepJb/cib/kRZw3uw2RI5rZmcZ1Gi61cLZBgmhXTNnj
	 F3pz7u5YM7UYQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 08/14] PCI: rzg3s-host: Drop nop instructions
Date: Mon, 19 Oct 2026 09:50:19 +0300
Message-ID: <20261019065025.2146539-9-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
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

Changes in v7:
- none

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
index 6acb0231a067..c4d552f13613 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1131,11 +1131,6 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
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

