Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7A37C923;
	Sat, 19 Sep 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835225; cv=none; b=RGEY28cMAJyPoNSV9e4m3LvTeuxxg8k4kADs8s665pXX/ht8zuukCld+Q4mAm6KuKBxPaHpQUHhwetHukNprgHxYGjczjKBsFjZiWGjeH0jJ8YozxC4d+tsp+xM1wggeMxjDA1cMjjel/2+0zucDIumeIHVZ0Pvm/s5ZrfPvrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835225; c=relaxed/simple;
	bh=0LDGncaI5MxJUIFYPYtU9c0kJcuTF2TQmLJsM2qYqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBhb0b5VN1wLWV4oyv+ODcyAOlVpIZIjN9kULiwgULWpq2PTIrUwEvLXkAEpSD426U7ZaRsJ6KMAAwE471ew6S4lxoTGJp2++D974hBLvmUcl7rcTKxEg/wKHzdBz4Fn2PwyBENlpOjd4q154waig5qVkXqj+9zZWy6x69e24AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MboDx7Dm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MboDx7Dm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789835224; x=1821371224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0LDGncaI5MxJUIFYPYtU9c0kJcuTF2TQmLJsM2qYqj0=;
  b=MboDx7Dmv87hX85+rc/uJ54O2cO8nwSJL0kLOfDws66yTl1SOnPlWAxk
   ++yM2ZMhJLLknKGB6rsR74M4gqkBl2nUP3Qg/oxt7wwEJHDBd3M+Qn3qe
   +PPtpAKbpqKqdEXCSzCLdMaf4oTJ74vgwOXPWbNzDSs/BSrA9IEc5eTFy
   pRqLNSS3zO0zgMQIaBn8fxPYWH/nJ5/ef6ErCdc3W1ufuxjysqtGDHkkF
   r79qR1OJbEtvQxRPYMAmpxqVObZHg+2H00f2zX2f/oSUuclH+yCt1XXMe
   1rQnJv3Vzof7S5B8BG4FcUHCBNyP8YQLIxgNkDk2dEmyZ9onwraRiZIcV
   w==;
X-CSE-ConnectionGUID: DdLrc6FZTcSUyMCZ/UKs4g==
X-CSE-MsgGUID: uBS26YJcTmKK9qO5dBbibg==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="94187228"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="94187228"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:02 -0700
X-CSE-ConnectionGUID: O8Vu3FlTTdGhBKY60sf+uw==
X-CSE-MsgGUID: BqQuAaNkQpykH+4HHtNOdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="272186116"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 09:27:02 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH v13 1/5] PCI/DPC: Ignore devices with no AER Capability
Date: Sat, 19 Sep 2026 09:26:51 -0700
Message-ID: <20260919162655.3499010-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Downstream Ports may support DPC regardless of whether they support AER
(see PCIe r7.0, sec 6.2.11.2).  Previously, if the user booted with
"pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
depends on the AER Capability.

dpc_probe() previously failed if:

  !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
  !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law

so it succeeded if:

  pcie_aer_is_native() || pcie_ports_dpc_native

Fail dpc_probe() if the device has no AER Capability.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Olof Johansson <olof@lixom.net>
---
Changes since v12

 * Rebased to v7.3-rc3.  No other changes.

v12 posting
https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/

 drivers/pci/pcie/dpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..4c2cfae27a08 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -477,6 +477,9 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 cap;
 
+	if (!pdev->aer_cap)
+		return -ENOTSUPP;
+
 	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
-- 
2.43.0

