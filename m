Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A8385D73
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030341; cv=none; b=umq5NJxxgDg14mfVLhQwNF2sv4fwB+CwdqZnQrr4d5PpSkvmnx2hY4KWeXf3iiPX7wxshwP38V/bphMFfbzF84Xp6lK+nCjPo76owqlo10FTglsInaNNEjdBYz+2XwtB5zHPfmMdqBLjEse87IYVpJzPmWnfBMxtg5VjyKETYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030341; c=relaxed/simple;
	bh=5cZJrlPKOxxy55cU1I+05GjtpUsf/PqzQR7YobX8VZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utuaXdbV6ySveLtR62CnoPSv8mmPk8BG/30btWrhKrLmGYQv2DN6A6Vp9FA/MhEIk9T47phiAwwj9UtTQeAadEX66SFqrel3dd5Dx89THuKO2KV3q3OWpJ+J0uMQ94b3pxuqlMzIdTlZnJDoe2aC6OPeNm8jJSiKdCcXFVGRWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCQLP9se; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCQLP9se"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso25544795e9.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030338; x=1784635138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o6TslkgUAWDqod3FQpYnfSZ08UmiNf29gC+HqLWyQ4E=;
        b=HCQLP9seJ/OMZ9pdnNmy/3nG+QrYLB1r10xrbFaXqXomVSPZPY3rju14Oute2kvBbq
         AJZYspx3jG6ndRKMWsjr+rDDZTPePrhVQEHLdUkOOkEgL9Th3Cp0MeOnUETvgqwKn/2S
         iCWm75ELh8Qph3A2ehEh51+B7+vnuLLFcb/Hgok0I2ItkJtEEvs2V+0L23YG9xVbFbY+
         WXRALB1nl8N2sSsf2p0CE87wMv+8yj/39NLmqDL8nDk1daqzxAJQgxSkUcfwqYdtXzUK
         +8TW/I62YkLgijucIzwuB/ty2Ze27HGpRypkLanYIcy0IhSqty7ME2WKLVdbxKA3ujwD
         DO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030338; x=1784635138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o6TslkgUAWDqod3FQpYnfSZ08UmiNf29gC+HqLWyQ4E=;
        b=WIBNskTZuOU+muRrcM880JLoRLADaIYBB/oXNF+g1lR0IncgilYkauww0kdS8K2Cpc
         yzXdEHPDD5XNn24KFm2W5/8G673z0ROMm2POPW+YU439FBUp/qPbGkil/4sLFIYZ/Zkj
         9vpF2sLuhfusYs/7iO+jSmfEkzCUKD7ej2ldXdV1do83WseHRRGN+RjWkmpg81LpkyHR
         4zeG58mcQChreg1NeLONuxVzIUvSemUHN81k4oyulS+6NxFcaEham2C7XN7urs50KvV3
         MLE2YNClobp+n2KCCK3NvYZyPO5OtYz/oIswQzmbAP+EgdbxEDHA5+t2HxU1AiGwF6iz
         zBgg==
X-Forwarded-Encrypted: i=1; AHgh+RrF8LvPAaIZrc/hZ1YZJgGsh9tKQMk0qpo2V/2jbVmMvJpVY1dk4WxOZWTt0tClqjjyiZ9ou5LZ4gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbj84+2rbSpt0REc1X/54SIouWgp/l6kq4PX4NAdtZ0lBKVIwF
	ryKvm5l3r5LWaRGspCsmLC/1pBfFx2WzIey64ZwTlRkZe72hlIM7c9rE
X-Gm-Gg: AfdE7ckljrbD2oK2d21i+hA7SDl/OYhiqjT3RcgBJDkkhJhzWjD4vTOX/bgaEhGTlaL
	hke1tSIpNoQ5eZKloB5ER1eX2J8wZ3KXuOz4PiHJJQQQJGtEB1uuYq8seVcPPaROl4MVAz+MZGs
	4Oxp6GYFbL6qtsSkjMYmM9XlPIBaPJtzRqXpq/NckT4+5Vlx76AB+jT/lpaKj0AF2A81X20JAy+
	UdM/JDFWRiROrKKr6l3LINW3DHnUbS0br4HXmInDd5M2yz/tfuBWAhLTk3haDDCuQsq2SSrIJRB
	AMvc5YdXPxa+b3UjLaT6r9gQVcwCRHeBb6DURbkELpooMkF60MduqCjWlas/WZvhkcTRJUAULVJ
	IeIIClo5AB9gDQFrszhv263vijSLj6fPVs14z0igTlckzfVN20cT+Yyn+ZAgKcrHMGjDFga0SRj
	9JGwAqJo1KnDQAb4iK/4rrKWu6JCLWkEUFboxB8fmhDjjmG/L+VeYBsJKp5+awk2/t5hpT2luiT
	35kjhcR
X-Received: by 2002:a05:600c:1f94:b0:493:c8c6:4989 with SMTP id 5b1f17b1804b1-4953909f29cmr16692335e9.6.1784030337488;
        Tue, 14 Jul 2026 04:58:57 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm180531655e9.2.2026.07.14.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:58:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/4] dt-bindings: clock: airoha: Add additional reset for PCIe PERSTOUT
Date: Tue, 14 Jul 2026 13:58:43 +0200
Message-ID: <20260714115848.8537-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115848.8537-1-ansuelsmth@gmail.com>
References: <20260714115848.8537-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional reset to control PCIe PERSTOUT reset line for each of the 3
PCIe lines.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 include/dt-bindings/reset/airoha,en7581-reset.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/reset/airoha,en7581-reset.h b/include/dt-bindings/reset/airoha,en7581-reset.h
index 6544a1790b83..25e75534daa9 100644
--- a/include/dt-bindings/reset/airoha,en7581-reset.h
+++ b/include/dt-bindings/reset/airoha,en7581-reset.h
@@ -62,5 +62,9 @@
 #define EN7581_CPU_TIMER_RST		50
 #define EN7581_PCIE_HB_RST		51
 #define EN7581_XPON_MAC_RST		52
+/* RST_PCIC */
+#define EN7581_PCIC_PERSTOUT0_RST	53
+#define EN7581_PCIC_PERSTOUT1_RST	54
+#define EN7581_PCIC_PERSTOUT2_RST	55
 
 #endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7581_H_ */
-- 
2.53.0

