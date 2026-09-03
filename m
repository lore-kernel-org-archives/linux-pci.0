Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CB45517D;
	Thu,  3 Sep 2026 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468751; cv=none; b=BGlANy6uDaR6Y+/UOB8x1XpRDB0Q7arbFh8S+FbTJTfq/BAHlHZCQpUK80G9kE2W2XwzxJis7Dppb6GCUcpatohEueiSAb0IKN26XjxkZdya/Q504IMUJArY3DtJbAHPLfpBnI740ewNktquSO/RF0k8yfNx7epmAYaWPlnyrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468751; c=relaxed/simple;
	bh=vwOuSLvL63dOCq8FTIf3VO6iJabE/FIYcZsUkmdtKxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGtTqMJ6sSQJ4qY1c0RwQ4x8icWR8o/pVgsmOjdD95KXGR6kG9FuVpze7nsuOwHv6xqqAlhuEsB1AWlgH/o2N7IP09JogcfTCQUNfJH67+WNpiXZ5EwyWorTXzf245SdjPWCb+q6dX4hLcQ1tfTy593ZDfZc1ITfITeSpc/rarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JZdjWe2M; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=d+/sEAiu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JZdjWe2M";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d+/sEAiu"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbWxj26cvzMlD5;
	Thu, 03 Sep 2026 22:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Fm+D0OcbzOy0IbyGDj4z1hQFOVoL/qLeotXIAAn7YE=;
	b=JZdjWe2M5FbbM5MlUrt17dhLmO6geib8e46t17nk6xr0lXW4UHNeoZkfi3y4gDjWGMFgit
	2WJ9UJr312NXLeqdJgXnTmd16PKq/GJwReC7/YTJgQuiYT8egz/NvhYzs8be5IccyQA9nq
	RFV1jSu4+hWpb+cYiUC+bj+FiVRbsBpgVu/ADSS1YW7gTCSrSuLbeNIoSdvlqNrDXwAAxQ
	LnXt6/2SLn84Sdc5hXd7p19IXm2rnUTGzJ/n7NZi01Az5KKqNqUxrXH+ZblhyRJZ6DHOhB
	7jLlwIzkKnK/5DqXRE1dHDDHrxhj3Ai5+ahYjDDKjqL8YGOWLIt1Z+veSGIPMg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="d+/sEAiu";
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Fm+D0OcbzOy0IbyGDj4z1hQFOVoL/qLeotXIAAn7YE=;
	b=d+/sEAiuveGD0FlmPArvdb/zQWZhdUOz2dVfFdsgGYnfGf+rhQWdO1282YrWbXV+WMJ5dA
	tm2DtbF6skRyqMvYdScgcKeVNlVHGxbytH7QCdUyyQclWOzhN99E5TQ13HmHHIPxq9o9iX
	uwqPs4894yHNY5k9IbEk14hJqncZfsFKGY7srZAVY9b89bn/+QCH/lpAa0kUFeeCBXJwpM
	2ckyu/yevsFWteyB7SKX82Jsd9VBXloXxgHU8S84Co4XU2FADWmnMgYc5TVl4dLIFP1hVl
	J4AmRRHvpg6mKpPhKPgzu1gnRuWSgnfTWP+dvX73uAeGBIapX+gp/tI/2Y7pDQ==
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
Subject: [PATCH 2/6] dt-bindings: PCI: rcar-gen4-pci-ep: Document Application/Local register reset
Date: Thu,  3 Sep 2026 22:50:53 +0200
Message-ID: <20260903205153.283553-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y8fjg86s9e6n6d6gbtcpeesq5ddkmz5g
X-MBO-RS-ID: 32e90b4b9a684e07b26
X-Rspamd-Queue-Id: 4hbWxj26cvzMlD5

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
 .../devicetree/bindings/pci/rcar-gen4-pci-ep.yaml      | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
index b23293314a6d0..a983aa015cd1b 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
@@ -56,11 +56,15 @@ properties:
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
@@ -109,8 +113,8 @@ examples:
             clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
             clock-names = "core", "ref";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-            resets = <&cpg 624>;
-            reset-names = "pwr";
+            resets = <&cpg 624>,<&cpg 1121>;
+            reset-names = "pwr", "core";
             max-link-speed = <4>;
             num-lanes = <2>;
             max-functions = /bits/ 8 <2>;
-- 
2.53.0

