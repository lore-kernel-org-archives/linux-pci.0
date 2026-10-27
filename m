Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087745;
	b=SthgAve08w2zvRkSOpNdh12VAT6XeXhqqEqKcj4rLUgBsuAHjSnUDuTf5LXLFhL7v3jm
	 lUkssg41R2Tbpmq7ERiI7Colxz4fxaJKYWILwNAfgOMHgFbCC+BgRC/hNHLEuhEbxTi23
	 ZsQl9Eikrg4bbiFS9Fc1fi3+WIktNXWUHBQAXNA2eW/J/cOmBppF4nNIOvPEImFpKLpMl
	 7WUzdvtIrJdj2fzwEkgZGOIPBLikPvB8eDTvhKGY25EaACiGQV4l0iM/YncwuFgq1Ink/
	 v75rTumyVk9BHIlzMNk+h6pRv2qMJNXNLw4G7hOL3q4rAswx3R3YczjVvYjQKUVscEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087745;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=1fJwad9d4tyqt4SjrD99rAhUThoxvoAA2TOTT72jfPw=;
	b=PbQIfkT41Yv5lKj/4y2fS9bmzPANRKS6cuuSXBkxmmJLoWD5tT6bVYwyHyUmFahFKBLL
	 OERvijoqWRI3VTv2i8ofYx5fs9JuoOeG5nMWmc2yRutEpWEdVlwsCITSv0ivsxDeWe33f
	 WzXOqVJeqEc+9JSB9pYp4IK88A0AZFsz7lFViGungQLVWXtTM4HzXeBKKxFDTiZnSKYQb
	 fWiFzIecB7PsCw018v43fzzBe6o2mxTrjRkWvYiyQaCht59lWTTH188mfkdvUy+yDgDML
	 uJuHZhHNz9D6aANDyHLAC2T4cN/d6+lxcK6WyJ2Tdhz7coxQJkD/fGe4jjtXtBg2fLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=C9vlpw2a;
	arc=none smtp.remote-ip=103.209.128.51
Received: from mail-m12851.netease.com (mail-m12851.netease.com [103.209.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1B606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 07:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C1B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=C9vlpw2a
Received: from localhost.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 527d681d1;
	Tue, 27 Oct 2026 15:55:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/2] Manage the PCIe supplies with pwrctrl
Date: Tue, 27 Oct 2026 15:55:18 +0800
Message-Id: <20261027075520.3591049-1-shawn.lin@rock-chips.com>
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
X-HM-Tid: 0aa17c5b7cf003a4kunmefbf004c4b8273
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEtOVkJCHRlCSkkYGRhCQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=C9vlpw2ajSEUYZfntgIh45itrjseVYKzWGhYBVtKPodxZVz3HQVJbtg6p6v8MUzi5BLNMAENNwU5BY/kOJb4rTx+L2HgPm66vOI5SM6wuXY8EV3nwv83nPKIsQKZFrEZYXR8ASSX9+IV4tLAix9vhd7b3a9+kGog6FdndoJbdMY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=1fJwad9d4tyqt4SjrD99rAhUThoxvoAA2TOTT72jfPw=;
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



Shawn Lin (2):
  PCI: dw-rockchip: Power on devices below the RC using pwrctrl
  arm64: dts: rockchip: rk3588-evb1: describe the PCIe3x4 slot supply

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 14 ++++++++-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 30 ++++++++++++++++---
 2 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.25.1

