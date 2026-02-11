Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8C21771B;
	Wed, 11 Feb 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814076; cv=none; b=srae5U59K5grSM25yOLOM1WQhayJtqTA65AlglnbOJs/z82/bo73Bbzz/oJSPSJ9WmhUW5U1oIleNA44eTm0mQX/a10tAaCKNBze+NvpryWpO+KJb2rNccQBarnUDX8aKU24l9EBlJF9tu1oSQR6o8aFg5M2UrGrzx3cl3sYh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814076; c=relaxed/simple;
	bh=r/5lyNlFnx8IXX2WjB2FYea6s93EnwGH44y++6ZAehw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E3nHBGPfrJ6V0A4Bsx09nfd5fMZ44Vc8muMLjlEisCTXXMJikiW/5HTHOmXjiTqRJ9M1yX1//xJhndcK9ilZOAuJquxXnLMAH1DgrkEzXQ5U81RSddl8aohwePjn6m2VBR8bsuZG5S3Vs+kJOJ9KN2iQ7aMLnfw2umTEccVtoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MG04Bzvd; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MG04Bzvd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770814070; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=G5PYZMNjLjCkB/3J1uvIOFYqNefpUtlIsBo/LElDi20=;
	b=MG04BzvdxaHKzfuIAF1vQg1qZU11pEwY+Zvm+Hk7GrGWG/buvofQboZcxBkT32wX56GQ09hLGJMO3g7TbwgbJ2SamF07h2qWYwk7wPB7F46zunGd39T6PZxzznCMFQALhibM+G2QvVcbFsYHMvrxSI0E5HsA9jajF3/3KenX+d0=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wz1H63b_1770814068 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 20:47:49 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	lukas@wunner.de
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v3] PCI/AER: Only clear error bits in PCIe Device Status register
Date: Wed, 11 Feb 2026 20:46:24 +0800
Message-Id: <20260211124624.49656-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, pcie_clear_device_status() clears the entire PCIe Device
Status register (PCI_EXP_DEVSTA) by writing back the value read from
the register, which affects not only the error status bits but also
other writable bits.

According to PCIe Base Specification r7.0, sec 7.5.3.5 (Device Status
Register), this register contains:

- RW1C error status bits (CED, NFED, FED, URD at bits 0-3): These are
  the four error status bits that need to be cleared.

- Read-only bits (AUXPD at bit 4, TRPND at bit 5): Writing to these
  has no effect.

- Emergency Power Reduction Detected (bit 6): A RW1C non-error bit
  introduced in PCIe r5.0 (2019). This is currently the only writable
  non-error bit in the Device Status register. Unconditionally
  clearing this bit can interfere with other software components that
  rely on this power management indication.

- Reserved bits (RsvdZ): These bits are required to be written as
  zero. Writing 1s to them (as the current implementation may do)
  violates the specification.

To prevent unintended side effects, modify pcie_clear_device_status()
to only write 1s to the four error status bits (CED, NFED, FED, URD),
leaving the Emergency Power Reduction Detected bit and reserved bits
unaffected.

Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
changes since v2:
- accommodate two macros per line per Lukas
- pick up Reviewed-by tag from Lukas
---
 drivers/pci/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..0e6a50260555 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2243,10 +2243,9 @@ EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 #ifdef CONFIG_PCIEAER
 void pcie_clear_device_status(struct pci_dev *dev)
 {
-	u16 sta;
-
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+				   PCI_EXP_DEVSTA_CED | PCI_EXP_DEVSTA_NFED |
+				   PCI_EXP_DEVSTA_FED | PCI_EXP_DEVSTA_URD);
 }
 #endif
 
-- 
2.43.5

