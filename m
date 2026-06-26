Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88553E959C
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465649; cv=none; b=TfC0uE8o9bDabmT17CsuAQl0ANW/pksEBWGY61HRnWiJXsoc4cNKHdf6Do6QBU9TGXlxMq5XpOoyb/l5nE6eAEF5db3afSj2qX0s8PrV5DMDRsgjL9hWyc/Gi5rpaEJCDw3UJyBPBbc8b9o6W84l5hCGg5h4/vKIhvsoWjrOLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465649; c=relaxed/simple;
	bh=ZuNZE8rcXpZILcOaEBKLDnkP7uQZIoXjCu/kApiOj7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXkuqDwoOAOnohcc9sOg/7k8GtR5qkpNQ6Kk686seTC/CENFxwYVjfm8F0H/g+cDQY/YyRT2v2foC7QmipfWuSrFfbhvosCd2C5jDj6QIVnLmX8+fUhFdtb6p3FU/n5pTdtZeWG2tzrf7UmseeOy4Evo01UFQnb5sSx7MCuoocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmwn+f+h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmwn+f+h"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so6966355e9.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782465645; x=1783070445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E49Adk+rz41ma/ZabM7UStJxIriNv9H3xlG3UDtods8=;
        b=Tmwn+f+hQLjT613ft4JfBaBwQNbRP2Ksy0+mh6WwztCeTSm+/2/I3DE4SmNH3X75G9
         +TCizRPIIxrdzi6Ihdg3FRlAr1ZGCndG9ev/oAZOSY/70Q/vxJdZjBtQkHTLkgfH25y6
         j7zYwWclwZVZH2VXCyvMq6itKa+66k0GaxEndBfCtDXvii+n7VZ3xBDxiLCQq15K2TpJ
         R8xKwQyHZbLOJ9vNUFd+99hp1cMRrFgfdE9rFMD4/bksOCJdJiebtSUwZeg+0oYupmt2
         INsVsYtd8hzTGIjkpigJmKhep8vdch43Yzt7ZPPB0PtIFsm10UX9tIFN0ns6dbXpPZz2
         ef/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782465645; x=1783070445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E49Adk+rz41ma/ZabM7UStJxIriNv9H3xlG3UDtods8=;
        b=dh4HQI93SS4RZWR9TdHPfeUTwuyI2Hjw44GXiXVS/1D9VM7wbN7hqG4shGNHMDIHoL
         h+LE3xCIRQ84wCIpSKKrIU/EERK+1YkHNhmhMj6pG9zGw1EA/s/lWuvwa7ZuMaSIF0+N
         kpP0xvfBKj1HqzIm2r3voQDX6lvpqJmP5jvQUsPJJEmvHumLdOH0IKfyfaOUB7U7cyg/
         poERnT8HSSrtvC+l8TEmvzuiadGsD53lsUkFiwPxtiWjVLNFDLCVitdkwI6rgWvi/FDK
         jLllIy0URBpjDUKrZ6m9GlsUROvLe3E9Wr+9shRTyqNFJFl9miH/Se5RQUG1Zv2dLU9u
         U1ZA==
X-Forwarded-Encrypted: i=1; AFNElJ//M1C2qkvOvheSJQ5WV7eRUfrLKdhjr3ybSonoy1C/UKTv2h8A4NHDZrZnsdSc78z4dTVwitQcWHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrObZDBl8UAbbWgDDr/kUedfqgd44+DLqDnLOo2TMnX3wfp8y
	EwBqxKkswEKQYh2yHfp3IMLNBnM5zOyhTrHXlAKHf3qOmmqd5PF0Ud0y
X-Gm-Gg: AfdE7cl+LY4WDUeIQ89AoegQRO3613cR/FaVI428Yat/ZS3OTja6d1YQngMQ2BUHOZ2
	pcIkjkRUbwxvorq3UfBpzJwrM56FpcQNhFaX5JEu+nH06Uz4Ni2kilg1NVa67W77xIPI7fOyc3O
	kX7JB5lvCjCNpHw09VllQoYeDX9wu3XR/41MvbjnHBI92xyRnqiCz9npVkQYs5+qY7Jv50a0VSB
	tWG+T2dKRtqlzVysab4CEQyghLwcIN49yEU1B68GJTPIldN4IAgSfzpjLptFBeHXgityBSPTkrV
	3XDzqFZ8RxQgyAXw2tmoxT0MVlVjQlO/IStsiXvPw6/xwL4UsdOsMeUTmGMAxQjisvjXf8r9sCM
	JaJDcST8yRfGqyan8F/KJY0b7Qamt5hcnck58fjIv78cf7XLTJgFFtYeEjRh7g5WaZFKzT79SY8
	9QqrEPDjyqtVA9+46+lCQooacSPMcInJDoQPKbTwaboz4qnik9D349yVN8V1tz9hy9psllmgwn2
	qT9a1YpgKej
X-Received: by 2002:a05:600c:1c05:b0:490:ea8a:32da with SMTP id 5b1f17b1804b1-4926689ee78mr79972515e9.26.1782465644046;
        Fri, 26 Jun 2026 02:20:44 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-80-183-219-152.pool80183.interbusiness.it. [80.183.219.152])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46e6167c05fsm9094388f8f.25.2026.06.26.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:20:43 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: clock: airoha: Add additional reset for PCIe PERSTOUT
Date: Fri, 26 Jun 2026 11:20:25 +0200
Message-ID: <20260626092029.3525264-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626092029.3525264-1-ansuelsmth@gmail.com>
References: <20260626092029.3525264-1-ansuelsmth@gmail.com>
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

