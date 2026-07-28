Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC3190473;
	Tue, 28 Jul 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201976; cv=none; b=VEC2lrzocagIoASonbwaq+o8X99hhiediEcKIBqhMuBbn8NUitQu6gaKQ4WKEG94Igrl21vhxiTIpPbi7r5Zco8pIzcQTks4uKmDq9pwDZj/EfjDjv8VIhX/MtUN1yCtyEFheHm5zQlgCVoc4OyKeXm3ktZeKO0dMkdsgFvdK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201976; c=relaxed/simple;
	bh=57edHnPfQ+aD2wL4qUOTWP1fNCiF4jaCA4MN2AcAij0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vBPQkllGzLviGuIvHCKILff1kHiqSLKJbgjoJq56+Hnt2GdiDCQmbMRow4XJF8rLW7d1Kjnre+yKCD8Nc0SCeLAE2vICvy/C4IPTTcNDU2MhtB5X71fQQ9L5+mKeeXsllMwPEZa/Z9aUHIHnbMtx6nGSzFW/Q7YYLbbTvPyg8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ckTmdxs9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hErtWiox; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ckTmdxs9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hErtWiox"
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8Hq80jt3zMlGQ;
	Tue, 28 Jul 2026 03:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785201972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DYj3Gwonno5tuigqL6BvnWApaq+2uBwSe5vHZ9bElX0=;
	b=ckTmdxs9OkhWuPopV5aVBYLdi56OHydKkzRRtbTY8T4A3Ptc0tuBM2m9hxcis6VT3HqRBj
	lhW/s8J892kWxhIECWC5npbZTxko9UerUFAkWIgLWjT0u5AenX6OBaO44m+sxkoeaJgAh9
	Lt9YfrIYi5lifDN85sk+xK03/xyP9yHMIFEvqlB1rEVogpsHtroWwvBVXabEE00vD2EYRv
	7L4aD8PeOTBeAv3EVR0bmyTGE8Vd1jOH9PLybGEmOBM+YjAOvvf+/xVlyV0a+O4fdlNp+u
	BbwtUFXgtvrAXIbvmmNYk3tGT4sa0QwwjgzdQMh3DEOShsiy3ouT03g0eKQLoQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785201970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DYj3Gwonno5tuigqL6BvnWApaq+2uBwSe5vHZ9bElX0=;
	b=hErtWioxNzYcuQSR6cgc6HhLaPgVsgNE/fEjbEgRpLqlojUzXglToYGEZBvNc74x+5aFvB
	stnAQBGxcLHP5s8ICl817uqN+RatiCaXAaY0KQbo0kDJJEm7h0FYpwm5Dxkts7tEoK1994
	ycpKjNEdH40z2Aa048E8GKhxQkcidD5WFIugELy7BXuJT5o6Tb7HFvToF8GqUmxf5PZ7sh
	4L3Wdi/9c+jOYh17SfoZ976Qrrc/O4wjlGGtdDh4BmuH1MtZ33Ygx/wH/8PtJxZhbTzDn0
	VYPhfLnDrLh+Fzw8j+wqIJ8YYoUSyTLkeYepQJ1KQZub1czTVr5PBWJ8CUvbLg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Niklas Cassel <cassel@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Roy Zang <roy.zang@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuho Choi <dbgh9129@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 0/2] PCI: dwc: Handle return value from endpoint .init/.preinit callbacks
Date: Tue, 28 Jul 2026 03:24:23 +0200
Message-ID: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 50191466ca9f8db85b8
X-MBO-RS-META: hmi6jyzzt1u6jydo7geudygbdrddrpon

This is a trivial preparatory change which allows checking
the struct dw_pcie_ep_ops .init/.pre_init return values.

Currently only the Layerscape PCIe controller benefits from this as
its ls_pcie_ep_init() may fail in dw_pcie_ep_get_func_from_ep() call,
but the Renesas R-Car Gen5 will benefit from this next.

Since this affects many controller glues and has a huge CC list,
I am sending this separately from the R-Car Gen5 patches.

Marek Vasut (2):
  PCI: dwc: Handle return value from endpoint .init callback
  PCI: dwc: Handle return value from endpoint .pre_init callback

 drivers/pci/controller/dwc/pci-dra7xx.c         |  4 +++-
 drivers/pci/controller/dwc/pci-keystone.c       |  4 +++-
 drivers/pci/controller/dwc/pci-layerscape-ep.c  |  6 ++++--
 drivers/pci/controller/dwc/pcie-artpec6.c       |  4 +++-
 drivers/pci/controller/dwc/pcie-designware-ep.c | 14 ++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h    |  4 ++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c   |  4 +++-
 drivers/pci/controller/dwc/pcie-keembay.c       |  4 +++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c     |  6 ++++--
 9 files changed, 35 insertions(+), 15 deletions(-)

---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Srikanth Thokala <srikanth.thokala@intel.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Yuho Choi <dbgh9129@gmail.com>
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org

-- 
2.53.0

