Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB238E8B2;
	Fri,  9 Oct 2026 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532618; cv=none; b=ByxMlyPiWnPkSea6jdhxpaEmZs+mXPkq7uFrOvLC/qc2DEbqqhuFHNcFEFPuUf6AFXSkL3A81Sp+KBE/Yq9DFWROCQayYsZ1jitqZo59bOFFp4NPNICaiPGg/2tn+nhwbkQnUYn4kUJOB2bAcqwCSFZpaWLUnJbVOsnE+cmJ+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532618; c=relaxed/simple;
	bh=G4sBlfB4NGRMNHWX1zneeBBLLlnhh7y7L1BErGKdRik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3xibtBjKzAeLGKw65cC547MffLGsZOqrAbNbiPSHuno6Zg0Gpn/caMJ2GKasFEQ8RfxXRZWcAh3cwACx2lIpNLeGf0cD11AcrzTR1ui4B2Q89H+LHT7VNoS959f47XvyNTHjA9fME1KBl3qP5Uo7B76TZJsecDjTaF3B1zqz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1791532526tc2f97ed7
X-QQ-Originating-IP: VBjnUdPH8eC5s6bbmCJPoWdYx3vLC3pyuYwl0fR409I=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Oct 2026 15:55:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10937849882715644539
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:55:06 +0800
Subject: [PATCH v2 1/4] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-q8b-dts-v2-1-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
In-Reply-To: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=sophon@radxa.com;
 h=from:subject:message-id; bh=G4sBlfB4NGRMNHWX1zneeBBLLlnhh7y7L1BErGKdRik=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j6dLvxD9rDtZd8tLCU/7edO92tbXbWPRY6Rk33Rn
 4KfbRr7O0pZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAExEIIrhf3Uyl5x+xe4V9m9n
 cvFybXfI4WFw2CJ+5NuE89LSx+S/P2Zk6A05+Nlu+u4MXVkN/n9eb9QCWmXX3nFPuyS1O0T5yv7
 PHAA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MLoh6s52BbrmPt0WmODRqqL2YGDC9PJEjtqxlkgrB7DpyEMa07vWcHU/
	hOr796k+sYeQHpXGM+gTZMUxuFRUe6o/0joiSzLw9xD/Q8jPP3iboJNc2Ww0qChNw08/Qqk
	HUW//LL1eQyk9PwOwgXQKc1/m3OrAynY4gucIPqemBrPcZhXwWbF0ayTdOigGcxENy2LJ2j
	QQP5+L1NHHNTHG4wxh9+I9qVHOa0UHoD33ThttAktG/LB/1OFV7F/123kcuVwlZglArF4uq
	wovuP2DRb8IDMovQZOIjYAIu7JCfDQ2ShtkpT+++3NIEa7EEXdyOcwgn9Bh7MH7CgBKxaOE
	qdr1lQnAzRIy5cC3/99s8gpK09KNkSfz0Hw3p0d4DGpA6chvitdO8bytG/cqKRQ/CVsudvG
	5K30e5evU+emT31z7R4++0GxIJAimcBzZi+NPY8Gv+ccDe80KB03VcVKZ1hHQqtNW0/+fwZ
	/0YzotquS0YFlvNAbmuFfzDjVHOciKZzg11/ayah2yMufJnWf5GZLpJITDxiN8V7caQsxaq
	nN1BVC6MaMyZMP0kFw4F0vtz7tFXPxQfhvi81cR3IsD6HrBBh8NeeLd7C2t1sqoQMyyISEp
	QsAQmV4eHYGgFIlqkK2GG4EqWoUDOOjh2qHYdZaPv+0Ozmq2wGqqjPcLFZM3IlRhvXI/Att
	LUkCYbFI1YV3JfuQRkzBRyQeU7i60ln7MYsGzDuH5jnBXS8wFmrzrazOiJ76nde3A7PaCsl
	/767ZX0TD+vMtyOR22sAer5NdEgkTD1ebPZL0oXKoBw5gxsvZszjY8pX1aCdlxnLstTNk3W
	JjP1LnvpNxtqD085AwCrEbNvlkiWIR8jvbdL3u1PEHK8Qc4ArQxCwH1xtU83VjZwt7lvP1T
	AKshuGOmNbE/1wz3Llpv+78AcnYCP3STyrJWMDxfqTFpBWd9J0dRIoDZdb2a8BAZqhIUHII
	STFGY97dFgWAqiM7gEfvowRfkdk3/LNcsO4zzVZbeH5kDTHl4dZeJJTD6x7ZFzA+u3qHeGi
	cMiHcjM8eOKkNsRbWY39VDwgdtw5+Sy2FNqSxMEI7WdCleHTjHJWOfeGDEPjTnMIRgUkXbw
	qTDkRRCvn7j9z86R8grETmmW5uSGVruKFQrv6Y1UTff
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.

The device contains an embedded microcontroller and on-chip flash. It
automatically boots its firmware and requires no host-side configuration
for the on-board use case, so it can be represented by the simple bridge
binding.

Document the chrontel,ch7218a compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Daniele Briguglio <hello@superkali.me>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 7636c24906ba..9e0e7e09774e 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -29,6 +29,7 @@ properties:
           - adi,adv7123
           - algoltek,ag6311
           - asl-tek,cs5263
+          - chrontel,ch7218a
           - dumb-vga-dac
           - mstar,tsumu88adt3-lf-1
           - parade,ps185hdm

-- 
2.56.0

