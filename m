Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229847;
	b=d1X6to632mBKxt60ZjaJJHJ0t+GKj83HcGcSjA/0mzlygnX+jocxw+oeb51mE81d/a1V
	 Jf7mKsgsAxuQv5PJP/mPOeIBD+xNYFalfn4sqknaW0LE/jjimYAXsj7g+xrp5L+le1KmY
	 RLL3bPx0taDUoi2LR7/sXw7lqL/Eaj3gfeo95nPT03ncpGAdGynIjgxkC1WaI1KtVZT1z
	 zPo20RfDCKaHqwcDeRDDwalnH4Bw0Y9jyMgW59sBCv371xlfoU7oFF3ePtqGwf8h3QRnt
	 LQxitvX53qXkxDx0we90UECbR0eK1lbTSUpDoxDRKzeOYuqXOlBgupm6nx76/4Wyhew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229847;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/2V6cyBxWdherczfm31fZCT3myTE5DFs8b6kziTZFDE=;
	b=t+HNPQsDK9FidVY//Y0B0hpdrXsG+N9dHTeNRCP45gqghc/SnAkOalpJw1dvssB9hXbS
	 YdncRXKx7RzZAncCQufT4j2LrUVAxEr/P7fH5Sf2u/SPAvRJf39YDmfmdMXlTjKScmed1
	 vt31GdKtFulRYAbUr4+rMmjRXVHL4UdS+reGKeoYL1jTVRu9nFLmci1zihvvT9a7PeatI
	 uxqAVOAG8wied7WhgODzRg+ZWaduyZGLPFnKhToDkQIA0L3Sv3E0bMFnDZ2h7Oz0nTeXS
	 OLW5O1rd+A6AEL5i46Nnte7rNEfMC9s8QxN24qBobJLUcJ4h2F2R2LAH+GT21+nx6RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dCvDMcdv;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B35606D804;
	Mon,  9 Nov 2026 13:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B35606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dCvDMcdv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794229848; x=1825765848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVfe0EdQ0ADK9rlXStdj2gNQkQxng4CaytjOvju+JrI=;
  b=dCvDMcdvbwR3FggmUiM583OEIK3GX06CYwYsdNUAx42zptdpVQxngmQG
   Y38VJuO2EMM/zgOql4ny8D6fcEBmJgL42Xpbnr00fKiBYTBncSF77tHIW
   EC3WWQsxVyw4YvRuwSkdVGis7moW11qIZSIjKWx+xOyxwJvB3uBN1Z3CD
   fPslcoFXPOF9yxSmxcuHLuVz8bC6GIL+/+FHxAOis9KM4zLYIt8s3bxnd
   dgMEhd+sUa9OHauWYw401XSKXWi41LdscLgOy3+PquHIPgelI0Eq/v3Ub
   5tc0AGlmWSktVSN0k42KZFtIcSaDGL6kw/oX3ZNLtrC7Rmb31OYHXZaUW
   w==;
X-CSE-ConnectionGUID: S6FMz04HQNOCkj1lQXXtpw==
X-CSE-MsgGUID: ps/QnY6SSfCGDV3CnplKaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2843601"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2843601"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:10:47 -0800
X-CSE-ConnectionGUID: 4fBXfPgtRFGEsMcsVR789w==
X-CSE-MsgGUID: Z21x23CJTFGEmtrWRwK2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7683709"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:10:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] drm/xe: Remove driver side resource assignment after BAR resize
Date: Mon,  9 Nov 2026 15:10:09 +0200
Message-ID: <20261109131011.1815-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
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

pci_resize_resource() assigns the resized BAR and the other BARs it
released, or restores the original configuration on failure. Calling
pci_assign_unassigned_bus_resources() after it is redundant. If that
call manages to assign more resources in some scenario, the problem
should be fixed inside pci_resize_resource() instead.

Remove the pci_assign_unassigned_bus_resources() call from
xe_pci_rebar_resize().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_pci_rebar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci_rebar.c b/drivers/gpu/drm/xe/xe_pci_rebar.c
index 7e2c7079b6ff..f47b3c039abd 100644
--- a/drivers/gpu/drm/xe/xe_pci_rebar.c
+++ b/drivers/gpu/drm/xe/xe_pci_rebar.c
@@ -100,7 +100,5 @@ void xe_pci_rebar_resize(struct xe_device *xe)
 	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd & ~PCI_COMMAND_MEMORY);
 
 	resize_bar(xe, LMEM_BAR, rebar_size);
-
-	pci_assign_unassigned_bus_resources(pdev->bus);
 	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
 }
-- 
2.47.3

