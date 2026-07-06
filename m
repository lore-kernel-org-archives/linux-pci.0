Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE33CBE66;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331978; cv=none; b=TxzShDlTiDFWZvzjSg1wmjjh3ajaotXRbVxe4nxWBB8X37d9IBDMNju+ghKOzU2un1PLMmwbkrgc3iM+UiM8gz6NtqzlQoTaGYEr5KMKaYfoeM3fXT2zhXVgNqGK1j64tZB6Kn9lh4ReYuJVKle519Ksa4+E8mZC0A2mtACOjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331978; c=relaxed/simple;
	bh=ARa8ZnsgdLdg/iKhWkG3xGMLOPSSmk89NzD5EyIWAbs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y2RM0cl9skAi23UyK+wUXxXkOCBd+2GZXN7frq7qyprhQcjwx7u/C+stRYOgFSEviuRkmmmghbj5WB7z7KoODDHRGUBSZlrCkt1E1TjlVSwwYT89Ly9PtKLlJqs5UMbikmI25J9h5choBe0yfSnJj1PpoFSYliPbeGDm+nDfsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLmOrzh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLmOrzh8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 149AAC2BCB8;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783331978;
	bh=ARa8ZnsgdLdg/iKhWkG3xGMLOPSSmk89NzD5EyIWAbs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iLmOrzh8fGnSQHM6W6roI4fnzHfk7thBQJApT09bhlz8eeWjlujYsbEA/pAIPX4GU
	 iGPJKSQHKDOmKFSoDk+hrimdRq3g2ul/fNWyH3+gsgiO1ZPD0ycIJJ6sw9NRNhYBR3
	 fk6v974sRjsj1Ml9JC1BomFRe78FH/FBGcw2836BPbQxTHg2kWJ6Ny9MnSlnuhlirZ
	 OCpu5St6Dvw/vW4d39KkEJLg1JsSvwCi1WRv86YS4xsT/gY+JlJM0vlD0zjmPKKBw1
	 i25CmoazoT6VurhZ35ZBHgwfAsos41eQE+2vRc5+L2NKlvp3Hj2W306zKJz98OuIrO
	 EyMPYghxSmCVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0077CC43458;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Subject: [PATCH v2 0/3] PCI: ultrarisc: Add DP1000 PCIe clock support
Date: Mon, 06 Jul 2026 17:58:48 +0800
Message-Id: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFh8S2oC/22NSw6CQBAFr0J67ZiZQUFceQ/DomkaaeWXGSAaw
 t0FNK5cVlKv3gSenbCHczCB41G8tM0CdhcAldjcWEm+MFhtIx2ZWA1V79CJJ9WRKKoeCskk+hB
 jYRhh2XWOC3luzWv6YT9kd6Z+Da1GKb5v3Ws7Hc3qffs2+dMfjdLqyBiG+lTkmIWXn7OntoZ0n
 uc3Ou1X98gAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783331975; l=2442;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=ARa8ZnsgdLdg/iKhWkG3xGMLOPSSmk89NzD5EyIWAbs=;
 b=5liZG14Wgp0p6+iNL2dfhOlq6P6dQowxxxSHIu4uQK7sAy+VOk6RH3YDFH1wPKB8Plnr7O4FC
 3a2I2ilLYHRDGPIhmxh3pOgEYtGo1yt8PmKN9lHEGe87CgUq3CjCl8o
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

 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 16 +++++
 drivers/pci/controller/dwc/pcie-ultrarisc.c        | 70 +++++++++++++++++++---
 2 files changed, 79 insertions(+), 7 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260617-ultrarisc-pci-clk-ac19047af1ea

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>


