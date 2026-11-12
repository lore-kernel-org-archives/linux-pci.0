Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453600;
	b=EUOVl6oT/7nnjKUHL247jDO8+zN2GbufO7cnCG52PsCpnkyTTN/Fxr+bq0Zt/X0sfnje
	 ahHWbexSF76P8HvoCXVkFfsRKf+bNMxiqzFoZspvfy6emBA8iOy6QzrYWgap2RPkMzS5q
	 G1XUt2eFMJrDdqyWyxO5Jzz0p4iCy9CfGdbo+YnlH/WJbfbr0fEBmCnT+LrGqI49xR1/V
	 uafTf0TudOQlq0EUKT70IM0sZOWXfSkhX18kXkxRSZtDjW/D3N4HyEqKyUvmE9BneNzNS
	 yh1LeNYx5HJJOkAXL00LFbEnO0XaB5FyknoKOsdH6U4wnl0Ok82lvB4CQF2BBwtcSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453600;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=giw4mW93rfat/G8zkpSBcz6EEoZBAskBreXvXku5LzI=;
	b=gcI7rlCuM40xdHT5cGqKBJ+LdFkrfeRXAqKKJQDCEtExmjzS2TbDtoNvCEM3l375fkrX
	 70pLBe1cdowOmvMD4RIjTGM8eoNXXD/31RgoClXTL1Le/3uxllkI9X55BNHi07h8CesoQ
	 rLSx/ey3baavEAAASHvtS6qt6eaVIPtp6u5qpLiiMn94pEdHjgEpZ1ki/T1Fcro7lGT/u
	 mBGNoasp0/MQUhTv9yYXuGqgk1O1W6ablP8KJ12oiR+V75N7wlkczj2TcdRqlh1nIBerj
	 zZxjWzErH4LLZdaA3Rp438xpmGdM6KddvVAwCYZROLPPHHWKHVONFJK/tB+3DkFNhMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SRinRKR7;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B3606A321;
	Thu, 12 Nov 2026 03:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SRinRKR7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gi
	w4mW93rfat/G8zkpSBcz6EEoZBAskBreXvXku5LzI=; b=SRinRKR7nIce2Ni26y
	l8XPA5iXwihcVcA4oO9OR0VLgmr+2cbMfm2ZIq+9UZp5udLtKDyhJ/q812dHGkle
	oYmSllFLBT6/hYNdbNvjw2w4n/HAlzWwl1Tpk55s09GnjQveLaoJJAHR3PeFFnv3
	DiTwTD1B0L6NkmArV0IXua3VU=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXD8o6MPVqh72fHQ--.23678S4;
	Thu, 12 Nov 2026 11:19:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 2/2] PCI/AER: Use pci_clear/set_config_dword to simplify code
Date: Thu, 12 Nov 2026 11:19:21 +0800
Message-ID: <20261112031921.1255661-3-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112031921.1255661-1-18255117159@163.com>
References: <20261112031921.1255661-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDXD8o6MPVqh72fHQ--.23678S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyDAFyxZr15CrWUGw1rZwb_yoW5Xw1xpF
	W3AFWfAr4UJF15ZrWkWa4kJwn5AF97t34fKr93Kwn5XF4UuFZrJ3savw1UJ345KFZ5Xryf
	Jws5Ka1rZF4UJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMyxRUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x4z1mr1MD4jTwAA3t

Replace manual read-modify-write sequences in multiple functions with
pci_clear/set_config_dword helper to reduce code duplication.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8708ca3257bb..7ce1cda8bc80 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -201,14 +201,12 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 static int disable_ecrc_checking(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 reg32;
 
 	if (!aer)
 		return -ENODEV;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
-	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
-	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
+	pci_clear_config_dword(dev, aer + PCI_ERR_CAP,
+			       PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
 
 	return 0;
 }
@@ -1272,15 +1270,12 @@ static bool find_source_device(struct pci_dev *parent,
 void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
-	u32 mask;
 
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
-	mask &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+	pci_clear_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+			       PCI_ERR_UNC_INTN);
 
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
-	mask &= ~PCI_ERR_COR_INTERNAL;
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+	pci_clear_config_dword(dev, aer + PCI_ERR_COR_MASK,
+			       PCI_ERR_COR_INTERNAL);
 }
 
 /*
@@ -1682,23 +1677,19 @@ static irqreturn_t aer_irq(int irq, void *context)
 static void aer_enable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+			     ROOT_PORT_INTR_ON_MESG_MASK);
 }
 
 static void aer_disable_irq(struct pci_dev *pdev)
 {
 	int aer = pdev->aer_cap;
-	u32 reg32;
 
 	/* Disable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_clear_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
+			       ROOT_PORT_INTR_ON_MESG_MASK);
 }
 
 static int clear_status_iter(struct pci_dev *dev, void *data)
-- 
2.43.0

