Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D012E974D;
	Mon,  6 Apr 2026 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473017; cv=none; b=a5dVepEOic09nX3hCfDGLQwJ4WDeXdybyW2DAhIe+yl6tQPuJahgx9d0ck0xTLrQxayrQYvFk2NpYxsZq1kILgvF4sfjjKoml6UzRAs4kvFAhXfe7lxF7mYdnR1icdAZP3wJLQQMRke0bt7H8p1PEmphTKpUqBzDxJMxLka5k2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473017; c=relaxed/simple;
	bh=CZU1bAFSf9JlR9KB4yeMbb8I48frV5NXpXIIz97ppHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1BRxKwFGnSAMq2K2ZdQcjgrWFw0Fc5pJUQuNjwES+b0h9HcBb83vmZSvATlOrkmC/llBGOAXaVREskFgzmOALgAlgCoPHO+cpmMMcrDQ2nqQJwUyyCITIpYvbNWAaPlz10hYHRf9P1/CMGbmLb+1kfobEpqdQp/eahZlcJreJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YcEX5Miq; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YcEX5Miq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6m
	MCrDR47EQMAbgME22s7g/ZL+FO83j+pRNlGGThkDM=; b=YcEX5MiqnPIz7H36Fw
	/y4x0B8dOahSm6dUYuIiaNDmsevjh5tZe/ejtq5h3goeCUZJTpM4llfDZK61GVUQ
	SUAFFVlga8Khj3+VW4TwspBd+QKiqhowTvvd39RUHVl2fQmnX/ARtRResaKxvsVF
	EvvoLiIfg6yZNwvDyzcI6BYEA=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC37wJQkdNpmdyZDg--.25057S4;
	Mon, 06 Apr 2026 18:56:18 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v6 2/3] PCI: Move pci_bus_speed2lnkctl2() to public header
Date: Mon,  6 Apr 2026 18:56:12 +0800
Message-Id: <20260406105613.1228673-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406105613.1228673-1-18255117159@163.com>
References: <20260406105613.1228673-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC37wJQkdNpmdyZDg--.25057S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4UCw4ktF48ury7Kw1kAFb_yoW5JFy7pa
	9xCFy5AF18A3W3AFZ0g3WkXa45XFn3GFWUCr43W393XFy3A395Ga4ayFWFvryaqrW0kryr
	J3WUJF48C3WUKF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piiF4iUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBPHa2nTkVMHoQAA3l

Move the static array-based pci_bus_speed2lnkctl2() function from
bwctrl.c to pci.h as a public inline function.

This provides efficient O(1) speed-to-LNKCTL2 value conversion using
static array lookup, maintaining optimal performance while enabling
code reuse by other PCIe drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h         | 17 +++++++++++++++++
 drivers/pci/pcie/bwctrl.c | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f0a082bfd6f1..db91878a86ac 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -611,6 +611,23 @@ static inline bool pcie_valid_speed(enum pci_bus_speed speed)
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

