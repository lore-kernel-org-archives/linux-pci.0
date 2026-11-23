Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465977;
	b=E+fW0+C6d2+IRFF7HuYKGnTsRzMh9KDCB1AkzSKToGbpI0l4ibpoJSiiYgmHX0RzVMt4
	 tG5BAZWMYOR8meV6iTN1kDUqEmVpgTEOoNkqRLwTzy4vFfthh5BHyedwx7pROYXpj4Pev
	 so7dBnGOEGONkaFpLHMzerXAZ+HEOEEbGQyjcOvZwsH/2U5Z1Byqk9Uf+xlDNysgTB+Kh
	 fR8q1HzESHBn7fh58sPSzZ6IjdWUzX/U6mvx/Yk/ArMe+qex8z+h3lmWvvEc2M0hadoVF
	 Ezhi48XNz7Ve1z81VJUI96xCWV04M90IURfparqJES97X8hWOyXg7vwLJlF4g+miZ1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465977;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lej6RTvtrpI2hEP/db8Qbcau2rotxEBHFNsfNijRJu8=;
	b=m9195HQaUJTKKIuX6sFJKCITBy21Q9BchHlndMFJXlbX8DU9a2e56xlsFDr9XUslIyYx
	 mSuFKd0aB/SrrT8KWLKKBVpQQWwRUC0fCpD0sGPfbsw87I/FKTW6Y008eEDSnx7+n4gJm
	 NiSxNaUBRg0LPLAXqupSjzgBuyoqLSAlqMEZssv5ts7T3Bv5vKcl0+noLo8+gkIDhWhbm
	 XqAH6lhBm6KkiufWYyhxK50zj3dC9WZwk86lli9wba7+bQWOlvl/jkwRTvQ8FbLhlRX56
	 tXkSwovDnWNpHUbaehV8bFuS3zRPwR3nBvm0enrrivko3rxSOq0Wpntyzp97JZYcGsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3TuCmyq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C606A68B;
	Mon, 23 Nov 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3TuCmyq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465976;
	b=rZ+uTr+orARP/Vcb2rVjKEsCV4/tylX0sYou8d8WmpJka1WFhlYhOsKA4NTApHuImCX3
	 EmD2qli6Fgx+BqosiciAn/o9APZWP4DCof9c5wZn6ucNvV45yuZsmudpHXvCOSfbh3lSf
	 h0rJzRFxInIJGGO3kWc7hO+KwAZF8l+A2uMtg2PExjJasvt453G/ESvEAoqejLvp7uYyR
	 Kz7zjl6bE/L6FUQj3gkhmvNi00epoQ3LrlFGZ6xOCWEox1U+vrOezitK3MXs2RK7cDTXa
	 vYZ/qyAVz/JUS/QEsL5vPxkz8HsFRzp3KK6XhtGbuDgUM/6jqgNJcR/K9YKNtWtuJVw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465976;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lej6RTvtrpI2hEP/db8Qbcau2rotxEBHFNsfNijRJu8=;
	b=yjtaHckWJk6LRVVoQ4h7gHVDl8ASFaWgZczE1AWjjGxIJlpd6xutZIuRtXc8mHCFAkm9
	 lf2WZhjNksFiCb/GQJAyKxFOStWwKlGC84QBErk8MkqguRzRBHCW8yQnaSvEAZTfGcKvV
	 ZomfCDZ2jYVV0V3yohKZL4ZLqcAyYlQBIE8txeT57lv+j7ng9wAArE+ghr26DCSDKeItA
	 BA/S3enpMmGj7O/gF9Mtq6zJlhWJSqbjG/pilI0J+rsxMy0ewgr+eTZReobOMhCmE0Ltb
	 B5OWk86JjCXV/symfIk9EWBpz786/PgeFf5LiMZls8Ri6tmqR8HvYsiwAVLnqGwu6pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1C5751F0093C;
	Mon, 23 Nov 2026 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465976;
	bh=Lej6RTvtrpI2hEP/db8Qbcau2rotxEBHFNsfNijRJu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=j3TuCmyqIDDR8NGD5LuQq5sXRj6fH32sOmv8uCX+++9Fem+v9yg6pXxafl552aMco
	 fdfgPP9C+1FFxsAqzZ7Heuac1Qm+3+2PWTnFhLgBMQvfZXy1n5TMgKdFL6uCrk02j3
	 nPSH4SioRgMHqPsxOBk394Tu+01/OL7DCeP+jXbjWoEdzcPGAl3PN2yIwvL6dy/OS4
	 bMSzNCbWSVREEXjj/UcerYGGoY95hSWPUXLpDx+e8vKaqvbHFoTPtnhA7yBIGWYMpS
	 68dXjwStQsrN6b0B3natzvKxyfwih6/oA1MpsrHgSRx6orNSf1dFh62s+yTHtaHVK/
	 p9YHKOe32HZag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 34DAC4C71A;
	Mon, 23 Nov 2026 20:32:18 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:32:22 +0300
Subject: [PATCH v2 8/8] MAINTAINERS: Add CS7542 PCIe support
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
Message-Id: <20261123-b4-cs7542-pcie-v2-8-f589a9cd0bef@gmail.com>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465935; l=1356;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=jDKZmt7guwHzNgRKzZtW9q1sZuhebiJ5PQkmWsr+DNk=;
 b=COAIM9n7CTGeI8/L4LkcbqnsEldMGtaqCfIl/GPNmucZysECPadrp5Gs0ZzEUCWCmxfqt0Ccb
 lEinjDjWYRmCm41Fm5Fkw5271BcAEUcjoMXeS16jSw1BCeT47F5tcqn
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
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8835aeca..511a6cb34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2949,15 +2949,20 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
-ARM/CORTINA SYSTEMS CS7542 GLOBAL CONTROL
+ARM/CORTINA SYSTEMS CS7542 GLOBAL CONTROL AND PCIE
 M:	Fil Dunsky <filipp.dunsky@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
+F:	Documentation/devicetree/bindings/phy/cortina,cs7542-pcie-phy.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cortina,cs7542-pinctrl.yaml
 F:	Documentation/devicetree/bindings/soc/cortina/
 F:	drivers/clk/clk-cs7542.c
+F:	drivers/pci/controller/dwc/pcie-cs7542.c
+F:	drivers/phy/phy-cs7542-pcie.c
 F:	drivers/pinctrl/pinctrl-cs7542.c
 F:	include/dt-bindings/clock/cortina,cs7542-clock.h
+F:	include/dt-bindings/reset/cortina,cs7542-reset.h
 
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>

-- 
2.53.0


