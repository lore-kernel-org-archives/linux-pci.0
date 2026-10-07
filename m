Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A3347BD4;
	Wed,  7 Oct 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351430; cv=none; b=tghL/5FVInESzXfxzl7qW4iWuA87diEXyBhc4lEc8z3AI7tGJ/Bc92l7fof1somTJvLuokpACu9hKBmBnUqbUBgKkjgcRWpmhFSNm9GDZW6oIs/vJxTMVPM+xgijgWUFlP+7vzVUQo+y4IbPUwVR4tfGDLI0sW62jaRoVyu7YGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351430; c=relaxed/simple;
	bh=YUEF36lohVn++/a1MgPSbr0QkpLsQ4/6zzWsufvCZEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hoZun5wTiNK9DWMurIIkUqjX1aryTUfnQKUlvR1zjeCK1TEAJc1aJY1uMMTi6w5eTKwZPHi333lHTXcY9GBZn6qmal7QNNYoh+6x1V5igs3LrtlhaCIkc7/DHfptd52Nf/oysEdMDo811nSqJWhCqRGaNofLSWmC+a5ctk7Thho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/74R4Na; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/74R4Na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBBD1F0089B;
	Wed,  7 Oct 2026 05:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351428;
	bh=tcSxhOiDrp3UQQKkfUKaBm9Y3n2G1K7iOTeVkE1Aipk=;
	h=From:To:Cc:Subject:Date;
	b=A/74R4NaKVGFHIHsgQ8GvofUVsKiOCpxInv65lfAjDpnYl0kXpfe/oA2pYmwuurK9
	 3/Tvl8Zfj5xvVc/80y/deA1a1w5o98x44EpCsI/dtH5qoZvbVjkNgKZjhntSNXNq3G
	 78M7MdxoPm6sO0/bBQG2MTcj/Ogsqzg3N4AtpgmXNMxqaAOIT479C6l+FufCviIsdN
	 sy2wsC3Ly1yVgNtM27ZSU8ucNjo2haTKDfGuGgzFVeHkguUL0yB/hdLHHeP2TdEshu
	 tRte9V8NUgCTtBzDl9o/4Cn+rJbe1bBlKBhsMFfZupmsOxV3UB5HB7/T13ufDUlCwF
	 xsjNAGPHIbLCg==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 0/9] PCI: rzg3s-host: Add PCIe hotplug support
Date: Wed,  7 Oct 2026 08:36:36 +0300
Message-ID: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds hotplug support for the rzg3s-host driver. This is a
continuation of the series John posted initially at [1]. Along with it,
prerequisites fixes and cleanup patches were added.

Thank you,
Claudiu

Changes in v6:
- addressed review comments as follows:
- added patch 7/9 ("PCI: rzg3s-host: Add helper to wait for link up")
- adopted the approach from pciehp and saved DSN of the connected
  device and, based on it, take decision if the bus devices need to be
  removed + rescanned
- in case of link up and !list_empty(&bus->devices) remove first the
  devices from the bus and re-scan (adopted the approach from pciehp)
- with the new approach cleared the link IRQ (before enabling it) in
  probe, and resume paths

Changes in v5:
- collected tags
- added patch 3/9 ("PCI: rzg3s-host: Select PCI_HOST_COMMON")
- addressed sashiko review comments (detailed in individual patches)

Changes in v4:
- simplified comments in patch 2/8
- kept only DL_UpDown changes in patch 7/8
- added patch 8/8 for the .reset_root_port() support

Changes in v3:
- added patches 1-6
- re-worked patch 7 to use struct pci_host_bridge::reset_root_port() API

[1] https://lore.kernel.org/all/20260630141720.3938514-1-john.madieu.xa@bp.renesas.com/

Claudiu Beznea (8):
  PCI: rzg3s-host: Follow hardware manual clock/reset initialization
    order
  PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume
    phase
  PCI: rzg3s-host: Drop nop instructions
  PCI: rzg3s-host: Move host configuration code together
  PCI: rzg3s-host: Move suspend/resume code into dedicated functions
  PCI: rzg3s-host: Move IRQ domain setup code
  PCI: rzg3s-host: Add helper to wait for link up
  PCI: rzg3s-host: Add bridge::reset_root_port()

John Madieu (1):
  PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

 drivers/pci/controller/Kconfig           |   1 +
 drivers/pci/controller/pcie-rzg3s-host.c | 952 ++++++++++++++++-------
 2 files changed, 673 insertions(+), 280 deletions(-)

-- 
2.43.0

