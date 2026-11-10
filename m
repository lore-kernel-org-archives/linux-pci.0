Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288854;
	b=FDD8cdcs9+yWbajuK1i+3M/BX2BwmLH9A9gKaY78uckhicoza96nj/4krRMXHTxPY7pC
	 A/91YMfl9kAMOh1eRLcdv1e8M7CyiTw5q45iayzpoCgNcAu5eRPFGS/CCt++Ls1Vx15gT
	 AIOi292ybw/6ymCq5GP4d1cIue81pyfLkEWebZm6y9ciKNt9b5v0+NKOTlw4mHQJDs0tN
	 NA01jjs3xBWkxK91Bym7eNza/YGBhoGxdc4rCPmMijX8f2fhl7FHQq0PU85T03/v3FqsB
	 EyTOKOGC4aq2221W/JtmffpurxPxBhy7ZyYVWmDnvUDap82Ouy5/AhDFdHDIH1HwRcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288854;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=CKdq3KVUX5IawGO3TabSH77SERmgWRGQiF/Gn51KHMQ=;
	b=IVOzXN82BMtPqRkZX5YSysDI9yvVjNyS8Q0WIJzPjHTuStnwhaG5pisgKESKUTtg/gFa
	 BT1phBfq9DvofzWfbukL78sQ7vy/Nt89kIEJxjeld44BLyuNB0TVge/8yAWyCDL+WA6Ai
	 EJAZH+lyXk1qmyNjbcSz27oJk9yM1fsrW9gJUWBhCUI46vzQ8MnwpB71dW0E2kF3nMa5R
	 w/fSM0gqE+eIFHNbvYPG47dJQ29rlKHhf44sYV1/zwqABYuR19g99s3JBMDozrTKYM1Gc
	 hiYsWWHVUCTV8YekYgyokk7LDjjawOmzWDU1e3gGZ32tmqUUmxmEgM6O+87f8Dlb+OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=QsKgoz5L;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9D7A6606A338;
	Tue, 10 Nov 2026 05:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D7A6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=QsKgoz5L
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Frank Li
	<Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI: Only restore state that was successfully saved around a reset
Date: Tue, 10 Nov 2026 13:33:47 +0800
Message-ID: <20261110053348.2419-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794288842;
	bh=CKdq3KVUX5IawGO3TabSH77SERmgWRGQiF/Gn51KHMQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=QsKgoz5LTAF9cKU6wcoJdDhl5nXCsX+IdvGthMzmFh/zc7dd3GuHaVPE1RN709WWB
	 let+nts8uCzpBPC9Y7HSoBhSSkCGqy7bryQxPrEUChNXQlsbUvvD6eXBaBAdhHtXtj
	 hMhbg1CdLFLpRNYsKfHb+0i6xP9AtozQfJzUbwroNSrzqBRZtrFAYx2m/11+cWMeaq
	 azd9dhwmuGaU1L61kbx8VTG/hDAJZL6i35B08ksVWSsjst/B00xPOyBt5WLSWfHWLr
	 /Kd4Wz2rfFz/rHcdBIwUK+EcswCn5OYk+zIiaQ+owUDxjNcD7KCUGGekPuxu+QGTig
	 Q1HEVOVHrLrmg==

From: Li RongQing <lirongqing@baidu.com>

pci_dev_save_and_disable() returns early when config space is inaccessible,
without saving anything, but pci_dev_restore() calls pci_restore_state()
unconditionally and pci_restore_state() does not look at state_saved. After
the reset makes config space accessible again, the all-zero or stale
saved_config_space[] array is written back to the device, clearing Command,
BARs and, for bridges, the bus number registers.

Clear state_saved when the save is skipped and only restore when a state
was saved.

Fixes: e18d1abc3bff ("PCI: Avoid saving config space state if inaccessible")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 67fe565..ddb86dd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5156,8 +5156,10 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
-	if (!pci_dev_config_accessible(dev, "save state"))
+	if (!pci_dev_config_accessible(dev, "save state")) {
+		dev->state_saved = false;
 		return;
+	}
 
 	pci_save_state(dev);
 	/*
@@ -5175,7 +5177,8 @@ static void pci_dev_restore(struct pci_dev *dev)
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
 
-	pci_restore_state(dev);
+	if (dev->state_saved)
+		pci_restore_state(dev);
 
 	/*
 	 * dev->driver->err_handler->reset_done() is protected against
-- 
2.9.4

