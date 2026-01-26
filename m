Received: from mail-m19731107.qiye.163.com (mail-m19731107.qiye.163.com [220.197.31.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979620B810;
	Mon, 26 Jan 2026 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769398380; cv=none; b=anRxBUEPH/jFpcx8QNLsaqhC1Fh3Ki3dpS9bvOos9QpkLd+3kQeJoL9IRJTAo4vKb2wYOgggt7qhgqPc7PcCVssDE6ZuroO9a5AZxkHustHEM+OF+2Xu1caocKTPtjcTxAzT1/lQ+4YpjiTRiotAA52T2pX1QoAH0FK/C9pdQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769398380; c=relaxed/simple;
	bh=rvxlEPMimZ/lEXbjsyYX/HeMP8OiUHdfv7hqOYSB0EQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MSaQ7vpqq1rHg5QrMSm1RPwR8V8XRHSSvFoK/97MVGElkDLB2ErJo1pRqgXWFXdADa96oQ5PTLY5qw4cb2qFUKULGfyoGVk4x/K/uLv/SK92hiFRHFftUPNcDC+DTPb1tKJ1dm6aNOwYR2MUzsp1q37LynaU2WVh+o9R6zz1orA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QbsmGuks; arc=none smtp.client-ip=220.197.31.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QbsmGuks"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31ec4822b;
	Mon, 26 Jan 2026 10:57:21 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] Documentation: PCI: Clarify pci_free_irq_vectors() usage for managed devices
Date: Mon, 26 Jan 2026 10:57:13 +0800
Message-Id: <1769396233-154698-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9bf83c01ad09cckunm3d05d50b3bd2db
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRkfSFZLQkJNHR8dTkNISU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QbsmGuksAYZbchcKGwWZLH3gy3YgWv/Zi08W8VW74HvVeECcdbssW9wvZT3EnEuzT7FH8FAy18FHAyFAMNvxWvcN3Kvg+rE8X8C2dsyX5SSAz58/tuo9E6u5UgL8+njwgARpSGppKDtF7DdWM4+po3koV8nYDl9uffXht7V2cvM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=S00j3mE9WjAbig/3Udqy+Vj2ZnkzfRkJIaPYBwj9A7M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Update the msi-howto.rst documentation to clarify that drivers using the
resource-managed function pcim_enable_device() must not call pci_free_irq_vectors().
This is because such devices have automatic IRQ vector management via pcim_msi_release(),
which is registered by pci_setup_msi_context() when pdev->is_managed is true.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/PCI/msi-howto.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index 667ebe2..dc85f1e 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -113,8 +113,11 @@ vectors, use the following function::
 
   int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 
-Any allocated resources should be freed before removing the device using
-the following function::
+If the driver enables the device using the resource-managed function
+pcim_enable_device(), the driver shouldn't call pci_free_irq_vectors()
+because the IRQ vectors are automatically managed. Otherwise, the driver
+should free any allocated IRQ vectors before removing the device using the
+following function::
 
   void pci_free_irq_vectors(struct pci_dev *dev);
 
-- 
2.7.4

