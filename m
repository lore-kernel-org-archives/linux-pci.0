Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712661C2AA;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460471; cv=none; b=GSPOXMRlMlwyoTXEuKeP64rPu1kb1bs5mkXmzVANshImOULYlYpvSjSrS9IzI60a62mFG0t2mwY4m0My7UE1Ew4i9bXKOlDuS21gmqOSL2/gGF7cJJ8fQN/EK/1q7W+BB75D76RrT4wfph0ZKO7WsIRw+KHyyR/7gLbdUpkxUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460471; c=relaxed/simple;
	bh=664nbVN/z/Nh13dTvS9ukzYiJiV3KLMrcH0uSAw82eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+9dxRTqPTXKoXzaULAdT5PkgP7XptKQDsYz4ggr4gKbhs2lTvm4uLEaMWpzxE1WgVn5TkqzJ6WeurnFdWn79dxvaPfBqu009JurkTnX1w7AfznTZ2ZSB7bmUga8Th+C+HYi5iBbc/1mqNyE5L3j37+07as3sWpYkMhBYPOpe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0+d8XYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0+d8XYT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1820BC2BCB9;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785460471;
	bh=664nbVN/z/Nh13dTvS9ukzYiJiV3KLMrcH0uSAw82eY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J0+d8XYT6fLN311B++sa9oa2pXrVD8RYUf5RuKuMr0w780tg2xLEhkDn8CweVBy4b
	 KBuRDC5/wBm/g7lMLM8kaIG9vLrc4/Z/UZRjSs4gLX+07hNt/3VkLu9wT487JpZ+x5
	 EQ/ncOGr2UEyFATz/cO+loB7e7kt4Xoz55BcFhu6lB99BXx1l9VKoQEba05BFzPLnQ
	 je+QIMRRWZB13FZO266KflWVFnrlLQmPxVbrCSt96CSdVxfxnh2UGufT5qft71X+nb
	 Nnsm5g0O9YYtMpSL0d/oJ5WKuUqcv7KlWUvIuu+eTCG0C0ZksWqOHz06Kz9hj/vUGZ
	 jvV/o8DE2CdRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF89CC55167;
	Fri, 31 Jul 2026 01:14:30 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Fri, 31 Jul 2026 09:14:28 +0800
Subject: [PATCH v4 1/3] dt-bindings: pci: ultrarisc: add required DP1000
 PCIe clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ultrarisc-pci-clk-v4-1-d738b491e49a@ultrarisc.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785460469; l=1883;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=MadaMzsEQt3m33Yn04ygfcyKkX6JurLuStxQ8qHRs6U=;
 b=BGwryA9H9iMnZba1+cnsha21LqaOqtk/tUxxJxBY9Se3jQlGUrYa5SHCYtvtVFMejLTxsycbN
 zV/6uT9UitrCfLgSVCI4uzlcE9ENsc79m3QYjDf9hj8szc7aj97pKyR
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Require the DP1000 PCIe controller nodes to provide clocks and
clock-names, using the standard DesignWare clock names "core",
"dbi", and "aux".

Fixes: d9ff07f45955 ("dt-bindings: PCI: Add UltraRISC DP1000 PCIe controller")
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
index 512b935bf5d1..d9d1488e915a 100644
--- a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
@@ -43,6 +43,18 @@ properties:
       - description: Legacy INTC interrupt
       - description: Legacy INTD interrupt
 
+  clocks:
+    items:
+      - description: PCIe core clock
+      - description: Data Bus Interface (DBI) clock
+      - description: Auxiliary clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: dbi
+      - const: aux
+
   interrupt-names:
     items:
       - const: msi
@@ -55,6 +67,8 @@ required:
   - compatible
   - reg
   - reg-names
+  - clocks
+  - clock-names
   - interrupts
   - interrupt-names
 
@@ -71,6 +85,8 @@ examples:
         reg = <0x0 0x21000000 0x0 0x01000000>,
               <0x0 0x4fff0000 0x0 0x00010000>;
         reg-names = "dbi", "config";
+        clocks = <&clkc 9>, <&clkc 7>, <&clkc 10>;
+        clock-names = "core", "dbi", "aux";
         ranges = <0x81000000 0x0 0x4fbf0000 0x0 0x4fbf0000 0x0 0x00400000>,
                  <0x82000000 0x0 0x40000000 0x0 0x40000000 0x0 0x0fbf0000>,
                  <0xc3000000 0x40 0x00000000 0x40 0x00000000 0xd 0x00000000>;

-- 
2.34.1


