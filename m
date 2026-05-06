Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A443E5580;
	Wed,  6 May 2026 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057348; cv=none; b=Gpn5VWhEOpiMzS73vMfacvUBLxYGeo2txlaET4VzCS/jDbANpmLh7OUiHZVy4c5CGipdd53QupwasE+C1eB2Jf415mXHBTTJ+tFyFt1lKA57P5zkAENm6LSXPGWilEpdVooynwMtKIpc3hBewogw/XEu7Pv9GBcNnIHHQirBztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057348; c=relaxed/simple;
	bh=gH4tNHByD1p7a5F+z6izPFgbESyPETnNCM9qNzu3rBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/e31KzXZiXKkbzbEb8K5EOicP5QGWC8p3CGXYUwEP4/YvDTKs7nSQ58858NfQ/GVRTWDWIjxroh+ch9ylCPzOnBcwVBfXuA7/IFbp8qQOXRrlaoXZGCaOt04DYAAplVGJCSTAYJSus4YcGHJlj7dvac8fYttLcldr2EM8TnJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvgpaDtc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvgpaDtc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778057346; x=1809593346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gH4tNHByD1p7a5F+z6izPFgbESyPETnNCM9qNzu3rBw=;
  b=HvgpaDtcjwxlkFWYhXLzJ8ye4nJSsleUYVSiCnOzN5TMROynizGSMJoW
   zHANlSUsAukZafVboPnsW0cSL8hN5yeOfuiZqFLx4oXbTQBkzhdP8QUCi
   57yS0HEB+Ksmly3aGtsvE2TWXnk8tl0WLjFTjlBnMyTb1ICO0hQGyvXti
   0F1NYkNHNwMdYsgMR3LwPWFhwnEd7Ml0QKaL+zlWTxqM4+gqW8jbGM6U+
   XiLX2tV2iJyvLPWIrMYc9qW6aa1gB7W1gdj5b6uz3DcjShmA2WesJF09T
   VchQXE+x/oJoYmX7f5UR/KTGrggEpNHqILE9xovpHbPIccbduI6m09EJn
   w==;
X-CSE-ConnectionGUID: 1CgdCp6nQS6Q/pJ0+buUdg==
X-CSE-MsgGUID: 296XTB6/TDO1IRjjgXkHZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78869743"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78869743"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:49:05 -0700
X-CSE-ConnectionGUID: d2Qu+C2NTJOdJ6Z0amNnPQ==
X-CSE-MsgGUID: /FRO+juXR4qywqDmV2LS9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259510102"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 06 May 2026 01:49:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id EEEE995; Wed, 06 May 2026 10:48:59 +0200 (CEST)
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
Subject: [PATCH v1 0/4] PCI: dwc: Drop or replace unused linux/gpio.h
Date: Wed,  6 May 2026 10:47:23 +0200
Message-ID: <20260506084858.867884-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The <linux/gpio.h> is a legacy header that is going to die.
Make sure that PCI DesignWare drivers do not include it.

Compile tested on x86_64.

Andy Shevchenko (4):
  PCI: amd-mdb: Use the right GPIO header
  PCI: designware-plat: Drop unused include
  PCI: fu740: Drop unused include
  PCI: visconti: Drop unused include

 drivers/pci/controller/dwc/pcie-amd-mdb.c         | 2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 drivers/pci/controller/dwc/pcie-fu740.c           | 1 -
 drivers/pci/controller/dwc/pcie-visconti.c        | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.50.1

