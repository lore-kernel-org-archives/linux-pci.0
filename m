Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45339A07E;
	Mon,  1 Jun 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309629; cv=none; b=HcdwE8QMzn+OtjWU6tSO6zcqEO24cVbCHzpfd3caJPias5qboXa1u33A47CpMVwkaZUv96R2pA1OOX8XnMj2Pg05hiTExbDrrTa/3BxYBDa+CCFsPCvT8EyAJ/8Z4chwksikoWb/VrpCWigTlsOtsVEu6JmfaYdZ71pDuQJmKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309629; c=relaxed/simple;
	bh=0qst/tslyWgQOAB1I6G7gBQUJ6DGJGeBEs5F/zIj+jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCA29qW3gS3XlJDmBF1/QhEpSTNQw+/SY+P4UIYuR8KRFtAwJsU3wjtr4Wz29Z8iWPn/l442CQcpuguBtZr+ZPhqbMvwekQMtvL7uXgVTZTHcNO4JB23f/o16UK1+wZ4sguSbe4jRcZeKDeXxUaljyraXt5VUyxdKOYLPwtA00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHuN98qR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHuN98qR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780309628; x=1811845628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0qst/tslyWgQOAB1I6G7gBQUJ6DGJGeBEs5F/zIj+jg=;
  b=cHuN98qRNy5eLzdbQb3Qpb/pyXFa1MxkfubnbVZPaHUeZYUnF3DAlafB
   1BtDddiWfn5oPuvWmi1tCHodtURxqc32YkOarXFPzQITwLeYowlMePGaA
   ozY8OODJnfm3tRLTJJncIODGqFVLj3qL/Bc3saqbdfUIzFqN3iAlqVDC9
   GOhz4XKBUgNBpPNrZdrskrlLKaDGlDIFc2ncD6oPTICkl4e8pSRAyKsej
   v6P8KbFkBmjU+Vc2MKN/oGHUECE7XB613p1WqUBMxIBPAWoGx0dpFFVPm
   nADyZ+v9gH0JgfSBcVfW25z6PD/5sqkQB/AjPbngg02qkBuN74NtcGPGi
   A==;
X-CSE-ConnectionGUID: XoZ/HY0mSKWMu+KzkAHqPw==
X-CSE-MsgGUID: i72tIkoISgKeyakP7Sb2CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80796474"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80796474"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:27:07 -0700
X-CSE-ConnectionGUID: YQOYhM68S+OQsvHIc5zYEQ==
X-CSE-MsgGUID: t7ZQ3Du5RU2dwov6U/Pg9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243371797"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa008.jf.intel.com with ESMTP; 01 Jun 2026 03:27:05 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Fix null pointer dereference in remove
Date: Mon,  1 Jun 2026 15:56:11 +0530
Message-ID: <20260601102612.2164388-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a NULL check for pci_get_drvdata() in btintel_pcie_remove() to
prevent a null pointer dereference. This can occur when
btintel_pcie_remove() is called concurrently from the PLDR
device_reprobe path on another CPU, after pci_set_drvdata(pdev, NULL)
has already been executed.

Fixes: 8c0693e29dba ("Bluetooth: btintel_pcie: Support Product level reset")
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index eba563b66090..eeaefffaaf6b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2694,6 +2694,10 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	struct btintel_pcie_data *data;
 
 	data = pci_get_drvdata(pdev);
+	if (!data) {
+		BT_WARN("PCI driver data is NULL, aborting remove");
+		return;
+	}
 
 	/* Cancel pending reset work. Skip only when remove() is called from
 	 * within the reset work itself (PLDR device_reprobe path) to avoid
-- 
2.43.0

