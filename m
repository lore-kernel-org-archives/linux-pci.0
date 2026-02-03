Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570631922FD
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078110; cv=none; b=Epiw6iEqp7gDL5js7UQrGZMc/WLrXUxmn8ApNMz4UE7e+50DEFM6jcp799NfWidQIBfiMxXyTMUD8mvxihBSJFR1/U24FoA5Ta83r0ikfJws2YDuxn1oqmXUtjPKSKIiwMPEYjqjIh9q/SpvUmRXY3sLcAAtMuQNNfKOrX1MDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078110; c=relaxed/simple;
	bh=Qg515vPUC3kcI00i4qvUjLj97sIrt0kOOoiol4VVZXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jM1UKOP+sUg6Qzbry6f5Ov1okZR1p1eXDVRysLaS0nGmx/LUgcRItzXawNkkqEPhq3yZ9NSEAZ+bJ9t/7fVShM+T/Oe4UBP24Ev+fiBFrYhA2s7D2X7tkTVBxiffaMwskhhcnItcLFHNLyB52c3s4XmbOn8QT7YNsFQS3+wjuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W7r5iL5h; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W7r5iL5h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770078107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuOWsCVIuR/WP5JRTGWbVJdWhDaeD5ZnnFP7ct7wKpA=;
	b=W7r5iL5hkTeQqW8Tiz4WLikSlkj4xcLTE/siInq6WUpr63vnkN3X7yN6abAqkxH0s5s6Ax
	oGrpdEON//phRH0Qy8HTJ5YB7JGd95fAeoarSq3vpBpn/QjbLoxjZderDJpwRRB5z0nPZH
	m+9cFfB2Ofzw3aDCUV7etEuM9laF1T8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
Date: Mon,  2 Feb 2026 19:21:21 -0500
Message-Id: <20260203002128.935842-2-sean.anderson@linux.dev>
In-Reply-To: <20260203002128.935842-1-sean.anderson@linux.dev>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add resets so we can hold the bridge in reset while we perform phy
calibration.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 9de3c09efb6e..7efb3dd9955f 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -69,6 +69,18 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 3
+
+  reset-names:
+    items:
+      - description: APB register block reset
+        const: cfg
+      - description: AXI-PCIe bridge reset
+        const: bridge
+      - description: PCIe MAC reset
+        const: ctrl
+
   iommus:
     maxItems: 1
 
@@ -117,6 +129,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/phy/phy.h>
     #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
     soc {
         #address-cells = <2>;
         #size-cells = <2>;
@@ -146,6 +159,10 @@ examples:
             msi-parent = <&nwl_pcie>;
             phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
             power-domains = <&zynqmp_firmware PD_PCIE>;
+            resets = <&zynqmp_reset ZYNQMP_RESET_PCIE_CFG>,
+                     <&zynqmp_reset ZYNQMP_RESET_PCIE_BRIDGE>,
+                     <&zynqmp_reset ZYNQMP_RESET_PCIE_CTRL>;
+            reset-names = "cfg", "bridge", "ctrl";
             iommus = <&smmu 0x4d0>;
             pcie_intc: legacy-interrupt-controller {
                 interrupt-controller;
-- 
2.35.1.1320.gc452695387.dirty

