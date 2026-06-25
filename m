Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CA37756C
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424682; cv=none; b=YTs8aLDLqBpAFl9gL86ehERZUHZK9th1rZ2twFvszLG7LkXiSSp7pCmQYXVWQ6jfAOpojLITIyOu/zQCJqVq/i7qR78mDNpyQbmZYUrEZJOkmXbaSWiQs13+vRGmvfNhG+I/Bc0lGXKFC8gG/LrHxQEneJiPxAi4drYvCUTJCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424682; c=relaxed/simple;
	bh=ZuNZE8rcXpZILcOaEBKLDnkP7uQZIoXjCu/kApiOj7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pESp0h06iTJWAnkaj3x6yGwod0A9MoyaSe7iHU8oA2tDwMxIKB0q6awdgpZsFrSxF9s9enQAS4la2YOavQRgqdqQmhZgrBZhj1QMF+4o5m3XEzpK4OT3Meug1p1EbKp3Ri5jM5EFZGGIR9qHpueb84FbHDXwC4utblLZ77DIssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSW/gAqE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSW/gAqE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4924593f45dso4383705e9.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424679; x=1783029479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E49Adk+rz41ma/ZabM7UStJxIriNv9H3xlG3UDtods8=;
        b=cSW/gAqE+L/J1Jm/7Dbcb4QcLx+DZDmo5LeW1VIln2ZMRQLu8F2pxJLAuY+TvRsNmC
         UTJBH2VDst0hEVGXCMAxE6Cj+j/ZORFQRLLYcdySYR1m7WzYrKhxVpY8iHZd7tsz117d
         WOzWElJAcWMlKir4mnG4l2jm2hJe1KhjMLfcdcCgw143g7S6E2OkC1Aj/wCUF0/4vPrN
         1OrZb+z1BaB9kh5UiJn9CuP6VuthtJL2P37imkXcLq3LmtFYnJDyw9pUpX17RX+Ozl3g
         MecAy/Lrsgxyoo63m87kV6/GmSayt6OBO3nAvSsaN//0ENHZNnjd9p8FbgXbmC5RG4SA
         9tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424679; x=1783029479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E49Adk+rz41ma/ZabM7UStJxIriNv9H3xlG3UDtods8=;
        b=dVQ+LLPj36MnlDxxmufZd1E/LJ+UDXxWyjueKQhAVJVf7DJ3wm+d79MY9+n809fXYp
         7DEaDZC/uhjSZMZ84XxQeE9sm2aJQjEUposMSjsliBen3GYvf/+MNSwrvn5rPGU8wS//
         tjCHmwCNsHipZSEPaFvti5lPgedgXI2VidJe3XtDCpsU4B69Crv6yT8wO2ikH1Cw49bu
         CcXSf3zqiJ1G7Bwxlitw4APjKSXfyQfD7KmdC0WkbwbVO8tuLkAmcxn64ebeaSZNntDG
         5yw9Tc2tip6fmNx1IIrDXlUB7p51Sgi+EfSNHPG9cbi0KCiNIR6CuDNEmrsZsVd09C0P
         jaZw==
X-Forwarded-Encrypted: i=1; AFNElJ8bdIBxcPcco+cD6zGT/vusUDgpStc1by5WRp+yWQDWzGhIkdvljrAxO5NvZzbqo5EohMtq14v3FAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARR3iSJXXp4VYbQFGfAb5uCvwMpoNFlzLJifAFX33L2Tkh5rU
	pCx27rvpW0XxXWF2ElXugDFcAd1R+smnXFEk+iUZ1ahwrR8axBtmxJe5
X-Gm-Gg: AfdE7cmrap7oBeutYzAu5PyLP/CORTdyApNWYX0beMFoiB5dAaVFeoZFusVBaho+XYz
	X9Pic6/kDj9QFMG2KPs+DY5K375Kwn9Ca4CbbDOB6eJ9n5L6Ejf9bLnrQDfQHHXwBwwZS5BvNMW
	clalT7+U2Nc9sDJ3OcgjQ1RS6rMDsf12fA7HTOfcRYunBr++bEwsriNfIKnbMnMa8zHYLNkUKgI
	PB9k3N5oNGUwet07eqwhnfA2WZQ18Pt/dz0UHOfUBNw9212rI94IImVgGmVB1Mtnu4NuE+/TgOQ
	N2XMCGhwsbDwxqnRJ//KhHizSlR+2dD8adi/zxhVOnPXngjdckH0W+muDJntTBLG5bP+WNXQURE
	Ljg2ozNsSrwTLLgke+ilcm94dsKpKvb8xfJASLKW58DDSDxdn7RauKVFxhcnxTqq0veY6dfMJhT
	T6ozkwcLDyU/Ufa3wUcBQR91UNAkMSv7FA7KEw4ja2Q1OHni0ZBMDG/McDdveZokP4d5uSg0DVE
	uPFhj3ER0Vn7JSpH7zamS4=
X-Received: by 2002:a05:600c:154a:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-49266881b0dmr61623945e9.21.1782424678463;
        Thu, 25 Jun 2026 14:57:58 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-80-183-219-152.pool80183.interbusiness.it. [80.183.219.152])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-492690988e0sm27339185e9.14.2026.06.25.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:57:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH 1/4] dt-bindings: clock: airoha: Add additional reset for PCIe PERSTOUT
Date: Thu, 25 Jun 2026 23:57:34 +0200
Message-ID: <20260625215741.3253212-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625215741.3253212-1-ansuelsmth@gmail.com>
References: <20260625215741.3253212-1-ansuelsmth@gmail.com>
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

