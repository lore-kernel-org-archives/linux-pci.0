Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182566;
	b=CKX/0KI5AEEX+Lt6Ce8awiDbzJmKOWJe7rYjUbwmx0Tg1pf3GUpzucp6xI3UNH03GPJh
	 DThJ44Y3EpP8qkD/CTSM35eyg9pT4bDROlf6nLyem5+OTr+6TryEJ6+aKtOzM7HpqFX3l
	 sOESnn3bRVmFoKKEI00cW3MlbFnmsSBLTbr41fMfyIUMogvTGON9sTy9VikcddaNfuN0f
	 8B3EYF5xA6y6VZVUIcbghWNKUDyqRyujwD7EFR3kYihbKspEUD3VeuW28Xbp66pemgRNi
	 AcscAbLnMVGbo8nPh4RGf1jcqhC0qOG2dekbiohMy3DKNMQxE2Uu7KBt9TVI8OSXewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182566;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/ULf3ecznQa8DrJFfJ+RJqkqm4B4+iOnUGDSUrrpJpA=;
	b=40Xg5pX0EBosE1W6MBo50q8HE4jkWcVwvkvZnXzXsxYTb5/ysT1a+iyOlI7Y1Lka9oEs
	 6dOZf3rj/rFKUwoF2uSRfNfyP7tdCCY4y1BA564OjVeiRGTlNZUzRUVZkD9+5V/VTIHH8
	 rhWe4R0HoIeD4DEee4A0KpaXvBFFzRbcK36we9/rt/XVO9PbGTpWBufUHwHUEy20P1f6B
	 iV+U5bzkO6L910bQIQ8gQLuF6IEWz11jLfPwDK56Obi/7pIjC4rSbW29/m5kTFFUskee2
	 BL5IyUnFDZiK+nz4rfCf3WmBCe+6SCuWCF8stOvVi3T+kpfpmKPAKlfNScULPyghiaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ms3vdiRP;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD0606A325;
	Fri, 20 Nov 2026 13:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18FD0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ms3vdiRP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182566; x=1826718566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gFAtvS5XpXkj88iY9N/MUmoAcl4qjJ3M1kivUL44Pfo=;
  b=Ms3vdiRPpfFWvnH4a8fpEtgiBt9x74mGxIIahxZgA4gyaP8QufPne/mu
   IVR5149PGRp0xmPNlnkRp7FCwR1+jyKm84fS+OA0GrC8E8oLrTIk53VFk
   i0PGEJSeDt14vqM1J5XRr8H4OVK/xBYNG7LOynsp1PoN/q95o1xpTLChh
   pZG+ErfptJ2u8SOdFxfx1gJi5Pp+Wo/wodR9dhihhPhg54lt/qFddGbmW
   ziLf61Cpem3NZj6bWYvsNfNMBHRItT57pdglk5BFoRLOc2odS4Gko6Xb5
   HqwvJ4+5Gc422SDTDeSp3/sg6MFNk4XDLkU5pShY7cMDRgFFPFSJmNtO8
   Q==;
X-CSE-ConnectionGUID: Ot6z9CJgQQm06/jJus/9tA==
X-CSE-MsgGUID: VWpLf2ODSsuNL//jAMtLHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3955209"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3955209"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:26 -0800
X-CSE-ConnectionGUID: SvKJ4pGeTka5aep35jGSig==
X-CSE-MsgGUID: /E0lJEDkSKa8hH/tr9JfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10971458"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 12/16] parisc/PCI: Convert to pci_assign_unassigned_bus_resources()
Date: Fri, 20 Nov 2026 15:47:07 +0200
Message-ID: <20261120134716.3027-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

