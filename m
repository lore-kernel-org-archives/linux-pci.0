Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267122;
	b=3yg/cv9c43pz7C40L4Lw3Rbgy+6LgEBR+LlGSrQbmaCAZXNz0AGJAnJxr7sfLvdG65q6
	 lGgtQqTdFUTa/jpwZhDN9SQ6VP4qZW79+y2iZxOCl9D7sXVKSywf0PkKMujaEpdfqq0Xv
	 K6ujHuah1qwGABOGzxABuEMxL3K8oVfAC3W5Hq4EbareuhpGUX15zcXTezbMVEparbzOh
	 yPYiTXhYikkfrmBoF1pykG36GL5XvwnoeNjKceeRe2F6HV1pFjzifkWnS0xLJw7Pytx6q
	 SQWLmIrMfpI83VnsDYeYk7vz8RpqwG69M86rkRyu2YkF14p5Bg5Z/l95+s1l2gjCBQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267122;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=ngdVk19IWkwlW/Xsxleb20R0fUdw6REuM7F5mAZ4T9U=;
	b=Ys77iwiW7/cDIIH+yoUW7/x7UOjmoJF9VN7gwk4AkCPuBlMOPrSksDlwt59XkGaZHtSa
	 zRQSQwH+fYaHYK6/VeYjvq/CH2hYuNWV6p7XMsNBLSiK6I00I17VxPQMdjG/98F0AJ2yB
	 3OtZtK2GwcME6+CMeXQLKF7ALq2++n+njqkLqWH/UKxY6Rt1KpGcuUIGQM5ZbM/jhI+sn
	 3yG0ZqumkVMnkZDvse/iOgIaMEL3UJxpynJC2a9tWe/mIy5ow+axruf9i4G+IYlHEFpMO
	 uV0j/rQE/UQbXCyU0wI+mkCyKGO88OpbmPvupu3FjQsJqMZmIBYkBKmN/DXd26CAHbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74739606A31C;
	Thu, 29 Oct 2026 09:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74739606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1793267086tbaccd795
X-QQ-Originating-IP: EzBRUw09562Hw7xzSIwX67EesubeAfqs9OrY/6NZ7y8=
Received: from [192.168.30.244] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 17:44:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13163984408901113754
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 29 Oct 2026 17:44:29 +0800
Subject: [PATCH v3 2/4] dt-bindings: arm: qcom: document Radxa Dragon Q8B
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-q8b-dts-v3-2-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
In-Reply-To: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=sophon@radxa.com;
 h=from:subject:message-id; bh=KHvssF0xBmxgfBrsMVKXU7Qx0Wh+vcWm5edVG9ChHrI=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPRRvZGT8/tDNgmvCucuWOxU9P3ns9d/0ltUu+G2InJ
 FZVnA9W6ShlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjARZxlGhk2FEkWvvi25tvty
 xPETdi2pm339bM7+krPc3DJJcskxW06G32zKM8ozrxbM80pnn/Nz7vXPRtXBnz6yar7+IC25ft8
 eNR4A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvGGTAUhB2iWRMMuathoo0YoVBwmcgiVS86ohs5zMGJ3/NamnJQzlcZB
	xML/j6rrsqJM+FX0eIvbYYbnkJlBVo3Len+YTlu9C0DxrwOiGI4JudwaDS52W5lggX0ngRQ
	A/HTTCbWfc0THOAs20ExFcjveCQnTe5i7W9MNhKybs9exMQWP0m6fe2f9xoR5AWeEppypHZ
	ixpk3o4nYoCxnQ+43U5qk7J+0dGgl+e4cWql4aUPHBGiFegTqH4wOtIdrSrov0e0emv0aLy
	hIqKeDc6c4uy6ekcQ2c2WaKaPcwiSdnPdKUShI6p47+a78ZhUGKsz6NnS9y/i9SytYKDlJw
	4v06lfFZqFvGULjZreoCpIHHBYd1VKP8jsTU7TF1DxMxTP+wP5nqzakUrQXEyIzpiWk5SUz
	AuXlH1hHYyD1M8V0tLYgRlawx86ZLOOXluEObXs93xligdsZLEoM95aOyPtV4uQtQMO9zYG
	Q3W6A5Gwsef2AlpbtOdhFeRDs3ZjILxdDvbRIlUa8lCbjIDasQnhN9b3LBurs5dK/I+3LQ4
	DWEb/Eblj5XIO6Yc4skZ45OuF3wGEFAGsbhcNn8W6Nz95yP31rAekmROXHRUciYjF691k3C
	ZzgRWNdoi9z+c/3x+39DKCRAPVpEaIs5CMdzkMa+F4ysvH8ibrIxfU8MOyNUmQW71RuUJTH
	ylFt4shXSBe1bUPSEYcw0YYe/r9Q28UXUvffS/AxT1y20NrpNMVvmEKdOLCC5JIk7wx6tfC
	bDMSOthTOm5FmfjWGjq/uNx+41vJtko1osGslAO+U0/oxmBOEaymV1ZA0wRjsNUxiJOxtjj
	a/DxT4eo88qAVek7HI/3UNiWKR/WkXsuMVk4mD8BnGFk5qsIG1Tuu9SsvS+Dm1sGeJMUlLx
	rZ+BeN+H6WkKJGq0wNWTDJ8mpTwYQfW6DnMIyHjDi8FfuoEyCwXRFmRuSACX1I0WtStEJ6A
	4hkYSJsQOuA60lGEuSSTNUjjrkNsC6/ylW2OpBiqG92JFmNWYbI5E2xMgi62ftaidGRmJTV
	t0KX2s1XXHcw+Kra/2FWDt5ft5IfjcxdScbf0UTCvG2R/mhcKp0uG+3K2A07uVbPUH3S8KW
	qImiMY5TY0x
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
SC8280XP platform.

Document its radxa,dragon-q8b compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..f28645b0088e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -937,6 +937,7 @@ properties:
               - microsoft,blackrock
               - qcom,sc8280xp-crd
               - qcom,sc8280xp-qrd
+              - radxa,dragon-q8b
           - const: qcom,sc8280xp
 
       - items:

-- 
2.56.0

