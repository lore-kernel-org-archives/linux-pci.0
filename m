Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601888;
	b=FIg/83Jal8HvOAMMkPJloNo2oupSBBhA97U1nla+OUOIR2Gnnzw081hTl/Qz5sVNuLYb
	 iQOuWkXbs84duOtCAEinFvzrOd7XjMikw1BgBF7Y11YqDGm+ClSQIcn9p68Pi3W8ZRtsA
	 JGBHU8mxgyZxR3vCpkuGZbYU8WZrWRl7eKIzs7JsibXRwPW5bH6m6MX1ccIfU2M4run83
	 7MQX9ZUg0+7YWc1eooEhdfNYJK1Yl68f1nmVRaHrKS4tRR6SVMnQ0RognZjNf8lvdgYYc
	 JIezuXba0m4mfF3rroBg3W2NZxnrIIEgBQWkftcOXfqBI9r+fSVDPKLueVYVjR43HoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601888;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CriRUap8AmJOUJMxrXkt9qWW59g/yopAD2nnYbYSa7A=;
	b=u7a9YZ7656bzcbFcClvBZJ9Vq1lPnjVHvlubwHS4JWh9em+7Fr3lTwLSuEB2sDnZ9Rwz
	 Qy5kbWWCkpjbhFbKI3vOD0wuVVSgKo+EIveYjqKyWMKY6Qb1tp8sLhBk31PYX1084O0x3
	 Hnmrur+YwtFd1L+VnDiVGsSMJAzh67UIVrn874M9tvrtkGChDQyHoit/a5glusU+JN9Y/
	 sjw+wupvgMDwoJ3X9TkxXaylmJLW0xXUaDjIIgySqvvXK2HK4PxphQz1ub1b62PQhzPRt
	 npqIzte3Mnd+ReURI1clrOhfnEV4WmzUBBdqdYCdMmKbCLg+C+morQCL0I4rhqVyLAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pc4zaTBx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D28606A326;
	Wed, 25 Nov 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pc4zaTBx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795601888;
	b=uVWGEx+0d2t9rfiaIRotinj48jis5ZeExBDVGtJwZt3tCyO8UAtJgGE7dg0hUMiS+/oJ
	 OK39HwRmPCEZVE3xUD08ybaTJkfe9B1i5oRhD2ngt5z3sCwahWEXGKl0vOPm1bjDkG8Qe
	 PYxBphlkkl8Fng6eaLdfLznK0h5NsdaUsO5+VZtqX+1c5/VMKBefIS9dX0PqqVf9FpaJ3
	 ZUgXk+XwafjFnK4tIxCi/RYZvJh1vJMwryjiLGlJFGnppLS4rDoz15SXU/w252SmWOk8S
	 llKKr43Ee29fz/6jYAdNVScpjYY/qzyz7oje5CBkMKnZmOei9W4ztatT/j8PJ9B7WKw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795601888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CriRUap8AmJOUJMxrXkt9qWW59g/yopAD2nnYbYSa7A=;
	b=RQ2N3PReg1wajgv4m6teoCzTEX9M3/J5BsHMy/koK/Q1rLVOy7rdmn03CJ/guqrjTPxM
	 kEtO6OZcPaM59v6bSTuxpryFruiZ6FwCGrvtAsdgS7viSp6LQ93QdtiwVPR5MvwMm1KDu
	 VBYO4FQ7OcJGn2NDNabjAge17RzBG5A5vwnd/05KRz/JSH9sMEGsHjrY4TBat3hoB+2bf
	 MimU3VfDk/0lga40pYE3kXcPScc7uDlyTrfMUu9Y4LfD95BtD+yH88Ee8PlTl6ptoaxJj
	 nH/2pBc9PUAY37sMiY34BPCtUa40BMd5apSTR9fipmJwJIgRui3Z36daYrB93XcX5Gg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 106B41F000D3;
	Wed, 25 Nov 2026 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601888;
	bh=CriRUap8AmJOUJMxrXkt9qWW59g/yopAD2nnYbYSa7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Pc4zaTBxRYj2i0f/oc4u/yoqU8pUgNedhHenwXmyJRX+J7DgLs/NjyE5WtwcTA0BB
	 A2URHxs5lCf8m3Akek0QfdF9uC/2uwMcY/ksa3nhlYusua/xnGKEVjf5htjJw6tArI
	 UpnW2ePVjnb+G23LEhwVBsEJgZMassaYPl9yxlwZ6yatxCRPJ7WAi2VyXo86QxwHhe
	 bTIxDrs+hpoITePJqE4GYazLlXsNTPxa37ktToj3vM0ik85tcGPmk3hPy7x5kF5R8P
	 zfDL7XQ8avPqTYq7XOCeH6xQJE2z51XmmTAfHwkccD2p0jRShbdl4OmZ6pRuMgfIBY
	 qk7qQJ5+tA07Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 960104CE3B;
	Wed, 25 Nov 2026 10:17:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 25 Nov 2026 11:17:42 +0100
Subject: [PATCH 2/4] dt-bindings: PCI: qcom,pcie-x1e80100: Add
 qcom,pcie-recalibration-thermal-zones
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-glymur-thermal-fix-v1-2-b93a9feae156@oss.qualcomm.com>
References: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
In-Reply-To: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=aidfoMBoiQFj9PzexN43ZSatE2G0PFF5W2U8Fq+yNOs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBrXNmeIZ+xo9d+6cYA3A3WnzI93dWegmdWvDl
 v2SLtNsk8iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawa1zQAKCRBVnxHm/pHO
 9SOtB/4hE4AsbhtT5MCVl/8n4v+pw50876z4vtxVRxyPWqMWh1b5LvHYQnYW0H9eq+3+iE4XKZy
 QmWq2Qwi9Tx6/KkzQovRPhDEsjG201TTzCj/TFYw2LtYXWxpzwwrwomQdgzkVeMbxWFitDQ38+Q
 8aDib88CyVoLJWsAyQBej4MfyUSQW2EuzAkji+MECYd14s3C0FNz5or24aqFegXob8txy7AKhoO
 krDPtRD6txfWJJFxT5uyYsSBxCTO4jXX3PrkecShDVsPGYzUUC4Ob05mxnp+ba9saBcN2ivXhDG
 tHDVXOJMbn8pXDcNJxPeOouDXFrGIeTaDdJkt1mq9GMQ0qz3
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
Content-Transfer-Encoding: 7bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Some PCIe PHY instances on SoCs like Glymur benefit from periodic
recalibration to compensate for temperature-related drift and maintain
stable link operation. Otherwise there is a potential for a link drop. The
recalibration is performed by the hardware during a PCIe link speed
switch, which the driver initiates once the temperature change on a
polled sensor exceeds the defined threshold. For this purpose, the driver
needs to know which sensors track the PHY temperature and the drift
temperature.

So introduce a new property 'qcom,pcie-recalibration-thermal-zones' to
specify the tuples of thermal zone phandle and the drift temperature in
millidegree Celsius to be monitored by the driver, and allow it only for
Glymur, which is the only SoC needing it so far.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/pci/qcom,pcie-x1e80100.yaml           | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 3d3b9f309a73..389a6bbacaa9 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -78,6 +78,26 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+  qcom,pcie-recalibration-thermal-zones:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 16
+    items:
+      items:
+        - description:
+            Phandle to a thermal zone corresponding to the sensor used to
+            monitor the PHY temperature drift.
+        - description:
+            Temperature drift this zone is allowed to accumulate before the
+            PHY needs a fresh calibration, in millidegree Celsius.
+          minimum: 1000
+          maximum: 100000
+    description:
+      Thermal zones whose sensors track the PCIe PHY temperature, along with
+      the temperature drift each zone is allowed to accumulate before the PHY
+      needs a fresh calibration. Applies to PCIe instances that rely on
+      periodic PHY recalibration to maintain stable link operation.
+
 required:
   - power-domains
   - resets
@@ -85,6 +105,17 @@ required:
 
 allOf:
   - $ref: qcom,pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,glymur-pcie
+    then:
+      properties:
+        qcom,pcie-recalibration-thermal-zones: true
+    else:
+      properties:
+        qcom,pcie-recalibration-thermal-zones: false
 
 unevaluatedProperties: false
 

-- 
2.43.0


