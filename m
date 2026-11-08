Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147776;
	b=OZEbY2Tqj8dBVSfW1iCxr2iTCM49VZ7a+q5U9w/4HKuB3560ynDZZRoeKnGTGK2FELYM
	 q/QsXS9MsOqtZ1sM+zbE8Ew8pq9hTkqiSdVlS0LRtPCzeUCUUJa9lbMqLT8x0NslHCw+N
	 NTa0NbNr0BOwTWdA0R7ns1yKWrtMKA0LODr2MrO1k9kcX5sV9xpCzS/PkpVdOeoScCDTE
	 niMN8PZzvZLRTuCg1oxaJCRmHN2Z4Ho3Lxobx+mNQC5P8XgTyWyLPVVJ4akScCfHXURIj
	 eHma/f541s2Q6DTPLP1v/gKX2U96OCc7+nZnEFn8pcOtK5PFJ/5scjo99T7NMGr7FYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147776;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SxBhdvt3/eeerEg5f6ojJgesCn4pQWjwm05oda2BD8o=;
	b=tDHOin9ZyMwMcfjCA8OshqPsyfRcZ6G2aYKoOY8O42PuLRHqQ6An9ykBZ1Ig54CeCXud
	 Zj/rrtQ/4O9H/8GEi601W6DJ1Akmk7BXfjdq+iiTww0c3wLPA4/NoaenY4625CrLhetoj
	 cLtAWWdoLZTME5lpWjejnRdgJVAS6C8h5tMhqMQMMtIHQeQf5004mifs96ffWmkhE4Dtu
	 Ssw9xJwrrLgki4XTAkOJB0FaIfv8O1zcP8OfiDltNQWQSuwNqnE58TVbdZczdh82koLzt
	 Dguy6FWqmSUdDg6xiLVp5SXd3BBC7w21KN1ON6fzqCtcujP2SYyApqfu7SF75Haf6Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=mV0Ciyg8;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qpOTgGmx;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3E606D805
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A3E606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=mV0Ciyg8;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qpOTgGmx
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDF6F140012A
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:22:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 08 Nov 2026 09:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794147774;
	 x=1794234174; bh=SxBhdvt3/eeerEg5f6ojJgesCn4pQWjwm05oda2BD8o=; b=
	mV0Ciyg8eg/KgJroi+v+WBtZYDdX8DiurvCsKyQdvA/d+KxJfxTlgXlvytcLnZe7
	AJXaTHSI1XRyMon2iKP4J25fW3y0w2dpbX1wrLg/IUXwgjwBtdZwnonP0pAU6dxs
	cupLEyEinHW+8DH2DlTHxfitTlFpKFzUt6xGls3KPCPUfbOEobdpLJaPzLN/9zol
	jfTUZ4UbZuusaNRPe0ljCGVkAzpX9RpyXEn71+MRWGkSxzHAuY9VY99aGDVNyR7p
	1rmH95/s4+mRCtn8gVbfhH+FrAV5+ICdfIvD3u8RpAktkscauNDuV7tUeglcO2TO
	YGJSHF5qv6DSARXC0GAcfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794147774; x=
	1794234174; bh=SxBhdvt3/eeerEg5f6ojJgesCn4pQWjwm05oda2BD8o=; b=q
	pOTgGmxSGldvn2y0/sQV+07FYJz8B2qxVbmZJ3wYQZ/bG1WWn4DKqGnjGfxxhPgC
	0ov91W+NRXAvrKZaF0wWJmDp9Bzg+c41ms4bwJR3KuJne/lDb2O2rfUrjV1IjLBT
	VpWNpZXQunucGWGcngpzPbRl4D5aCwKzNwyrS8DmBIQdHSLcUe8qBWYS8l4xqKCj
	IEuxIJvavyk2/cFEWmkgxzwS7YwuOyZ+GP3oeB2JJbpwEW4Ssrgye+AYdkl7oc8G
	oHOXHoV7s2jTFNH3/Hin6OcovaSBfOCmCLpraAUVod2OLbBpqX5MJnDyCzaMoV2C
	+ldKSxt1V+RtsCIlQlgyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794147774; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Bov7Ct1rCwc2l17XqRc52hWXATG4QTluu0ZFB8kCgKiT5v+
	+H1MpgfvOJ89VNmWcLBdVBOe/JZfnKLVz2p+uR6xXhKI4l3fwPseOIJ/OgyAQQK2
	Yafx33sYAjua8WFYZt4cloJ9NdZiHEjGyVKN8N1AKyLHfWrva3QekPkXUanFWIel
	Dsw/l9KD8Nev9zNo5A1kocC+7ksOXsq34ASsdOEykySqyaZN4dri0RObqyXvSSi6
	wMXiBVOkBtrVV9KGDsNGkcLjv/9HwiQZuf4ZbYgIRuDOx/hRDVDF7p+SNCyapVGX
	GldP7Lpv4mcHW+GocfMpWQZRz+lZhVMrZ2kJjHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LqiGbhzvV/5wHY++2IHN2VcOrs5T3DYfqW2xXfxsbxI=:ysfuKteBBK3BrJYrQIb9r0AKuLdd060EUuL2t+e9shQ=;
X-ME-Sender: <xms:voXwakUbeaEDuGHwcZw7ZhFp1mMMWsZ0J31FfYoQs9p2raIS1U5dAA>
    <xme:voXwap8xx-pJ3SdPIhCHvSqMqVDOJ1oJmEzpsrSk6t5RhAYnnvyk-PmIuRvyd4eGT
    Np3U_6vgtZEi6lb1Cr0YVw5OW7QpkVVWD79vW9rIHfIpO2eYhdVpHc>
X-ME-Received: <xmr:voXwahq6rynjK1-zJ3w-ncuecVxQhCOzUSC6PQNoe0XrgJCXLlsqLzeYRn667KjsF_nqMCicBAAvBM7cBBr2ZYzKN53tN9Wtst4>
X-ME-Proxy-Cause: dmFkZTGo3CfmNkGVcoCqQm+2xF5BgQTQHLEob89QGgMg/fmpPsx9Ba22YEWDsCMCAsJVht
    iPMwYglQfWngG0EQiTCIk1j//mHbmcbWVDR0k5U/uGGvuPWIdI5VF0QmVDi2K9omMvQXse
    1SsImkgs2/+NnGnQwBHgKzDKk3rdaZCpy9lOm/CBgsoPRaB2SL90jN/DpplvLkjqri7DRF
    34GZFZT6mx2KG6dtb3J1oKeeuxv77VarACJ5K9flwFuG4XW+zRuJ4up6S+R6m6RCgUFeXK
    suuZS7ohMrlLQBXad0P686p3sxTyrb8JLChbCEM521ZgNKvK+lIcmDaAFt7tO6sNGMYckN
    rvrJsI9LRFl515cpEds7Ss+uhqdKn2okNVzRDH0E1zSLFLuVyGYZXerw+/5cQOzHgVuY1g
    uVcRHL5a34vXKahVXYAqlh/+JKJil5Me/JVezsQrgh+mGNmqzwUMEcE6ZqBmWNapPw9NOQ
    4xRZu0026ChhypY2dSNV1JN2hYS2u8x1JzwhZtWiu3BxIYkXgDgcldkrmR8zg8YK1Wml0r
    eNdk5cHz7noWTS3dwMfDzAY6MtbKFBpNy2hRXdReTDF96dcfL4SG0qJCKKD38ncXPirnNi
    RFzpusk0VqGZ5mreOhhlbyD7Y8acFGCcpFz5EIepmEb+Gjsss5XEIHgN7nxg
X-ME-Proxy: <xmx:voXwarlP9MAvdmLHF70XscswxpNb-xCh7UWYSVjd3ciUJ1xqumu_NQ>
    <xmx:voXwalYx2KkA8f3n7yACTimpGmkcWMPC7V5Lyp__HUW6j-b8fezhzw>
    <xmx:voXwajWji7EnxAPsDV7GkNM6guXnsOiv6YrHa77pGaTW1yqLg0wp5g>
    <xmx:voXwatBt4SmDtepLr65PG24pp5HsNgka7ztdmwCI1VX-kY8jn7UOLA>
    <xmx:voXwasWAlz73OB2LcAKYJg5li_C5wlzHy_bWMciLaZ2psQViqVST0bYE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 09:22:53 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 15:22:36 +0100
Subject: [PATCH v2 2/7] dt-bindings: PCI: apple,pcie: Add M3 generation
 compatibles
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
Message-Id: <20261108-apple-m3-pcie-v2-2-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
In-Reply-To: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joshua Peisach <jpeisach@ubuntu.com>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=j@jannau.net;
 h=from:subject:message-id; bh=ysfuKteBBK3BrJYrQIb9r0AKuLdd060EUuL2t+e9shQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPrVvObfxnF7zLc5rK546ZIfYd8cJyGeITcmYETz597
 vTSt33rOiayMIhxMViKKbIkab/sYFhdoxhT+yAMZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKneps3wTzmn/a3TBtHf/zROH320L4u5Y+rCtYbysj8r4rqOZujo/mX4p8PGIHT
 o32MxlZVOVU9Sa+RTlq/SnRxYLDBn2qzbkUcv8wIA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The PCIe controller on Apple M3, M3 Pro, Max and Ultra SoCs are
compatible with the one on M2 Pro and Max. Add their per SoC compatibles
"apple,t8122-pcie" (M3), "apple,t6030-pcie" (M3 Pro) and
"apple,t6031-pcie" (M3 Max/Ultra) to the bindings.

Signed-off-by: Janne Grunau <j@jannau.net>

---
Changes in v2:
- modified subject line
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index c0852be04f6d..a40b5d5b9a5b 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -41,6 +41,12 @@ properties:
               - apple,t8112-pcie
               - apple,t6000-pcie
           - const: apple,pcie
+      - items:
+          - enum:
+              - apple,t6030-pcie
+              - apple,t6031-pcie
+              - apple,t8122-pcie
+          - const: apple,t6020-pcie
       - const: apple,t6020-pcie
 
   reg:

-- 
2.56.0

