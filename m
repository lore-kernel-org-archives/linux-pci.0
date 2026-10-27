Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117199;
	b=xxlqGStlD7IX9Gdel0VW5F8a7p9IVkLKJo0abORe/w9WpaZtqLdupEsTjPf8lEAjLq/K
	 TA9oxObLQJAhujfwJU2qzVhfNY10A4IhEvOXSAV8gzSCU7SlPEhyOC6q7qX2jc50WL7zJ
	 9oXfll7yX2hfpesk+mBeFydiiATPIUkcP/EgG1IXFbTcir8UlrNdpccD8bcc157m8tJ/u
	 bsYqEIqYqGqNzKWm34FPeFUwtuFpM7Z1g/JlNZLqbfG1psdC9WH/w/Tu325Rv7n7mz9dy
	 VOgECjsG0QMPx5WBCBuSp2o3g7c/FBtwHECMgE6ulg8YD7Lp8usZKrQ0VuYwxDksSTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117199;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O8bPfaRyx0puHwo3pq2Wa16iNk1SjfMz5sUL/S/2c70=;
	b=dnW0rjB1LXUlPHR4ELrXUufGHDaXge4F1j9Iot/gvCaWLloF4fmsgJc+50hrPb6zbg8W
	 UEkjfnQ3rh63t5KAt8Pk+Vn8F3TRqhbf6hUKfdw+Opw8YdUj9Y8Fev2QB+d16IDCltX7f
	 F+KH14ImO86o5fx+llw1iZTmxYkGItce8eSmNbhekcQsUhxyJ/Z1oZ5JqP9C9th+T/lN+
	 SQ5DgzGsoGPVMLrbJ9E3J3a9EFGwZHCcgkQercQmNzIToy8itJ4sHwtaH88ihmZJ714aW
	 FzciD0lCOn5vq+pAket7MbqEdV/XTl4ZG/lwWQ2uyoYXprGkGnNnAH4nSxLDr3Qxh1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hFceXKoZ;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4D606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B4D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hFceXKoZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117199; x=1824653199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyN9R3FVS59Zc32B0w+pZo5QrUfYADf2EvPGAjl3sTI=;
  b=hFceXKoZ1QtfFtJbkzEe82zMZ78qQAz1JuQWfQBp6xWUvsIqnEDWppAH
   AiNM5qimyieOtUqoiZhyHfYb/b+aWdMnm94UVdBh02g0vNhCJnONVtLGK
   8dssiAijYm7V69mcEVid75kwV0EGUIkrzl+lQHafRqdChyDoVoM6kq62B
   s33X8DPCtRC8Y2Q88bBmwWuXIFy4CE5Agbn4SXtk4vWR+vHHomuJD32mn
   f1dqW3HHIa4XCHSLInmM5iNzET0dhE0Twm382QwHsIMTqEXedPoTYewgF
   m4GlBDTZBJE04ey6f3d+D2BfBS0qH5nwwIOYkqfofSIxjsRnvT0EdJuN6
   Q==;
X-CSE-ConnectionGUID: M0+xWKM9QI+KsUiuz1ZLzA==
X-CSE-MsgGUID: OzsFh2qFS+KktExvVBZH6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1711601"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1711601"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:39 -0700
X-CSE-ConnectionGUID: gxQL4JFpSmCz72BfZ4tOBg==
X-CSE-MsgGUID: DZ8mU9XlSsGGQSjy7zCQ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4956145"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:36 -0700
From: Lukasz Laguna <lukasz.laguna@intel.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: michal.winiarski@intel.com,
	djbw@kernel.org,
	brett.creeley@amd.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Subject: [PATCH v2 08/13] PCI/IOV: Allow bus reset_method for PF with VFs enabled
Date: Tue, 27 Oct 2026 17:04:41 +0100
Message-ID: <20261027160446.858300-9-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027160446.858300-1-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_parent_bus_reset() accepts a device for secondary bus reset only when
no other devices are present on that bus.

While that makes sense in most cases, it is too strict for SR-IOV. When
a PF has VFs enabled, those VFs are enumerated on the same bus. That
causes this check to reject the PF, even though its VFs are in the same
reset domain and should not block a PF bus reset.

Ignore PF-owned VFs in this check, so the bus reset method remains
available for PFs with VFs enabled.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d0b25b8979ea..261c7bf9427d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4966,7 +4966,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
 		return -ENOTTY;
 
 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
-		if (pdev != dev)
+		if (pdev != dev && !(pdev->is_virtfn && pci_physfn(pdev) == dev))
 			return -ENOTTY;
 
 	if (probe)
-- 
2.43.0

