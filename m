Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411A3F660F;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331978; cv=none; b=OfS2WA85v8tFuNoavaaN8szaoU0K+tWIB5rA3ssoR0rCKtEeMha6knmKvrE9Sx4DX2tl9EMecmaevwdg9oZ61KTGEACn0ZY45AOVXOKqkePD0FEwwwfhX+6dhD5wN2U0pptN8VYocHNlTcF4ETLHtCt95t3Aw44q0C9d1ScqL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331978; c=relaxed/simple;
	bh=664nbVN/z/Nh13dTvS9ukzYiJiV3KLMrcH0uSAw82eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPIEz464uLPPGexNqmQ4ySyUGDRzlhCjOs/NFSO6lrU3IDW5XjaSNKJJmLfrCk6CZ67M5VIb8r7k42zVmnL5JMnnw0cof3yIiWjAReJ/wDiYzi907ZsioxhThXkUevwxA2MtD1sHsnhOict1wOhze2/DtLC1vNFTegUUoYt4vRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6WhA/nt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6WhA/nt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E03EC2BCC9;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783331978;
	bh=664nbVN/z/Nh13dTvS9ukzYiJiV3KLMrcH0uSAw82eY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g6WhA/ntES7uDxPMPg5FwT7fBw9aNaGeUtJvruscp3LBAChHVME75XyES3lrOgdfv
	 l/gpZ7/p6M3Q5iyUNeO68bvygyoaNolUFez+zRhvuihqov/Dijc7S0kCww0ZjcE8Fr
	 1bgNkeq5CCKSJKom2NbJoTGdXTzkau9fRDyTpH0zE4Tqj7QL5kXAZ8yHh+QFEVzy7s
	 peBzYMA/uBcm3pMIklUK9AF7sx2AQEsK82o53a1snXNmh7kTL2vi8wSbhPZMoN69bQ
	 0Sj4wjuFIViHbD9pHmz21ZckphpzAJ7MBAQ7GeSC9ghSZl0jYoKbnmK+jlvC3QdKpz
	 arTE/lRoaOgwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5C1C44500;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 06 Jul 2026 17:58:49 +0800
Subject: [PATCH v2 1/3] dt-bindings: pci: ultrarisc: add required DP1000
 PCIe clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ultrarisc-pci-clk-v2-1-2f3fb6fba66b@ultrarisc.com>
References: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
In-Reply-To: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783331975; l=1883;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=MadaMzsEQt3m33Yn04ygfcyKkX6JurLuStxQ8qHRs6U=;
 b=bEFugdScOKe825UCHTbWbXTeXm1m7URDjoD1eWjcFim0uNMQs/Gd8eUEpT2Hdmix3YnD2H+RD
 bFJfeCVGp33CRIdk1h2c38sLXJIN2HlFqqK3nj2uhJ7L8g7Xbx1IySN
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


