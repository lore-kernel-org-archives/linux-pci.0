Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824536F913
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618667; cv=none; b=aDWpONp02uAsNfXX2laDGVjTREL3LqgZAXJ2VZnmXtdaXnRxD46sODRWQpXm+IKJXEweVPNG0a0kEa959g5Wm+NjWWH/aXveXL9lA+5Rs4tJa5nylUEOU/b1tIIIb9Y/MYGqx0OYxHa7qZWcVVYzI1+I9A3t1SwejPqkgN+FTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618667; c=relaxed/simple;
	bh=AQ2Ix6wZ9CuZJ5qiUzlv0dc8MusU8jMkixx6Xsdc7+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j51Jb55iU0VaiMQXL9m6uakFKsMWaaX2UNpslI4x3PqqZ/G/u9GP+laDEHOyQMDXqXD8SdmstUSvkGHtqxbCZKyJQKUng7nVGtmq8gC1gvsKAgvmHuIlTgYCCt7VqXtQnzHpgjPmroddg/IGcUK1GjFHhFZykU78khuLARzx/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhfjSe/1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhfjSe/1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba1e9d3687so39525105ad.3
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778618665; x=1779223465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkLWxlipTbno6JmfDZI2+Pv9Jj+k0EY4YY+b4Wubtu4=;
        b=JhfjSe/1hjbtdtf+Y6fapp8REXZOBGbAnxhBti6v0DtU5/oCFg1lxJSnQ8zkhSV7UR
         XHET/8NDB5DC9gw33gY0TxESne2FPLSd7cEp3Ny409jzGZV+voQ93DjGEErdb8EPFbfT
         tROpUgTMRLtjqKhzts2pibHihXPpjyZKUKjTkPyE9+QfiuVL1y1rHFAfNPzldOu9kdza
         0ccbq49VCafHtov0Zj3P5qcrLXoHNIuZfkRoLah2necSR0Q8TXT6ce5KZrr/VNXWBeBl
         8zQALA9oZnXs40Ok2/Pvuz46LGIbLCN8amjjy6dL1as1/5AmpAPvJErvA55z6z1C5alG
         Bj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618665; x=1779223465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkLWxlipTbno6JmfDZI2+Pv9Jj+k0EY4YY+b4Wubtu4=;
        b=aXfVTr5VPfujkgh7qbLC0iqBPd0bmeT9SQLeXwEE/bzSo0yXh5WNG1gbiZSIM8DpxX
         7cdFRjEs8CjL+sg8YChPGJ32iSLxsEMMUYALucQoc3fT/W52jGa9zmFWrasDqTOqhdga
         WGbjpYyqsVEaAbGifBlyW2npIdpim2xl6cn+ZjbORC2qNILGbeLGvcke25rr52CZ2GWJ
         DuDSGPdwx3JiH6dFHvxOA5lYpkw5xB0vCwWcCk6WdWOkp6GhszuRNG5+o6sat+uUgkRF
         PqT570olwbUO8Bds7s2BERxHzS7TSsaKHU6z7TM3XyhgNImd4B5Itd2lpGLfhPg6ZQgO
         hxpA==
X-Gm-Message-State: AOJu0YyQ0kwAwPOMEMJPAUQ6oLLjeBns8TAXb3oAfbcx4VdH0n/cNw69
	q2dNziX9r+H7xp0pIiNTzoPk/iLehh7nu19w45ajFdH9a9ebiEjp8lwPqEsVP1f3
X-Gm-Gg: Acq92OFegGMBst2NaUSr+uAprGzLEEyWYBVj/CPU+ggEsmpczkGAwaysodPo2JdjbTj
	mdpGPfXFyV1Ipn8n0ePgRvH6jwVPmuscQJXRM8HmGFt4NdesX1ZMb+mC79HYEbLwIshYLxfKpaN
	t0oAulUzOsZf84mg6uNPv3+qBlrTiShwEO1QwTYNQXn/DaPnV3ZzLkiTkkKLG67TRsVo/YmtSpZ
	wo3iB0jRwCBDvlV6gBr57CF5SCMEBL05mRzamX/tqdixT1otpHBUfBcUSp1nMqGst1m2Sq9gF7o
	ERLH9JI34vV+GFnpPprSazd3R6uWyQ2JXJNi9bQoBCka6rDb+/wp8wrSRUeIG2T2yVeCtzQVPND
	R1tUn1+ehuH4uTKe9MZtfN4clTLWORpmAvJTWfN+7DA5QfG0HvOjYHznm31Gfk7Dp+ZvonoDRtK
	X/1UCKXn7SjhTzSZDkrLlo206vh+kkYWnJ0BdWnND7825YPvqsoYpQo+9a24Jr/hyMCLTtPXoV+
	hAUnZH7kdgt4CMs2AAIqXRhNZO/MUwzRRVmoYP/UKkwXg==
X-Received: by 2002:a17:902:f647:b0:2b9:87e0:1f80 with SMTP id d9443c01a7336-2bd274ab163mr5480965ad.24.1778618665328;
        Tue, 12 May 2026 13:44:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27049sm145221315ad.7.2026.05.12.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:44:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR MVEBU (Marvell Armada 370 and Ar...),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: mvebu: Use fixed-width interrupt masks
Date: Tue, 12 May 2026 13:44:07 -0700
Message-ID: <20260512204407.39753-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use u32-typed BIT and GENMASK helpers for PCIe interrupt register
masks.  This keeps inverted masks in the same width as the registers
and avoids truncation warnings on 64-bit compile-test builds.

Drop the unused sys_to_pcie() helper while touching the same area; it
references stale ARM pci_sys_data glue and has no callers.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pci/controller/pci-mvebu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index e568528bad85..da43661792e8 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -57,9 +57,9 @@
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
 #define PCIE_INT_UNMASK_OFF	0x1910
-#define  PCIE_INT_INTX(i)		BIT(24+i)
-#define  PCIE_INT_PM_PME		BIT(28)
-#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
+#define  PCIE_INT_INTX(i)		BIT_U32(24 + (i))
+#define  PCIE_INT_PM_PME		BIT_U32(28)
+#define  PCIE_INT_ALL_MASK		GENMASK_U32(31, 0)
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
 #define  PCIE_CTRL_RC_MODE		BIT(1)
@@ -950,11 +950,6 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	return pci_bridge_emul_init(bridge, bridge_flags);
 }
 
-static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
-{
-	return sys->private_data;
-}
-
 static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
 						    struct pci_bus *bus,
 						    int devfn)
-- 
2.54.0

