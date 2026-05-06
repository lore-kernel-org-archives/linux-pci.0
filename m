Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358A3ED12D;
	Wed,  6 May 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081123; cv=none; b=eL3Xh6EmtA/kpebIVSG0UPmP38AT2AZWMH6a58IfEWpUaqhyijTkolvmN5UO/fQCaI/2GweL5eejo/nkciSebDqjQscOMSdfrDWe9PKTjyEoZxghYGoyfSGG0RVKEAdjrLVZ3h2lkZA9L+YARgUI0O9v7PC+DBe0ktyfB1ajWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081123; c=relaxed/simple;
	bh=hY++APyd3XZbnN5q3LQICWZ+d1vEmEnd5lJnusDw0jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StugWU9ER4aiZTUEHcJRCshR3d+z2PD5S4dDieoYjkcg6rW2yAGlni4P14EisbAQa0cYueRCY1enC0BGFk7IaOnDj67H1lo9osn/+b1WetzVPQ5uqsUV1VAgv8HD7gpU6XTNmNah97iI/XJ47xzzNcENrjmKN8QhHmSnj4HsiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hllE0yxF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hllE0yxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qC
	WWMFDSN/kOWR8DlFD6me9GCJ5creIxlg4thZxsX2U=; b=hllE0yxFT8/hsbJuSi
	2R7v+UgjAVdFGNBZ5Vp9+HdWrR3NGVK2rjNvfG10npkPNWUV1nU7v7Fh406x5nQk
	YjPykxbwcybUus+apz8TalWSYNz8gDgz/tSxlf/8ZfwLCpzYpGohHZtzV23NGo5F
	mHgKLs2cp4Krvtp6/Bgu2LBdo=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHAqsXXftpv5CgDg--.43926S3;
	Wed, 06 May 2026 23:24:10 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com,
	jingoohan1@gmail.com,
	thomas.petazzoni@bootlin.com,
	pali@kernel.org,
	ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	claudiu.beznea.uj@bp.renesas.com,
	mpillai@cadence.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/8] PCI: Add pcie_wait_after_link_train() helper
Date: Wed,  6 May 2026 23:23:39 +0800
Message-Id: <20260506152346.166056-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506152346.166056-1-18255117159@163.com>
References: <20260506152346.166056-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHAqsXXftpv5CgDg--.43926S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr15uw48KF43tFWkXr4kXrb_yoW8Xw45pa
	93CF10kr48XFy3Xws3Ja43WFyYvan3Kay7GrZ7G347KFy7J3W3tF40g3y3Wrnaqrs5Zr13
	Jw15Kw17CF4YkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pif-BAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBq2Wmn7XRo4wQAA3e

PCIe r6.0, sec 6.6.1 (Conventional Reset) requires that for a Downstream
Port supporting Link speeds greater than 5.0 GT/s, software must wait a
minimum of 100 ms after Link training completes before sending any
Configuration Request.

Introduce a static inline helper pcie_wait_after_link_train() that checks
the given max_link_speed (2 = 5.0 GT/s, 3 = 8.0 GT/s, etc.) and calls
msleep(100) only when the speed is greater than 5.0 GT/s. The helper uses
the existing PCIE_RESET_CONFIG_WAIT_MS macro defined in pci.h.

This allows multiple host controller drivers to share the same mandatory
delay without duplicating the logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..a8705a2a2d85 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -60,6 +60,19 @@ struct pcie_tlp_log;
  */
 #define PCIE_RESET_CONFIG_WAIT_MS	100
 
+/**
+ * pcie_wait_after_link_train - Wait 100 ms if link speed > 5 GT/s
+ * @max_link_speed: the maximum link speed (2 = 5.0 GT/s, 3 = 8.0 GT/s, ...)
+ *
+ * Must be called after Link training completes and before the first
+ * Configuration Request is sent.
+ */
+static inline void pcie_wait_after_link_train(int max_link_speed)
+{
+	if (max_link_speed > 2)
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+}
+
 /* Parameters for the waiting for link up routine */
 #define PCIE_LINK_WAIT_MAX_RETRIES	10
 #define PCIE_LINK_WAIT_SLEEP_MS		90
-- 
2.34.1

