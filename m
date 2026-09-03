Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC93C3F4E;
	Thu,  3 Sep 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468749; cv=none; b=nrJSa4x0JqEOkcydxro9/vIZtB5XWc0bYuHkuyjofck4tMTfoNEs2fdp6UJihOFx0YKu8+D/gutBYLAAmAVfGkIkmyal0XtT/wg1vK529LrObjJ5a4bfJRwL/5sSgRm+uAPQwFciRULLhC6Q9y/zgmTfdxEvzoOZE1iXvg7Q0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468749; c=relaxed/simple;
	bh=ua9movh5ynHsIyj7VDtkV46uP7X2x0p5gvNYcALSGck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TOEKbT7TX+MdHHXmef2IfES4raIebRHQgItUsc4+0rdkugJ3JuM9JDsdbpu9t7048pxVrKeqa6qopG1anvPRi8s18l3wwfHxZM3jdN6XpV1xkHOisxjH/Y5SfVKmgEX30O02Jhaj515Qga2VWjlQSUe88dArI6cIH1vZoBXgbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DPxC1yFI; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SeYlHUMw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DPxC1yFI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SeYlHUMw"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hbWxd18v5zKmcn;
	Thu, 03 Sep 2026 22:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=59PKEI7PYtuS7UFcYhxPqjo/ys07XPDANz6T91m1qQU=;
	b=DPxC1yFIWGdwR/r7UsHGJdyNzttEpfBN9qmJbQ7X8xhLmVNPLStjSslK+1QowwiOELZ7bv
	zlgLni0jdkMc65rtKOIZ9NzW4/PPC2todvOha/6k88brYCE5yaqHxy6Br6Zzmh8hXBR1nq
	QkufKme0yXTTmclcdyhnAGsSVtjc0swJtoHxR4dtf11qoZ2ZtAg7ybmUSuV6uGN/MNH4F+
	b55ujQOwnOFv+F2P0Nz97mefCn2YvAHs0m7ODLLmZeMss9mhFG69HA7bpFhW/b9veWBGLo
	iKuL1GKUsViJBRMNJ00/tQbHGKV0qpWS0iEqiXvbrgMFn10pChI32aZRQxQKBQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=59PKEI7PYtuS7UFcYhxPqjo/ys07XPDANz6T91m1qQU=;
	b=SeYlHUMwnBmZp8dRJ1oLMaSaU+JU6Vg9X1FPp8r1/5Fqzn0YFNlzxQapA91Ew71nAChNaL
	yeWRT3DykEO9np3erqXBAPFSGS39JPONwc6e9nzQZujSgfXeDhqasRueX+I5b12tRvgXUL
	TwvK1E0yDe0eGqeM6tqQKduGFwhjfAOnc8hvoKPxzeDkrlgwXsIIGUtrGF3e21pSgzsiMA
	QIDNkzzvnmrYThHeeXjSPODlDW6TivJKXjb4jtA1yhjcCWhBeK8uqGXs+ZtI7ot/tlEY3i
	i9U/aIPoU7Z63vBnIv27yuHCHUNITwcZ9X2S2D28aNNOTguhE1px2RnqBZTz0g==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Document Application/Local register reset
Date: Thu,  3 Sep 2026 22:50:52 +0200
Message-ID: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mcbpas4ahh1pk5i66mwxi8niujnbaj48
X-MBO-RS-ID: 617d7d59b7d1f8b8209

The R-Car Gen4 PCIe controller does contain core reset, which puts
the controller back into well defined state, but it does also tear
down the PCIe link. This is called Application/Local register reset
in the documentation. Document this reset.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
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
 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 64f456c6a75a1..8a06a25e266b5 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -57,11 +57,15 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
+    minItems: 1
+    maxItems: 2
     items:
       - const: pwr
+      - const: core
 
   max-link-speed:
     maximum: 4
@@ -111,8 +115,8 @@ examples:
             clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
             clock-names = "core", "ref";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-            resets = <&cpg 624>;
-            reset-names = "pwr";
+            resets = <&cpg 624>,<&cpg 1121>;
+            reset-names = "pwr", "core";
             max-link-speed = <4>;
             num-lanes = <2>;
             #address-cells = <3>;
-- 
2.53.0

