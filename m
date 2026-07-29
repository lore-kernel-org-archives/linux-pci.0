Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE8388E43
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296719; cv=none; b=XZKWL9TJe8WaJlbpg4/w+rsdFn37Wsb5mK7uBePsALgRSDI9nve0ElN5eharp0XDl/vOpGU3RBpUFb5gfGhpyP7nFu/QoaX1o6HXj6D7cxSrYzBORzXtd3vnJTXpQ+P/dZ0v33hmbxZu6uIl0Mq3IHXkDc/xfOH4i/oCXy6DFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296719; c=relaxed/simple;
	bh=qNfNLPxECNmFuWopAFDdl/vjhAK7WhLmbXurnHjj138=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/1oaWeS+SC1kaUARrs9YHEn0l6/w7te19yK6XVKTedHuCPc+O6gfgwYdX+MXYP7N0Sqvq8d8YreOP6pO/Gv/KQCVMgDTcKSn4FucYyHip5pNVi7dR8jcgxFIlvhaUrtg5FGV/tgxCB9/jrrSfGdiKDMVXDQ0E3wFNzJX85OHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IP2cSr5s; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IP2cSr5s"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785296714; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=io43ZGzbyeokyokLcd0rhUgHGnqJaksNSlvHGwdOYho=;
	b=IP2cSr5s9MlDeP1TvZAV5iHd0s9cJ6WQpoGk3aIlIxB8HBM4lwMI7ge//RaHl+P1lh31TvCxKX2pjIfczlhTnZDWsjUTZixg6cYO+lLrenfeXVd2X383FktPBC696nNaRUHGVAn3wu4uAiPc2T9iLbTtmMPaWt93IJP29an8fx8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X80tmuO_1785296713;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X80tmuO_1785296713 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 11:45:13 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Kees Cook <kees@kernel.org>
Cc: linux-pci@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v1 1/2] PCI/bwctrl: Add pci_bwctrl_available()
Date: Wed, 29 Jul 2026 11:45:04 +0800
Message-ID: <20260729034505.469107-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260729034505.469107-1-kanie@linux.alibaba.com>
References: <20260729034505.469107-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the PCIe bandwidth controller sets the Link Bandwidth Management
Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
(LABIE) bits.  On some (typically old) platforms this has been observed to
cause boot hangs, e.g. commit 46a9f70e93ef ("PCI/bwctrl: Disable BW
controller on Intel P45 using a quirk") works around one such case with a
per-device quirk.

In preparation for a system-wide switch to turn the bandwidth controller
off, add pci_bwctrl_available() and pci_no_bwctrl(), mirroring
pci_aer_available()/pci_no_aer(), and consult the former when deciding
whether to enable PCIE_PORT_SERVICE_BWCTRL.

No functional change intended: the controller stays available by default.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/pci.h          |  4 ++++
 drivers/pci/pcie/bwctrl.c  | 12 ++++++++++++
 drivers/pci/pcie/portdrv.c |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..7a1d4f624ed8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1121,8 +1121,12 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 
 #ifdef CONFIG_PCIEPORTBUS
 void pcie_reset_lbms(struct pci_dev *port);
+void pci_no_bwctrl(void);
+bool pci_bwctrl_available(void);
 #else
 static inline void pcie_reset_lbms(struct pci_dev *port) {}
+static inline void pci_no_bwctrl(void) {}
+static inline bool pci_bwctrl_available(void) { return false; }
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c4c8d260bf96..947cb4b8697b 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -48,6 +48,18 @@ struct pcie_bwctrl_data {
 /* Prevent port removal during Link Speed changes. */
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
+static bool pcie_bwctrl_disable;
+
+void pci_no_bwctrl(void)
+{
+	pcie_bwctrl_disable = true;
+}
+
+bool pci_bwctrl_available(void)
+{
+	return !pcie_bwctrl_disable;
+}
+
 static bool pcie_valid_speed(enum pci_bus_speed speed)
 {
 	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2d6aa488fe7b..e212c34f7f4a 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -274,7 +274,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
 		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
-		    hweight8(dev->supported_speeds) > 1)
+		    hweight8(dev->supported_speeds) > 1 &&
+		    pci_bwctrl_available())
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
-- 
2.43.7

