Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6503D0C07;
	Fri,  9 Oct 2026 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532610; cv=none; b=OOfZSr/C3J24CMEiKIuUNMlDpcwQ2YhNvfT5L26Dd6CbV6v+PoJO5B6fKMciWIbZ1G6Iq+e9ZwOyDvh+dZYgNQEkT8Yj38W3D5oUE42A8giQxKZvxyo1qF2W0l7s75abTQ0LwBeH2b/jRQ0hj4dXUg1ELH/JYlmHHXQc0mwmWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532610; c=relaxed/simple;
	bh=+V4J4jb5Aj7TY9xO/xX782sZxUDJGWTEX8LeDQ4fkho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RblevmYNLuH10/+6NFodVxnl+SMzE5FGNOypjaPvtb5Q7uOaoxSHx3S+fw8ahyZeVBWC31kHoVNZdNldzbRMWxf4AzM8q45Hy8YL8+tkFYR2sYQpMNkvv5maDRTCtM//bvysp33t2JVlU1VaI0fKmjSB7hsp49BGA/Y1cr+KtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1791532534t173164c0
X-QQ-Originating-IP: BuEVl1c8H95NpE4oXHOC/UUST0zQ5tlQaJLw7XoHYz8=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Oct 2026 15:55:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5870349108209219683
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:55:08 +0800
Subject: [PATCH v2 3/4] dt-bindings: arm: qcom: document Radxa Dragon Q8B
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=sophon@radxa.com;
 h=from:subject:message-id; bh=+V4J4jb5Aj7TY9xO/xX782sZxUDJGWTEX8LeDQ4fkho=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j678tLO/c7n2Lsx+oaL5/RW9WpUalzP1nHiVMqpn
 el+V1S9o5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwERsHjH89/m89f5x/yg/3i0x
 hjvMLr5bvOD0G/MXy3iPqL7/s8xi9QGGv3LLfKy/brJkmvvkpT5jsu7fgwc33THc09py2uTqOdV
 Pa/gB
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M472cMQbILHLcyXJxjtfAmjsXD5/IDODG+gUL2dbesiHgasEEhuhcVFE
	uxl/tGxQ4AXz2Hi7YKE8XU20hKlvZdQzpbfax5Miem1/cPbJt3OAYH03ejTqk8ZqAytlZVr
	XUBWdVDCNiXUdlDhYGra3ssKme6hSCq2HU8mlpU7GEmwyNIikl78hibvTLtXEpBFqpqgNUy
	7gGydc9kI6zLxGnC3oB5LUwcGMNivYw1WZEp8Leq5A0MH22t3cvuh72iMOoMD59c/jO3tdn
	TU9LG78gxOqX6q+/c7Q39TzFVN+0VVzZ7CZP9/NZ6o9XU2KjGwvgrZol6E6kbTnrPN26FHo
	qhwrqe4ehDoxQLYFb4w3ij2yhPcfn11HrqQO+9FOQF3dSq/MThJ0KU5CA4T17SoQ4MHZyks
	CtlT6LRH656+nxhkUxnAML4z10BcCdLrkzvRRmJSUMSo7GHKfkX5fhoy5hgMuD8bLCCSPkg
	FRZcnJouEttkN9JnQVFoX3xQei3RU+AajrbuO9jcm+LsfLhawK5sMJ5c0sozkm3RJ6mjo14
	CBn8AzTOyySvaKX5b71ZOhtNn6ojyv0/wM85sxvzVvQLCnP00M5wJwGlrJIlLVbKm73x0Pd
	eMz4kZKi7x+cAiTLZ53lu+74YUr6CzXfVuYavc6OYmMHt7rSfkQrTJ1rtn6ztgJvdCk0jUT
	gDBYtII/cXvSy/7ef7RCAOFvkqyFl9T7WDdVSPG7qvVYBYooQWhe+xyKbtb5vrexE6Tqtyr
	7ZFWbtPPZCQMc1QJIrRc2iUB4HIyKVmmdpShCFrHZmXvMx2weSWlkg+yT/XaG8MFg4BZXpW
	81uo4HMPYAjKIGH+rI0xT0T7V45zXzE4MNUhAdNAmUvyWgV2b/5GDTwwzINEVAW0VMpL/QM
	5Hg6zetQHYxPJdwAdaVIOb3nyG8xBLfOseYheM6mNOtS0OIKtB2glWXL5+BXKvCY/sPg9YB
	y4zLXbtdCPnW4G6LVoY+3UmuC5xFdbKlVU4C2Juv10WvVXfhYaK6Dnt6L8UDx1wrxMnR1ln
	y8Wbpj8xX+lYKLfwQJLX2eoob2MrKAZgEVQVy+YIq3ZmcV+8lXo9kXCmnlis0At4iVOqt6h
	8JiUbmgPE5OVKdT12ZO6jPn2wfRJgDqpQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
SC8280XP platform.

Document its radxa,dragon-q8b compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Daniele Briguglio <hello@superkali.me>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..4341bb04f912 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -902,6 +902,7 @@ properties:
               - microsoft,blackrock
               - qcom,sc8280xp-crd
               - qcom,sc8280xp-qrd
+              - radxa,dragon-q8b
           - const: qcom,sc8280xp
 
       - items:

-- 
2.56.0

