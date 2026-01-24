Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860812BEFF6;
	Sat, 24 Jan 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769240807; cv=none; b=FgeHfNAUN+YunduunwAnWkssViq0rYyDY5l9DImasB1Tf4tPhlHYvVIdeE9hEOJMDU3oS4ZeRAwsMkuLWfsqPuSzkT4xzSNZFmoOSybF0OsrkTl29TL/EkYrQv7oqGyvxWNHy5I7Y6kelC+GHUlVXNyk5yuH+Jkvp3TrKhuqUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769240807; c=relaxed/simple;
	bh=DVWMHTNJQE5K0BQW2nIXCCu88zLHRBYPXSf6sOrFFy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ot5mYLmRLlsWtAzRRbjGlRLY1AGfDeYcxz9Naub5NilxuG9n+vXSagbHiVY8EOKVx0UdibAtR6teD7BYwdL0ZlSbpzNb4FYAwL5OBwXPReE8i6o4H7f2xk5FDlEAwqZupC9pbxG3D0ZsHBmzUefUW4zAEl8v94M32E2TsbxkYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t7EV4mG+; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t7EV4mG+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769240789; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sBSDEixm4+8FCCTYQu1UeCBdF+LTdyt08Svk7uwlzxo=;
	b=t7EV4mG+yoarR/t0bXg0k/9wDAMAJfjbQMZjC8ekDzUVmXakmw0E9Q+NPPUZkXdCETEcQzmdaJW8PjKVDLriz1Eeyeh8sEzp7U7mFAfwuPfs3dm+5nv0u4qanZuszEdNuBoZvsDXMTXkcWv8rKc9rVHeNmbpUgQhSKYLIgIhlkA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WxiIIC1_1769240788 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 Jan 2026 15:46:28 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com,
	lukas@wunner.de
Subject: [PATCH v7 5/5] PCI/AER: Only clear error bits in pcie_clear_device_status()
Date: Sat, 24 Jan 2026 15:45:57 +0800
Message-Id: <20260124074557.73961-6-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, pcie_clear_device_status() clears the entire PCIe Device
Status register (PCI_EXP_DEVSTA), which includes both error status bits
and other status bits such as AUX Power Detected (AUXPD) and
Transactions Pending (TRPND).

Clearing non-error status bits can interfere with other drivers or
subsystems that may rely on these bits. To fix it, only clear the error
bits (0xf) while preserving other status bits.

Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pci.c             | 2 +-
 include/uapi/linux/pci_regs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..0b947f90c333 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	u16 sta;
 
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
 }
 #endif
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..f4b68203bc4e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -534,6 +534,7 @@
 #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
 #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
 #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
+#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */
 #define  PCI_EXP_DEVSTA_AUXPD	0x0010	/* AUX Power Detected */
 #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
-- 
2.39.3

