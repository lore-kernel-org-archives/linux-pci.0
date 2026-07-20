Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9494086A;
	Mon, 20 Jul 2026 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513126; cv=none; b=HkRK6NJdZhLnpu0j6AELk9+pC28Jj2ISCXqvNnxnNNvGXjZDtJIRNuvGamEC6rDHAwZVU5HaPZccJ63mnPsHZOWZUWUEtNDOWGsjh4oMWjM3eQ+laSLhjaxzpSvKUJOxZH0c3HdhH8GrRphCkYgcJFMSu+FEpk+Rs6phYAc+GcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513126; c=relaxed/simple;
	bh=pFC47DayzC+JGwJZXJ+7rOJ2s3loP5SyLyJGtdzO+Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GroGaGMvVi3r6tafGuppEGmqKipKfJjTX72Bw6ggcom4Bs+TUUjw5Dh2VRFwQ2f4u58/yGSbLzicXoLueeALyvjsemuHzN0+oPyDAz7KrkrcMFDLf4Tr4GjylLet3NP68HUmBn+czAKTX4abjwWX+LW6D+StP8DTA1bCgVWjW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=st0/9kXv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CEirCOiR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="st0/9kXv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CEirCOiR"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h3P3w0Xqyz8tb0;
	Mon, 20 Jul 2026 04:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pBFPDhfbMVzzPNbWBevrf7/zXDorPPcmxjaeaIlINUY=;
	b=st0/9kXvIVRDTChuoC/XwrchUyzyjTpgm2ypBg6i0TwxeJZlch8y7/vk7+gIGlvTMn5HSj
	zm2qwhaIqbSPsS5tI+LBbPI8Xkjq/zyT+yfJul4MdItDhQQH47UQEYx6rwc5utmMGNxPNt
	vrNAh54kxneLkZawBanuoT3O9lAm3JigTc5AadhWIO42JRab6vYu2M0kpO+3475xuuyJ9w
	ZVS5Jwypgup5Mqpmr7PQn5VPVTztcCAFEPwp/lrNIwEnkSse9RMGIV6InL8v1iEDSPlMty
	uVEu6amJQ8vaOTloButQS/+z/SYBWdo9LB630ibyS8JhBalSKp0sPecAdy5Cew==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CEirCOiR;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pBFPDhfbMVzzPNbWBevrf7/zXDorPPcmxjaeaIlINUY=;
	b=CEirCOiR8pHJGNtgQKWVeKrzGW6tjs3veGDJtpcmou4Y1mTFa1VlIOkZKqQe/9KRtYqvQx
	EV4ZWZH+gWGvnzJYRV/Tu01IynwbQZg8VUs8bh+2KFi4xZdCEXGO4wONiv7NBMbuVU2uK9
	xYhzFJ2Be9jaFEHjDK114g0u/hHWw5BvZehH8taKjs0YtkfBLmOmIWDeRPLTk6ipBFymYF
	Mi/0pSI58pv35o/ZT6pHhNp9bzNPtmhB3wWU1oWDiast1aNjNzxPhTYE/14D0BOGDWrvy1
	SAinz7C363Cpr+SQ33D48N5aeMqw6RviAutbI2sc0I0pC6TaE9AnCxF2yBtZLw==
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
Subject: [PATCH v2 0/5] PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4
Date: Mon, 20 Jul 2026 04:02:28 +0200
Message-ID: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 148305522c3c7b053a5
X-MBO-RS-META: tuyagn19cdusyezbfr9f19zu45ooop5n
X-Rspamd-Queue-Id: 4h3P3w0Xqyz8tb0

Add support for R8A78000 (R-Car X5H) PCIe4.

This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
of R-Car X5H PCIe4 are almost all the same, except for different PHY
which has its own driver, slightly different initialization code and
the DMA is no longer eDMA but HDMA.

Endpoint mode is currently not implemented for R-Car Gen5 PCIe4.

Marek Vasut (5):
  dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible
  PCI: dwc: rcar-gen4: Rework rcar_gen4_pcie_drvdata
    .additional_common_init into .init
  PCI: dwc: rcar-gen4: Split .start_link into ltssm_control and
    speed_control
  PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
  PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  74 ++++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 237 +++++++++++++++---
 2 files changed, 252 insertions(+), 59 deletions(-)

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

