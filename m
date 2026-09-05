Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192C36606B;
	Sat,  5 Sep 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643630; cv=none; b=RRQLn1xFaKz59MQOFEGsNKg5DTwLAFuYLnIsSbsqGIVIzNwby1VuwV5+oenbci9sdnJsYcSDURAdd47sM799wyeK8xjc4ZSzmrbpLmWn2f3LV6njQNZspxOgeMFPgb0djwqQtn6k0OorkXieZAv1Lq9sHRiQA5ig90ACK2geZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643630; c=relaxed/simple;
	bh=1h1ZC7y0yj98CAZSWDGceajgc4khdjsqJZrksGZMV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hYMPHAmy2sBvlXuwgtUlCAd8OHBmaZiHDtwHXjBpYTQuD2SBpdB7lENNwRnK5ZcG09d0pGfwTdnfPcRPBM783B6sdYtZJQkUJ8WwLbPYBrVquCbKbhQneX4hjzqOHYxW3Gtif1H98lwgwC9qXG7w3XDtVvxcWBV565Ye2g4ZKiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=USRxiGVq; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mUxDMEGj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="USRxiGVq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mUxDMEGj"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hcmcj0HfNz8vB8;
	Sat, 05 Sep 2026 23:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=byhUwPGDHTqPvdp0b0HFuOv9xgDF4NgJ1ULDOsBqB2Q=;
	b=USRxiGVqZLV0GrotiY4BSnk5gap7zRuPAK+jYIRpahLUvsDIzq+rnlg/aQuRm/ylP3LS9V
	HOJklucPrNt4NJEZHJvxvkiRePdCl4vl8W0/pM9nmCnoi1RfXR84/3nu36xEq9TDYkCDqj
	F2lkdgNOV6M+l6NFSznq7pybJYFb8FneWgCHYCyRYWeAsz+kCri4NkQZu5wlZtN6Y2A/Yr
	D+7G1ohHzsUl7bA77thHWTrbbBPYIs5VvI/h7IseAZI/mdQltCZSU3l7TzM95gceguyYxj
	VWPohzegDFAnUe/3cgFHf060xXqbF1PGZl76X7DDIYtiTyg+lLdwChmHsO9NYQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=byhUwPGDHTqPvdp0b0HFuOv9xgDF4NgJ1ULDOsBqB2Q=;
	b=mUxDMEGjQ+1N76oGczIiVS1gyo4kZAHamA07bYYMipMe9EftBTpEvwjwSbY6gYzyoWLsWV
	1aaNdMxW9vPxigp7LFoqkvzcFzRhvDfLjWfSXtitzBZmcsz8HZwsExRfgG54IY6rbK6d36
	u32NxLES+rDOaLnfFNaN5vTdHN52zbXAPoEcAVkBNMTheEwtjNyjgvND8khKYo09sPBkRz
	hIyBPIWNm1Gch/eCJJmRNjlWvtJtaicMWFHdOOzS+c6rYJtnCm2sebL1IPL3zun38x9v7e
	77jPOfgi96uzKy1dSpIukWl/fFnXkI7sDPs357/scJJIrCvXluMcIV9Yh8wS9Q==
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
Subject: [PATCH v4 0/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4
Date: Sat,  5 Sep 2026 23:26:21 +0200
Message-ID: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6oq5y3ems7bejjyqx45jua56exwoy133
X-MBO-RS-ID: ee287531a7baea1c1ea

Add support for R8A78000 (R-Car X5H) PCIe4.

This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
of R-Car X5H PCIe4 are almost all the same, except for different PHY
which has its own driver, slightly different initialization code and
the DMA is no longer eDMA but HDMA.

Endpoint mode is currently not implemented for R-Car Gen5 PCIe4.

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

