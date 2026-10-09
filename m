Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917147206A;
	Fri,  9 Oct 2026 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532614; cv=none; b=Z1UTs2OQgLoPFFSavYb3+dAnf3TK+L6E4r8ZvvPbB7JogUbBQHnAnHhd/Dd0dMyiVW85O97FXjyVvgcahxA5lqxuIzje4gIwqHs51Qx315OJIH+OAP3mIa7Fw0PNhZlFHA6DSlnHTRqZC78lnPAyqX02wRIzA8Dc21XPfxU02Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532614; c=relaxed/simple;
	bh=/D8P3kABTsKmzN3/LTDLick9fibyBw396ut558wJNKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QR39IJVXnG7ha0SNnFiT/1czohu670enacekUgiItvfaINV9rZWkbOzgbg22W4P0kKRPOxktQ8KpOm5tfDU+M2J6zhmXSXQSN2j8xeuGGU5XmF/0QyH+SoK1IIod1F76GlQrKlHrOdJkqX9AwuK9FOpskU0hzhrPQuCEzL1AYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1791532530tbb4c4c53
X-QQ-Originating-IP: 9/NgJElDi7wbagJh8pJMPJTdUCHLgUpjdwvUfflcCS0=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Oct 2026 15:55:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13704991742146090228
EX-QQ-RecipientCnt: 31
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:55:07 +0800
Subject: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
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
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=sophon@radxa.com;
 h=from:subject:message-id; bh=/D8P3kABTsKmzN3/LTDLick9fibyBw396ut558wJNKc=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j69eUdZ13FWwI1AsUeNCWtOvhHq6rBjd7LdLLbw7
 p17eX61HaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACbS/oyR4aTLgdCD5+9abY3x
 2utuvefpTiXrMD7XKTZ50ds+TTGemsHwv1B228oEs/mM8TfyKoUfq0fwMuu9mLd0rluN0IMI571
 rGAE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OfG5xWeEWeTyluFtlaAwzXrtEkJBHzXv/aqH6dM2uhsboD4/Lc9kZ+Tz
	I4gr4FiEFJzt7n/SQ8Vgngj5QTAzBpCSxijHDnfqQ/AnIpGRxhivoXJRLAgdqSkx8Rq+zh9
	huxE0zT5fTrSSersX7jiovZYhz/m2aYx8UN4zUH1D/YQ01E8J16BJot7isDfEPp6HtZ4Kr1
	jOLmqlCQzZ3zx8WWsjQJ26OqCmzQRnnrjtnYlmtzrXDoM6S4CxPbqFdmTKWkCCXbuWJ4nGu
	C4DQhB37E6Eyr6EcJxECseBdAoTtUPhJvBFhQQ3GmZ2FClaiBP6qILfebprnNvmwR1AJkE6
	KpdYnpbccbHC8NRyWAXcjWSOj98CmADO2O8xCEKNsXVdAAdPaxZFeLoPuUp6TrEacGcDaPq
	bAqncYOV37h4u7LjSpkP9dcOyXSKEdvXHKD/787c+tdhVD1EOhrjm0h36VyTXABAxR6y6UJ
	RrrTFhp624YTnfmT0+i42fYU0tB3hRKMMUwHP7hQocAACGrDZBsLhTlrn21UGXaO3RCiT6b
	5ahh5cHEEbgme7EUObg2mQZKUsllWGFy/2CFT7x2XUv7k7ZOBHyk3+TQ4uoH8fsfbvCSxDl
	5o/gCAFqAb42jtYAfILeKkcB7yYRblnHl6x29CYzdI7lwxGwD3Nlu/AxTY8ylFx7wHJPs8V
	KIH1/9kHyrGIoC/vhuWjfYudT0DLQkLfaAWxpct9mQlhxldoXWKi7hEPHVb+c842OAULmEJ
	u7jT1L6HjnCzMX3oaUx3wdvnW3YigPw4unQc5zZpCdqyGzkFttuahw6Xgo0G0vwgfP6oy86
	T7E0Q2aHd0vVmZ5lqhx8KaU5/v+PDWSq+uCL3OmA375al6r9Re0IlJuCgD0L1x5ZDrcgFB0
	wyI0Cvj/STFL9BadyF9p32FHT3GQjZjqzjDT9aMXG1FpJFa6imQte/IWVBE81L67osxN5qK
	Zg6LftUqHtBo2zqP7gbQclxYRSdAFnRC2R2XYv7u2zut9CQ2ugUZZpsEGWx4/e+qMEZpLVx
	jRHJ3LCLsi/LI5CMsWYUvXJ7DEcYxkyAYj9Dt1g6zIOGgm0tj16oXJL7FPHWViNB2JC8OVC
	Fzvp7DGLtkBf86kzx09KMQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The Chrontel CH7218A automatically boots its embedded firmware and
operates without host-side configuration.

Add the CH7218A to the simple bridge driver and expose its output as an
HDMI Type-A connector.

Tested-by: Daniele Briguglio <hello@superkali.me>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3fba7002322e..fab793fb12b5 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -275,6 +275,11 @@ static const struct of_device_id simple_bridge_match[] = {
 		.data = &(const struct simple_bridge_info) {
 			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
 		},
+	}, {
+		.compatible = "chrontel,ch7218a",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "mstar,tsumu88adt3-lf-1",
 		.data = &(const struct simple_bridge_info) {

-- 
2.56.0

