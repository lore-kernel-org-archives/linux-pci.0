Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307D3E63AA;
	Wed,  6 May 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057352; cv=none; b=X2Oy1ViNyXzBFd2DjFBFSNEKpyL/grHl9U0nKdS4UCNl6QsF0iRRM1i9TfwCn4EVCOkyx6Qq6RsSefsdTciL//y6BBUt2jVAO4uBUbR4Cpmh4t4DCxR/YRf6jl1j6P9AK1NAxL7bsCIx5Pe7KQX052seGT9jHQTYUYxQhZ+/Eyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057352; c=relaxed/simple;
	bh=sXJPnH5sx+BWU1msStd23fcHDa5lpoLcmHDRRBzqQto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ormN8WZwBSkA03wiM5iCpKX9MCltY4dPhDpinEUSfuLG2C2jqFMMxlx+5J5SASmvkciENfw7VpJK0/ZpOKJTVqHYC9LSueCW6iKeJqv7haEpoJyLRtIjqwBguiFW0OZE/Tm3tfL7bEmW4q9F4vStNC6Jhu4Z3Y5KRRbKBJfMzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMT3KN0y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMT3KN0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778057351; x=1809593351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sXJPnH5sx+BWU1msStd23fcHDa5lpoLcmHDRRBzqQto=;
  b=WMT3KN0yUE0DIkvNROaTrvMpy/OvAclvlMLFn+ll7ok9AWwhNwzJrx5n
   7TqTDO+Ex0Dd0vidLQA7a6dYjLMfAOTCdpfuwRJikcsEqxQmnh/btRlD3
   tPVh55X+pN5yR8noUhQS85As90AXTRbSxglkuHel6m3Xrp/2eAWflGWrN
   hSlXUK9vR8wnxnau4qexaKWM0TYQbhCB2BYiSAfpmatIAEfAf475cndil
   PpO6DJjXJGTOwAIuqM8wNS3KtrI7yiN8+oNewCex4wqaMvwysQvoK6Nua
   NQLTDU2qbNQ+dmv9fTwA0K9cUjFF1IBfgNo7rPjbvdG6L6iZ+RC4UMFtm
   A==;
X-CSE-ConnectionGUID: 1zNHlehmT6+uCSbTOoYnzg==
X-CSE-MsgGUID: gonKz+EkTK6qPEuqm0a4AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78869765"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78869765"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:49:05 -0700
X-CSE-ConnectionGUID: 7oVySJZXR2SeQRTaEQijuw==
X-CSE-MsgGUID: +2LzXYrIRjS+0AiMEPw9Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259510105"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 06 May 2026 01:49:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 076229B; Wed, 06 May 2026 10:49:00 +0200 (CEST)
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
Subject: [PATCH v1 3/4] PCI: fu740: Drop unused include
Date: Wed,  6 May 2026 10:47:26 +0200
Message-ID: <20260506084858.867884-4-andriy.shevchenko@linux.intel.com>
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
 drivers/pci/controller/dwc/pcie-fu740.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 66367252032b..d0a34f680397 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -13,7 +13,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.50.1

