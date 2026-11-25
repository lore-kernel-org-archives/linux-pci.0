Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648314;
	b=yeoOZXSfJ7KOMsYLajiGBHUuBKzVdj/yWinPFowRA3HxpOKMRDe727oVnf5FEUYS+5A4
	 mFRWJ/v+Me3muvo4o3Dd87mM89WWD1iZV6mUYoupnqVfBB1k2s8zScAfzY3ML1u9r9xnH
	 ng7jmORcGMOZ2UcfnJlHXZXS5ZYeAgTuNYznjNwArbmF7DqrKNUOmRFZcmnxIQ/qO5pBR
	 nQluzURO6JlWGvAbv/c5Mci/oYddeallELsr9K/4dlS9G90jvZP7aZpHVxJAMNif6xolf
	 b4AU7NKjKP6TXCzLTnlvV7pl291hvOiqhyBHRQS6Sgx137nqkfBdLD8jg3of25DJ+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648314;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xei6wpjeykoKjkdwpsJIscvNqWsoeVhdm4F9rN4EARM=;
	b=Ae0NlUgC3cnluFZBbZR6iuLm30L0cWDvQW5zCDEQExzxvEikkrHapv+czz5NZoEOmXOV
	 aF5h49JuUcuj1nMEkg8mejtmO5+J0t8k5TUlGvjy8hSRH6nBIceLqQOxGPSezQaKPL3cQ
	 u+KHAzB9/Gz6OWtcYVJb7ZK2GLu6omZVXlT/dqupJTAm1LQr0ppZbh6u942Wforlbrbp8
	 dnq2x67NvtNJDXc3fe0aTzdEDy0DnOLdCaRWwUx67ZqipdfNh/I79rN8d9lkBIoT79aYy
	 xt2cze/CqQg2q3Up4T86gzcq/TA2AwNtDfmt8nV0p9HTrFztgcx8baifsM2xZcIIbRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPKguQPo;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E58606A32C;
	Wed, 25 Nov 2026 23:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E58606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPKguQPo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648313; x=1827184313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzUiYw7RDREZjYycHCyL464Tmr8VJwaBAZHAwVtU6ZM=;
  b=KPKguQPo8udx7QEo6TSeZLa5Lpm7/Ti4mvTiIfhONVJnhoUota9y1k3K
   xH6uwj6MhL2+B2K7Lu2RGwGV4jJoZZUz8gLo2bJmZ4r/tQ9Z7pGCQnULI
   M4THyC9FFZA0CYcmULZq6mX1Kj5A2jGbudwpHqwJ5s69UqcY2tzFEuntj
   0W+y6XgwT7VHH91ES3h0J4zo3dIxNupnLkFUagxVGPpxV/Y6SkRGlY7K5
   yghL+Bg3H1MC84mT0GfuAV7MKeSFytL2Flw8EKwYC323CpxXycYLmHVTT
   77lDvO7+jLSB7Zn9fcgvlrZfWwDm7lPFDrGHuPQfe/bbZ6qWn7/bG3rUZ
   Q==;
X-CSE-ConnectionGUID: 3YYHfpiaSBmXhT7Pn4FOQA==
X-CSE-MsgGUID: 28Y9emnaTISdG4gx/7JoUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4451826"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4451826"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:50 -0800
X-CSE-ConnectionGUID: +eVxzqAmRsCPSRlK11uPcw==
X-CSE-MsgGUID: beHvVDKIROaw91HVJryJew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11874527"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 13/17] parisc/PCI: Convert to pci_assign_unassigned_bus_resources()
Date: Thu, 26 Nov 2026 01:09:12 +0200
Message-ID: <20261125230925.2441-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Dino PCI bus driver assigns resources using
pci_bus_assign_resources(). That function makes bridge window sizing
disjoint from the assignment phase and is going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be a no-op.

Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Helge Deller <deller@gmx.de>
---
 drivers/parisc/dino.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 286f4f75dba7..da75ba15faf4 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -1050,7 +1050,7 @@ static int __init dino_probe(struct parisc_device *dev)
 	 * if it isn't, this global bus number count will fail
 	 */
 	dino_current_bus = max + 1;
-	pci_bus_assign_resources(bus);
+	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 	return 0;
 }
-- 
2.47.3

