Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1B35E1A1;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991484; cv=none; b=Nhbbx1hGqUHM4Ge+9kTPpRJ7MfdAoOMobiqU4XjDvkfWjWUNcQuYp0nhBG8DKR/5NhNzzfd1L/gfXH4ba/JGi+3MtLjBikE7TMgQ0OjVO53q9Xovb/h7W6AsvYw/T1c+TlWay/k6yYbjBkq2SLT/qTuo6BPtlWacd0ytJPnHYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991484; c=relaxed/simple;
	bh=2okLRAGbVQqKklUYGWmJ7tyA+p3vyLm+/B5mkepvT5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Trs3/T45oNnbGm0tJLjuQfD33rSJ0JHZ1blOLGouBI643e/j1dBh/VFT6NWoeN2y186zTbSnbirCZBdjor6u5aVQ+Nwv6cA21TIbOEU97dVURgAhEPIO+obxXhHmMWjHfp0nlOjIomOrFz4Lu3ekqPsXaLTXj8MFhLEk+pRPgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzhCOYWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzhCOYWs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C387C2BCB8;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783991483;
	bh=2okLRAGbVQqKklUYGWmJ7tyA+p3vyLm+/B5mkepvT5Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MzhCOYWsGCsJ7nUAWyah/617hIhMdYAY2W4j2Cv/1fYQj9wwqWOujTNv6mdZOPSDx
	 Gm/9rBi8ToXqvHFB4XWHWStCm1Tdv2cOcS9RbXsc7IL5eyjMtcq/rHl55wfDYDm6+X
	 NDT7tu9RAoe4lH5sgdjMG1+GlAnTUwlh3jfEtLtmeumzlwYLjJOMrSy9s4cKCLntuF
	 Nw8Uoldgcj7sXtq7lJ+b37I546qIJbHnuhjvFDgMnFf/OwFdzIQhIlGgolU+yacemw
	 7Xl86kBXU5AFFmGJ7q/2F+E4vPcO6gJTlRc813RdrkZnmvOMaT7HgBaI26v/r9Ggtq
	 3emwWbLi8+ZJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD61C44501;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Subject: [PATCH v3 0/3] PCI: ultrarisc: Add DP1000 PCIe clock support
Date: Tue, 14 Jul 2026 09:11:01 +0800
Message-Id: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKWMVWoC/23Nyw6CMBQE0F8hXVvThxZx5X8YF225lesDSAuNh
 vDvFjSaGJaTzJwZSACPEMg+G4iHiAGbOgW5yoitdH0GimXKRDChmOI57W+d1x6Dpa1Fam9Xqi0
 v2CbXjoMmadd6cPiYzePpnUNvLmC7CZoaFYau8c/5NPKp9/FFseBHThndgpaS7VypjTx8O2vb3
 Mn0EcVPyZlaUkRShJPOKGe0UuZfGcfxBRQjU7UOAQAA
X-Change-ID: 20260617-ultrarisc-pci-clk-ac19047af1ea
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jia Wang <wangjia@ultrarisc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783991481; l=2995;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=2okLRAGbVQqKklUYGWmJ7tyA+p3vyLm+/B5mkepvT5Y=;
 b=PMqfwG3L/HPPIM7FZXN8QLT8vF5qGlTEcsmO7O2+RjQAIHyJ7ZeLJpxQgTkzrkK7U3NqTCTXH
 nDKJzlPRWvxDi0rmUvbOf5DLuRDJjhg5buBapFyxEWWuIVl333CFIcQ
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

Add clock handling for the UltraRISC DP1000 DesignWare PCIe host
controller.

The DP1000 PCIe controller depends on three input clocks: core, dbi, and
aux. The driver accesses DBI registers during host initialization, so the
clocks must be enabled before the controller registers are touched.

This series documents the required clocks in the device tree binding,
enables the core, dbi, and aux clocks before DesignWare host
initialization, and keeps them managed across probe failure, detach, and
system suspend/resume. It also switches the driver to
module_platform_driver() so the existing tristate Kconfig option builds
correctly as a module.

Testing:
- Build and module build tested with ARCH=riscv.
- Boot tested on UltraRISC DP1000.
- Validated the PCIe binding with dt_binding_check and dtbs_check.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
Changes in v3:
- Track whether the PCIe clocks are enabled and make clock enable/disable
  helpers idempotent.
- Skip dw_pcie_suspend_noirq() when the controller is already suspended to
  avoid register access with clocks disabled after a failed resume.
- Disable clocks again if dw_pcie_resume_noirq() fails after clocks were
  re-enabled.
- Add a remove callback to deinitialize the DesignWare host when the module
  build support is added.
- Link to v2: https://patch.msgid.link/20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com

Changes in v2:
- Add Fixes and Acked-by tags to the binding patch.
- Add a Fixes tag to the driver clock handling patch.
- Fix the suspend/resume clock handling so clocks are disabled only after a
  successful suspend and kept enabled on resume failure.
- Add a module build fix by switching to module_platform_driver().
- Link to v1: https://patch.msgid.link/20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com

To: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: Jia Wang <wangjia@ultrarisc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Jia Wang (3):
      dt-bindings: pci: ultrarisc: add required DP1000 PCIe clocks
      PCI: ultrarisc: get and enable DP1000 PCIe clocks
      PCI: ultrarisc: allow DP1000 driver to build as module

 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        |  16 +++
 drivers/pci/controller/dwc/pcie-ultrarisc.c        | 112 +++++++++++++++++++--
 2 files changed, 120 insertions(+), 8 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260617-ultrarisc-pci-clk-ac19047af1ea

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>


