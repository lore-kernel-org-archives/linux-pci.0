Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB73DA7C8;
	Fri, 25 Sep 2026 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368268; cv=none; b=B3LDjS1xisOsGDGmhvhpa7lrPdVUvFKzTZlZe8N/ejxZsHgu3Z7Y493dH2oWXB1Pw2+U4tdIoSH9BDPZclDEj1lu/1uge0aNeg4Ijxhlh8X5lkNNcj2TJbColnpc/kHf4bX3k5CVi6FF1DMQvvX9uNW9B2CaJ/SJBM51LgY1Pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368268; c=relaxed/simple;
	bh=4prjH3JSerSDfYDuINQFJhIuaAABekcPPtNcx1u/gm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojyuxrzj3a6T3WzqZsTBPZ4N/tYMW/ggAWyiHHS2XQgD6p40ozJOiG0oUnak9tDtlV3J63SY2SwB7JbuPe+nAbRYKgTPn788oaSOnI+QhJPZi0sLIO5kvFFo2uhn3mjIEay+K44g/4Gcf3Xu5rWDNfVDvlOlxTcCEvfDFUruJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xfF6xg+N; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QwFRNKbq; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xfF6xg+N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QwFRNKbq"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hs2Qk2CnTzKmHl;
	Fri, 25 Sep 2026 22:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790368254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9tjU9mEZpQyYYbCsp2FIl5GryBCKfGpmvGA6r5giC4=;
	b=xfF6xg+NMxALi42SSsmp1KqEMXn2tBKBiK9uCcaooHlta3DTm1a2mTJFRe14T/sy2TdUqS
	tn0jJ09W+xrsn6iIL8W2E3dcrLH9pqIE7E/iaqr1aY203cOD04n5wr5nNnEnVSlKGWvFQT
	j2klZfDuORZkexaYL/88LNdHYma30f9Y2GOXNWkKOf1oOPj6NhZwE7Ktdd/D7fuywSN57Q
	gB3XcULGlAmFukC7kNZ1n9lKsn27hqKPzMBb0fEx9lFOhLXayi8yPeohizqQcEOoRRZPJ1
	rUkytkA/5JLu+tULFOth7yECKlopBHB3yVhTMv6tT4m+QsLWkCa9tZVxP1CNbQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QwFRNKbq;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790368252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9tjU9mEZpQyYYbCsp2FIl5GryBCKfGpmvGA6r5giC4=;
	b=QwFRNKbqZip7B7/RPpJLWT29m6gthv2XDU9X/Uq4UIjIrCpvQI40kpEHXVp6LTWvJR+Zsd
	3z9YW8IMu1qkhLcVdUQZG9oNTYTBkqjsLgb67F8WY6euO1Fg+98xtpNFprdxy0n8W06sKN
	4xOokx8DDmRthNQZDyQ7oWFQhnczZqkAN9pFXThG2ivRgYVk6/o0o3/Vh6ughFH0YkeHvW
	nyzOFhXBnji5wnm1WIwRTawfwa9hXfP5GSH96lJ6ikwdY3LmWkvkCmwzOcIdy+zkQL1Lwf
	19Rl5CLXhaObTwyyUbOKZFub+G0474X0V2qFqBeilwAI+9VOvcLxV3ik22ZIGA==
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
Subject: [PATCH 2/2] dt-bindings: PCI: rcar-gen4-pci-ep: Fix reset-names
Date: Fri, 25 Sep 2026 22:29:52 +0200
Message-ID: <20260925203039.110653-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org>
References: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ea34df963bbccee2e3d
X-MBO-RS-META: zxyadjbobjx49zk8mqsezawebcy3jwm8
X-Rspamd-Queue-Id: 4hs2Qk2CnTzKmHl

Drop maxItems: from reset-names, since the entry already contains items: .
Fixes the following warning detected by DT checker:
"
Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}
        hint: "maxItems" is not needed with an "items" list
        from schema $id: http://devicetree.org/meta-schemas/items.yaml
"

Fixes: 173cc7417848 ("dt-bindings: PCI: rcar-gen4-pci-ep: Document Application/Local register reset")
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
 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
index a983aa015cd1b..ce177f0eca753 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
@@ -61,7 +61,6 @@ properties:
 
   reset-names:
     minItems: 1
-    maxItems: 2
     items:
       - const: pwr
       - const: core
-- 
2.53.0

