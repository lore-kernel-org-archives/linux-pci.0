Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794130882;
	b=DzbsqRmNw9NPxjC1kyqkIRyH6gEZwYHmZalpVCjvaykAjjVIs4+MpL0k2d1syS4aqHzF
	 y/70ECJjqbISH8F3fcVX/l5UXjCf+wUkPkygsqgii9QEI5m9GbIaYH5cfDXix6dpL49Nu
	 My+S/NqdL5lHi7BUvrkTN/WbHQ6JBlwJ21vxKWT4kHgQK+VXDPn3d0FeVI0EdgdYyI0tL
	 f5573SLJfHex5I5ByUM5oA1Uyq3RBRI92u0GILkcjSS24JHNyaaZZyZZZWs6dtXCogcd2
	 J922tc+WRss0HJXvxZEeUMCxFi366Iy0qz1ECWr+w+XJ52VCPFglsYzeksKGZdf1tnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794130882;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=/KxXKEws25lbYq+kwCpBubXmc4sMnnIfEYvw+09RsbI=;
	b=ZWuMgL0W//Nw6J2HSogOxZ3sjZ4lJoIEN1BMdDlBFNLqtcM8J2/0UnigHKeXZ3pUgDYw
	 tX+P0D6FjbNXR306WojWARShGqwYBrtJzArUO7T+yDPOI/I+1/ydtKFD01/LFgHlVC7E8
	 pi4yo/gOe0n68BMpbBse/dG8nYWw6uib5tfh8oP88s09iODRD32Hh5jSlRgoczhndKlU7
	 dC4+Ez7WgL/wMHQvlFFzLPgcmyFi2WA8saiCBKrpKXmvKqKV9C/9CwYBx/xUs7/izGl1J
	 +eJ00zOVC7nv24uB7aIoIrVGRSdbDn23VumZ1/2rdlJS25KFyaRfU7Xfk7CgSmFldtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="Mr2fniX/";
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E10606A331;
	Sun,  8 Nov 2026 09:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68E10606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Mr2fniX/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/K
	xXKEws25lbYq+kwCpBubXmc4sMnnIfEYvw+09RsbI=; b=Mr2fniX/r6LBlZr5HY
	087fmzP0ypN5YWE2gUcQ5nOvDf4uJaZUQ62wmKF4rQux9/IApDbzuDvndQC6yeMX
	pfM3MASHzrVScxyjqs4l8A4m9uXGUe7yGfm2DDm7U6d6KHnlc5rDT8yUP3rngsNk
	z9mX6/O8shmMQyB6AbVgHadmg=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXz8OTQ_BquUg4GA--.62891S7;
	Sun, 08 Nov 2026 17:40:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	thierry.reding@kernel.org,
	ryder.lee@mediatek.com,
	jonathanh@nvidia.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 5/5] PCI: Make pcie_link_speed[] private to probe.c
Date: Sun,  8 Nov 2026 17:40:34 +0800
Message-ID: <20261108094034.679945-6-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108094034.679945-1-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXz8OTQ_BquUg4GA--.62891S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkur17JrWfuw4DGF43trb_yoW8XFyxpF
	ZxJr40yr10q3W5WrZ8Xay8uFy5J3ZxCFW2krW2g393ZFy3Jr9xXrWa93yfJr9Ivrs29rW3
	XFnxJr1jya17twUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xrNcWrwQ5rwXAAA3i

pcie_get_link_speed() is now the only accessor for pcie_link_speed[].
Make the array static and remove its extern declaration and export so no
other code can index it directly.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h   | 1 -
 drivers/pci/probe.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5441741bc330..04bdf3b86a56 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -118,7 +118,6 @@ struct pcie_tlp_log;
 #define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
-extern const unsigned char pcie_link_speed[];
 unsigned char pcie_get_link_speed(unsigned int speed);
 
 extern bool pci_early_dump;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d0283a8158f2..f79b048f45a4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -756,7 +756,7 @@ static const unsigned char pcix_bus_speed[] = {
 };
 
 /* Indexed by PCI_EXP_LNKCAP_SLS, PCI_EXP_LNKSTA_CLS */
-const unsigned char pcie_link_speed[] = {
+static const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCIE_SPEED_2_5GT,		/* 1 */
 	PCIE_SPEED_5_0GT,		/* 2 */
@@ -774,7 +774,6 @@ const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* E */
 	PCI_SPEED_UNKNOWN		/* F */
 };
-EXPORT_SYMBOL_GPL(pcie_link_speed);
 
 /**
  * pcie_get_link_speed - Get speed value from PCIe generation number
-- 
2.43.0

