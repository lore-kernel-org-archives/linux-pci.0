Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21148E0F6;
	Mon, 19 Oct 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392728; cv=none; b=LfgfFULnTw1TC05CkiX3uyF7g9/e1ysHZxIgLeHiMq/g6PIB1fqaS9993OJypSZmRlswTiA8BgllvFEm6muJouAhdLOlRyvQbeBiSa+0P3Tfgd8OOJmTo5H5T1WaAkjPNnOiLp1YS+EB6uL5Zo1lfRZ8sYPQO1F7iAaCiYHKQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392728; c=relaxed/simple;
	bh=gSWJQViF0Kp1dwqUH1qD4LfU/7nyM0cP54tIESZ7+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7L3iim+TjE/badjtMRCdz9zP2D9sGQC9PL5b3Z+GYk3GjZlEx6zuWHwx7w6k/uuAmE4OB5iyHjXly3vrUZ2ip1Y83AQ06ZSIjVqyDf2cWZLPiMpxrX3/wF6KXxVUOanFPD9ep6S4sbKIDVS6fysCMj7K0bY+k+HEkSQvHJVGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brULjYPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brULjYPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D011B1F000C9;
	Mon, 19 Oct 2026 06:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392726;
	bh=IfjunYCL86KdylGpSCgQ1SYIpp+sTbKnno/HkM8VNJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=brULjYPtY11/FSbzvSBUV9g4fUKBCApWFwBYhlKzmeMB02DoDasjjIpKoSduIq1br
	 jE1TloVQMiVYb+1w2o+DrKhW6jO04JRcDx+Jh4JSbAthFWm3VO08F4+8XWFuZPi+TB
	 9wsftVWOWEhNi1VHSaZilWX33GdfGmX1Fgrldi5WvMIggzK3TB04PWyEGFH/NnxKwB
	 1GTPKUVX2/59Z2r8HQ73YG+AZEqpN6zh29vK7kjrWUIZVb9s/B/1e079qpvzm3p/3b
	 21STILq5jLgLifOF12E0SB9VXZcOL0EnZYgcABripiEVUonbjUqjPUptd1x8iurLc7
	 PoZeLu5x5Hm+g==
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
Subject: [PATCH v7 12/14] PCI: rzg3s-host: Add helper to wait for link up
Date: Mon, 19 Oct 2026 09:50:23 +0300
Message-ID: <20261019065025.2146539-13-claudiu.beznea@kernel.org>
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

Factor out the link up polling from rzg3s_pcie_host_init() into a new
helper. With the link up/down event handling added by a subsequent
commit, the probe will no longer fail when the link is down, but
continue and rely on later link up events to detect the link becoming
active. Having the polling in a dedicated helper allows the probe path
to treat its failure as non-fatal.

No functional change.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 30 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index e104c6b4ae4a..1ced6d83c7c1 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1084,6 +1084,25 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
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
@@ -1633,7 +1652,6 @@ rzg3s_pcie_host_init(struct rzg3s_pcie_host *host,
 		     int (*init_irqdomain)(struct rzg3s_pcie_host *host),
 		     void (*teardown_irqdomain)(struct rzg3s_pcie_host *host))
 {
-	u32 val;
 	int ret;
 
 	/* SoC-specific pre-configuration */
@@ -1667,18 +1685,10 @@ rzg3s_pcie_host_init(struct rzg3s_pcie_host *host,
 	if (ret)
 		goto teardown_irqdomain;
 
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

