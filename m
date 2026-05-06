Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86433E3D83;
	Wed,  6 May 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057351; cv=none; b=skApwcLdRvsLqEY4yycJXQ+XvHYZ4W0Y+3sc0FZlHbSTQkI34HOoCD7gzwAAmbGwEe5Fh+bQubApBxh76ofciTjM6GfNISfhqPIj+2h34/mKFPicbCt2I0zdXs8kdBmBnsF+dgZCSrBgNxhbkT9JcG4rHqj7WkdIKHqEkVeJT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057351; c=relaxed/simple;
	bh=33pv8jkngV/TubJ8dKVNRz9O4JXzuX0rI0t9g4vltyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMKS1cVXPSSU2ncjejUH6Kexvi3P1MDPTpGtc2ka2N1BKiJ5MxjY+XWnt+I/xrDSPFeOVc/ImOPm4ApN/ubZyBZo7D/DYlgohmVUazXJzATex3U44ihCOhxGqGLmMIIe8OdtsG+YOERL4of+KetMP4AOreZkB9SVHbHDmPDhnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlzJaK/+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlzJaK/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778057350; x=1809593350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=33pv8jkngV/TubJ8dKVNRz9O4JXzuX0rI0t9g4vltyc=;
  b=KlzJaK/+NrdncQjcbt7JDw4jR7O0Kjot1unGZQkuaEt/IcGJKTrrQ3fJ
   vNWXKYU+BALU4d6aFGo4AiFENOBiPgSMiig4qxQDRSst0MXrMMspgrnEO
   32gumPB6K0hZ6G1g9seu0PfJfVGHf24Gmak/mtcLV5BjhFgfcMLm3rPEn
   tPnlVjqguV+JF0MoSsfOnj9KDxmzCwpVIJmnlJodzpTGLFogXfLhDkgJ/
   9rrBVv/OEfvw4zBtJ8TBDHGOMFSek9lkLxqgMWauZU70MYjLTGla6pKtT
   UtDnVh5EBOeS2S8ulsoFtOVbB+dXhgVwFhErixuknqhJ5H2QQRfo9tpvO
   w==;
X-CSE-ConnectionGUID: aRn5CxXdTUa5C8X5rt4TYA==
X-CSE-MsgGUID: qbP/7rgCQlCszjPN+18s/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78869755"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78869755"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:49:05 -0700
X-CSE-ConnectionGUID: 3CJfSjmzQTWsSJhOShrycw==
X-CSE-MsgGUID: /FDid8XlQLGSbXFNVEcoYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259510104"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 06 May 2026 01:49:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0321699; Wed, 06 May 2026 10:49:00 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Niklas Cassel <cassel@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH v1 2/4] PCI: designware-plat: Drop unused include
Date: Wed,  6 May 2026 10:47:25 +0200
Message-ID: <20260506084858.867884-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260506084858.867884-1-andriy.shevchenko@linux.intel.com>
References: <20260506084858.867884-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file does not use the symbols from the legacy
<linux/gpio.h> header, so let's drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index d103ab759c4e..7d896752d43c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -8,7 +8,6 @@
  */
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.50.1

