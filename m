Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7B3B4EB4;
	Fri, 17 Apr 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418163; cv=none; b=PxrG2HTdZL2woyslOCJ0iAOm1DhOtMGlfU9S1hmxxyrhqTyA837yr0dx2HGU07XgwJYfkwPRIa5B6i2ZE+b88EPjdKIsqOSr0K5eXVe34C4PxMVYbXgeANwhE6mU5LI+0Wx9A15LibSi+F8+EUL1ErgMtiYK4/dQZoylL88i1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418163; c=relaxed/simple;
	bh=f7SLMYJoEHgSW/CGZ7RB6uXd2lxRreqr5d2o/92XbyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaRBMXmpO/xCcJtUQPZ1HvnJkzOmiQdoBSaOOOqZ9Wh209otLdmFkMB40f18bbXF/eHYg5+QEZeLvmAfsOewksiBdsoBNS9dlXMwSKXuBkQyZ0zCMnTHaf9qLz87oeRGFLuilNHZlUuc0UulRgSSAf0mSvaWOvQNz3vyhfcdnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2skoy1V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2skoy1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776418162; x=1807954162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f7SLMYJoEHgSW/CGZ7RB6uXd2lxRreqr5d2o/92XbyY=;
  b=P2skoy1VAv2yMLH02Ihs59rKZ//MBAcknQwPqdSfl/TCbx3O7e3vX/CJ
   7+8HVNjhDNlBmWHMnEdO/o28Sg+UaORpJO7fDuOUIB/IYUPa/YzMUtaxD
   sCzL6Oent+qv1GAqmGR/UfErHkFQ/WfqoCqtwgv177an2rtGFvSQWmLlB
   iVHUIlYmYXhqBDWHFGtFkjN5peqxOZPyBrCVPDjLFBv3AdsDOKEpX8BcI
   JoyM1KZJnXUxTDtWrGpOYpxLm6W3crfqQOKUV2gx3leC0AZyZeK8NuVLe
   VNUb9io4pDkiPFUEQnlp5LtY4tNyFu/tCd8LomVSw0QM11TERkJh7+lH4
   Q==;
X-CSE-ConnectionGUID: dY2A4MGKTRm0NOzHHTlspA==
X-CSE-MsgGUID: lS9T6M7KRdmmFyokK/vWjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81029392"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="81029392"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 02:29:22 -0700
X-CSE-ConnectionGUID: LO2pJL6aQDGFq4fZSXhhFw==
X-CSE-MsgGUID: Fnxq7XWzS6SJOksyZgT0wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="230870035"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 02:29:21 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com,
	dakr@kernel.org,
	alex@shazbot.org,
	hanguidong02@gmail.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] PCI: Initialize spinlock in new_id_store()
Date: Fri, 17 Apr 2026 05:29:08 -0400
Message-ID: <20260417092909.226412-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

new_id_store() creates a dummy pci_dev structure but doesn't initialize
driver_override.lock in device structure. The lock is taken by
device_match_driver_override() during PCI ID existence checking, then
below lock corruption is reported if spinlock debug is enabled.

  BUG: spinlock bad magic on CPU#74, vfio_pci.sh/4575
   lock: 0xff1100018fd3e158, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
  Call Trace:
   <TASK>
   dump_stack_lvl+0x51/0x80
   do_raw_spin_lock+0x64/0xc0
   pci_match_device+0x22/0x180
   new_id_store+0x184/0x1e0
   kernfs_fop_write_iter+0x13a/0x1e0
   vfs_write+0x31b/0x440
   ksys_write+0x67/0xe0
   do_syscall_64+0xa5/0x12c0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

The call trace is harmless as the whole driver_override structure is
initialized to zero.

Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/pci/pci-driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index dd9075403987..9c3d4606721a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -213,6 +213,9 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 		pdev->subsystem_device = subdevice;
 		pdev->class = class;
 
+		/* Initialize driver_override.lock as device_match_driver_override() takes it. */
+		spin_lock_init(&pdev->dev.driver_override.lock);
+
 		if (pci_match_device(pdrv, pdev))
 			retval = -EEXIST;
 
-- 
2.47.3

