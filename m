Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241627;
	b=NdbzMKJ40Yw+b5xaH5zSQFfsSTs00rH4xsnA2r55V/SIvmdIp9L66YA/0cfJ7koqTMEe
	 ABez2j0bMby1/j9kduU+wPFOPG8ER0L/IOd76ZJtpuuqDAnKGTC/Xh09wNfn6oKkIBJKC
	 qBTOZYk47jhe7Kd/e1RjhbRmmC7zshZVZW3jqXko0LR7rUSsmQSUyPzWooueaLjlv6Cti
	 GwJ8evra/+SMDRgTQG5sdfAjUUoltWvm+7jZlPyWvaFgmjSh7IIuuPzlDWno9JWJcj97Z
	 6dLt9qCwH7uLyMHZR8Vl92ivNc+s3yXu6UNrmUqk4+VaIuooChVeytbEv9JjSt5AKeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241627;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=Q4migt+JhVpeIUD/eAEu5pH5ki1PzAXg2mx7vuH89hk=;
	b=DXQhXntou02xeqW2CKA4jVCsK5PjxmbDd3cvBtpTuhkfXkb3v2XLu1fWU6DovWN0rKlm
	 M/O9jwyQXqyZsBPC7jc7s5fbQxjLh32jy/sGFrEzpvXUQo18l4hpqPldfyASL259mFl9x
	 n441HeSX06si00HrnGpuwrKmVJ1x9bM9uHnnbM1ZxATpeE763r5XDuiv91GVWukP0kG7R
	 c3fNtZjeFPLCLOuc7J4v5Gk1xHY5iRA7VGO14+CmiMYR3DfjaqGEA4TwjBtkNVVaRo+n8
	 0jnAVGi101FGO6Doy9Ti9J44pCojUTtykky++w+48i+bLe5z5GBPzHJ8NwbngTzfVFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=buqtItTt;
	arc=none smtp.remote-ip=45.254.49.244
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA7606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EDA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=buqtItTt
Received: from localhost.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52bb2512f;
	Thu, 29 Oct 2026 10:40:16 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/2] Manage the PCIe supplies with pwrctrl
Date: Thu, 29 Oct 2026 10:40:04 +0800
Message-Id: <20261029024006.3483210-1-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa185878e8703a4kunmf51ad3a01124bd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS01NVh4fGh5KHhpISRhKT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=buqtItTtEUq3DI2U8GtApHJXiZmFzChzHwAcmbuHxVec6hvGWOfEd+KJUtKPJPPa2mzzeHR5IE0F3mB6FZdldBWG6IGhOu54M644gdGADJmRGZDRuaYVv8sVVR4lB8G1hduYfZvmGz43F9s65uZSdcdLi7GCfIUeeTlLNpZt6pc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Q4migt+JhVpeIUD/eAEu5pH5ki1PzAXg2mx7vuH89hk=;
	h=date:mime-version:subject:message-id:from;


The Rockchip PCIe host controller describes a single vpcie3v3 supply on
the controller node to power whatever is plugged into the slot. That is
enough for a board that only ever has one device there, but it cannot
express per-device supplies, and it does not fit boards where the slot
power is owned by a separate power sequencing or switch device.

This series switches the pcie-dw-rockchip driver to the generic PCI
pwrctrl framework, which lets the supplies of the devices below a host
controller be described in their own DT nodes and be enabled before the
PHY is initialized.

Patch 1 makes the driver create and power on the pwrctrl devices below
the controller ahead of the PHY init. The controller level vpcie3v3 supply
is kept for backward compatibility, so existing boards keep working unchanged.

Patch 2 moves the supply of the RK3588 EVB1 slot into a child node that
describes the slot as a PCI bridge.


Changes in v2:
- Select PCI_PWRCTRL_GENERIC from PCIE_ROCKCHIP_DW, so that the
  built-in controller driver cannot end up with undefined
  pci_pwrctrl_* references when the pwrctrl core is a module(sashiko)
- Do not destroy the pwrctrl devices on -EPROBE_DEFER, so that the
  deferred child devices can still bind and retrigger the
  probe(sashiko)

Shawn Lin (2):
  PCI: dw-rockchip: Power on devices below the RC using pwrctrl
  arm64: dts: rockchip: rk3588-evb1: describe the PCIe3x4 slot supply

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 14 +++++++-
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 32 ++++++++++++++++---
 3 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.25.1

