Received: from mail-m3290.qiye.163.com (mail-m3290.qiye.163.com [220.197.32.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4B23A99E
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862427; cv=none; b=q+/g12WEADalKIStiXHifquSiSO0vHoy+57cAKkQxk98YAndT+SVn2Y6ctDCALIQVThfj2J9aBeFdBKqN3Ebbaw4GSz6dVqJmn3GQatampwY/xYHlsNWt24iFk7sU2yc+z6ueunMQLZ+0GGczqaXO5zw7AbXDkjU7FgAApOq7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862427; c=relaxed/simple;
	bh=uWJTX/pZvRp2MGck9gGLfKLk59neVmndOpsruB0ivQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bu+d/I4rlWX7Ds1ArEi62ZxgmxBdAHhFVfXRg6N5doluRW1GKEa4t9PmYigJhy82SjFdRXoMO8qc58kQwMG/hic7EdpOzfaUHA8x0BSkeR6So6UO+Td7p74EU0HnEE9XyPojvsCsiXBldZkPhDsWMRO8StqMdnpN88cinlaxW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Fll11VsC; arc=none smtp.client-ip=220.197.32.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Fll11VsC"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4045cd;
	Mon, 23 Feb 2026 23:55:13 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 23/37] accel/amdxdna: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:55:07 +0800
Message-Id: <1771862107-89399-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b363aad09cckunm247f0236987db3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MeTVZMGUpITRlNH01MT0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Fll11VsCeZzILEQYhdI840GLOF0L/LRQuzUY9TVT5omlusLuCObUcukaA/c2mhJNV7KpXt9WQV4UqYBhjWZsAeCBSJUZ2xUopC0/gQTovY2SS4VuqDdnIfW5zzyN0O1q3BJsLe442mUTN08NImgdHvPtJowO2esihaM7XpGXGOo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=b1rS0Nsq28tkkImVqxJcjmEgZF3Hb2IkNJOiSkJHPQk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Min Ma <mamin506@gmail.com>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/accel/amdxdna/aie2_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index f70ccf0..3935a22 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -551,7 +551,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
 		goto release_fw;
 	}
 
-	ret = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
+	ret = pcim_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
 	if (ret < 0) {
 		XDNA_ERR(xdna, "failed to alloc irq vectors, ret %d", ret);
 		goto release_fw;
-- 
2.7.4

