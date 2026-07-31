Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D302C0F6D;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460471; cv=none; b=Z2JmckIFNwBjvIDqqC2AJoBUMGupVjC8Hx1owpPuNL/NfFyzlnEFdQd5o5SaPD6wakeooF4yXmAPMoKcu5e1EBnZacnhBuARSsYO4/IMPtB/26UTjpp5zXDo06I7GDffH01N+PYdtSul3kVfBrTef1n2Env+DcPphs4HNmuCcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460471; c=relaxed/simple;
	bh=FYkPIvAElmiYWEd5HvpzjyUnAR2zLgN+dB2KSmza5hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZrcJE5TCSb2bE+9Cs9XOpfiLIUw3HLG48KJno62PnSuQb4u8ybXcoWXF+ghLuj7wgmUlKZoYPIelX05S8CvsMzkzFisuB21sSfyfjjdRE6K+KbqZe2yy77xMVtsSuqSphRL3R7ajuh5cjSwhOqSgcRzA1h3CHtK+TvbmomBqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxkwHc/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxkwHc/W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35AD2C2BCFA;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785460471;
	bh=FYkPIvAElmiYWEd5HvpzjyUnAR2zLgN+dB2KSmza5hY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AxkwHc/WjZsZOzHUD4/9Kmzo7Lz+biU5W5eQz+V+VZQtL8worGTHk2Y7jqedgDvbx
	 aSPpuTWgcZC3hymExfOK1cWNygcEH8Y+aPTKU2lN35/xqW87wTGQFnR7aqmqhSPlgL
	 xsKujv5gV2q/TEKuBQbp+WG2j3u4IUDekhL6KrdJI48C8GotDAoR6YfD9ftqiiwrme
	 8V8INC9r1H1nY8LgBb8akq4qDHgwVszTUKTPM7216HyuHDbcW3kyoqbWS1rEqzz5Xi
	 O8L8/qtNRuJ61QYBfmyeYX1bVQs9AdfEL9MF5SkaLcDNit/R7Cs1vWYe8JgCMo6QKf
	 hoKZEyc28sXyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C0C55173;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Fri, 31 Jul 2026 09:14:30 +0800
Subject: [PATCH v4 3/3] PCI: ultrarisc: use module_platform_driver()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ultrarisc-pci-clk-v4-3-d738b491e49a@ultrarisc.com>
References: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
In-Reply-To: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785460469; l=1066;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=peRDpMKKHgxmxfFJTmmW4y1XH8UWyNDI4nxaz6qI5+o=;
 b=ISyUdZJpfcX4jzGcRBoVy6KvH83lFss0KJuoc1oGWzJe5rKs9IcNDHaapd/wqohde027wEIbk
 ffuFpITtylBD64xlOdAkC/NOie0iycTOV1P/YWpTT8pS3kOaeZJ5ZZU
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

CONFIG_PCIE_ULTRARISC is a tristate option and may be built as a module.
Use module_platform_driver() so the driver uses the standard registration
helper for both built-in and module configurations.

Leave .remove unset because the driver registers an internal MSI
controller that cannot be safely disposed during removal.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 8e57135453b7..51e89180490d 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -240,7 +240,7 @@ static struct platform_driver ultrarisc_pcie_driver = {
 	},
 	.probe = ultrarisc_pcie_probe,
 };
-builtin_platform_driver(ultrarisc_pcie_driver);
+module_platform_driver(ultrarisc_pcie_driver);
 
 MODULE_DESCRIPTION("UltraRISC DP1000 DWC PCIe host controller");
 MODULE_LICENSE("GPL");

-- 
2.34.1


