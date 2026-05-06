Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40803E558D;
	Wed,  6 May 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057347; cv=none; b=K58vyykNycnJqhjsoQ4CxN+QO61BatUISgw5+5NiUEm2FHsyM/+pOjBOxuWM49R+yMaQKknOHhGThyOm3AyYU0/OyfjxRdv9+yau3xjk2XrSTXIsUGSw8SgW2hOmsySAiGp+4dySy5nAH1Ur4xxM0bpP4yw6ScBfAWm7u2uzkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057347; c=relaxed/simple;
	bh=s6kR3uTc3wV+vVyP9HWWBDu8ffUDgMM0mq6fvvjzt3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkdijJWcXdaqpMBVWF/+O436f1/JFiIg7zep6wuIYoQyj115w3JlBzaUM7mHT6R/capYnAo7MKHsVCf25tOmuOdWVwAm5dG+X+oz1ccpCZkVXgo8egK6MFOLkNXyILN5lcJkbT6umD0osEBnbEHLQv9Ym8eDHDnF7vf5EVa9pZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ysv4MiHM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ysv4MiHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778057345; x=1809593345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6kR3uTc3wV+vVyP9HWWBDu8ffUDgMM0mq6fvvjzt3A=;
  b=Ysv4MiHM3foGTyhnXTzvhblRlWAoxfDaWsNwxxTDYdnP0X0o8SSdKBrk
   KEWziV5pugN1yfcnrlRPhMO9Wc5AJJdypq3d6sMRzG7d2IWQnwRvOyQLx
   JMB/uMEInOT5Fbg2lCF/YiC6S+vW76Fshf2HKDIFOCqvKUvxpn5kUbqM+
   jOsCzJeh1WrjkdIHjqrdpuly1hAOy6/rTWQ+JvLxbC/8VeaxLG9gNgo49
   nKQjFakIQ1DXCxbNBU9Py2f6G+0aXbuN1tlBANdkoDcEGFoxV3cP+Vz7Y
   6lN1HjivdqPiCJZvITX3Eq07e/O0TmTNimPBRbwrNKIkoJLcdqsUw7b6t
   A==;
X-CSE-ConnectionGUID: 7oIQwwIkQWa3GfM+bWXc/Q==
X-CSE-MsgGUID: S5PYcHjFTH+z+mMxyjEPgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89681536"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89681536"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:49:05 -0700
X-CSE-ConnectionGUID: XkQ951pgTUODUrYDoeuEVA==
X-CSE-MsgGUID: K/2w+vp/TaSvDynXEzl+pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240412779"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 06 May 2026 01:49:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0B9AC9D; Wed, 06 May 2026 10:49:00 +0200 (CEST)
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
Subject: [PATCH v1 4/4] PCI: visconti: Drop unused include
Date: Wed,  6 May 2026 10:47:27 +0200
Message-ID: <20260506084858.867884-5-andriy.shevchenko@linux.intel.com>
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
 drivers/pci/controller/dwc/pcie-visconti.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index cdeac6177143..f21775c3b3a1 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -10,7 +10,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
-- 
2.50.1

