Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F721922FD
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078108; cv=none; b=rUhhfxoPBzAFEGUlRFQi9BqnNb3VeQCZyWse02ET8g8WqeSkDGP+nkhTBA+gtpUSrjKQ/101cqCZ2ecIwI9CJSrcCXUG0LeW+Ymb2bwCTb19sGwvYY3aUbkcGJmB4d2O0so1YH/xuNFTcotUSmEXfrtSviacBHhPWv8HKd8sMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078108; c=relaxed/simple;
	bh=yl42pVmd/Pi0ztQ54DneU35smjr2f4vAu8DEetdqRuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HNr7Q0dpip3uJ/a/6YfkiHZvR6GH3gUuHBvVxva4YXcAlXu5tekCnihki2ArfLXa+PJiJKV51bDoNnoVTwKOiG6sipEuTQvTOpdPdTQ+QpyxfkwUeRXy+zlg9IQBixVpnDBTMOC+9nRV8tGMW7Ifjrvim41pLKW1bvAzW8ATrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJ6tOz39; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJ6tOz39"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770078104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+2XTSPZI0r7r0xxXuEFfDuh4AMy4Nmaw4oOpOLhAvXI=;
	b=FJ6tOz39ef3x9lh948TOCFUoh+KaPWT5sVuHy7f6TNRN961P6OhIhTYx8BzBhwsRkuCnIk
	7ZX4HfvTe1DCCbScLcc5RJgoTVjeyK+cLEbgABoOu2v2hblyR4dfOFPbvuwTb1AuLaSmVc
	G8bsfPUu8zZv8/2dra5Tpp53PzK7PvE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 0/8] phy: zynqmp: Perform complete initialization, including ILL calibration
Date: Mon,  2 Feb 2026 19:21:20 -0500
Message-Id: <20260203002128.935842-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series completely initializes the GTRs in Linux, making all
bootloader initialization (as performed by init_serdes() in
psu_init_gpl.c) optional. This gives the following advantages:

- On some boards (mine) the reference clocks may not be configured in
  SPL/FSBL. So ILL calibration will fail (and take a long time to do so)
  unless we defer initialization to U-Boot/Linux where the phy driver
  can request the clocks.
- If PCIe/SATA are not used in U-Boot, ILL calibration can be deferred
  until Linux when it can be done it parallel with other initialization.
- We will have flexibility to switch between different configurations at
  runtime. For example, this could allow supporting both SATA and PCIe M.2
  cards with [1].

I have tested this series with DP, PCIe, SGMII, and SATA. USB3 is broken
on my dev board at the moment (independent of this series; need to
investigate) so I have not tested that. I have an equivalent set of
patches for U-Boot that I will try to post soon.

[1] https://lore.kernel.org/linux-pci/20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com/


Sean Anderson (8):
  dt-bindings: pci: xilinx-nwl: Add resets
  phy: zynqmp: Refactor bus width configuration into helper
  phy: zynqmp: Refactor common phy initialization into a helper
  phy: zynqmp: Calibrate ILL if necessary
  phy: zynqmp: Initialize chicken bits
  PCI: xilinx-nwl: Split phy_init from phy_power_on
  PCI: xilinx-nwl: Reset the core during probe
  arm64: zynqmp: Add PCIe resets

 .../bindings/pci/xlnx,nwl-pcie.yaml           |  17 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   4 +
 drivers/pci/controller/pcie-xilinx-nwl.c      | 255 +++++++--
 drivers/phy/xilinx/phy-zynqmp.c               | 487 +++++++++++++++++-
 4 files changed, 713 insertions(+), 50 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

