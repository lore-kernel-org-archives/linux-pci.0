Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96E288505;
	Mon,  6 Apr 2026 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472469; cv=none; b=UtDiTDUKvXUnP9qHYQmgO+qd2OCQQ7NssPzqnOhAQ8JeosqpDfNqgsXkvkCbh7wmGGfKEkWUkq15oPS6fM8knf/dqjbJeCjrgaAvb0rLa9GUeFDautA5s58GmEc+K6f0G2NeIOWPaKM8LnQINi29rOsButphkKu13OduFCmEUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472469; c=relaxed/simple;
	bh=K5Y0PBLnucTW3zOL2uWce0Kl7pET+ylirq39OJDQdRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PU0EtFcUsoqw/HVPD/syGhjIlUjAoCWFNCgtej2mBEqPpGCntUQDLKNXKiLmgiLmqq11e3zft21CuFb1YTErBiXe27WNYLbtKtQ7Z+Ay6GmEDd+Z7KdnJYUndLDfj45F/Hw1VySPR03ucMS4ozE3j9Oby+r1OhJP2dAGMbGENQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=joq/718F; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="joq/718F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2A
	iyRk9VuZ8SjJ/3y8MHKB5yKl6vNqKwzPKLEYzjPaw=; b=joq/718FEvRJzjRIjH
	wYBmvGwRIzVgdk9bh3UFTHXTFtianlsUit7ovRriYXX8CLPsFObGJYImsGkBXK4L
	4RB/S4pPBziWoIdkgcmkdrVwULbIAxQ3nxWHIliLSyLfM4725Xprp7+3KgULJE5X
	kb+PziVzR41+2lhFdKGhCkhg4=
Received: from Precision-7960.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXX3Qwj9NpKHYUAA--.1246S3;
	Mon, 06 Apr 2026 18:47:18 +0800 (CST)
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
Subject: [PATCH v5 1/3] PCI: Add public pcie_valid_speed() for shared validation
Date: Mon,  6 Apr 2026 18:47:06 +0800
Message-Id: <20260406104708.1218648-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406104708.1218648-1-18255117159@163.com>
References: <20260406104708.1218648-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXX3Qwj9NpKHYUAA--.1246S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW5CF43uw45Xw15KF43trb_yoW8WrWxpa
	yDAFyYyF18Aa15XF4Dta18ZFy5uFZayrW0krW3u39xZF13A3s3Ja45tay8tryaqrWIvF1U
	Ja1YyF18Ca1jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRxnYrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BZA42nTjzb6zgAA3u

Extract the PCIe speed validation logic from bwctrl.c's static
pcie_valid_speed() into a public static inline function in pci.h.

This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
multiple drivers and functions, avoiding duplicate code and ensuring
validation consistency as per PCIe specifications.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h         | 5 +++++
 drivers/pci/pcie/bwctrl.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..f0a082bfd6f1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
 	 0)
 
+static inline bool pcie_valid_speed(enum pci_bus_speed speed)
+{
+	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
+}
+
 static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 {
 	switch (speed) {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c4c8d260bf96..ea82e326f164 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
 /* Prevent port removal during Link Speed changes. */
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
-static bool pcie_valid_speed(enum pci_bus_speed speed)
-{
-	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
-}
-
 static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
 {
 	static const u8 speed_conv[] = {
-- 
2.34.1

