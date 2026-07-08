Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA943EC2FF
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494466; cv=none; b=oh+xgof/ogxgs5TCejgysCpOpgf2TFZta0C5FFS/pZ9KRooeDiJxo06uTTPYrOXewOLacvDBNYW1Gy45sxRbaad9gWf6deJnHgMydPR8ThWsUGCm/rZVAuI6In/0pKY9CuXhLEY0NGnU1Q7yCWHCdT9a0J8Z3GqhQhldzi3Cg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494466; c=relaxed/simple;
	bh=ytNcMbesgL/eKdv4T4cvoNnpg59gCTQe/HX1PNhqTzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7j0IkMWhPuSn+lgrM6/Sn6HPb3CFmJVampZxJvAKgSxFGcGwwp1v1Fr3Iagitn7RoCoA6urGodqJ9GXvXIsrF1ebcSrOzHeGSp6+PU2x1UGYg56KxeOhvG79vDofnrzzvY/wKUBj5uk0m8MAwKdmVe/QkvIZGjrj4IJ75dsaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cg8/OQmb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cg8/OQmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783494457; x=1815030457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ytNcMbesgL/eKdv4T4cvoNnpg59gCTQe/HX1PNhqTzI=;
  b=cg8/OQmbVFIuDjNwFMpJnxZ3MkZAgXddYojqz54GgPyPfzllpgUdgt2P
   zvtHeA/vGd0psgib9Ec9z8OhGtdBheR3BKK2egLg2FsTAVtcTznCRcZh6
   8hyzKqpV1qkj5v7f5iYVQmz5uQs4Mq5uX9uOn9eDzaFFg8oICB4cALlnv
   i2Ma3lhCOFtq7hKFFgbfO5WrslrxE7Mihs9pOE+lB3YU46ZYSCU7qQQCX
   siet3bVqtqYipqrMnwvsIm3WscDRdSb4KYsbry3z1oOs/W7G2cRc1Spg2
   jyLef0nwryvbsOt8s3n9NbWsmcbozsTm3KfCo/td37DUMhH3xgIKwcrw1
   w==;
X-CSE-ConnectionGUID: K/6CR6CJQNSewcgcfkcj3Q==
X-CSE-MsgGUID: iisSZPQ0QRK1cgG0+LSW3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83261793"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83261793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 00:07:31 -0700
X-CSE-ConnectionGUID: mNTiDma9Shusfecc0sCNmQ==
X-CSE-MsgGUID: Kem+aiqzQkSCku9aCBsPDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292395282"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 00:07:29 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] PCI: vmd: Add VMD Device ID Support for Intel Nova Lake (NVL) and Dunlow (DNL) Add VMD Device ID Support for NVL and DNL processors.
Date: Wed,  8 Jul 2026 09:29:57 +0000
Message-ID: <20260708092957.3269545-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <djbw@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..f9d145932155 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1132,6 +1132,10 @@ static const struct pci_device_id vmd_ids[] = {
                 .driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xb07f),
                 .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xd70b),
+		.driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xd73b),
+		.driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.43.0

