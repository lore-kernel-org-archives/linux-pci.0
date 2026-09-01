Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78A47253F;
	Tue,  1 Sep 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252528; cv=none; b=qyF2dwisKGxYZ7HLrHgr219SUcbTqrinI7u/0Op2bL9K9A4pjcMIvGikzoGIO/F+qMHdOwE+Vh686EqawxUOVeiOgLDAgIccknnKoIr4Gey8HijgD3dGUkkHgM+Kg5WkY53SA/orvLqnR8eX+VOlbkyZMBQJBHMKFcYBJMLka5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252528; c=relaxed/simple;
	bh=iJGKW8aHiwPKnRjwppqL8s5bjHfZk47Bz/9I4jredbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxp6qt3MLHxiLAQqc/s+yl4ehSwam9RlQ3HsHRX8HiwnocSmroYLE8A7QIENZvBdnPsZBqw/SFVmoejvt5lbQG/g1NNEwyDbYwbjCBAce9lBzT7zQ05FX8cE9IJv+nvFdjIMOs5DwCViI60btuNOoR9cw+3LILzzAKriAPmAJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1788252501teb53240c
X-QQ-Originating-IP: 0mYgCpomsnDKbD+h2k+lHMBtEyjIbP0NaGhFxfccFrA=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 16:48:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3973929460923786869
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:56 +0800
Subject: [PATCH 3/6] drm/bridge: simple: add Chrontel CH7218A
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-3-7de0b6a73d08@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=sophon@radxa.com;
 h=from:subject:message-id; bh=iJGKW8aHiwPKnRjwppqL8s5bjHfZk47Bz/9I4jredbo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjoHXa6R05moK9HzrSoptJ+dcW6iy6JZUW73mZ0b3
 ydNfzWvo5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwESynjIyPPkxtaPHS99Qwuy0
 2n6hCT7FSzcyMn1Qn3XzYHzr606hzQz/HbWPrBT6ZGm1MvW4ytLClij5xQ3vm8p3s07VUvq6TcG
 RBQA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OXhWvHhbOVwt0+jzzmhscBZOKaDBlV5DmFPY1YB19tOeWd6OrDbCcy4E
	nVUwjtK+DDhvy7+f4/k1NYObxjDPw2qo1pWbP3duKTHvXbxzOMLYTFx4PRxGv0Je59Ub8Nt
	48Pmz8pGKKwixdBeNGlUob+EoyO7Uc8SSVWkzgJkejcVlaY44Xwx5k85LH7UG79qyiBVIgw
	IkYjRLf/TTddrX0JopQ3CjD7k5BJnWknEsq48j/IIrsSEkDOk6ODdY7dyZi2jcERnqBw2Km
	bJyBM4yThSwneoK3DhI+9D4VbYOrBl1kxg8gVg0up+hIHBXhS1A6Uow/nqhmv2avSGdOeYo
	UCA16SWp/nScDYCFeVpZyjmBg6gaEv4i82gES43cfOlVEM3DVfyJBmKoy15m9k5RZ7gxHbL
	cyAFSFsKvTPx2J5YxlsPxNPjf7vBlBVltTB8lqogcWxBMC11QHSG3cvH0xjQsWG7HPEyiv5
	OVgnFFnQH5jU73+kx4n4gwAFypsahLgfij9sQT/TWo1NCXyh2CGLngxDMAyLDXuhK52oMVe
	b/QiyaPju68etMzRa8+OTArehwX7E3QGX9k3fmp66mZpBOKGi0jfOAFw/SV8o1dfb+IDcoP
	al2JLhNj7mWZovqC8V6CzHg+VX1ppIal4xt8cGKkAiWGkTJniKqK3GsRirZuJ476t3vzuGD
	HXLFDPIy9yF8iAvJBAgCZoTfPEgnlu60b+baO0KrwMv75nFkL7iH4/hZ2hwipaw3D+VIyUU
	jSw8H9HB5npK3PwlQEr9/FgwJalpwF2QyrNBL+kBm540CBNlDG0B/bz+2efLcX41fQhBrdI
	vb//uO9iFsio5iS2Qa8MRzy7JjD7l2OtZMhWZ/1CDbIY/lsD5UmeQ5tGIWZtl3yPaalqQKC
	OHdVWRbxylB9q2LzGtFGJlUadq9Gpu6BN34IC/XNzs9L4WOibBi8LNzSmfRTO+4TPdR4UYc
	wq/E5g954duTwRJYS51InrYhfjq6eMrKl18iHmFqZ0czczYenBuZI1b9ZPO8UvAo1LgFhhH
	WPhuegLIjdKxDCeJRF+PjrZgb+vYGBIecE/NyXH2UNShavZj+6URP2KiBBD/4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The Chrontel CH7218A automatically boots its embedded firmware and
operates without host-side configuration.

Add the CH7218A to the simple bridge driver and expose its output as an
HDMI Type-A connector.

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
2.55.0

