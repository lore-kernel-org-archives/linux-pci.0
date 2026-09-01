Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E6473C86;
	Tue,  1 Sep 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252535; cv=none; b=jLW+HJuyf5MpNekdQdJGhAGaHewPV9G4oE4eLY2YP2jsairrxl9sVo6IXK29vNkD/ot3QIqxSgBiYs+M3nT1Qtq4BDEL7b3Lr5HT1dhWWyVB6aH83Qwlbe9jSScZriZscHs8EQP/qMm4/roWemm3OPzLlGT0rpF35ZSOxdqNRP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252535; c=relaxed/simple;
	bh=XiivO9ePSRP/6Irz+PM55rhD9kC4gh2QxLZOX5pCwp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKgrBJhMVUhGWU2WmCRGj2auHFCtUgBczHEhCgX1FHokr3t0PvWVsWZz44fhmmC6y+G0Q7ZjscIvhtn7h8fp7QjkG27xF9fNauvw21YfimIzQY/U0OZ8u65Ih4iYi5/2l3qQat02bQ3nVooHYBM2St4aqtUj9bZMB/v7Oy/ioUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1788252509t94851027
X-QQ-Originating-IP: lIvP1GpVQQqw+C7jJ6FIpBcVY6xKxry0TN9Yl3JnFvM=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 16:48:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16756156345845701689
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:58 +0800
Subject: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=sophon@radxa.com;
 h=from:subject:message-id; bh=XiivO9ePSRP/6Irz+PM55rhD9kC4gh2QxLZOX5pCwp0=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJrrkHHs+38bv27U78yvk/YXve736EWrMOM3PuUz7y
 yMr9YSIjlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABPhVGRk+DvJIVHi+Hrt9TeZ
 dDZ7qz53V3614516ve/ZfXMeMIrs9mdk+O55aOXMVfGzH2zu7l9hc1ZzcaCWzhS2xv83cuMeuUd
 84AYA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MZ8WYWnVbnpdI1ZlK/fXVvGDfy7s2qybm1HU8S8IlRpNhYZVFxXZVtL/
	gtf2+NetTAGelWM+U8a51NLjqvxxb69Je6DMVJ5TY/2kazQTrUk/dd/4dO868OC/FhA1v0A
	Z2v43GE8fJpA6ccmPAaWCD6ZZ1AFPtQL8JW3g0JP98j0R/RyRUjZqvR0wxwWc9H2vf8lig6
	I4Lu+amQZ3crGrPOmqpMfMRopjDZ1FfAMr9KBynjhjUMXEO8nDgrcZrQJ5ZVt7dj78k1tq2
	Q5TKlafNp/Bn3uLkIUdtKlv/3xtDS+eTZol+Ah6L1JXeNSmnkV/a0oHxgmIeLF8VQchRJbm
	asCiBvgPHYB2t5HJrIbQ9YN9msANMKb/P0yO6rMWmReNGTCeYBRTAiLTb933HCb5VJw6TbI
	I6fzsBAt0YSCUDvrpob+coKtNelp6WhQ++OzsrU43ZPfJNYL8MD38T7OZ/cyWhbEg0OM8wj
	wFx0YaIZqBNsS6wzuDfeyBEqi2doyMNT5S/vsCzVAqmz3isFmZBCcidb5xtWBS0/zogXc87
	5dvgU77hsucVHRB75Kf8F2E8j2bLlF7kwDirSUsWyLkDRqlZP4t75UkmN1PdPEhsoSSmS7x
	f8ieDwesWyUPIZdBY/gXKWgai4vGJYrjiSBveAVCTma6ca7aGLvc42jkdv+qGWXq5qN6Igp
	fQ5gxkAC9Cc6QfIFUO7DeHgpwEjpz4Qkhcbed0UCJGqo69PeRR/ZOsH57Es1bejn4pTaTHY
	O6fZY0J1ootbTykAUacBXZJPzQdvYMb/86Att8k2czclIUMVVvcWK/CPqv/R8HA48+5qJYp
	+dppfVuRAFzX/6Is2oQx1GGs2jJw6TO0cM0EBfhk6wyr471IkTmNG2dW43gzhpgwKURx9Ui
	y01CvHZWC/Py6S9fDzSfbQvPt32ywm1X+3RN5hAVAaRUsz2+H9xdp4EAcNbsDeHmji9knS/
	ILN4t7Eae3Qjt3o4sJVy3qHEYqZFshsn9w3UPVPMfHz8CKEllkJVblkInpaNvvzHtOWNFNv
	rwwloFCAQ8WNjra9cJYh/qtO7ASZUK9hXlaFML1Ghrl8vb4k/mADoNIudEyRI93f91RHxIh
	OCvcdW59PfY5eJZUaNjpIXgFd2z64caNw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
provide descriptive names for these lines and constrain the list to the
number of GPIOs exposed by the controller.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
index ed344deaf8b9..ebc3a8b34a4c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
@@ -27,6 +27,9 @@ properties:
 
   gpio-reserved-ranges: true
 
+  gpio-line-names:
+    maxItems: 230
+
 patternProperties:
   "-state$":
     oneOf:

-- 
2.55.0

