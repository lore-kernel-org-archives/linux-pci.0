Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE632395D8C;
	Mon, 21 Sep 2026 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022517; cv=none; b=tb6JeLvu+UVmdrmr0HMPvErxZHhZb9FN7fJTadHxmcERnSY4BYRsUYs+qCwRqmDapjso7lmTOK6Kej5ILy9gvBaVDS2EaDQUYO2lP/AW2yq7lGIQ2j8hgMeBZYr5Fm/oRUxOYdGG69E870GeXr7l0OVr8u+RUcSYo/1UcrAZuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022517; c=relaxed/simple;
	bh=FDc1iD8aqnuI29XhJQ4l9ZhOGJZEmJSNNbjS4shHc4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kqrRemrsQUnFzEmR44cNy1b0sHpH05a9z4RIMxl8DBnvOUZW2t2QYkX6jtgL6bWYblp95qO0UyWfzHhG2HSDaHCTiq1MQ5sFi1szUIjVckP1JevF4D93ImkURNzpsT4Q8Fg4SXnFuxe+zrL/97S0IK3vNKVmvVWQXA9LitJ9rI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NYZdG2Sr; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=F1VvAJCU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NYZdG2Sr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F1VvAJCU"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hpZYs2LKkzKp2L;
	Mon, 21 Sep 2026 22:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fy8zHXAowwe/Vp6KN7ErlUn5X+VoYdzyZ/+t/j0YHpg=;
	b=NYZdG2SrEte1P3TrTUp+64LBWNEPmxRHBmaM+Ke633xMPh87mMsspqH54gqIEOpBSB4YJm
	w0od5cHyQtBriTDH2t49FRnAaensnQTwXXjLU1+7Lsyh0JHdgrZrgktnAHiHPzieQzmDPR
	pPaF0FdhyQjy1img1nkskb+ozQSIMVs8Er2AvRHpoyOxBIS40ohUMjW1nsUeCXATel0kuZ
	yh/XgPhBs+SzfKkyahhZH2lhuR5klurkl/587//SMzCl2HiRNsTeScg8mxEHyeH3ksrlYm
	n2ov/WNmgjVN28p8WtL/bSwnH6GMXoZxBGL5HOFG3WN1SBLnCzTd95riQw1q/A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fy8zHXAowwe/Vp6KN7ErlUn5X+VoYdzyZ/+t/j0YHpg=;
	b=F1VvAJCUhxGh0fXuca16I3SnI/W91n85Q92wDGy4A1kGcq71oDaDDlwDGXcApJZcaljlH/
	/5TAwLR/jf+EsGF6T75FCpGUqfrXYCtgwjLxUUZn00lwmoBZFAdvxrqKc46I2Q8FA1Ab9V
	pIEUpdxtkK494GeOEvppWRtMufiMgyM/X1ekBBsQQi60xItRgkK8hUOh2Yw7Pn3GxOmqCf
	KjOkX3F7yRGRIsKlxfrm7DHZFApiIEGPsR8a99jaC7g3Zv4hWoq6Oy/9AAnViLXf7VbXxW
	YlV5X9iQh/y/sxuuL2fP4M1V0oFjPQHekUw3jHM70zAEqH97tRdsTXXWlF4BLA==
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
Subject: [PATCH v5 0/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4
Date: Mon, 21 Sep 2026 22:27:42 +0200
Message-ID: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cw3b3hhq5isn1r8ergkashgaerf6n45y
X-MBO-RS-ID: 69d251fbe6da65a3daa

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
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 253 +++++++++++++++---
 2 files changed, 266 insertions(+), 61 deletions(-)

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

