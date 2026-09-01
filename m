Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349642AFAC;
	Tue,  1 Sep 2026 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252524; cv=none; b=fWeC0rGxmTLY5v+J/NSX2CsB0+iyDKkFXX+ZCYoJsVcIH8wurupNFIisAhBBV5fU0KAMIWjDNVEqp9gjRyM1BZDQd414V8hw4nn/gYruS26XFajUHUHTkNFBXW8q8u3jXzT3eWWfqGammc9C763btQw/mJyCShBK5tK3k7Fiim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252524; c=relaxed/simple;
	bh=P3ecEwYp+pJD3fXjF69gnodv/MTSj8RHD4NMUnKFiTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APZhnjeuW8PElJjFXR1eyS00ebHEFo3vHT9TYCtaAihM3niRdudHHFpJudOIlHTduViyd3RNnOfdJZGOUKpSUg7jQYNBSP/aGLvw+5caOO1+Vcvx4kwdUl9GYyvfdMkDF4jkxG5Vo5nilR/qaaPYdZ1EW3WNrh25bdwbSjjNg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1788252496tc46f9645
X-QQ-Originating-IP: jAnARFYDdwVi32JHsYFw7EMsDCDcE2uzlE6/Bqeumrw=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 16:48:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12420683238229624417
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:55 +0800
Subject: [PATCH 2/6] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
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
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=sophon@radxa.com;
 h=from:subject:message-id; bh=P3ecEwYp+pJD3fXjF69gnodv/MTSj8RHD4NMUnKFiTY=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjqrR7AfSJUq63m/46MtbyfjrqBA3RJ1i5436+P7X
 zzrCD7XUcrCIMbFICumyKIQzzCXvTL32lOxUj2YOaxMIEMYuDgFYCKmpxgZTk3XVrj9d8+Ohe1R
 f3lPdVcH9574uP6diM3a/ze//y84LMvwV/aDOFu6avDN2KbTmzV8L6bzmmucncLNxTn3Z5iR9VQ
 1BgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OVJbsmpLzkvU+Q5zV8GvobH99npAwRLgWGjh8KR84TVil4V/FItqOoOR
	ccBCfwdxwVsiBNyi5fONNdVrwWASv5F/LKEIJmLRXuDJ8/kuljvQfzaQ688OVpeOjWGpltG
	l7Yos5Kne1GEWBkXSvmMHz7/8YOgiCWlFJjBndYFAoW0Npb4nLJrOQNr2CNqdeFH7ILdNyn
	tJHcXIp9y7PsGpF8hads3sapzuY+i18+WQg9pUNOk0LpD5kCBwAjf8lNYJgkwz6GyRMm3tS
	rvGT/kYmyK11JWZuf82mXZvipqruxWlZjwWoOZAXTlDLdnZCY0GPccp5Dr4rA9Bb8A66Nf4
	hHfRo6OYBUM9gt0Gjc9mflJ//QosEnM+K7LxFKwWG7iADaTHFBrWpt7euotQmgOwFWDWs9q
	TO1Ob0RXMw/gvnt2otQigXkBsMQtNyckfdPsEYFJxkuZqhUaDNdDF/6/c8Gu556sTt8ahjs
	IQVbrfYWtUPhiM7yRRSMGjOmPjte/davWuywEPC56hy76Mf9OnaQuwQtmqXyi4Q+I/DmlYn
	+TfytXFRloZGHNe+gN4VKxteOKj5rrqOH+jvwRYzyV9wbx26SokvkAEjTqvXDmb1lRGC52I
	M8Q7DdMMDuljPYuGjW+TaByUn5OBwNvMunuJmUGLl5WMPHhvQh9Lz7wcjXrNyFs81D7kmt2
	Hp67c4GD3FbfnuF7+a1JD1nMRvHWPGS5nYooI7EsNC47nJ+L06+iOM5gHKooHIraKPUSnrI
	osYq1J46aI1H020jwkgrLnZIqb1jMAQQxNtQNSgpEHog5w81FIVAhlNiCaK+DcP5xR98Li5
	4E/aa4EbGgWhObYULU8Uo9GR8m8XFxBTemKwFWprSrj9rPONH97sFvcCvsNensodvcmbM1F
	BIq7HTfyCWw6ZXBdaLRVrR+WrZDvRiOrFCJyDLaUUGwmvAwVP5zGphpicNU2pV2DOrA3n2B
	k+jgH8mUI0U7tYEYJtAmpaVeFxCmwY8WO7R2t2moXaywXg7Rr7yxPPNlmPM9mTxQ6QrivlE
	WZ3HUPJNrQ5WToO1wH4dnAK2GuAkj9akEZYtdDTwZnocaklc8DfHd55KjNyrwkHRZYjP2Bu
	1nWl3cvPX5K
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.

The device contains an embedded microcontroller and on-chip flash. It
automatically boots its firmware and requires no host-side configuration
for the on-board use case, so it can be represented by the simple bridge
binding.

Document the chrontel,ch7218a compatible.

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
2.55.0

