Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFEB486647;
	Fri, 11 Sep 2026 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132976; cv=none; b=CYWVXJgcj6YWAbWeMmh+oTncyNYhcDsSi6DekyVeoZHKhy8TIBctYjL7gMTC70BbL0XF/q5kxk0+P+D/j/vYKas/rreHoI3EikWzBWUjCSE4a1kfag2TImzQhRwKzMxHlmSRA4HhSxJGTLV2uGkaY5YOy7Aq2EUo3xs28vT9oA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132976; c=relaxed/simple;
	bh=+IMNMX8r4itntbYvCTVw5hgMSBfpObS20ipO6kbwkCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m7kuFX1U+C7wKqj4XeMMS8V9mnbrIQn8/twzZKFtKY3q9Fsfpc6G0j/7f8Pgdx/KdZE1tboTtOJH42tQsX5UIDTgQYRBq07Aw3XSj7aYfyLNb1J3ClR1NxmNvY+BHofADBTYdrcJuBafxAH6B+d2GWod2t+Dmr83BWyHlUa40VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aL0D4sMY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aL0D4sMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hl
	kDh2w3FYKJyuWC9RIyLPhUb8AZYQjeTSJNq/2gbqw=; b=aL0D4sMY8DfqNRk2QR
	wfGQAxM7wqe9xd58OF3ecMGCauO4nSxffVLagposE5qVNMinSnBw55evk/VYdfLB
	K2KpZjsGwwD3DbHspeWSa6DWXE3VfbSEIca6RItX8OeeWGlYyLSoWnQ5G3EBtzVD
	K6Wrar/BaRRB3BgJx/tzQQDKI=
Received: from zhb.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHqBJmAKRqYh6mRA--.52761S2;
	Fri, 11 Sep 2026 21:21:43 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v8 0/2] PCI: Configure Root Port MPS during host probing
Date: Fri, 11 Sep 2026 21:21:43 +0800
Message-Id: <20260911132145.211380-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAHqBJmAKRqYh6mRA--.52761S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1DXr45CF1fAr1kGr1DAwb_yoW5tFyxpF
	WFqFs3Gr4xGr15Ga9rGa1jkFy5Xas7GFW3GrZ8Gw13ZFs8ZF1UXF929a1Fyry7XrWS93W2
	vr9Fq34xC3Wqva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0JP_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AndgWqkAGl5BQAA3i

Current PCIe initialization exhibits a key optimization gap: Root Ports
may operate with non-optimal Maximum Payload Size (MPS) settings. While
downstream device configuration is handled during bus enumeration, Root
Port MPS values inherited from firmware or hardware defaults often fail
to utilize the full capabilities supported by controller hardware. This
results in suboptimal data transfer efficiency throughout the PCIe
hierarchy.

This patch series addresses this by:

1. Core PCI enhancement (Patch 1):
- Proactively configures Root Port MPS during host controller probing
- Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
- Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
  and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
- Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
- Preserves standard MPS negotiation during downstream enumeration

2. Driver cleanup (Patch 2):
- Removes redundant MPS configuration from Meson PCIe controller driver
- Functionality is now centralized in PCI core
- Simplifies driver maintenance long-term

---
Changes in v8:
- Rebase to v7.3-rc1.

Changes in v7:
https://patchwork.kernel.org/project/linux-pci/cover/20251127170908.14850-1-18255117159@163.com/

- Exclude PCIE_BUS_PEER2PEER mode from Root Port MPS configuration
- Remove redundant check for upstream bridge (Root Ports don't have one)
- Improve commit message and code comments as per Bjorn.

Changes for v6:
https://patchwork.kernel.org/project/linux-pci/patch/20251104165125.174168-1-18255117159@163.com/

- Modify the commit message and comments. (Bjorn)
- Patch 1/2 code logic: Add !bridge check to configure MPS only for Root Ports
  without an upstream bridge (root bridges), avoiding incorrect handling of
  non-root-bridge Root Ports (Niklas).

Changes for v5:
https://patchwork.kernel.org/project/linux-pci/patch/20250620155507.1022099-1-18255117159@163.com/

- Use pcie_set_mps directly instead of pcie_write_mps.
- The patch 1 commit message were modified.

Changes for v4:
https://patchwork.kernel.org/project/linux-pci/patch/20250510155607.390687-1-18255117159@163.com/

- The patch [v4 1/2] add a comment to explain why it was done this way.
- The patch [v4 2/2] have not been modified.
- Drop patch [v3 3/3]. The Maintainer of the pci-aardvark.c file suggests
  that this patch cannot be submitted. In addition, Mani also suggests
  dropping this patch until this series of issues is resolved.

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20250506173439.292460-1-18255117159@163.com/

- The new split is patch 2/3 and 3/3.
- Modify the patch 1/3 according to Niklas' suggestion.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/patch/20250425095708.32662-1-18255117159@163.com/

- According to the Maintainer's suggestion, limit the setting of MPS
  changes to platforms with controller drivers.
- Delete the MPS code set by the SOC manufacturer.
---

Hans Zhang (2):
  PCI: Configure Root Port MPS during host probing
  PCI: dwc: Remove redundant MPS configuration

 drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
 drivers/pci/probe.c                    | 12 ++++++++++++
 2 files changed, 12 insertions(+), 17 deletions(-)


base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
-- 
2.34.1

