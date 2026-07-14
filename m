Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC263033DF;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991484; cv=none; b=tYssIQwwbfX8DS1pi1cKz5T0bqBZDsGF9ORMUhvBlqJB85G8ruTkupVipaeVqQVogUB2i4H4nUj+M9Uxjx07o2d7fxFrcrvAPKpAN7WbeSnsljRwafrCVtqBxCVoyFfIDpBDAUtbBbHu2wriNEcCOknZGlFtPsYv+9I6XNKiQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991484; c=relaxed/simple;
	bh=wRhAe2vhMpJdHMJQbDxyjSWX8mJyAJcUW7ZZCSSWaQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXDzK9JxUTENSokpiLUd8d1LkYO/CMWAY56wxuNuABLnunOGpwJnHrDdgIAoZYDIriJ7Hii5mq7AqBbP6+TI2Ae611GcW6lGlyKGlQmR0x/yPqPh0zba+HyNps5KjXMCCuvPcR8xarokF3DdYQ+LJT5xi4YrI/54zQZlimQZsfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ9DOCao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ9DOCao"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F1E0C2BCFB;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783991483;
	bh=wRhAe2vhMpJdHMJQbDxyjSWX8mJyAJcUW7ZZCSSWaQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NQ9DOCaoekIOga814ouD0lya4WlXXTdLduWY45TIzM2UPodkxbJaXjhGU2xghZ0Ee
	 2o/aj/CoZnrpNZbX/6bExfF/R4agbBWhuKLnzCfL7tFNujlMli8Dom1E66zzRmjcGX
	 oc2V8il9dWRFPOZ6VSfT/P+4Qx/A+bh7abewgDDTWS68WUODGFiRqMkjKrtN9Y3V9p
	 fXGBvDE2gzNFwXwpWUbj/PY0/nFRls2HOh1zb1pelwXRusp5h7LZTEiDWw2HaglWmn
	 qi5vk353m9G80P5toTroILjIXVifDrRy7yyxcAHvpnzF6huEJGdm0EPTXb/VdmjM/N
	 yX50HiqrFK1Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8311EC44507;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Tue, 14 Jul 2026 09:11:04 +0800
Subject: [PATCH v3 3/3] PCI: ultrarisc: allow DP1000 driver to build as
 module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
In-Reply-To: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jia Wang <wangjia@ultrarisc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783991482; l=1888;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=XcTZmVoSZFS2n0hsc4SvpU5AR+j0HF5sHlxgI3DxZTg=;
 b=lVeYRfT+j1fweGZ2YwkwrOX/iivL/LBom7hfF+EFD1hMgVtG3nOi2X5aj2adhEPBAw53sdwu8
 Qg31WSd9KxkBIFZWImmIbCltSqkCAIziZGU4ry6MavZ/eoInRn8bV75
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

CONFIG_PCIE_ULTRARISC is a tristate option, so the driver can be selected
as a module when COMPILE_TEST or platform configuration allows it.  Using
builtin_platform_driver() leaves the module build without the module
init/exit plumbing and causes modpost failures for the generated .ko.

Use module_platform_driver() so the driver works for both module and
built-in builds while keeping the existing tristate Kconfig entry.

Add a remove callback and call dw_pcie_host_deinit() during removal so the
root bus is torn down before devres releases the controller data.

Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 72ba5840b62d..9bee522a20e9 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -193,6 +193,13 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void ultrarisc_pcie_remove(struct platform_device *pdev)
+{
+	struct ultrarisc_pcie *ultra = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&ultra->pci.pp);
+}
+
 static int ultrarisc_pcie_suspend_noirq(struct device *dev)
 {
 	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
@@ -256,8 +263,9 @@ static struct platform_driver ultrarisc_pcie_driver = {
 		.pm = &ultrarisc_pcie_pm_ops,
 	},
 	.probe = ultrarisc_pcie_probe,
+	.remove = ultrarisc_pcie_remove,
 };
-builtin_platform_driver(ultrarisc_pcie_driver);
+module_platform_driver(ultrarisc_pcie_driver);
 
 MODULE_DESCRIPTION("UltraRISC DP1000 DWC PCIe host controller");
 MODULE_LICENSE("GPL");

-- 
2.34.1


