Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F781449B20;
	Wed,  5 Aug 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931066; cv=none; b=kJ79ERzbNdpdw65+//VZ/oC2/ayU0oh1uxM6uIVcv6tef+9XQGBeZn3VbKYZQBWr5Dj0dQxoT9DnHYwwqTNBxv5bNtnMBWWR2kC61gQnLTh5FfneQQjf3U3A/6arvB9Ecao2pEaYk8UFK8RvH3rw5UXuW4pMWpkNzrPo4eaPoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931066; c=relaxed/simple;
	bh=85J86g8NwMy91eKvFnOGvY9WgI5qgSDdYWSluwEYNqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tplTC6qOZ02Kw/EA0yKTCTYPqpqaETGqb4+ag7I0Kmv7DG+miX/BcCo0wNTVqa47ZjJ0JToHdLH9ZuPHWJMLScPs5t+e/jurPWtszj8ZdG/9PkFaFajRXn4ZwC+KXjlmg+ubJ0tI5W8OYdBW2b0qpMBb0iWph8anJXzHZTU3Wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeJydkvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeJydkvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F6C1F00A3A;
	Wed,  5 Aug 2026 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931065;
	bh=VQuquWybIJt5NPvoYpIJOEYlI5UicxGSp3uv0yTZvu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SeJydkvUAjoePMre3ouyJYH/jHyr64G0xW12l/yZvbWrjzfY0SMuRg4MN30HEqShT
	 JRSsaNQZzIUgqygwD5tqp2WH/23n64IwIeSqkTgFLA3IOlhBLNvLokQdaFUYreeLPb
	 gDQhMe5V7u1QgWYNh/wgdRpuRR7h4TaFjLXIrpKJAeUGNlhIpMmc/lWafZ9MKf/96J
	 BngmkotQlgnBcuV0bR4Ybdl9q31N9Onjs3FdBLu9yqucRxHxdg2Eb0Dlwqzzu6YBqc
	 J6fq32VjzeMALDSBjvAZFTvy3eJzB4W9ryhe6O0Au4GahcBfKwFwPVd4glzDX7QZsh
	 hYCXxP6n7TWjg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 05 Aug 2026 13:57:21 +0200
Subject: [PATCH v9 2/5] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tegra264-pcie-v9-2-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
In-Reply-To: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=treding@nvidia.com;
 h=from:subject:message-id; bh=y0cAIDjIfEssDyJ41GlxlCD4kHVl3Su/tkVt6PDr3jQ=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqcyUxTZ9hSKbdc1UbF/l93dmE/oGmPkOlFqz77
 N5ExqkfqyCJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanMlMQAKCRDdI6zXfz6z
 oZwfD/kB73p5Laln1O6TV38jtHT9Rq9H6/PhIVZhGWd8fhtczMzFu3SYGC9o4nSPb9+iM3/u0h0
 ZXG82kdHMR5h3SZbcaiR6L2ZOtJjJu10JikTfXliVtoQvlZoDQe2njabXl0imIEm0eIxdudhI0G
 eckgteHuIpcpjVoi8EmcUNnHjHEwQZaRv9ZT+N/U/DNa8A5eC3npkIk8O7TjGoT5VL4HM/HJKhz
 xIwBXAqXYos0UKEM4LML9b+iSmw7w90esrVomfmyekpUTBS3fqE4rNERmOXpSGik7+QDc+dBH20
 7Yrecq5JgVx8xu6s+ULJ24FbkFj5wvTcIb5CiK5qMIr+re4yUF5HIQQhHL+VUmXAWkGL6AgRLmc
 FSeyyP1i/2mtfBeVbdNqQN1ZZndJtSqbOT7qhds+Bxv4+Xq4ivpbfsZyuFsn++6/BwXTTQl55b6
 PcMvaZa+6WVOxaO1FrN7QOBI+X6BGRhcs8KNzg1c+rrJO2aY8TLW9Yy04c7S+etR1ermb/wSde0
 CX+Fj5cH3ePFKZUK693YnYwyXIFWO31WrtOOUuP7xhjMCPRLv5vnFiYy5RGD5u0k08b5KOB9xku
 gXcWS9voeEP9FGg66HlNV/uU9K6N2XDMNWZcc3l/Gd1ch2BGOFBP7lWWWrVTybgC3geX2fa4YGb
 6ZbI1ohXUV3uTuw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Switch to using the PCIe root port bindings in preparation for using the
standard WAKE# handling.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/pci/nvidia,tegra264-pcie.yaml         | 40 +++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
index acb677d477fb..f0114defc04e 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
@@ -52,12 +52,11 @@ properties:
           - description: PCIe controller ID
             maximum: 5
 
-required:
-  - interrupt-map
-  - interrupt-map-mask
-  - iommu-map
-  - msi-map
-  - nvidia,bpmp
+patternProperties:
+  '^pcie@':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+    unevaluatedProperties: false
 
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
@@ -96,6 +95,13 @@ allOf:
               - const: xpl
               - const: ecam
 
+required:
+  - interrupt-map
+  - interrupt-map-mask
+  - iommu-map
+  - msi-map
+  - nvidia,bpmp
+
 unevaluatedProperties: false
 
 examples:
@@ -130,9 +136,18 @@ examples:
         ranges = <0x81000000 0x00 0x84000000 0xd0 0x84000000 0x00 0x00200000>,
                  <0x82000000 0x00 0x20000000 0x00 0x20000000 0x00 0x08000000>,
                  <0xc3000000 0xd0 0xc0000000 0xd0 0xc0000000 0x07 0xc0000000>;
-        bus-range = <0x0 0xff>;
 
         nvidia,bpmp = <&bpmp 0>;
+
+        pcie@0 {
+          device_type = "pci";
+          compatible = "pciclass,0604";
+          reg = <0x0 0x0 0x0 0x0 0x0>;
+          bus-range = <0x01 0xff>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
       };
     };
 
@@ -167,8 +182,17 @@ examples:
         ranges = <0x81000000 0x00 0x84000000 0xa8 0x84000000 0x00 0x00200000>,
                  <0x82000000 0x00 0x28000000 0x00 0x28000000 0x00 0x08000000>,
                  <0xc3000000 0xa8 0xc0000000 0xa8 0xc0000000 0x07 0xc0000000>;
-        bus-range = <0x00 0xff>;
 
         nvidia,bpmp = <&bpmp 1>;
+
+        pcie@0 {
+          device_type = "pci";
+          compatible = "pciclass,0604";
+          reg = <0x0 0x0 0x0 0x0 0x0>;
+          bus-range = <0x01 0xff>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
       };
     };

-- 
2.54.0

