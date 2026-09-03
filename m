Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8E3FA5FA
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422028; cv=none; b=GxALb66nnTrmxZEbWrmoLyVRMY7kxbWRB0npe/N4azHfNzgx/ZNVCefyguGlzCpV0ka3O0zUALqSHjJJUI6rValTb2YHnwFuvtZbffvhzJL9c5t3IGp0iHEpAaRpdkcpN9thluAxKfok49Q1rMKz5a6KKiVHTyzXSxhrFHRpG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422028; c=relaxed/simple;
	bh=uC4tlxNT0031iIQM4TBQvwl6KchLCfjKxw65OYMFJmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgorUTL7os6tIsrK/HMjaAZmxgIyV6svMfGMik/kFSXQCWi4ZsGxVLlyhH6rcKBIMkRF6Wl5W2cFUiZHxqGxgj0tMX85anXhG9YfkF/AjLuMOCz5eXQQJTPbq0Wbshh6ZzhJ9s2xinDZZSMdG+VrBZ1LiQQtk2t5F54tQHXmHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qlbmce1w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IE3Ow9Ve; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qlbmce1w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IE3Ow9Ve"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lmQO3176984
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 07:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PC978y0C+WT0DKBK3S73qJbvQPZtoMfFE4MNL321JA8=; b=Qlbmce1wtdvNKVSP
	IcgfhhATCl1DP93hH9tHXr+RCBZzFK5A64SgP1qOKJpND5SUBi951NP45nWvfkP/
	6zTt0iSHk6zmH8xNqV72WQ2yrINpUXscJVJq+yFU5EXxh1L/K4g11EcKjAqxrsm5
	2XwqwHA7ioijLjmo8hXxYQvLHT7w4YUlwkOii/d2VMtL7HDIaCXA/Cjh9UhovHTg
	cE9uLNlkAsPWchTv7EBgWfvC0xWO0upfqCPbDj4LObgA9dahYwb13mGqJvll+6rZ
	Wri68jmzYFDVS5BecDaGjgVSchfFCVPZ4l4pE9H3hfnpkewJ4HL5O4y7zrAxSb8j
	XtCSnw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4v5gh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:53:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so391513985a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788422024; x=1789026824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PC978y0C+WT0DKBK3S73qJbvQPZtoMfFE4MNL321JA8=;
        b=IE3Ow9VelucbI28EXuSrH213VAuvSeHSuq3xlYtTuHBZyOLmKxnqNQ3JB6ZvW5xqpE
         vsHgV5h85tP/PtK9zpNlNpATKGiOLK6kQUYb/rRKBqcYNi6nVkawZ3HsBuWBCELzmLMK
         7BXdxXNBPOlr95qo39AVlcT9pVvocqD9MCNBsgqLQS7OxbO1PXeR412A3/Hokr1ysN2A
         HO8IjXqbOVeb5uPVvfOadfQEhpVAiOwumrHzK/ccUmwKIEJK03he0J+uwKngHBjLF3Z0
         I05yyuEfqcliOhFqJS906CYCrb4SmG7f/5T1sXsOE0EV3mCBd4ZVvmXcYcCviPv6Zs5N
         q1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422024; x=1789026824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PC978y0C+WT0DKBK3S73qJbvQPZtoMfFE4MNL321JA8=;
        b=iukJ1oSeGbgI7DgsH5+iY4FSyE4FgMz8AXe7/ahxdjV1u3ECqN65a2kF8Y56bAqV/B
         1UxZx+a9uRGK6U5Cn3v/XChOGsTSTdAu+u8SbnheNmIeLKeRKWD2G+9s28vgTGCZ4kYX
         zJFVWcqPSh3Z+DayZMmnwYJ8akhuJ3YVgntRmoaUdWIZHb+MnQttyvueVUQr17Wn2knX
         67ETS4UaSVDBzXPRNleMD2ypY+QaNBc+4ggxhfHnzHO/jIJ4pd/8Albq0dNKBV5i+Ilv
         nOLr3zg7qC3KeQwlAQpc/Qh7U2xuo6mesg8dg39/Mroj3n7EbIKGOBL9k0cklIBaJAEZ
         sgXA==
X-Forwarded-Encrypted: i=1; AKwUvBxyjqzg05ju2QDuhZgPfTAgC2hKIITS5Z3/fnGtBzT2a0vlJnsxika27RRFwotacpLe5NJ9nubQSKo=@vger.kernel.org
X-Gm-Message-State: AFuF++nOz49v8dYCBelzEd5YLsFJrT6EAiRsjFAZCaExJbVJVT+ygtqK
	Pvua6aVsYD/lK2G98oumz9EKqEfvWWE5j2AMO6QTqug9kGt337jaJPL+A7hveG81MeaFqgcKtnj
	W7GmXdrjR6z69tCTIlhKipVYah6ejVXvBPkJGhxF3mOqNw2RP41Ta46XQ3/u51SQ=
X-Gm-Gg: AYBFou2PKww39BUFNassXzAB7O9CrciEcSbCOIuumR/4wPi2QF2YQIIwHXPZfVNefuX
	NYo8OuICL8+KxdrpgjDBcFiXx+5Ak5B20EQYwiiRv+UDy8vkRUvkLgQNaCxhKHETq7BS9t8IdlE
	S6DE7Ts13IGbZJwDcdDonjE9CW+KURPMpd3CzlKSOt9N/g2BuzwBQVEe07Pfbndxy4pt0TFoygN
	AI4dgYi+3SGWUv1RAviiLfhzZmr2DwYXFKmylG+iZNhKHtyu/4DS2q8wy10G75bxUBSw8jb4m8l
	5BbgawFMpeWinLaMuPUT/oHauUzoKn9yaop61UT1w94qHb8Ojj/OBoFGmI7wYqiaHhomTVbAKwQ
	i5kWYfMpM9Mitvg==
X-Received: by 2002:a05:620a:3714:b0:937:19d3:3fda with SMTP id af79cd13be357-93960f2cb1amr1190981785a.28.1788422023647;
        Thu, 03 Sep 2026 00:53:43 -0700 (PDT)
X-Received: by 2002:a05:620a:3714:b0:937:19d3:3fda with SMTP id af79cd13be357-93960f2cb1amr1190963685a.28.1788422018352;
        Thu, 03 Sep 2026 00:53:38 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72c28sm12878376f8f.6.2026.09.03.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:53:37 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 09:52:57 +0200
Subject: [PATCH v2 1/5] dt-bindings: PCI: toshiba,tc9563: document embedded
 GPIO controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-pci-tc9563-aux-v2-1-34c625b542c1@oss.qualcomm.com>
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
In-Reply-To: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX3hKgZrwjwy+x
 jcf1P9hF6fHGTyt070/0zeaYDRvvsRWMZ+uVMSXuC4rxdbSl7XOr9LaqAqi1GRvBRXjvaSa5FZn
 wDxLoGxM+iFksGca5caKIs4wpA0n/FuIqk/DxW3aRyjvfe5gbqN1lax7KhnjWI8V8vjVPxm+CKr
 bsSd0Kl8k6xi8FVWMJFmzxI/AFkFLjY+8v91FaZkFbyE4rUZiFwBQN/lwoEmBt+7lINB8N7tP+M
 OhidPJRCy8l/6i8KSHEJ8Cne9YN77gvlOkyWATrwxphszb3j6QbzHDBK81JKcMjIbwLgEFxIqGJ
 eGTAW6YJyMuZVOVmEDfQ1afswyj19c8hd++GeHGTfAhwnhdTTqNLp64rCo6NuW0RiwEDPEkfhky
 AED+bGpL6KH0zpUGzT8UsY0ra3KENIUyiic7AatDHh/CTx6LZUwvYKYhtjai5zOp2E9PHozYCaC
 7hIzXKOAO4SUH6rbNcw==
X-Proofpoint-ORIG-GUID: 8raiCQVqtB8VCHw0MaXYrNhcMkNeemyL
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a992788 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=LEtEptG61Eb6tGkL2-YA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 8raiCQVqtB8VCHw0MaXYrNhcMkNeemyL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX8aZSdo7Z0CJC
 HpjrYf4+gSTrXi2zr7nUpqj08dEqv5t+eLaUOq2eNAhi6eOQyj4Naub62OOeePo1C7w3m7beV5m
 S2VC4B210HemOSejPIsbmp/fZcg5bEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030069

The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
lines. The controller is not bound by a device tree compatible string
but is registered as an auxiliary device by the TC9563 power controller
and accessed through the same register map, so the GPIO node has no
compatible of its own.

Describe the embedded GPIO controller as a "gpio" child node of the
switch, document the per-port reset-gpios property, and update the
example to reference the controller from the downstream port reset
lines.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
index f084830c6d0c..47cd58c14e4a 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
@@ -54,6 +54,23 @@ properties:
           - description: I2C slave address
 
 patternProperties:
+  "^gpio(@[0-9a-f]+)?$":
+    description:
+      child node describing the embedded GPIO controller available in TC9563
+      PCIe switch. The controller is registered as an auxiliary device by the
+      TC9563 power controller and accessed through the i2c device.
+    type: object
+    additionalProperties: false
+    properties:
+      gpio-controller: true
+
+      "#gpio-cells":
+        const: 2
+
+    required:
+      - gpio-controller
+      - "#gpio-cells"
+
   "^pcie@[1-2],0$":
     description:
       child nodes describing the internal downstream ports of
@@ -62,6 +79,11 @@ patternProperties:
     allOf:
       - $ref: "#/$defs/tc9563-node"
       - $ref: /schemas/pci/pci-pci-bridge.yaml#
+    properties:
+      reset-gpios:
+        maxItems: 1
+        description:
+          GPIO controlling the PERST# reset of the downstream port.
     unevaluatedProperties: false
 
   "^pcie@[3],0$":
@@ -149,6 +171,11 @@ examples:
 
                 resx-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
 
+                tc9563_gpio: gpio {
+                    gpio-controller;
+                    #gpio-cells = <2>;
+                };
+
                 pcie@1,0 {
                     compatible = "pciclass,0604";
                     reg = <0x20800 0x0 0x0 0x0 0x0>;
@@ -158,6 +185,8 @@ examples:
                     ranges;
                     bus-range = <0x03 0xff>;
 
+                    reset-gpios = <&tc9563_gpio 2 GPIO_ACTIVE_LOW>;
+
                     toshiba,no-dfe-support;
                 };
 
@@ -170,6 +199,8 @@ examples:
                     ranges;
                     bus-range = <0x04 0xff>;
 
+                    reset-gpios = <&tc9563_gpio 3 GPIO_ACTIVE_LOW>;
+
                     toshiba,tx-amplitude-microvolt = <10>;
                 };
 

-- 
2.55.0

