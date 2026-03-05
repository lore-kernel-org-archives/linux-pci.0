Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285D3E3D89;
	Thu,  5 Mar 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731146; cv=none; b=eXkbdlGaU2ptWhpeWOitoffU8issjCdQo4cAaIggr5mRx+9R+MSOCnNQE39jso09sTcqCACtG+xGJQdbgq69uLN4hCCq5F5m9w9zxUPsG4bJNfxEjbUXJWh5IdOZegiJsZP9gBOU9Esn781bjh5qrcEwzG7mYXNzPzbs14eUFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731146; c=relaxed/simple;
	bh=WnW6zvuQiHOprUoXP5Z/Ggtlnk2Ekwjn4Waa6So1imI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nfz0Ja3HXqTaL+Ada7XDbNxSGV5gzuPA9hCdr4iWxO5ZCBs0FOiOvu9Bap34WaLNOC0c84q8fMbwiQw6oj87MFznuw9tlhu4/7xNMFHmH0Y6f1E9wf++UJqQrVs9LWgsI7XSTPBm363BdhPwaWticIJcAd4kF3dwYkluc73reS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9fIWMgk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9fIWMgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772731145; x=1804267145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WnW6zvuQiHOprUoXP5Z/Ggtlnk2Ekwjn4Waa6So1imI=;
  b=Y9fIWMgkuUD//jBzmGrS4fnGrU0ny/8u6Kam+U1wAuvlGDKIyjByBjFT
   HO+leQp/Oin8wFNnJNEzZRUSfkDr74RZIbnbfR4OS2n73h8dJ+6nmdGdx
   tmWuhHEZWHPwJnxYXdTG5RSlBIwZwash6nwbGvA7DMKqCiBGBTgoYhUQw
   C4lMZHHH0N/+l6lnGYgb6xTFLqS4pi3Tjiu2MvtNhhfPdrWRlnnqg5FLH
   KqdpQyOrOsKrvGz3S0KQkYvDXNPgx70TsvWlcSf2CSmc9Z+4B4wH8ovul
   GEvSn7ublKQWTqRcwEho8+nq6NkNR9enTMXcGNu2TiQiotxjozvQV869p
   g==;
X-CSE-ConnectionGUID: YRZJUhxrRz64v/gqgH2f5w==
X-CSE-MsgGUID: BMKcOGk2TSafcgCe+8Y/Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73875027"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="73875027"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:19:05 -0800
X-CSE-ConnectionGUID: mcda0HkuT1C7uqw8cScRvg==
X-CSE-MsgGUID: uILyyjEDQiKeH0GkZ0/x+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="217884370"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:19:04 -0800
Received: from ray2.sr71.net (unknown [10.125.109.20])
	by smtp.ostc.intel.com (Postfix) with ESMTP id E50A76362;
	Thu,  5 Mar 2026 09:19:03 -0800 (PST)
From: Dave Hansen <dave.hansen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove bouncing maintaner, mark Altera drivers as orphans
Date: Thu,  5 Mar 2026 09:18:52 -0800
Message-ID: <20260305171852.3114177-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This maintainer's email is now bouncing. Remove them and mark
the code as an orphan for now.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c32d76a949979..d010689fa91a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20121,9 +20121,8 @@ F:	Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
 F:	drivers/pci/controller/pci-aardvark.c
 
 PCI DRIVER FOR ALTERA PCIE IP
-M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 F:	drivers/pci/controller/pcie-altera.c
 
@@ -20368,9 +20367,8 @@ S:	Supported
 F:	Documentation/PCI/pci-error-recovery.rst
 
 PCI MSI DRIVER FOR ALTERA MSI IP
-M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
 F:	drivers/pci/controller/pcie-altera-msi.c
 
-- 
2.43.0

