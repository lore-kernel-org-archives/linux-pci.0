Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123D5695;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460471; cv=none; b=YYKY+lepZJOw/thsmdfAv2ibE4jYb/uq0vS1J+QUfHlULYEeg/WhBaHGXAQAsLnFHWqmtFbIh+pwGEK70C38LkCl7CWptSPoqx3oht3+DASC24Kp53QkHJaWkUsXldzdIyE0QrpUjrBTyh2xbJJa3iJd3HyjP64bC9/baEnnpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460471; c=relaxed/simple;
	bh=JSvec7HDFJGfnMuZsEtQRNBEJPE1AGTc5uAlGb3p9os=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YHR9r902dFdWfBGWkzFeduHETpW4vLWiwG84W+He06cxwNOv3+i0dYxqbJPGy9Th4mO1ztAXGGyNUX6jzsrZxVqE3++mPdj7bP3ZMSbflInPy17ErGkinZb40HWVrp3soa4/E6TdW6aIUUNURyxFjED91gpl3jfzBz9nODoGDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLQNoUM7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLQNoUM7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 120F7C19425;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785460471;
	bh=JSvec7HDFJGfnMuZsEtQRNBEJPE1AGTc5uAlGb3p9os=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FLQNoUM7ZPN21VjPcmU5G9zYgpyNSCM36jHQlJE9a9YpCpXKCPkeXSJZGx+SHj8P9
	 RNNTek0SyQMqZZtQkntcz5WLSt2JgYqnUlQWQtkn4uNc4qjW7w40fZyzHeZIOkxlv6
	 6kcarPOn2uhGYFDKfbiNIaHSAWNiEoNj2f/1801oPgWWM+8MUTvdWygUq54klCl4oh
	 8mnqyB4PuU+mKPPww6vHfVsKjJ/lD+MnV9079SSrOZz1pvp/2eAElbryM/XjIEA6+x
	 0ECrCgtpjUwdukuDe4WSKkGWqeiDGpkF/AYAk9XupnOAYDUQdkQNQHHq5RQKGHo7jJ
	 mmyb+F9ohSirw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F8EC55162;
	Fri, 31 Jul 2026 01:14:30 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Subject: [PATCH v4 0/3] PCI: ultrarisc: Add DP1000 PCIe clock support
Date: Fri, 31 Jul 2026 09:14:27 +0800
Message-Id: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPP2a2oC/23NSw6CMBgE4KuQrq3pA1tx5T2Mi7b8lfoA0kKjI
 dzdgkaNYTnJzDcDCuAdBLTLBuQhuuCaOoV8lSFTqfoE2JUpI0aYIIJK3F87r7wLBrfGYXO9YGV
 oQXKpLAWF0q71YN19Ng/HVw69PoPpJmhqVC50jX/Mp5FOvbfPigU/UkzwBhTnZGtLpfn+01mb5
 oamj8i+iiRiSWFJYZZbLaxWQuglhf8oNF9SeFJAMsm4NQQs/VfGcXwCdUTFIVQBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785460469; l=3428;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=JSvec7HDFJGfnMuZsEtQRNBEJPE1AGTc5uAlGb3p9os=;
 b=WeB0W6G3Koit7CUdQJ97HTBUOglCOydSGKTvyVl2+b6d52cYzGoeLXgc/05Vo2okJhp+Y+0Uj
 uHrM/GrKtlcDgLfLOfUT48grhSs1jdKo6wF6g8XYIIls5g+eLzTeNgZ
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
Changes in v4:
- Use devm_clk_bulk_get_all() instead of hardcoding clock names in the driver.
- Drop clks_enabled and simplify the clock enable/disable helpers.
- Keep the suspend guard for the failed-resume case without disabling the
  clocks again when the guard is hit.
- Keep module_platform_driver(), but drop the .remove callback.
- Link to v3: https://patch.msgid.link/20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com

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
      PCI: ultrarisc: use module_platform_driver()

 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 16 ++++
 drivers/pci/controller/dwc/pcie-ultrarisc.c        | 87 ++++++++++++++++++++--
 2 files changed, 95 insertions(+), 8 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260617-ultrarisc-pci-clk-ac19047af1ea

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>


