Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBD1C01;
	Sat, 24 Jan 2026 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769240798; cv=none; b=LjLqf01cBZ61ja/Tk3mh0zbDkF61SbTAB947pODrs8QFB1lCigjN5rql8DN2wxtng2fLipxdR0ZdbHv738nCI7riiQVsJibUoxbEdiI+sUtWO/B7DsFBaY5P4h8k4FCMuFbNsQYITwmCrM76lAs1miKtxeUvDrTtcS0PvdSH6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769240798; c=relaxed/simple;
	bh=DNLTpq5pOf+Zd30it71XQ2eM3DCg4fdegZhQZZ6+eQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTEk2trZqSm7y6o1xC5Cn4KJuX2AthZ4oA1qMZ2KhaN22pe4NcYYScmYwB9SYNZk2RhcHjT508wsNPVoZHHjCmM8sfOEVBIAILNnFF5RxL93YPxxlghM+gEYb5ClnaG/mwjJR1WDx5dBHpWUGHjWQ2op6KTl8ZM0KmIto/X5Jog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QqohUQ1B; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QqohUQ1B"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769240788; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aFxdKk3TVTGbZ741QSPtHZ39lb0EWDC9svYSkf2cf1o=;
	b=QqohUQ1B/eASue0I3tHfV07sqdGNN0hTkOEt4K7H10JF0oRPk4zUm0+X6SmuBZ1DaLsAN3ifwUVxtMyf3O97y4UO/mG36IgruWHskd3vj18MtkPLaaWMnZ7w1rO2F7YD45gn3nbtEOzEThnEkWpiE+Do98m2M2mf+5DNgeJy7pY=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WxiIIBY_1769240787 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 Jan 2026 15:46:27 +0800
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
Subject: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
Date: Sat, 24 Jan 2026 15:45:56 +0800
Message-Id: <20260124074557.73961-5-xueshuai@linux.alibaba.com>
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

The DPC driver clears AER fatal status for the port that reported the
error, but not for the downstream device that deteced the error.  The
current recovery code only clears non-fatal AER status, leaving fatal
status bits set in the error device.

Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
status in the error device, ensuring all AER status bits are properly
cleared after recovery.

Fixes: aa344bc8b727 ("PCI/ERR: Clear AER status only when we control AER")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pcie/err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0780ea09478b..5e463efc3d05 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 */
 	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(dev);
-		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_raw_clear_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.39.3

