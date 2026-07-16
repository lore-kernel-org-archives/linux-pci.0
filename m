Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DE432E6F;
	Thu, 16 Jul 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221661; cv=none; b=MHn+zgJdadEh2D4mWzQAKkuSkyHugWBYaSuoCQRlmj31EY3eBfNGyoDneistF8WOlY0cAxKhuKLrdHvnaetvhmqRPYypltL1MhQ7xx/w05Tf0oPoUPKR48P4tMcFueVtw0LrS0n7B3kQy4I4S+i5V0QwbYDsfDDlhTJNTpySPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221661; c=relaxed/simple;
	bh=85J86g8NwMy91eKvFnOGvY9WgI5qgSDdYWSluwEYNqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZya6+Y1+sq2ZGE184Ihgx6Sj2n0FrBoUu0nYCNGE9mtIkLpX5LXc3hyk9Vj7QwcTo7dphSzS++nnfm80a16u3yABGSQgGE6TefeZF3e4FOp6A3fhZNaDX+pQWgYg8n72/yXlxJisPbds1kcHz1bZDWfvMy58P1VQsrtZZ0MIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qdn6S6Mo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qdn6S6Mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1A01F00A3D;
	Thu, 16 Jul 2026 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221656;
	bh=VQuquWybIJt5NPvoYpIJOEYlI5UicxGSp3uv0yTZvu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qdn6S6MojrjHJfMkB/xPadjRuxuUBYqMPkyMFYE47DXeAf4ziW6XkxrAFOxK2ZkKx
	 xLZvsiGWzRvDeLYIHLcOayiYd3zbtRqwszhzz4GqRVm/s+Av5IJ+lcae3Hzv3D9SHU
	 mSdncdEXJfo2eJJUm7I2Elm2+ugRC8tISq/cDYETdRewZmOmIMrLOE+BYp2ou6hEj/
	 N6QGTOakVKnEy4OOvVrx0oMMrMfeqr+VOaD4caJQhpZMpI/+VH2apvgv8y5M3IKVqw
	 Bsoiq5PXK3fU9zosbHt8UOSaj96UAcD+07kbzRp4uvoHBwCuPoeQLeLE80vjDu/jcY
	 ZDcyr8Ak44HHg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 16 Jul 2026 19:07:13 +0200
Subject: [PATCH v8 2/6] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-tegra264-pcie-v8-2-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
In-Reply-To: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
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
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqWQ/QxB2TaBtKd69Bs1zWPF8liEb1Uhqm/g4G0
 qTeQ8Ouma2JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCalkP0AAKCRDdI6zXfz6z
 oZkID/0ZqjCPz7gVVBzumGwFhXuHlHpNk86SVtat/ARgnvhXxM9+a8ZC1kXOm/a6X2FRnZvA7Hv
 Yxm0octjq3j7+2eXAjm1JGNMsgk3AdTsR9NbCs79Si9y31DYciAG81w5HtbC/FMY5NSJBQGPlrg
 HVykOo4gvxKLD5/I7Fc0CL88f8AtDvunKaBbBDAsjdW7k5mEOdVVTqPvbPxTOKpM9fRRYgOKGWf
 4OJuO7mFEDlisYeagtEVC4OoYzJ6pnkhvu9E/rT01z52shSY+ZVBHRMVGF7BGYdQm0jVgljZkRY
 xFxrfQJi/lNzx/9jdPZsBnNAgRWMV/myqNuRKPOFH11ETw5Iy6v2j5udDLluFNrwDCmvQSpe1fT
 gODk+2/qyiPPCZpWlhyuDXVkQG4Qrngz5ZwJqXzTH9sffeBj30MEb6acvzgfKXhLakor5OnC7oT
 jyyy1Nq7CPQfffdtwp2Zjmk9vKirzw1A3krx2dY8IIezgpp/Fg2mg5iUiWI7LG3r9SM4Ux9+6fE
 qQ+yRUumfi/OLlXhWAgUsZ29Uf3lvutG6tJVkgu1mHYHaWOM9+l0i5y8GyH0uob6Q0nbR3/edgP
 uF83WP6MbmBXie0Le6aAfPtUqz13WvB4Dqu+Aur0VHngp7cFYp6C8V06LGUg4rQ8hrJVakLpexH
 9MD5VMVjgYsAWnw==
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

