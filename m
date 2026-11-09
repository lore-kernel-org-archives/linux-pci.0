Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258512;
	b=BnT8XlSIipTEttorTwtQWr/h1WJyfbn7imXoFNm5PBxc6I02MDadVYGFBFEDvOdxpXDA
	 HvBndM4h0YO5cVDwxgJlLbf2bCatYGSoc2tAu8SajnmKTtQaX1hmvRvUhWxuT3DRbhssE
	 /pKLV/RqeRuXWIyV+Ss4mSXqoq/XmM9oGBrNsTgaA/fUJLr1ULIfvybpXKgAYbOmp4ntH
	 yXpiKazy6N5dARYIgu5fhQfOA2M5Z55WrUSuObCmN70w9JtamM2tNGYNQHzjSd8xsCjAi
	 HVz/YEn4mekBGbeeB/9iqT2HITg+zjQAOBppuTKlfe23W20XIKIMB/K7+bQmiPLdgKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258512;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HWBGFbq75w2+ceZ03MW5J/kwbImT6thFXGbjN5F7R0c=;
	b=vZhN82bE+lW4QEak2IJ/JXyEC2HJQT95v4vufwxbr2Qdp79scpzpFk58ySHSDRAglzCl
	 H3n1Wmk6v6iccARV0v/j3E/feVMpa5rasIrDv0jNDijpAsIOnN2lZG9DLtQn0/yHFlJya
	 XUe3ZzMRGj5okl0WRbkB2auEyfYfrsw6P9H17/Y4CYG1BDMq+RyUUpnqpBlM69gWIOY1j
	 TDQDsF23lHfDdhirJLsffPq7KFfuWUTjnk+bUoWaYCvHZubR8e2Sx4Ijlv7D02dAYMdeR
	 6cpEZb9S0nGMG9hyVTN+e7oGALJmKpYVJNn70zmKBjI0EBoUVMVJlfLKCdRCUXi+0lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CEtE2J7C;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28155606A31C;
	Mon,  9 Nov 2026 21:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28155606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CEtE2J7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258513; x=1825794513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JauJjOoXBisy6/X+BtXdwpA49n/5J4KUoCSMpTCpLq0=;
  b=CEtE2J7CPvq2wsZQII3MEWBUawa+JwEDRXuaCJhqGSw2AJKB+FDCRz1N
   /r3SvDP6D4cF4s34EG/6ADHMnXExBlhkSgN3TTAyVtr50O1UGJVU1AFuz
   awjNkRNgJtEX6G5j7fiwbIB2sbaimbOw4q8nFvs0zkMl0FDYUj8lJOkf3
   bchvuMf5UB4QTWz/NFhF0kIfKkfUrrBAk1Cl/Tgcvh+wULzkGZGrv7qDw
   q1KZQDbY+K44zVqjR12GJCs09xx5Zy8kVWuauTBBEiZ4ntNv+wMppAthr
   5I9zNp2sIPeEWaTmQCrsLbGEaqTn+EEQabt1ToZcDixNAa9v9OrNbKnBm
   Q==;
X-CSE-ConnectionGUID: 9evKlTy3T0uWagTmEuC8hw==
X-CSE-MsgGUID: xkgyLTe0TtuOU1iPdQYFCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2891055"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2891055"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:32 -0800
X-CSE-ConnectionGUID: SigjcDhOT9aeDMk8xG9k7Q==
X-CSE-MsgGUID: PqyddaEVRn2p+G6BTbUL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9824492"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH 07/11] pcmcia: yenta_socket: Always select CARDBUS
Date: Mon,  9 Nov 2026 23:07:07 +0200
Message-ID: <20261109210714.3862-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
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

YENTA selects CARDBUS unless EXPERT is set, so with EXPERT, yenta_socket
can be used without CARDBUS to support 16-bit PC Cards in the slot of a
CardBus bridge. An upcoming change makes the PCI core ignore CardBus
bridges when CONFIG_CARDBUS is not set effectively removing "partial
CardBus support" from kernel, which leaves yenta_socket with no device
to bind to.

Select CARDBUS also when EXPERT is set.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org

 drivers/pcmcia/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d1d25aa296ad..92c34553b1ba 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -73,7 +73,7 @@ comment "PC-card bridges"
 config YENTA
 	tristate "CardBus yenta-compatible bridge support"
 	depends on PCI
-	select CARDBUS if !EXPERT
+	select CARDBUS
 	select PCCARD_NONSTATIC if PCMCIA != n
 	help
 	  This option enables support for CardBus host bridges.  Virtually
-- 
2.47.3

