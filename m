Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3073E2ADD;
	Fri, 25 Sep 2026 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368262; cv=none; b=OH3D7Z6YC38TM512I9K+RYskQjTfBXyzfwdHRTD4VCNXSZ67zDKP9pDTZjqEo9HLXxmvGHpqEhKathgt2n8HtSoR9Tb7nKUPDSrKHP9ZEfPPxTJVPYc7WkHJl3uzBNzZeSdZLScZbz/xqh/LLXfFyt6vmZh5m9y2J55M3RojqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368262; c=relaxed/simple;
	bh=M9sQtsrZE+zW52A31eNSj54pCl6wu3flAEO/7CvfkcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gVfc8Pb+DpycIayKPQX1qB3yLIG3i+wlbfqV87WDAvRY6xLr3078nrl2w0rOhlAHP6LLSzRaVZjwa2OU4c5XZTrKFKe63YWPWy3rhzYIjlnzC2z8sdu/+aZmBiDXuQcbg6In7FLkQo7acP3Gzd/j0x8LU/M6l9z8nBxjqF5wwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=C85wXDZB; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vouODrhj; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C85wXDZB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vouODrhj"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hs2Qg2dGVzMlFn;
	Fri, 25 Sep 2026 22:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790368251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M4JDupUoFY30dKt82SQKJaxPVVLkSrwF1C+uPs42vVQ=;
	b=C85wXDZBbUxMcftKtyqJ5MkWtnIMUAWsebdsslEjEIbgTuEbIF3uedCHuLoQhrBitOyEge
	nFyB0YghOSE9mkF8KUQQiqb+1h8sk3rQ7Oq/FGqlKKAaiw7Bfp2rjAysXQ2KiZb/2BT3ap
	1Aq7eWj3zjzeskNLNklAPvlJH/1Yad9xNPj+y7OBma6R3zJSePwRa87cWTIrnUCASiScM+
	MiDqkbFjkOTyY9KdN8rjHLqnOSj/HUpwFDz6a2QV0IVJ60eLkE8WHl6TEXbL/oXAr62imd
	oaTtZ2Oh5niaF94kGJlTC+wFzYwDNXuVBaJEACoXx8Ktwd3pzr93nFJ3WfU4yA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790368249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M4JDupUoFY30dKt82SQKJaxPVVLkSrwF1C+uPs42vVQ=;
	b=vouODrhjnzWdn8wEAkIkXQ2KWCXfBq9li+wmbbyd1wr5BhngtZ6DU//ULW7tomJUubIysD
	NKqpICEmpWtUTz1QXZGHltjGBb+kuM9ud+B1QtT0arpXEhUYN1PnrlK+IpmE1XdrLNoN7R
	06dwmEzn/orbYTyloL9Knp/Epf68AMKt1Zi5Ioh40oRE8jmOkxzmRCgG5hOVc7QDiv1xJy
	8d+js9EhJELWU2Zff/EQP6Kc7cYRRJ6BSUaz7Q3n53FjWjCIfKb7p5Qv2mkl0T3Lx2lGb6
	4dZzEO+r9wqS0cdxtwodZmTx08wDBXDe0+s49vMetiERn0UKz5Gg/FotSkfkJw==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Fix reset-names
Date: Fri, 25 Sep 2026 22:29:51 +0200
Message-ID: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4b95f761df38acb62f0
X-MBO-RS-META: or1r55copitpbhkbpwj64xjdk631y44p

Drop maxItems: from reset-names, since the entry already contains items: .
Fixes the following warning detected by DT checker:
"
Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}
        hint: "maxItems" is not needed with an "items" list
        from schema $id: http://devicetree.org/meta-schemas/items.yaml
"

Fixes: 50b1333e0c7b ("dt-bindings: PCI: rcar-gen4-pci-host: Document Application/Local register reset")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 30e244fda56b7..362c43a1a15d0 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -52,7 +52,6 @@ properties:
 
   reset-names:
     minItems: 1
-    maxItems: 2
     items:
       - const: pwr
       - const: core
-- 
2.53.0

