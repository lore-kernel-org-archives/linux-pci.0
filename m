Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847886;
	b=Tc/VPMMdPzOgOKkrxeiNun1y4US+U2Wr+SDtTJmdcS0ZKNhqLhIs2sYrDQMwnHHBLGY2
	 8KtQz5ArULZps1DLVYLYFdsLUR7VbFvqAyg0ivTYwYHGlxowV9Eh1O0LP8bPrLAdMOxgR
	 0saZVW5eOpmKNOIpgQb1q8o4PRnK1u62CqHHq/GoHJTLdgoGnSpNohyANdh5Dc98hZUVP
	 xygXjwUd5Twa8ELWtX/jUTcqNCAS3wLmXS/kS89j30+YOX1MlTpNE2Lm0Tuk023Y89sGv
	 9R+uLywadkRJy07m92flRKBU5l2+VZQLOwzygsVT3eB5oBndveVViybi08DyCQgOi6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847886;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Y/to8FbE5YYlWSFO4zTlQ+B5Zi7RN6gYp/qeiDpCb+c=;
	b=oZR1O2DgiTRrL4vX1Trfbed2xhnZmWHGXjTyhhNzjVh6xapNS+ED6jz4aJnX18dVCqIf
	 p9XXxLTBCkP2QUa5Z3d+cN+PqioAyudw87RdgmX5ccBA+4bgt9ZqdHzpD8fRKog+aSnC5
	 FsfMZG1Bd/UzGJbRi2BIAGp56/ecwiT6cT5nRQy8P+0MCVvyTw9IyQirb8yTtJDWFBz7P
	 fsQsIky3EbBrDVU1mGYSLD1btlbYGcDL/NWOgaNKRtBoQPTWSaVgmNW6RCu8p7jxa2cyk
	 Kk6YKtSx1rq4i+Cc3WPBWflFzLmPHKYEzRObMt+hH8Rci4acY6pRC2riyaMOwgDuiUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WwqjBALW;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37416606A31C;
	Mon, 16 Nov 2026 16:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37416606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WwqjBALW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794847886; x=1826383886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y/to8FbE5YYlWSFO4zTlQ+B5Zi7RN6gYp/qeiDpCb+c=;
  b=WwqjBALWw3OBoHppM/qpL2XlPlLMhljw7SvjNo1hUwW2afYYDa/ZAvTV
   6fLwvx5MZxxV/BMBLZ0DfG/IfXqKS5bsc2wkLlwZMb8+T7Rbas3b5T8ha
   3jGFpZ2eV/inQrtdNtiWGWK99ai1e3sta08Orz4KlKx3QQkKrCesbzk/I
   bfLwgUF3YuRMU8HYsbbb73E5QTu4RNTa5KSR82u5oyPfftR2/sEK4lj/c
   IX1nZPczgCYMveD7PNkFhJmg0HIzoMKqfsYQ4mRcTaNzB/14MlB30WeyG
   4tQYoQxIYGrv3iaRtjaFh1t5olCL8Qkwle8Wagn5Q8Etk16vOYg7e8d1Y
   A==;
X-CSE-ConnectionGUID: B4UU86T7RsaJkwobuu7DNg==
X-CSE-MsgGUID: WbUfqfrqQrm0DTfPWBIAKw==
X-IronPort-AV: E=Sophos;i="6.27,217,1787011200"; 
   d="scan'208";a="34067393"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 16:51:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:6624]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id 4fd3e899-5759-4ea8-9ac3-cac7db866744; Mon, 16 Nov 2026 16:51:19 +0000 (UTC)
X-Farcaster-Flow-ID: 4fd3e899-5759-4ea8-9ac3-cac7db866744
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:19 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:17 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Zeev Zilberman <zeev@amazon.com>
Subject: [PATCH v2 0/3] PCI/PM: Keep hotplug ports that can't wake from D3hot out of D3
Date: Mon, 16 Nov 2026 18:51:07 +0200
Message-ID: <20261116165110.2773301-1-avivb@amazon.com>
X-Mailer: git-send-email 2.50.1
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports on
non-x86 platforms") lets native pciehp ports runtime suspend to D3hot
on non-x86. The PCIe switch ports on AWS instances advertise PME from
D3hot but do not send it, so hotplug events such as an ENI attach are
lost on Graviton. x86 keeps the old logic, so the problem does not show
up there.

Patches 1-2 handle existing switch devices, which advertise PME:
patch 1 makes pci_bridge_d3_possible() honor PCI_DEV_FLAGS_NO_D3, and
patch 2 sets that flag on the Amazon switch ports.

Patch 3 handles switch devices that advertise no PME from D3hot: such
hotplug ports are kept out of D3.

Changes in v2:
- Patch 1: check a copy of NO_D3 taken in pci_pm_init(), so
  pci_bridge_d3_possible() does not change when a FINAL fixup sets
  the flag after portdrv has probed.
- Patch 2: reuse quirk_no_ata_d3(), renamed to quirk_no_d3().

v1: https://lore.kernel.org/all/20261115171831.1498006-1-avivb@amazon.com/

Aviv Bakal (3):
  PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in pci_bridge_d3_possible()
  PCI: Avoid runtime D3 on Amazon PCIe switch ports
  PCI/PM: Keep hotplug ports out of D3 if they can't signal PME from
    D3hot

 drivers/pci/pci.c    | 22 +++++++++++++++++++++-
 drivers/pci/quirks.c | 20 ++++++++++++++------
 include/linux/pci.h  |  1 +
 3 files changed, 36 insertions(+), 7 deletions(-)


base-commit: 23c62304dde29abe92013d85910d03a77dada35d
-- 
2.50.1

