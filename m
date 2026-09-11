Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7A39A80E;
	Fri, 11 Sep 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144019; cv=none; b=YO2vA+FxazBzn3e85NUaMlczDxw21tEmJeZ7JSx5SbdUfWjMgalbBoNmGKCQOa3YMAvbliZsdRy57sghWKArAUxj7E+r6A2O3ghNo8Nzyx9p7iWQww7rXmD8iTSrVraK1p/XVCnPgLyFMNP5G4CeOBSG/hI1Dgd/l+Atxt1QHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144019; c=relaxed/simple;
	bh=mLib11bR0zb492wgsKCsdA2w8KV5zHeVt4dNrZA/KUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKb/unsUFnpJ7N1MNiTQ9idNoWlhfV3630RpjcmpMq1XpCwcTodXVqAyb7xdHkTfmHEG/CLvkrWL3/LxKCReUENGj5m8K+vsuMgcKovB8ZGGp39rpts4l8i93ToOSsBPkKXV+aHd9sCKLL0E2RrLOeBmqeJLTOaBAIr5LQAEQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I1JbfeIq; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I1JbfeIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=AP
	2ZJ8lX7rjvH1moWpuOMtPTfzrXU1f6x/jsrt9JHRY=; b=I1JbfeIqmOhC6zPCKA
	3VgmaHpx0x08GFT2XDhXIJiXyFC7db7GVo+zleDFwnqG+mPgp81Uxc038TtS5oIf
	MZh6zzdsoWjUqoUN237vuGDNQqxcYah1qdGLxann68zVKU9zSXc2B+pxNiG4itiJ
	/5oIEgLBdGZNjbHPfdAeNmn0U=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnDy6JK6RqMNRdAA--.33660S4;
	Sat, 12 Sep 2026 00:25:49 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/2] PCI: dwc: Remove unused PCIE_ATU_UNR_* register definitions
Date: Sat, 12 Sep 2026 00:25:37 +0800
Message-Id: <20260911162537.469018-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911162537.469018-1-18255117159@163.com>
References: <20260911162537.469018-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDy6JK6RqMNRdAA--.33660S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1rWr17uw4kXFWxZFWDurg_yoW8Gw4kpa
	45XFWIyFn8Ja17uw4rtrn5CF13tFsrGrWUG39xKwsru3Wavw18Jry0vF4Sgry2qrW8Kw4a
	v3W3X347WrWkCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMg4SnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCww6xVWqkK45HcwAA32

The PCIE_ATU_UNR_* macros are not used anywhere in the kernel.  They
were presumably intended for unrolled iATU register access, but the
driver now uses the ATU_* macros and computes unrolled offsets via
ATU_UNROLL_BASE().

Remove these unused definitions. No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 10bf06427e41..89cb809e056b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -257,18 +257,6 @@
 #define MARGINING_MAXLANES			GENMASK(20, 16)
 #define MARGINING_SAMPLE_RATE_TIMING		GENMASK(13, 8)
 #define MARGINING_SAMPLE_RATE_VOLTAGE		GENMASK(5, 0)
-/*
- * iATU Unroll-specific register definitions
- * From 4.80 core version the address translation will be made by unroll
- */
-#define PCIE_ATU_UNR_REGION_CTRL1	0x00
-#define PCIE_ATU_UNR_REGION_CTRL2	0x04
-#define PCIE_ATU_UNR_LOWER_BASE		0x08
-#define PCIE_ATU_UNR_UPPER_BASE		0x0C
-#define PCIE_ATU_UNR_LOWER_LIMIT	0x10
-#define PCIE_ATU_UNR_LOWER_TARGET	0x14
-#define PCIE_ATU_UNR_UPPER_TARGET	0x18
-#define PCIE_ATU_UNR_UPPER_LIMIT	0x20
 
 /*
  * RAS-DES register definitions
-- 
2.34.1

