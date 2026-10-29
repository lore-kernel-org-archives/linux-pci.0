Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268882;
	b=qQ/7MFUHP6+xAn5J2n/A1H0ntfPYnIn0GCi4xviXBaRgKhtcy0KRV7D3lxcZuAIbl/Tv
	 rCMVgwT5IcQ+qOCdSbBrS6Gboi79pUUOUUA6dYJjavzQYnKfL/nG46IfmoEnbTSJgE1wo
	 P6CZzOCq+CxI3fvbafZ6uDeA3yMrhKDMiWyDV1tyMM4C4Abkafo9NdfmuOdlwMUGtaVt9
	 sDtfubt8DfJnJ7hhpxSMVqBYxJzQVvkqxMa6KmAT8NcEkVNSwjuN9UYxIR59+C83PwzHx
	 6f6x4LGA9rnWHlAhBoWbDref1Bas2hge1Dk3xZdMpMm5L6uEweI7dZNZoME9dZSWmbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268882;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=ZTQjA8zljN1ZEB/RMOcOmcshPHsNIzGWEobToCZYhQU=;
	b=HRl10gTTXa/ZEGkOgxJlWYw9KpsukdEPkh+y7fYZOPUbwdJCTOF+aq0ZpoDXDb4UFnpR
	 ErhPzvCQd/bAIycZmecre5eyRJMeKwOIEUaT9GeKpjHJiCEpgqng08pKIblaG/fscf3p8
	 5zpRn4OjXdEPkjfDc0yrKvt62BPy7Vf5+GFXXKbArthCdkYMg8BWZAuQOF4BL9oa7mhNl
	 X8CXYdNT2JFyalaMMuS9q1txddL1KwOOpB68YaN20qfDj8oFZ3c2D4v7oxamehWPYFz1H
	 X8MwBbf1WGUemDgFhKbPydooBbrBkrw8FxHH/SVgVMr4b1OuRu0T8HgpkTxL9NJveSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3F606A31A;
	Thu, 29 Oct 2026 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1793268844tcabb610e
X-QQ-Originating-IP: sMMrFrowwf6ZzoovnqFE/cAgzaCLtmR+197kXHsgFbE=
Received: from [192.168.30.244] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 18:14:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12288290236240033629
EX-QQ-RecipientCnt: 31
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 29 Oct 2026 18:13:38 +0800
Subject: [PATCH v4 4/4] firmware: qcom: scm: Allow QSEECOM for Radxa Dragon
 Q8B
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
Message-Id: <20261029-q8b-dts-v4-4-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
In-Reply-To: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
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
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=sophon@radxa.com;
 h=from:subject:message-id; bh=ha+6AXBZg8vPgpy9CUy+X6vPtWkIMSbkDFJ7rZDLj7g=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPZcIF+TNUXRbej6+7dv2upr+XYqPri+crHjdPdv0Tv
 fNXnuvmjlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABP5v5Hhf82uiXcrO+dMPuC1
 rtS5cb1jZLHGkRnym8pqQ56/Szg0x5Thn+Yk/tj3/yL0pnOkCYtH54jW75xTWXhGpjbOlWFlhs5
 LTgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MV4bJPEodRzJHjFtEiJzheNZeVnpZocpvDF71bWg4qc5xWWHy0WAqCVG
	rLgJEkAtTJ3ngmrZxpd5ICdZm7U67ojUsSxLRiigrudORLVbxWGjMGDK8rfdOsOi4jSgTcF
	sFlLPFkoBL4TY/a2S8J0r6sMnTKyezo/74lyhhgAdnVPAmh+GsKjgCbFmk5Um4N/+PtkGsR
	eSl7WqtbUEtiX2pXptfrJjOV7mL/41Lv6flqdTUm/rZnAfrq5PtfPFpDAbG6i62SLyExeqX
	2QaQrN0yqTVArmN9gE2W+uSnOZvCm2qGx5/LX+lQgH/aai+DE7tL3ax9fxBspAkMnsrpPM0
	2qUSM3f55XVlZa7GWgW1KiHjwnUC5Z3T3Fbl0KWfSBlbws8gCLlzCbXt6M5In+C9wjqidE/
	4gAJAWi7V68U+vIsgQkoa6KQNfk2GtS8um7/LNrB49BGpjfRw+TqyJIFHUevyIo/Ymnd4WU
	BczHvaA3wbq4om60fmMeY1KTrg3KYWL4CRoHCfS1J4n682Srj778Sa+YhyRjFCgW4gVoa4y
	us81CE92LFUKazK/xx4YRm68aR0PGL9BFADEX3wPvq72I5QjpQtmcXhdWvqDAMV8FbVgCZW
	ViXqKUAQ3K0bCaNLRIPB5WV2GqCuOTTfQlnSZmcHCn5iCXMJvkHgj3fKKRcPw4+Y+49ox0F
	Oluh+mbl2EMJFKxb67OsTTvwc9e3DajoB5h7FJo30bXMrqVnifzW9wYCJ85rzPV0E8dfGgB
	IWNrK1/sN6jrvW5CF9/IC1OdRnGs4WX02N8BqoEM0VCeWEy8CQeqLOlwXt6hOe8JStLl1Se
	YAVp5brUAa8a3+RgRKXSTu7A2uIyEJPdf+rV1ZTjlrU46uDi8AvIlxr6L338YWmBuXGVRcp
	wkDxGfUlroaUdMETcpc18zSz0OvsHk5g4h8mXTBFwzLNe7RaEGWTpR/nVi4yha4UroPiYCG
	fyif+6H2y1cz+Kos4Sua5v3HDaEkCDqXspiKwcq/UO9GGlNT4abYjnK0O7gLgQc3dfr+CGs
	We/vBIEN/Qr+ukDWYWCCuVGstCI7LoMZaQZ4/45RPXwAejuNVSdow90sR2zKDrhpNNzpzQB
	wlVqhYj6uAGHk1tU5sFU5EyENCSddiQSCbCQilNpm+hFD+Xgz0iO/vHKRuUaHfKMkdqgVdf
	B4U83QcRpvIPR4w=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Add Radxa Dragon Q8B to the QSEECOM allowlist for enabling access to
efivars and uefi bootloader.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 43e250faea75..0cb6f8e3a5d3 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2266,6 +2266,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "qcom,x1e80100-crd" },
 	{ .compatible = "qcom,x1e80100-qcp" },
 	{ .compatible = "qcom,x1p42100-crd" },
+	{ .compatible = "radxa,dragon-q8b" },
 	{ }
 };
 

-- 
2.56.0

