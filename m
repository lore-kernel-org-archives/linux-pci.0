Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C1361645;
	Sun, 15 Mar 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590475; cv=none; b=jzgMLU4KtdEjOlcbsyGdUel5+YALtIzCQhHjajVGT2lyxnZKiUUFxCOwNoBGsHIHCVkHcLkRUJNMvD42BI5/ZYEYJalDMaA30L/GLEFb9SUWVWX8fsuuFDLedBJ9l2czDLqx3umDQmF9sO4ixZXpWHn1AJDCgJ3ppH6kWDcVjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590475; c=relaxed/simple;
	bh=uO4av075UJqjg2cyXbeqJsA9Pn8zoxM+MYfcLyvbGKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhmzmEVF7XQfHYT5ll3Mx21J7ksR66LAPzCLc6qsWArC12I2w/4Q2LJ/GBClxIIZrgQ00j/eyx3tUPRzXVwvqG2S1Du3IPKiwA9qJZ62ttGUpzsNtQVNYmmuI8Il/P0se4JsollnAmQ8NypI2S3M7Tf2bKWXa1D+jUuX84dn09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HYWPuGJm; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HYWPuGJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kU
	x//bqMg4zEGGoKB97V8gg16VmSVOusKeTn74iwfEQ=; b=HYWPuGJmTKpOUYasye
	hEG+UHLd04VV4fGQOFoq714+xXs5vVzLrFemPu+jEzNyCOjqCIOil3WZx4kEYBDP
	FMwz1SKH6TnR6R/VYAfIe976TLD38cBHdIxJpiTR+GpsQVP4yuYSQqwdysBbvMFf
	aq4NLdlbjDHHpnwycEXL3RaOA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHvwy817ZpjnSYBA--.30374S4;
	Mon, 16 Mar 2026 00:01:03 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v1 2/3] PCI: Use to_pcie_link_speed() for link speed conversion
Date: Mon, 16 Mar 2026 00:00:56 +0800
Message-Id: <20260315160057.127639-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315160057.127639-1-18255117159@163.com>
References: <20260315160057.127639-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHvwy817ZpjnSYBA--.30374S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4fJr17WF1DXryUGw4xtFb_yoW8Xr45pa
	yUAw15Ar18Jw15Xrs5Z3WDWFy5X3ZakrWjkrZ3Was3XF47CrZ3Xa4Sq3yfJrySvrWDury7
	AF1akrnxAFW8JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKhF4OUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x8t0Gm217-foAAA3B

Replace direct array indexing with the to_pcie_link_speed() helper in
both the sysfs current_link_speed_show() function and the inline helper
__pcie_update_link_speed() in pci.h. This unifies link speed conversion
and prepares for hiding the pcie_link_speed array.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 drivers/pci/pci.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 16eaaf749ba9..c4231f3de5a6 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -235,7 +235,7 @@ static ssize_t current_link_speed_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
+	speed = to_pcie_link_speed(linkstat);
 
 	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 409aca7d737a..053fc245a1e3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -645,7 +645,7 @@ static inline void __pcie_update_link_speed(struct pci_bus *bus,
 					    enum pcie_link_change_reason reason,
 					    u16 linksta, u16 linksta2)
 {
-	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	bus->cur_bus_speed = to_pcie_link_speed(linksta);
 	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
 
 	trace_pcie_link_event(bus,
-- 
2.34.1

