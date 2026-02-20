Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E92C11C6
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599892; cv=none; b=FatrsxJws5BmGKFKTndA5Av6vOhF+6VelQNqWcrT0j5H56rkbYpkaGzq1Rpbqq3N5qztZQs1PGxOLuMTR7yARegCqcc3uXBBGpC+JlA1OFFmWcaFtCeKbL0qjEdJnw/HFMg31ffCBVZbeURUlRK2W70ZLTsjIouw4Edl4TrN9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599892; c=relaxed/simple;
	bh=K52g4ga2yw79eCXHygCVrwkICvYG5U0dxgjsIk3GGww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX0bnc2faRa4xSssY511T7kwtZiIa/C3jfCafPYW4LyuY8b5sERT3O0iSkzEvuZUVAG6bhSdmSIEzPl+/q0Byvi7QZ3Ij09GGC2vRLd+T4CuUwnw1tb5TYmH8QlRFHQ18fMERKhuXTaJQ8EE/iq82y9BSjx0UJaNjqpTM2wDWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKNtzbA0; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKNtzbA0"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48371bb515eso28403105e9.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771599889; x=1772204689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf39OMypbd2OZzaTG40QQZ37dkFwAr6bUYbA8Mqeigo=;
        b=fKNtzbA0NcF6q59KbCuX/iTPwwWX21qCw9PfbnieqEvXIX8a9yKHlTgbehouF1gcls
         nQywU0lmQHGQgiGZOUre+mThABbDQKsJm7xr9NOzJE98QsrRO1wo2fvvlPNKhsZpX+re
         vNkwK2LBw+Cvz7F1o+agAgUd9AIjan40Ux9RbJSmp43uoG8+R9eU7jOhb9E/f2wEGp8Y
         uYqJugMFfsXjOOaI2R2Pf6TrS7rgyXbW3rfnaHaQakEDJ+At6MngNpNNt2O7dvjr+6Eo
         e6+ohB9PggrTOtKEwnLM0P/mdpxNsuBdNEyW7oj2IW9x2hdHRV9HkT5dL54py/fR3j0w
         n+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599889; x=1772204689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lf39OMypbd2OZzaTG40QQZ37dkFwAr6bUYbA8Mqeigo=;
        b=PxFDbJGyOOiimrGKsTvMEZ3eVG4fctzKQDLk7aUrckrya+26vYyAzhG32Pw7OZCMBT
         idL0XG0sx84yJkqIQUC2o2XTvXgzSOryOaorOKL2gVaLTSFZfPi1C9gEstf98zlXDAPQ
         O7KIsk1WIXO56rFICOxWXDe5Yto1YsK5zD6j02BuyZM8WrsqjIC5XzUZ7pqx45PEe0AZ
         x8hQk0Ix9Qv1FXKpK0cdT47HsV9uG7OoQJFou3FXItBnUt96U3XXsngR0JZGHiXmUzsZ
         dVYVqS7ayeQlBv51arxS6ynD2XJmRgxwWOsVj5SQrHzxkyszYIFQmcECQPNfq3KXz8uT
         3abg==
X-Forwarded-Encrypted: i=1; AJvYcCVigNfEp4nPuS632wQpx5B+GaWuTV5a8ZxrAZTzD7c3oQjD0BBOoJhbWqcH8U5gg4pni9fPp3s5A3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Uvza15SGRQ/AhA262bKAZ7aawf7PRKKHJZQPHP2XifB9x555
	Lbg2DBLkalbqbxjmnnLIHw48p/PbHv/a9IcHhLrAqzjugiRCAZjVDv9kyD8SamKtfp4=
X-Gm-Gg: AZuq6aLF6025s+Fs4zYMlARVO5CEtWsxt4jcq33Js87nykOyVlh/oAcuMsOnErugJ5h
	VaByXfytYsyz+0VsKAwmv2cjQfwpDx1Lf69MG1NtjjrMVujiDTg1z7d6gARuKRCmCbcZJcR98tY
	rUEmrPXjvSu0awp1HNBYLQlU5PMn1CLARbUIldvQ6/80tV5kPPX/i7F6Sq2YnBwasdNqS5e2Nv4
	zuu68qjy3yqNDCGRX90koIAXTmGk98/TZ4sDYegIuzlXOHduJRWekoq1xscTTExyd95r6aMT31S
	cdrsb6YH4u03KNijH2L1WEac+UElvvBXBSRVQVIkNiqLy6VWaH14stNqFCG2A31pmxM8kCAoZnL
	cpsdHrjzeYMBFFUiurggaqNp8sNHIcPObEUoKglM2xBO3TmpjDfVUM+abg9mKTfZmopRJK2rJpW
	QntRps1fs9DnKjfO0pGpVVTmns1qKcDqQZrDFLIDapHhnc
X-Received: by 2002:a05:600c:a185:b0:47e:e91d:73c0 with SMTP id 5b1f17b1804b1-48398b5df09mr110133625e9.19.1771599889067;
        Fri, 20 Feb 2026 07:04:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm122064505e9.8.2026.02.20.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:04:48 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Feb 2026 16:04:40 +0100
Subject: [PATCH v5 1/9] dt-bindings: usb: document the Renesas
 UPD720201/UPD720202 USB 3.0 xHCI Host Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-1-1ad79caa1efa@linaro.org>
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=K52g4ga2yw79eCXHygCVrwkICvYG5U0dxgjsIk3GGww=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpmHgLmSW9NqfuE6jmkHegXhTb3a1Pi1ttmNy1DKLv
 Wt6MpFWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZh4CwAKCRB33NvayMhJ0U6cEA
 CnH/2XKFjofrcPLFjJ0buZN6eF/4quV9RFzcaWz2F2NzCh2nZ3yz5sCNRpEZwZIt+OtP/pi9pbsqgs
 kaFdWCAGSPOjfvDh/QcWkStCBfK2C/oiZmSoUDczD0UIbFKHjcLxVcoqgKEAyhobMQM1hb/WSyoves
 jzVYx8TX0SdlSor6kJ4HZvRYEiPnsxpYFneV8KOCS1S6yVvw1q4+yccIQ7DlGYI0y3hJhxFcLHGHvQ
 l6VoDoXxSfP/w5T43kgc1n5tG3kbmbO4Tm3K4NI5IfumGDd3Jv6hNl7z2y4+cnAaQ3txW28TpNM1Z0
 USRZFsRIFXoeO0Mqf49tsWse0HO3M4nRkVj7HhfHygcmKZ8UQfkvGqzTsw3UTT7qU65M/tvZ4hO5G/
 gAphNUmWIiVlfC6u6bc3vZ6Hf92lO6PDSvrkB5W2XQ2tDYeg+3WQT32Bulq7LO2I/G21yucI1ISL5D
 gp9VYIJZYmb5Nbhe6Y5mmYsHDY9ztLMS0R4DoaU8fIo6eNYAoXGkoQBxrCT0Bxph+NGOOdgMqMBoBj
 NsJ3Iczpg3mJH+wVwBlBfTCku9aaDLsz88oX/+tFnKxOwOahWJRzxjxkyftjLQY7MzR7KZbQ2CL0Rr
 sKRzdFW7Hsv901ay78qMqPS8DfqbJs9nZauylfJM1Q4TGu/B3XlnHaoj38AA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller,
which connects over PCIe and requires specific power supplies to
start up.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/usb/renesas,upd720201-pci.yaml        | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,upd720201-pci.yaml b/Documentation/devicetree/bindings/usb/renesas,upd720201-pci.yaml
new file mode 100644
index 000000000000..8b8be572c930
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,upd720201-pci.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/renesas,upd720201-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UPD720201/UPD720202 USB 3.0 xHCI Host Controller (PCIe)
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  UPD720201 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
+  The UPD720202 supports up to two downstream ports, while UPD720201
+  supports up to four downstream USB 3.0 rev1.0 ports.
+
+properties:
+  compatible:
+    const: pci1912,0014
+
+  reg:
+    maxItems: 1
+
+  avdd33-supply:
+    description: +3.3 V power supply for analog circuit
+
+  vdd10-supply:
+    description: +1.05 V power supply
+
+  vdd33-supply:
+    description: +3.3 V power supply
+
+required:
+  - compatible
+  - reg
+  - avdd33-supply
+  - vdd10-supply
+  - vdd33-supply
+
+allOf:
+  - $ref: usb-xhci.yaml
+
+additionalProperties: true
+
+examples:
+  - |
+    pcie@0 {
+        reg = <0x0 0x1000>;
+        ranges = <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+
+        usb-controller@0 {
+            compatible = "pci1912,0014";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            avdd33-supply = <&avdd33_reg>;
+            vdd10-supply = <&vdd10_reg>;
+            vdd33-supply = <&vdd33_reg>;
+        };
+    };

-- 
2.34.1

