Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369C1C5D59;
	Mon, 18 May 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779065044; cv=none; b=FPfMmDsHMIR+kmp1ImZ/YGufpMX2lN0wttqSS28tyGIr8AyB+dMFSlm/m6br2SE3u0B/8+K79DyROvpcqJMi5y1upUdAaB4dxFsk8CX223DR8yVGCBD2E5YpDFk9Qsxrp+ZZAGviIvfqmgHa09eR76jb9WKLC3nvMEHFRptU06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779065044; c=relaxed/simple;
	bh=FGzBDwThUWkuoKwHocii3mtJMxt3D6WApYRlPWjuAZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+jSqeXsy+OiMbNHAKjQMtTxGWc9oF+J7hikA0QaC34I7oIW0RHk6bXRyXxp2lFv+9bjY39ghFYMFzuaoOPaJgbdJpYDU8nmgSVr4cgB8tjHAc9v9Lbg7RK3Ka4zMOLCT632Quv/u2WjVU5LQeVlHiPW9voAySgEJ6Sun5uGROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Kg0XnWrh; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kg0XnWrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dW
	IpNo104u5obDhE2dFSS+vTm/NpbYqoKeVdxuNBDUQ=; b=Kg0XnWrhG94E8cn/Lz
	/WyFaa3U0hSIji8sl2XD+x6cLiLCwlkvZY4Zilc6jonLn8xnjzGFLgYcSEeYH7I3
	UwlXEnQ7XdqPoTBtDvZmZb1djo7KEV/8cCl3I37cMvYSTTMhuJeQTXQLcFFi/Imj
	rXar4CEBKA8KbXesMHGuZZXFI=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnj6SIYApq2fikCA--.4779S8;
	Mon, 18 May 2026 08:42:58 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com,
	jingoohan1@gmail.com,
	thomas.petazzoni@bootlin.com,
	ryder.lee@mediatek.com,
	claudiu.beznea.uj@bp.renesas.com,
	mpillai@cadence.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 6/7] PCI: mediatek-gen3: Add 100 ms delay after link up
Date: Mon, 18 May 2026 08:42:45 +0800
Message-ID: <20260518004246.1384532-7-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518004246.1384532-1-18255117159@163.com>
References: <20260518004246.1384532-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnj6SIYApq2fikCA--.4779S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4kWw4fAw18WF4rJF1kZrb_yoWkKrcE9a
	yxZFWfZayjkrySkFnayFyrZr9Yy3s7Wr10qF4fKF13Aa48urn0qr9avryDAF4kGw43tF12
	yryqk3W8WrykCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKCJmDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBJZ-GoKYJIFsAAA3U

The MediaTek Gen3 PCIe host driver lacks the required 100 ms delay after
link training completes for speeds > 5.0 GT/s, as specified in PCIe r6.0
sec 6.6.1.

The driver already stores max_link_speed (from the device tree). After
mtk_pcie_startup_port() successfully brings up the link, call
pci_host_common_link_train_delay() to comply with the specification.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b0accd828589..5abddec4e9be 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -30,6 +30,7 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
+#include "pci-host-common.h"
 #include "../pci.h"
 
 #define PCIE_BASE_CFG_REG		0x14
@@ -570,6 +571,8 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		goto err_power_down_device;
 	}
 
+	pci_host_common_link_train_delay(pcie->max_link_speed);
+
 	return 0;
 
 err_power_down_device:
-- 
2.43.0

