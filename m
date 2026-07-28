Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2E26738D;
	Tue, 28 Jul 2026 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202408; cv=none; b=RJCjQfxJriuHq0YMWhdxYjWIWM35zoV7Lk59fSxVRVS8VhuZSV8LM3m7YzBWIqnZ9xB1kBj0zGIQuGGGH0WjXxNKMEgpxKgLaNI30SYTn2lSNTzTGIO3Ge22e8F0tjslY60PM7Mqgsgo2KMhG/cT2M3QocRFWhgXu90Z5v35pI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202408; c=relaxed/simple;
	bh=s5JDNfyp9kMaQlOuQ/uKyW3Dc9mZuKsJtGPniKP1Z2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OLUJigCCUY1Pam+VbAoW0m9uXAb9luQSSI+ZXA/eZvkYo9sfV7jdRgsH+3aW/d1sZgpt+09Cm6hjM8OVIzpj7rUtdSCYwvkjENtuZXgiE54nqJCX69If82xse/EigkvvGHe4PBE0WcQgaEkYbkHGD1G7QvIzm2aTNvllZfAYKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vmnwT55i; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LvzrB/pp; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vmnwT55i";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LvzrB/pp"
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8HzS0YRdzMlDZ;
	Tue, 28 Jul 2026 03:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QAGBRJzxAXd/YNpm7LAmJOSIdx9xKXLFrjvM0ODM6w8=;
	b=vmnwT55iY2I2ZSf3Ah5DH2VwkUxJiTdCCk2yZNCB8mA8SBGuPcDKfknNM+PnAwEpVBJYC0
	h2SolJSHKv1ye0tIjKmzezNyJElLgqwbCft/YRmbIn16kxA4yMXcqr22B2mH2D+/Kl9422
	6qA5Xs9SfqOQ9bIhBP2PvBhiuKyZyT/4gv6TUQqEnaaxv6OY/zrNObVWJ0+X4w9IMJVS+G
	IgFJTQFB1WgMziSGFrDqiaUwylm+WMcvRo9+3B6iMBWRHJLq8XFJ3bT1VK8RFkeWRtfIcT
	h70XDLg7I4VFTa0oIY3BCnUbqCv2G5aWTsqSQt4YaG4A2OTuE03Aluj+ur0oOA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QAGBRJzxAXd/YNpm7LAmJOSIdx9xKXLFrjvM0ODM6w8=;
	b=LvzrB/ppz4efZbAkqKa3f2fH9ALloDnPgeoZGlnLiTdk19+gPskedJOj6baZafEdT0asvN
	gIuSVPOljh3ljq9MrDtzhETf7xG+rUKItlA9FcZV636P2tJIdPLO8l+61s919GdDlNJSuk
	mADIxxJNolbm8W8y4wrfgyn33Dpz1yxjgh3p/hEXMgxHJMpiWgvJrQHht2YiNkfvtqvZ2I
	af1tecSkL1bSavtMhnRl8Id/D0a+o8sNetdCnO7sbAwCBQap6QMnMyXoBr+mce7Mo2/Xta
	bLQcsFAOFBXEI5q9IPRSBzswMKVO3i5iibXrVxME8Z2hQJOzSbwRLKBIL3WiqQ==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4
Date: Tue, 28 Jul 2026 03:32:33 +0200
Message-ID: <20260728013311.466242-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cws3oz4firbjma7d535xwn5r6qe946fp
X-MBO-RS-ID: 69e1614bf7576807205

Add support for R8A78000 (R-Car X5H) PCIe4.

This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
of R-Car X5H PCIe4 are almost all the same, except for different PHY
which has its own driver, slightly different initialization code and
the DMA is no longer eDMA but HDMA.

Endpoint mode is currently not implemented for R-Car Gen5 PCIe4.

DEPENDS: https://lore.kernel.org/linux-pci/20260728012548.465139-1-marek.vasut+renesas@mailbox.org/

Marek Vasut (6):
  dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible
  PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_drvdata
    .additional_common_init into .init
  PCI: dwc: rcar-gen4: Add .deinit callback
  PCI: dwc: rcar-gen4: Split .start_link into ltssm_control and
    speed_control
  PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
  PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  74 +++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 264 +++++++++++++++---
 2 files changed, 277 insertions(+), 61 deletions(-)

---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org

-- 
2.53.0

