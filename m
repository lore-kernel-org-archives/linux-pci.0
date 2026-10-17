Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF1387373;
	Sat, 17 Oct 2026 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257535; cv=none; b=Nc6q2WsDidIX5F0vWOkicjZTlFrUCR3uvMZi5NaqJcAs5QUCWiLgjAPCDx/KCasJ8KvWNyM4Y3GZXSQ1D+Pbv/S7tWWdLZ4eQxzbYG/NU++FOnGi/cG/QOA8j/nsvz2zFQvlIHmGd40T//2bh7Mwakbk/vWFCMQewpTuk2sEk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257535; c=relaxed/simple;
	bh=GccPDjqwn15b8XzQUDmhsHtpyc/v2t4iHl588S5uf00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E1CdK4Jrff4AoN+8qCznp5dyKyJFMj8dLpLstM8ppP3crdvylm5U19303syRZe2/9fhNAyneNfv9H0bdO0F2IKYZy1V1l15yJ9ROTbp6v2D/1jK40HBOOaF97NXt4DhXQedWKPbuM3xevUgP2/848TJ4TgDaKc63wd117yv7Wwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qh8ThBrG; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qh8ThBrG"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6T6x0CnGzMlLH;
	Sat, 17 Oct 2026 19:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792257529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y0s0c7fyPuxTPITkkZltDw3XxnNR9KWl/1k40+nUpJI=;
	b=qh8ThBrGlyNmbOVovOMcuTwnvdN1CgGTKIo2mAoQLqgYW+RqcD0xMGjNYfMYwv/cZ2IwK+
	xu/3JOJWP8FEMWwN+ynU9eEfP80Go3Q330RFDWhWUJYqCsMW/1kGaUXfYtIY5cA+oaCKnv
	JRZP4rziYD9Qt4BVMOk9AFm4PUb/UiLjitPyUzDIAdFZdXcSMQL7n3dcdSPGxBDxgTxWwi
	O/e2GLxqaQ6b5ffunrydH9zZsxPlrhMULRIn0uOwtYmhRK2H1xj/i6aj70gMTDrKHsFl71
	6wA0srtrSmSgWcKuaySq5zwhAbztfcFsMwyppkgaZ2YE8gOc91ZBb8+SP7a4FA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] PCI: rcar-host: Validate IO/MEM resource count in DT ranges property
Date: Sat, 17 Oct 2026 19:18:10 +0200
Message-ID: <20261017171845.225769-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d20754dd647624dbd9d
X-MBO-RS-META: howtm7cuhx7mnbu5dpp8z7616kmq8zwz

The R-Car Gen3 PCIEC controller supports up to 4 memory area mappings.
Count the IO and MEM ranges described in DT 'ranges' property of the
controller DT node, and in case there are more than 4, refuse to probe
the controller driver, because such DT does not describe valid hardware
configuration.

Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Perform the validation in rcar_pcie_hw_enable()
---
 drivers/pci/controller/pcie-rcar-host.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cd9171eebc289..5856861922599 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -341,7 +341,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
 }
 
-static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
+static int rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
@@ -358,6 +358,11 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 		if (!res->flags)
 			continue;
 
+		if (i >= RCAR_PCI_MAX_RESOURCES)
+			return dev_err_probe(pcie->dev, -ENOSPC,
+					     "Too many IO/MEM entries in DT 'ranges' property, limit is %d\n",
+					     RCAR_PCI_MAX_RESOURCES);
+
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 		case IORESOURCE_MEM:
@@ -366,13 +371,18 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 			break;
 		}
 	}
+
+	return 0;
 }
 
 static int rcar_pcie_enable(struct rcar_pcie_host *host)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	int ret;
 
-	rcar_pcie_hw_enable(host);
+	ret = rcar_pcie_hw_enable(host);
+	if (ret)
+		return ret;
 
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
-- 
2.53.0

