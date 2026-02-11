Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com [220.197.32.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754863502B5;
	Wed, 11 Feb 2026 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798325; cv=none; b=aUWql6tfnlwyI1uYjOjBM5/eOhjP4wU9e0zKCp3MUCidAn1QpaXntpkHJ02a63LOVnmLFNhIP9KehNzmSwuJA8vGl2fuv0YWQFis9QXqUrNPspKZoaWlZxcvkG+A93GqfFqQIyIiHrIGVWQMeqBp3C3ZBzLdoNOS5Et627hOc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798325; c=relaxed/simple;
	bh=YvigmLCqOr8/AoMiyT9kc2nOEGyhWmlyjRzi0fdnevs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FuiK8lxelS0V6s0wQM9tzZX28/TSCEOYMbcX70ZzNEhc/ptANicK8Ga4pCONl59Lc41CzfNIEaCJq/t495SpWvmdQpEgFuk+iLn5CjVWdm2uLfQvPtu68gXqyu3gOzai6ENtiIjCIaF0tF3bkhvvRR249wCOEsf5Uzy9r5yG7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JufUhP19; arc=none smtp.client-ip=220.197.32.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JufUhP19"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33d86955b;
	Wed, 11 Feb 2026 16:25:12 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/3] Documentation: PCI: Clarify pci_free_irq_vectors() usage for managed devices
Date: Wed, 11 Feb 2026 16:24:57 +0800
Message-Id: <1770798299-202288-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1770798299-202288-1-git-send-email-shawn.lin@rock-chips.com>
References: <1770798299-202288-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c4bcdec8309cckunm6cb3bb0ee1952
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwYSFZDTE4YQkhJTUkeGENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JufUhP197s404EhhqFc+pQZhJZa9rod0V2L9oqrMUrh3NyQstJCxuZ7JOLQTpncGG7/SQftbAq5tYsEhaILjUKIWOth+0SaJAGKNk12LMXj1tbjflubP9Zcw/xeKCK3bX2jpkUxuJdwgRHZHxl8Yt6jZr7qkBqi4NKHcLhWUKHE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=kO7osYZ7Ghm6DE8ieF75ePp5+J1QxST7/0v2tb+XADg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Update the msi-howto.rst documentation to clarify that drivers using
pcim_enable_device() must not call pci_free_irq_vectors().

For legacy reasons, pcim_enable_device() switches several normally
un-managed functions into managed mode. Currently, the only function
affected in this way is pcim_setup_msi_release(), which results in
automatic IRQ vector management.

This behavior is dangerous and confusing. Drivers using pcim_enable_device()
should rely on the automatic IRQ vector management and avoid calling
pci_free_irq_vectors() manually.

Suggested-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rework the commit message and documentation

 Documentation/PCI/msi-howto.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index 667ebe2..844c1d3 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -113,8 +113,11 @@ vectors, use the following function::
 
   int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 
-Any allocated resources should be freed before removing the device using
-the following function::
+If the driver enables the device using pcim_enable_device(), the driver
+shouldn't call pci_free_irq_vectors() because pcim_enable_device()
+activates automatic management for IRQ vectors. Otherwise, the driver should
+free any allocated IRQ vectors before removing the device using the following
+function::
 
   void pci_free_irq_vectors(struct pci_dev *dev);
 
-- 
2.7.4

