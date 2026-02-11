Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com [45.254.49.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D8314D07;
	Wed, 11 Feb 2026 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810884; cv=none; b=CEZEXMJ8yky7ayCqPjT1HQpipAaVpzKeS2EvYKggt5HJ5MMVjVEKI6B3wE1TKe+Yco5uM+3b/CnBEy1qsiSXMascABsii3x+71AiHqkVAFQvJIV+lF/TSoNxMMa3W646yOvpu7lY8tf6x5SotEa8uCPdfWod2xYz87dwfNVGR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810884; c=relaxed/simple;
	bh=UVFhv5Z7BlBBKfH8QaYu3fxEmBpx7rK85du1nEWo4Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VnOMY6vM/ghuSeCgZe+VM0z+WI7z1OPVgeZuEod16XqMtSvJQqwoNcp8u7t5hIRX6h4z21dqK2MqN+WkJZG2UTmMaPCjps8dWzXRFhWBTeIO2R0FteAdaR/HJYzAY9iYtfZIuXt8nHWYHe60KFEDM2ChkeP5NERtpCRfQipE9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UIp9g7gh; arc=none smtp.client-ip=45.254.49.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UIp9g7gh"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33d86957e;
	Wed, 11 Feb 2026 16:25:19 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 3/3] PCI/MSI: Add TODO comment about legacy pcim_enable_device() side-effect
Date: Wed, 11 Feb 2026 16:24:59 +0800
Message-Id: <1770798299-202288-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1770798299-202288-1-git-send-email-shawn.lin@rock-chips.com>
References: <1770798299-202288-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c4bce081409cckunm6cb3bb0ee19cd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhkfSFYfSR5DTR0YShgeTElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UIp9g7ghBfQGQZ/3okgBqWjahEVRpOtzhoVw/oMnzmr8wntmjpYyvuG/D3PeBpnwvseClvlb7lSwRIFvQauk9xdRxJuqFUvb/AYDUy+8I9M73lO+Q4XUMo0+riMG50H00/SjiXEOPQdwj0rtNNoyB0mtO50yB5IldeC/1V+A0HE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=wXzM0K0CcUqD2rLTcHZcO8hNOKAiCR32tUQai7tG7qY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add a TODO comment in pci/msi/msi.c to document that the automatic IRQ
vector management activated by pcim_enable_device() is a dangerous and
confusing.

The comment is placed near pcim_setup_msi_release() where the automatic
management is implemented, serving as a marker for future cleanup work.

Suggested-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2: None

 drivers/pci/msi/msi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index e241217..81d24a2 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -77,6 +77,16 @@ static void pcim_msi_release(void *pcidev)
 /*
  * Needs to be separate from pcim_release to prevent an ordering problem
  * vs. msi_device_data_release() in the MSI core code.
+ *
+ * TODO: Remove the legacy side-effect of pcim_enable_device() that
+ * activates automatic IRQ vector management. This design is dangerous
+ * and confusing because it switches normally un-managed functions
+ * into managed mode. Drivers should explicitly manage their IRQ vectors
+ * without this implicit behavior.
+ *
+ * The current implementation uses both pdev->is_managed and
+ * pdev->is_msi_managed flags, which adds unnecessary complexity.
+ * This should be simplified in a future kernel version.
  */
 static int pcim_setup_msi_release(struct pci_dev *dev)
 {
-- 
2.7.4

