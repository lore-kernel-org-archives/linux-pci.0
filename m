Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B83932CE;
	Tue,  7 Apr 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567147; cv=none; b=HpqcYki/jIhfTfUJBwGWaBSRKfrLFt58UoKmS+HqjeCtBQzY3jJhfufoQt8+SHAM4ZucCXbJf/3rNQWc/n7vJGtH/SBJgLZxOkY/VDXPJLTZo69WbAoJwiZ5vjl76OteFFerZAuOGYuBlrKEKyWhcWYMLMsr4+r0ikQpbHxfGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567147; c=relaxed/simple;
	bh=aV4/PfQ0MMsxmwGCANhfhW0+XLmKLLxwbvgZJ3/pe+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGkpN/sxwi3uM2X/22xqCJVCw7RPYEWcZBHh3tkGB52JCnGydhCrRPbXj1sta41vxBVBp2qRVjsv+JrOYtXYsCxOWr1LPjK4AtGtnn5fm/RsvzdV8n8DFz0Qbg1wuAVsW1uz8A/s58EjccrrlSCqvaBy+wdzc8ddTDnEmZemVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B1GcZFqB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B1GcZFqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+2
	NxNNebefVVPcox12b5aqVRfl/zr6eJpvMHbIcrZV4=; b=B1GcZFqBPQEwyutQxJ
	yfZf9DB6XS5opaMvzuftkqjn5Ske5fdy3WmYDBQvVSjN5HiyEnfkszqerENkKblv
	goFjjaaey3DLFjTVP/gNU3nkM9rvZzUjtWzyrem8TQ5g0BX5P86bkt8D/ul7ZOIt
	WSdXkccfRY1Y7Ae428o87Dx98=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC33bQHAdVpBqSeDg--.5276S4;
	Tue, 07 Apr 2026 21:05:15 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 2/3] PCI: Move pci_bus_speed2lnkctl2() to public header
Date: Tue,  7 Apr 2026 21:04:49 +0800
Message-Id: <20260407130450.1489318-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407130450.1489318-1-18255117159@163.com>
References: <20260407130450.1489318-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC33bQHAdVpBqSeDg--.5276S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF48JFWUJw1fCry8Cw17ZFb_yoW5XF4rpa
	9xCFy5AF18Aw13AFZ0g3Wvqa45XFn3JFWUCrW3W395XFyay3s5Ga42vrWFyryaqrW0kry8
	J3WUJF48C3WUtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piNzV5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwsStWnVAQvN+QAA3t

Move the static array-based pci_bus_speed2lnkctl2() function from
bwctrl.c to pci.h as a public inline function.

This provides efficient O(1) speed-to-LNKCTL2 value conversion using
static array lookup, maintaining optimal performance while enabling
code reuse by other PCIe drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/pci.h         | 18 ++++++++++++++++++
 drivers/pci/pcie/bwctrl.c | 17 -----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f0a082bfd6f1..e0c2630e93f2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,7 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <asm/bug.h>
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/pci.h>
@@ -611,6 +612,23 @@ static inline bool pcie_valid_speed(enum pci_bus_speed speed)
 	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
 }
 
+static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
+{
+	static const u8 speed_conv[] = {
+		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
+		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
+		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
+		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
+		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
+		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
+	};
+
+	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
+		return 0;
+
+	return speed_conv[speed];
+}
+
 static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 {
 	switch (speed) {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index ea82e326f164..d48021bfd844 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -48,23 +48,6 @@ struct pcie_bwctrl_data {
 /* Prevent port removal during Link Speed changes. */
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
-static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
-{
-	static const u8 speed_conv[] = {
-		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
-		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
-		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
-		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
-		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
-		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
-	};
-
-	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
-		return 0;
-
-	return speed_conv[speed];
-}
-
 static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
 {
 	return __fls(supported_speeds);
-- 
2.34.1

