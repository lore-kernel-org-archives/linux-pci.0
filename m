Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B56393DD4
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187914; cv=none; b=V/uVq5RTkh4o7a45WqTt1TRMxHJ2sMWVMtTT7jrCU2ub9Kotxz47tdElrwtX3dJu7smNV3d6DP8rV9z8PUCtezdI+PAgMnLWDpDaeuDn826C0FaR39NNB9veVA3vMFj95aSkNr4ifToyXxieRpZ7EH6tXmGfUKMhxjuL6m1XvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187914; c=relaxed/simple;
	bh=dIgDvxqdfK6led+l2ocuZWsNizuqqLIkLz3gumzoZzI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvUm51lKuCPD6T+GGbdgc2A91QqY+jxxci4PrxumaB3PjCJ9MKyqdXuljqf9pu0VTZBL2cs7FrG/mxFv9AiJ7fVPzGAf+F3nzadlcPpvOtGa2QM2wgTFBbm1IAHpEYftWrgGSW7RXKpwFz7Wy9o6BD0VeBEW7NdPNGwxdEbySfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S5ZJwPDd; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S5ZJwPDd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wjFhWpdw82lmWFWzEPKMjJiaYwU+qTRQ2p5Ku29JCUM=;
	b=S5ZJwPDdEcRT68nqaGsocZoXTni7wLqRXqZ/KAM9t2ovo+h8zLw7Ly6E3yJZccLEGQwBOKNyT
	hGWGWcUHujh9bH+59y9CPCbD2WNfd952VMNl29uLxxIGG/3swktgl3sKNVjV/KYGW70eyfESgmx
	fo2vyOl3g7cVEOrpBquuezg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fMkq81pSszLlSN
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 18:20:20 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CA5D4056E
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 18:25:08 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 18:25:06 +0800
Received: from huawei.com (10.50.163.32) by kwepemn200012.china.huawei.com
 (7.202.194.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 18:25:05 +0800
From: Sizhe Liu <liusizhe5@huawei.com>
To: <bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<shiju.jose@huawei.com>, <keith.busch@intel.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>,
	<liusizhe5@huawei.com>
Subject: [PATCH] PCI/ERR: Clear fatal status of the reporting device
Date: Fri, 27 Feb 2026 18:25:05 +0800
Message-ID: <20260227102505.3966864-1-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn200012.china.huawei.com (7.202.194.135)

During PCIe native AER error recovery, ERR_FATAL status bits are not cleared
after fatal error handling. This causes stale ERR_FATAL bits to be reported
in subsequent AER events, even after reporting "device recovery successful".

Prior to commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery"), native
AER handled non-fatal and fatal errors separately, clearing the corresponding
status bits for both types after processing. That commit unified the error
paths through pcie_do_recovery(), which began invoking
pci_cleanup_aer_uncorrect_error_status() after commit bfcb79fca19d
("PCI/ERR: Run error recovery callbacks for all affected devices").

This function only clears non-fatal error (NFE) bits and leaves ERR_FATAL
bits uncleared, resulting in stale error status.

Fix this by explicitly clearing the ERR_FATAL status bits for the reporting
device during recovery, restoring the original fatal error handling behavior.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 drivers/pci/pcie/err.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d7..f51225f2592d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -281,6 +281,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.33.0

