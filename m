Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8D3AE6FC
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782562505; cv=none; b=hJWJr6HO3hY+tqxCZ6xLW0k6EMUoSc6KTRgSZcmpp5bwUFQ+F5tDgWxgp2zYQciqP5ge4STzR7JULdaeVnRvMBci/yDagqHEiTtAHT+N6dymsa2cuxmr2xjyQEiAP0YKGArdbp5f4qjNgseRaFw5hD22pgEN+9nVuM7eTj1e3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782562505; c=relaxed/simple;
	bh=5cZJrlPKOxxy55cU1I+05GjtpUsf/PqzQR7YobX8VZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5qiKbXZA8I6vxms2X6jGxUkFynRaFAbFThNmW4a0oQJdIUoV5ElDDtWRef9rjpCZNZQ4mE9oWbRNpySwHNxKhjYWdeCtbJgZmkHTSGo6fzBQA4uryoW9hp/IrA42yZO+XtC5qOr4LLHsG+N+mQk7ytCkquUNmHeiRXyG9eq8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFoSnGKD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFoSnGKD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so16085595e9.2
        for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782562501; x=1783167301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6TslkgUAWDqod3FQpYnfSZ08UmiNf29gC+HqLWyQ4E=;
        b=iFoSnGKDTDoVjV9ZO4L7oaMPM5xAiGSbk5f6ESpfWfYr6Iv4S4GA4H9IGRhYq/2Jiz
         HUJEWbtreC9/7pfwx1yjIkA2YXWMRaNjuF6Z7zQEYknm7rMoputFmk3il7y8s9YOCNkL
         6C3Qx/ehBw8q57LfKIkOU6INeK0OYPAG8u0vmWwNgYtdXNtImLx8SfLeD+UrN3nxfy+7
         A8Fv/qRElyjzAjVWa1jsihR6/dyVpMPDhLUcojH3F7BAVqVaYvvblVAoKkTA4N9xl4Y4
         G6Fdy3Mz98ZH7U+EbVbGlxG53JlUChPnbaRZA0aove3dMIPu/u3AESmJV4hTzEyaIjbW
         pm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782562501; x=1783167301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6TslkgUAWDqod3FQpYnfSZ08UmiNf29gC+HqLWyQ4E=;
        b=M9xzbrBhPfr+OLciBCWOgvxwoRETHsQvIm4JmG+GtYP+20P9H7Vu621P7ZdAL5Z6zz
         I3VjPIzXPW9C15IEgCUZCAxEb4gw3BL7RBVd9LIiT2Zk/fI36ifVS56hz4MurV60qD5a
         86OWPgA5KFl42RiRc2wH1yKnDMbx20SZgeAhoTxyOE5vWDs7DPrb4ejFwCtpMVsS/KeQ
         y3mtcuYgmLwOaKUGIQ34ZT0AuXvRTCq4XJSKwRsX9m4BuS0UZjMgcPdgf6WzcBYzDksx
         M1SFN2S8rSipeyqeLG/xyH13E7dz3ND4nSv86ClYam6f2Q3aMp8hxm/KvMaaIhAoFMtx
         5HhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CfqSC135vUCHWCWQq5nnn/vQ2QeqA48yt841d3yPnKkOct13k+VxpBx0PegOIBHeqHjudI0e8h/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpohgT4qAzcxC5r8bMLnm9AGK5QET8kgjMCRuw1JT5wy6EMjH/
	aMguNk4uHNpneyiFsIy1NlWqedp5i6y/Caaedctb3RjvL3rozcoxr1I7
X-Gm-Gg: AfdE7cmCd3QJ+NMwGpEA65hLvwBAzioBP3eRYUM0LU7tua+5BEsaN8SP8qQAvpfrp/G
	Qb73RiJGnOyZUZkO+2o+UkaHOI5Xukzqvz+9d+GUSSOD2b+Y5eHWq1hsTkfLFSXfnr054HFdDmo
	Oj782O3mzekrAX01jZrEe/BYj2VXrCtUOUSgCx0zwtrZ+zZHqhPNSxlSlyGStAxg37+BH7ryK93
	lCM9l/yiffkmL3njSnPDf945Q+EQCJEEAqoGUCYln+hGhaZ+JOycMphl4krB9JazKEFJDq+aY6O
	lh5EjthAjz7/Rbr2Sum5qz4D0RHR4NqsGMY37RXs6Owgx6QExsa1MkP7uSs5Am9tEbqL76BVTC/
	r3FOAk3gaiOw+C6MP6+hXYhYiOVBbooAGdZKomzkNIdTbayVrY42KKUP6W7QCpZpMjhWmNogF9M
	2xRNUzhHFinsm2kBOjQlVf1kknjrIZZNWMmZ4IKHwheT/1Vpm1xGkRsucw45RcYw==
X-Received: by 2002:a05:600c:3b24:b0:492:3fcb:22fe with SMTP id 5b1f17b1804b1-492668551dbmr160952675e9.1.1782562501557;
        Sat, 27 Jun 2026 05:15:01 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-89-195.ip49.fastwebnet.it. [93.34.89.195])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49269002511sm149028265e9.8.2026.06.27.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 05:15:00 -0700 (PDT)
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
Subject: [PATCH v3 1/4] dt-bindings: clock: airoha: Add additional reset for PCIe PERSTOUT
Date: Sat, 27 Jun 2026 14:14:42 +0200
Message-ID: <20260627121450.3529133-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627121450.3529133-1-ansuelsmth@gmail.com>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
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

