Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375143F08E;
	Mon, 20 Jul 2026 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512518; cv=none; b=FW97Ld1gmqaV5OZRaPBWvGqokLZnytmukFb02KE8LerHzpU8CGzws/91iSI1HHc5q1ivqB8r3k4eYN/CYwSamuFTuZAyKwapxfmcoGWZRdXT+oPIymEeyRmSqMymRNT5csqoN21do2QvZmlsrkYSHfCBUaCsq2XzUej9/TxSC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512518; c=relaxed/simple;
	bh=Xb29uNU2XZsPhe9bg1OWDVHOrSr1L98u98F74cgEUwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BIBW35Qft9It9Vre+bQNW+OJF/a4IDCc03G7U21bW0aHEdMB+CEz1zd1QZNh0wwO/ng9ASjLethb2sut3cPCK9/xMCmvF09tqs5k3dcRdUzSFm6ix4wUGJ9r/d8NIWvxwU6Ama6GXUEM0K7haE4T7YT/BGWOCUSTRsxYo1g5Q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=apjqbCa0; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hOGeZAZk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="apjqbCa0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hOGeZAZk"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h3NrK1Lx9zMlFf;
	Mon, 20 Jul 2026 03:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784512513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyO7p+74bbeYVSKJrWpJ70ESCwZS0XJxbtUZ29wAJLU=;
	b=apjqbCa0jxBziXFnpRGV8h0zNz6/evpbz+5y5Gkg8TX2CjNPr38LP3HRMcKWI0rRq5EcHz
	u33kHG1OSnCJ7yhqatvciyOgH1K9kKj2PPbA4v+UEQ2g2BgiBJyYSvcG2rbUnOymqKkh3w
	XCj78Jpe5FbdO07p0XFYIdWECHLD5GBl7rrXTJJJNw/6zndes9k4+Wmz/hg2Hl6aY2f1mp
	PTNInD0r60YCvE1GoAjHACucDdruLxINWVYLMiRx9hnmkoO+6kezfIfhiWx4W2oh5tXeIb
	VUjF1bL8wAwBjsnNyVfMoX9V+xXnz94lhqfwFOe8W6R6BvXxLVObT8sWkEI57w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784512511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyO7p+74bbeYVSKJrWpJ70ESCwZS0XJxbtUZ29wAJLU=;
	b=hOGeZAZkLNGeY7k5SLHX4hCUWQA6KEuE0cbKUjFuO3YPuzu9DgKKh3zCcrkBYjZ8cTWtGn
	gzZ7zJPDaUmqdBm1gg3Dtfpejmj6zZuqhSLpP+YOmxPZj6mdG6/dbGavFSxiPb5PA0pWiI
	XUDNGXw612GRxCWRVWpObxu0fIPOehqrbuBdxQSox+7w1Ko9PvNwiLVB8N5jnrsjvzwRDa
	ffiCdwh8hQTCoVmRXfPZsRLfR4DwmVLcFpihUV2Mrv2yW253nnwjMfSde5UuxNExDF7CtP
	i4A69LtSU1iL4qrkOMQBmecepVPqOCprolLvVxYxP10csVyspxMrLnjzzk0qRA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Document optional msi-parent
Date: Mon, 20 Jul 2026 03:54:41 +0200
Message-ID: <20260720015505.314957-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 52bbf083aa738f1cddd
X-MBO-RS-META: mj4a71upqbrsneboo33mpx59w784p1kb

The R-Car Gen4 PCIe controller can optionally use GIC ITS as an
MSI controller. This configuration is described in DT by setting
msi-parent DT property in the PCIe controller node. Document this
configuration.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index bb3f843c59d91..64f456c6a75a1 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -66,6 +66,9 @@ properties:
   max-link-speed:
     maximum: 4
 
+  msi-parent:
+    maxItems: 1
+
   num-lanes:
     maximum: 4
 
-- 
2.53.0

