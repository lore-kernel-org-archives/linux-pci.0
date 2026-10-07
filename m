Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F973F9F2F;
	Wed,  7 Oct 2026 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351452; cv=none; b=Tn4Shqeihj6lF67UBA9gTQcCo6KXQqT5phYrv1Gt/KYJThxUSrQEEa3z5EUdSoB2BOYFp7cXJLFiTR1oscvDxiDCLFlFg8ucRJ0jYqFvayaR0nIiTRr5csKVy906jdHdzWNCwZOBkiRgWvDypMgWD41ZzxIhS5MxaGvulfWphZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351452; c=relaxed/simple;
	bh=irlrB0kQj4ORDFA+6QwcET1+7lqofLdQyLB2hcA9Pso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFkvn+4ucLKZOXkPUDKzQKSFMHd6tgyupRmDfVpkCyq/20LX2QiQsHKvoyFZTcWvc30SiJRMcNbWEG2bRPJ7V59/qoR3Q8Fuu2eeNrcP7SvwgGG2TyXSxOh1BRXXZ0R1iC7gtC4wC3+CKHzLfNhjylDYW42osu80byGusBRci3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiei52kh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiei52kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CBD1F0089C;
	Wed,  7 Oct 2026 05:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351451;
	bh=zYvLKuCKFakkWjmrId7jeEmN0RWcZsNhcOfEVGtgFVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iiei52khdOdn2g/KYOQVdhgiEpP+LiXHr4j+NRD3UpqRxA4P+2ToXpNcmeTgpyeD3
	 9qRotzskzsyPIqXW3T/3jqbWWpi56ZW5P3T0oT4nQUrQzQrcCVZXglKzsSe+40xwQl
	 ONknuRqHNRzifiQ/OoyKLGS5ZKxzOgldRpXoy5UaeuHcKP3eDg1pTUuhu7LF7oYY6T
	 ADPJameolKQsTXXRL27RUt/tY9cWOSEiRCPMge3Q51NDbtJ/EDu31/zSQ6Ru+PP2DW
	 AD9bG+nTDBWG2UdrqurDYRrSZ/Imac9i9JmwmAdrfarXXnnW9nUaByVVBPULAAjYlm
	 SoFb8eNZv74cQ==
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 7/9] PCI: rzg3s-host: Add helper to wait for link up
Date: Wed,  7 Oct 2026 08:36:43 +0300
Message-ID: <20261007053645.1391545-8-claudiu.beznea@kernel.org>
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

Factor out the link up polling from rzg3s_pcie_host_init() into a new
helper. With the link up/down event handling added by a subsequent
commit, the probe will no longer fail when the link is down, but
continue and rely on later link up events to detect the link becoming
active. Having the polling in a dedicated helper allows the probe path
to treat its failure as non-fatal.

No functional change.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 29 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 3b62b1be5b2a..ebe89e6a0796 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1095,6 +1095,25 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static int rzg3s_pcie_wait_for_link_up(struct rzg3s_pcie_host *host)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
+				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
+				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
+				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
+				 PCIE_LINK_WAIT_MAX_RETRIES);
+	if (ret)
+		return ret;
+
+	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
+	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
+
+	return 0;
+}
+
 static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
 {
 	while (--count >= 0) {
@@ -1673,18 +1692,10 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto config_deinit_and_refclk;
 
-	/* Wait for link up */
-	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
-				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
-				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
-				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
-				 PCIE_LINK_WAIT_MAX_RETRIES);
+	ret = rzg3s_pcie_wait_for_link_up(host);
 	if (ret)
 		goto config_deinit_post;
 
-	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
-	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
-
 	return 0;
 
 config_deinit_post:
-- 
2.43.0

