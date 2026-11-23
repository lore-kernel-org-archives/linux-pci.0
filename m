Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459451;
	b=ZD2QuaVAbkl2xRkITYzRxgo4I9XpCV/PZ0jNK18VTsJPKOabpEeOu99SRYNF5C9qaD3l
	 tLEkqpRk8drjs6aDvQE/B1/4Ihqm8axt0ul4ydg3pw+hMiIk9Gy0CLMqOEN1g6az6UMbe
	 1+cUyMX+5X4eLxz/BrCSjD+H/jmAgMWBIs1vhSvI9rKwsQtSaJqJANvp1YViQDhYRLHb9
	 hw82nALpHBYFPETcHdZlVyMM3tXH/IYLzIZUS6y+bG82Ww2/ZQE7KNYieHsAUVXWKrUfG
	 bHuzxL0sS0AYxXen9jFd/s2o5K+5Ml+LQG79WC8F4Q0MC9pi00gQrySbl5G5Ud4g5hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459451;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+o+JlwNGILg9TS+MqHvdFg2BeF8SIkQObMLxudXZheY=;
	b=Z0ONHCnsVtwepfCHZIuRTzZcKq+vD53SU7LUeUP60rnVWCBr6msjJ/2VXuHv7hYm1gsX
	 XNzNkpQBEoIW/3YCgjDCdgM96NfeGtSrUMqAPQXvsqVBvlHEW4L+Qc8jDFRVII4Fohg4T
	 qEnqAsepl/8INDSOBL1krtDcwYZUo6u1mKn4op678eWMUiDGnYQmdp7puBLg6xRcpzSHT
	 mea7gp2L9RbTBy8wnfBPuxueVPdYA2AXdzXMJ2lbLMLIpf8WopioMZFfIFCZc49J41G4W
	 HbWw2z4hPFY0fO8ihCmbNsA7QtkHFIbn+Se4ZMhzUgcBJQUleefy3IhWdfatizft+aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDPs4Ra4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AF606A31A;
	Mon, 23 Nov 2026 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDPs4Ra4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459450;
	b=qW9DfzQJVE38QvPlqPmBh1Jan1VcHEOitT99doJfNgP/VXSwyrpwWXnM0uA9jHNBdxwE
	 4zwYChTDr1p99ppZUfEDwnnzzVKFVejLfBMJfEGZdeYyZKQWUeq6KzCkgh+CVC1MJVMm8
	 NDB4MME/uy2Wbs8zt2sND36J2fsXAOpsSz/WVz3tOVYBJsjiX/IwmOkyh7E9ZJFnFuFlf
	 IW3fx/P62bjE3/4Gb6H72Xfk5wD0wwOxYsxJgt+rDMRLJH96vmJEKi9XETABLHXaw/Qtk
	 f8exa6Zxuwm6so6CcVgFvk9XQTSllhe0kWNVAfnLQhUaumh59NG/4dG6ZZBqidzF6xg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459450;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+o+JlwNGILg9TS+MqHvdFg2BeF8SIkQObMLxudXZheY=;
	b=mq4TxaXVmVEuNLi76kBR6jRpsM0Luw+1y891XzuBGMDfl865X0CnPFl5mg+vMoGGzprO
	 woYfHSFS9aUJnvgwv/pixZkGTrd/p2QTKS1rRKNB/F3pXasHX+xcnxADdsvSCY34hifGW
	 ouc2RqM58wCmdMUZ0E/x/PG3ZV07nSOTAFHOeGmlv65iXd8J2DCSsSiq00KFg0Xu7JzqX
	 o9hjzhTMIQnCdbSjXGy/igy7MVCSVJyndCIuCrvesPeMNBK9N8NdJ84eIfgoM7S0HTlBK
	 wlHgDb5RlJdbRkayfUxu1D29hm+lKayA4OlnRV3vmpRVkCaJpj2G8ivBUbYGnX7TQjg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A1CE71F00ADE;
	Mon, 23 Nov 2026 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459450;
	bh=+o+JlwNGILg9TS+MqHvdFg2BeF8SIkQObMLxudXZheY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aDPs4Ra4jTLj535EXb2q0WBdhPvEZBUS2UsIK41YMxbSE1I738ghK9D/hsZ2aG7eB
	 kDPJBqO7mdnSw0AIQHZNocISENrfYOT/DEm0mwK+ZEXsguI7swrg0hPRiyGCmIs6lL
	 Mk7x1TPK9zFvUFeVatuZTjC4liXQekSzXUcEnjCUxmSIDBB002AiPSEoJ6cvnS31yO
	 Pf3V0Hu0IEsZha6krG05xqEIO8KlT20Rq/SccbpIvUc4SBLosq2X/oBJ6xH3FSC+1F
	 icmiprHuVTmwggnYOHwvwPl8UGIziFNXTJftsv6B02sultKqTrBwHIEN95hdt4kwFm
	 raXNPFZeHs1oQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA1284C616;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:43:36 +0300
Subject: [PATCH 8/8] MAINTAINERS: Add CS7542 PCIe support
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
Message-Id: <20261123-b4-cs7542-pcie-v1-8-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459409; l=1321;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=QHj1rsaxQpilF2S2K/I8XJEDNkzvjAgVnMPKiPzY1VY=;
 b=tPTmBU/Q6JWbN1fb1Rw5jN7N8a2+v3+qHKavCh3GAprkTVytOkoit+bNqhXYVQ7xo4ZZbLL72
 M+Kh19wnycdA7AYEOizhL08pou1T1L4EJ4YbplBb6U1Sd4FFRe2YTrb
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Cover the new PCIe control, SerDes and host drivers and their bindings
under the existing CS7542 entry.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8835aeca..d4cada9f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2949,13 +2949,19 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
-ARM/CORTINA SYSTEMS CS7542 GLOBAL CONTROL
+ARM/CORTINA SYSTEMS CS7542 GLOBAL CONTROL AND PCIE
 M:	Fil Dunsky <filipp.dunsky@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/cortina,cs7542-pcie-control.yaml
+F:	Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
+F:	Documentation/devicetree/bindings/phy/cortina,cs7542-pcie-phy.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cortina,cs7542-pinctrl.yaml
 F:	Documentation/devicetree/bindings/soc/cortina/
+F:	drivers/clk/clk-cs7542-pcie.c
 F:	drivers/clk/clk-cs7542.c
+F:	drivers/pci/controller/dwc/pcie-cs7542.c
+F:	drivers/phy/phy-cs7542-pcie.c
 F:	drivers/pinctrl/pinctrl-cs7542.c
 F:	include/dt-bindings/clock/cortina,cs7542-clock.h
 

-- 
2.53.0


