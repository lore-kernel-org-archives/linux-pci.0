Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235588;
	b=e4LwuC/B/CSwG2zCcgIMCVkG0P2K6HlDWq3EPVKflxsdNCt6qnW4Se72y33rd+1UtkQd
	 JT20KF7vSyEPFvXe02gptEXDFVtDE2ZEBotikwILxvndM9/bv9k3PrBIYPE02PMIQaCW2
	 3OHfHkj35pslZ6iElD76Yel//nbZlPQxTjz2hPxF8e31LUdU/8V2fhfW9HvpCuSSaaZiQ
	 Ne4ERGHTtzXH1LBJhZWgoOuJRgt+o239ntFPpwMASrnieb1mcvjjl+DbApy3N5szs+vcS
	 J9lRuqRp1jBAM7i+UE76SvNrmuUQOX2PS9x94I8dy8gHTpfVaTctark4UFQn9T8ow+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235588;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4dO7Kk8Irdp1/wDKALWHpzE6RktrRmUCnBZYjDwnKdM=;
	b=iDVv1AS6VwtaM0BZ/FLhrzN5923zyEQcZaGvh3qtQ6eR37bd/G5JJqvF/kgM5K59pklN
	 ljXE9td3tcvKut03uhqzIkxDtDlpQdDxD/Bn3NDIMsN/LZndxzqgI64XQ/kLBhF4MzL4U
	 UoD0PtLs/9y1Q79RyWFdH9XDfRQSDHI7LC8JwBz4F1B0qlIraem9uoPxjVJYPhC1gBqCn
	 xg0w4NFV0aCenY3VJCrRFrOBF1WhpdjAtYRCybjCeoTfz/+zWhC0qFj3y35goUcI8bPpg
	 jIfNHqHYBmKBVSv+EZq8jbc8hDY69E7ZzPpC/JqT2ILylwLXnQVA+UQvXcR0BtT1ddQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bEIMojpx;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0A606A330;
	Mon,  9 Nov 2026 14:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F0A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bEIMojpx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794235587; x=1825771587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QJN3AYXd8e86OnJC0HWIuXQ395KyDk8WoL6LFNdEsvo=;
  b=bEIMojpxeKUSlVCUk1t7jGX+3Y2L9/Tsl5ht7G6/UWhPOK1wMv7VRGjd
   SF7JcooJB59ApYxwu/spXnC1cIEfoCmWVfRJEx766IDqtXbOCUdI+jrAn
   HRXuh/zf4U2W0qlqK7FwJMPqVc0qqUBumkLg/E+l2wzcwoFil7FRSQinB
   cKUxehLlSlRxPSP5aCcrLqa+534FFv5m7hy231MPeqyrWa97WUgJMz+nA
   tU6OsBuULQPTjGd1qzbv0pDe5sWWODMTmci0lTxlHptrI5GNTU05PDGE8
   PVCfzxW0nChyaszOoJvYBgQdiydt/quJogERfeaxzpwOk2W0/6yErC9jD
   w==;
X-CSE-ConnectionGUID: YHHbLYJ9RDahSzkX+nKJlA==
X-CSE-MsgGUID: 08M9Zgh1RICZrrCuNzv5HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2856388"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2856388"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:27 -0800
X-CSE-ConnectionGUID: BRdLeSU6TI+yKLPM8zsLqw==
X-CSE-MsgGUID: J2QzgfjbSYG2gvFSyIdkiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9739165"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI: Fix hotplug memory distribute
Date: Mon,  9 Nov 2026 16:45:50 +0200
Message-ID: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
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

There are a few simple to fix issues within the code distributing the
available iomem (and ioport) space to bridges (to allow using it during
hotplug). The worst issue results in violating window granularity
(usually 1M for mem windows).

Ilpo Järvinen (3):
  PCI: Fix NULL dereference when shrinking window without optional size
  PCI: Fix start of available space for the next bridge during
    distribution
  PCI: Honor window granularity during resource distribution

 drivers/pci/setup-bus.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

