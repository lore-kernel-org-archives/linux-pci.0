Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88D3E5EF6;
	Wed,  6 May 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057351; cv=none; b=DAq7YbO7fwJf7Rip/G7JUkv/j9rGasXsTyGoeXu7n97EiJRQqWpmut8Jp/g10UtDYRhG8FqA86BPb6av2cWHX/9ibINHvoFvg6yxiGKqFyxMVqIxP87K2fuywLbbHY4AEsSQJk2+KvIbVdBU4B9LDumKSytBCeV1aIFDxJcfFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057351; c=relaxed/simple;
	bh=DDptMACMAhm7xTMfOgYU9QZU6xrY7e8N4931prIpECk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqL+hs9brLBb7Lt0uFAg71eQQQn41ZLWyqx2vaPi+F0Z0hVgbznDn3LxVBStwuOLbL9mpctSY5vMRH5p0irY+dQ0847LX9ehsJXnHgAG8e+SnG6rpGnFRNtNe7I/yynkdIy5oKXf54l7SakwMFu4HThF5FIbfKMA3jFxG6tsViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zn9EY7uh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zn9EY7uh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778057349; x=1809593349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DDptMACMAhm7xTMfOgYU9QZU6xrY7e8N4931prIpECk=;
  b=Zn9EY7uhSB+oJvAbPq3isMKN1iuUBU7UrH+reScLO+dq36KvideM+NnL
   75ANIACb5JwhWo7YuSmpFwlZCOqrxh5I6Zcgqf06nWxyNmzfwHTXLemOe
   358UaPZyARhD3rY8ahdIfC7TT039sTkoWtM52EdciF49NG0I3EPFsbJ0k
   6971FhvLEl0HQyi/MxPcAMb7x7YSdFHDBCpvHBJRPPVJ/WMWO0NK90Ekm
   j6HVjrJ9cHau1OSrgkQxZumGL5ZtHYoX2hrCouZeNYdb1iUkeJ5QiJ2wd
   RCgoXg0E42iw1mCFQ0ay3Bx/cLMTGaeoU+skLk/PkoeQlrug9xzqP+ykm
   g==;
X-CSE-ConnectionGUID: HqteM2hIR6aiLXPRwQawSQ==
X-CSE-MsgGUID: BVWwvSqxTsWSYwki6x3TfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78869731"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78869731"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:49:05 -0700
X-CSE-ConnectionGUID: dRHWd1i0THy38j8bVbWNBQ==
X-CSE-MsgGUID: 3hj1c6WUSwy63w4M3JmUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259510103"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 06 May 2026 01:49:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F24BD98; Wed, 06 May 2026 10:48:59 +0200 (CEST)
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
Subject: [PATCH v1 1/4] PCI: amd-mdb: Use the right GPIO header
Date: Wed,  6 May 2026 10:47:24 +0200
Message-ID: <20260506084858.867884-2-andriy.shevchenko@linux.intel.com>
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

The driver includes the legacy GPIO header <linux/gpio.h> but does not
use any symbols from it and actually wants <linux/gpio/consumer.h>,
so fix this up.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 7e50e11fbffd..88208e967201 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -7,7 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-- 
2.50.1

