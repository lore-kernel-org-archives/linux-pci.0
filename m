Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A25488D9C;
	Mon, 19 Oct 2026 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392711; cv=none; b=Sizwff2GpZpU5exVTxGfpjdVBROMEwrKfAOwz32mmPmzQ0zGNkkjSoRf/n0KMQKm4sco1z/eZta8Xz5DpqM/G9jy1szHlPIJnG8asgLKsGlqC/GKcXhWcd4dx9z7N06TquGb/ng44WpGkvBviPJKzbZ3x3jbdkIYe2+94DcPxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392711; c=relaxed/simple;
	bh=JKF8M3zN/9nkgBlRYr11WegN6XgjwaIV44etnGDkfsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBAKSgbDUuVPKMFTRWrHJ6wIFarnLmS8euHXKGj4i+s+PDI6U7y1e1n6dT484xWndafoYtswUTLUmj6dpRfBClqICf2PdBP3RiNndLnBHmVkTuSka229HtipuFc6muPlvjRoLTCU5zGMHXhanpU7ugfHCwETmCoIvPMzbaqo534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmUDCsiE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmUDCsiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86211F000C5;
	Mon, 19 Oct 2026 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392709;
	bh=61UVuIXEwhKty431ZjA9LKthVF6b5nnhbcYKZGMkP7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmUDCsiEZyBmv5Fc8jPf+7tGWMuUOzjY233Dix+u2kOHdwO1pGcy7Mnh9VBc2melM
	 RAsVqTW4t22tr+QgklO7yF8MVcieF2FCnley0U/N5Cdyyfc+1i766e9HgtMnv7NQqg
	 arpRQI21S8LOZjSKwZ8wfVraXgjBLrdyaR3caZCNrbYn1SPT5zAqTBqZc8mwLh0j2f
	 PMpgPMPeSbdvwbbMcYQPyPzUC21Pbn/DladyIiSzMWdhYyiGDiFAG0qUF5q6H1DKh7
	 cKfJM650+RrMI5QO5yHt8TWYDgBKcatp/dvPMlWdcZoy5Bmqxhj4wOBGokrtaMl8+d
	 3Vosw1tOBlk1A==
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 07/14] PCI: rzg3s-host: Use cached MSI address in .irq_compose_msi_msg()
Date: Mon, 19 Oct 2026 09:50:18 +0300
Message-ID: <20261019065025.2146539-8-claudiu.beznea@kernel.org>
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

The MSI window address is already cached in msi->window_base when the
MSI window is configured. Use it to fill msg->address_lo and
msg->address_hi in .irq_compose_msi_msg() instead of reading it back
from the controller registers.

This avoids unnecessary register accesses.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index b0a150262959..6acb0231a067 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -660,19 +660,9 @@ static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
 					   struct msi_msg *msg)
 {
 	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
-	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
-	u32 lo, hi;
-
-	/*
-	 * Enable and msg data enable bits are part of the address lo. Drop
-	 * them along with the unused bit.
-	 */
-	lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) &
-	     RZG3S_PCI_MSIRCVWADRL_MASK;
-	hi = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRU);
 
-	msg->address_lo = lo;
-	msg->address_hi = hi;
+	msg->address_lo = lower_32_bits(msi->window_base);
+	msg->address_hi = upper_32_bits(msi->window_base);
 	msg->data = data->hwirq;
 }
 
-- 
2.43.0

