Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE3484250;
	Mon, 19 Oct 2026 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392686; cv=none; b=CZtbo4xXUZUvcRMKZbKublkdvWns5+lar2yRzfL4+WHZXgowlyCwYak0GlzhL9uXYW+sleiNF5daahfVCPkMFLDOQfqYbV1hiyPWM7VAWLGtVuGhxzmo/0r/qK3Iq+fWzPSAjvr1R6+e5/UynT0VbLGk1fMNOFcLRxtB87n51YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392686; c=relaxed/simple;
	bh=SKCpijYdf40bdB7TjZgsPQt1cOqmj+Rx6EDrKlUQHcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYyu3dEdWlST19x8dhUqJe3wNan+tc/jile/ZZ6r1z1nMnk8yVuU6g1Pqs9NOIDlHKp0NvV7eBCoQFmX4Qf5wlGsaxmSad/UUkO3yhHT5vcoTLH+XykN++wGviqpwJ+uA44YsCXw1zqv9A5uRqAw2Ebi6/P0gQUP4YeApnoAvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2PeLf+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2PeLf+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C210B1F000C4;
	Mon, 19 Oct 2026 06:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392684;
	bh=j8oA05heiJ+N4wmFr3ACIe5gpscRTFotRO2J7gCfkEA=;
	h=From:To:Cc:Subject:Date;
	b=n2PeLf+F0crZIjsT3pnOI1BhYjefSUw7Ncz+YHki9etBGikp11A/aV8fgMbFuM+BV
	 WSb6yO9QWpGRzw48nBTi3j94NHhxsKMEUkrj0ANTVd8+22ySy8bjK4oPOlwQaCZ98Z
	 jBQZGr4kh80CszEwjmRf8Jeo7UjY40CwdseDH3Y/2zuDHMOwBGkMKUv3UcLbFRW0ur
	 QnBj/c2ZHqqRK6lgtywfLLoftQX9WWuUmYTmZ5fFDcfUyzUUtjgZ2Opy5x03gfVEen
	 vAvcsV7o2cRrSWS1KL54XAVVbnSg2afWLzrnH7ZW8SyoqD86J/cHhDtRX3KMDi9rhU
	 7Q9cV7HeEBGPA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
Date: Mon, 19 Oct 2026 09:50:11 +0300
Message-ID: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
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

Series was tested on RZ/G3S and RZ/G3E boards by generating consecutive
link down/up events. The RZ/G3S has an I2C device which, depending on
the way it is programmed, it controls the state of the PCIe link. The
board has 3 PCIe interface: PCIE_SLOT, M.2 Key E, M.2 Key B. The
following script was executed for ~9 hours:

#!/bin/sh

echo performance > /sys/module/pcie_aspm/parameters/policy

while :; do
        i2cset -y 1 0x18 0xf4 0x8 # Link down
        i2cset -y 1 0x18 0xf4 0xc # Link up: PCIE_SLOT (NVMe Micron)
        i2cset -y 1 0x18 0xf4 0x8 # Link down
        i2cset -y 1 0x18 0xf4 0xd # Link up: M.2 Key B (NVMe Transcend)
        i2cset -y 1 0x18 0xf4 0x8 # Link down
        i2cset -y 1 0x18 0xf4 0xb # Link up: M.2 Key E (WiFi AX200)
done

Thank you,
Claudiu

Changes in v7:
- added the following fixes patches:
-- PCI: rzg3s-host: Don't mix goto-based unwinding and cleanup helpers
-- PCI: rzg3s-host: Create the INTx IRQ domain before setting the chained
   handlers
-- PCI: rzg3s-host: Initialize the IRQ domains after the IRQs are masked
-- PCI: rzg3s-host: Drop read-modify-write approach for the R/W1C
   registers
-- PCI: rzg3s-host: Use cached MSI address in .irq_compose_msi_msg()

- addressed sashiko comments:
-- do not mix goto and __free() cleanup constructs
-- addressed concurrency: b/w different paths calling .reset_root_port()
   and b/w IRQ subsystems and .reset_root_port()

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


Claudiu Beznea (13):
  PCI: rzg3s-host: Follow hardware manual clock/reset initialization
    order
  PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume
    phase
  PCI: rzg3s-host: Don't mix goto-based unwinding and cleanup helpers
  PCI: rzg3s-host: Create the INTx IRQ domain before setting the chained
    handlers
  PCI: rzg3s-host: Initialize the IRQ domains after the IRQs are masked
  PCI: rzg3s-host: Drop read-modify-write approach for the R/W1C
    registers
  PCI: rzg3s-host: Use cached MSI address in .irq_compose_msi_msg()
  PCI: rzg3s-host: Drop nop instructions
  PCI: rzg3s-host: Move host configuration code together
  PCI: rzg3s-host: Move suspend/resume code into dedicated functions
  PCI: rzg3s-host: Move IRQ domain setup code
  PCI: rzg3s-host: Add helper to wait for link up
  PCI: rzg3s-host: Add bridge::reset_root_port()

John Madieu (1):
  PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

 drivers/pci/controller/Kconfig           |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c | 1260 +++++++++++++++-------
 2 files changed, 851 insertions(+), 410 deletions(-)

-- 
2.43.0

