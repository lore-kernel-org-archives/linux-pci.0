Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763122;
	b=ND5NCtPGF34/xfhOTl5rfQmQE13PhLwdUy7cByrkEi++P/4T2gLncMCeSD8E03Ns8YQk
	 f0S9SB1hDA7Vzj068rfekY8ZFgPpqhbAkaJOof5dCjxtjoGzAu6PagOYTU2bmIWZmuAii
	 qbLgadjqiOaEz9rAz0z74WX277CLvCPFjp3mkjDHeCxqflS50mUqYIvDA2PrLmJfBaBbB
	 ehmj6IpcekVToDM8q35uvBBW1HDzqiW6fR3EK+Yc+at1M4fGw5pdnYIT1OSYFi8K/63YF
	 xAR/P4evOD49SnEU1BIug326lFtN/sHee66E1updkuTQnWW7860M1CRO4PdS24lq/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763122;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=W52FgCC87EH4hTxaBSBXsIORfGazek+ZlRVLcV8AdGI=;
	b=xUUhg5jW5XqQIojBf6ZfRMbu3Pw4DaYV//SuRyoHJjpcOfi7+4aPM00u052MHPiI4+7T
	 ezE+FACHQZn4MBv9PBNOsWAx2CrVmQ6yhceiodhfou0nG4IvGmdN/lgfciRdZGMjNEUsg
	 hsbVJ52hRg5OQkPGYXrXhrqN3AwmFkqjcWLgs8dmpcPZthmHSaAjQ/uHdDPEHT2ltRqQd
	 NpYV3x72MMdftZuqZ3/KvYpKRd0ax8QTY7I5SzRJcpfYu+nwzyNupuE6EI0AnnMMvmXBC
	 K6Axjje2PnLtbc6Mx1lNFLWFXOBcG0M6iIAxoiOLfYBuCTgl0Fs46JrWkQpibv0vjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=O6n4gR78;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CB606A31A;
	Sun, 15 Nov 2026 17:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B3CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=O6n4gR78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794763122; x=1826299122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W52FgCC87EH4hTxaBSBXsIORfGazek+ZlRVLcV8AdGI=;
  b=O6n4gR78S/wbhYVstY9DweFDwz2QTCJhTLfaGi2CSZ+7JQBJoH89xx60
   xNgPd7GrtFi/UJvjKHkIJvH1zA1QK3uaAc1hZ72kIWOO6DwZITh6LkhsT
   kJDrz3OhqcFFhG7vzYiwX95gcLk6q5bnZiWwIebMUhzmOnky/m/7WXwjb
   A/kR13l1OhYrEzgcOfTfunyw/efZl4VoDOYAHkDqqZGTfmeE94Nh7vreH
   dF6ojcbWWtqKyS1SgKr39iyTYtHaTW0F62bgXGrGt+K8ZZQ1R5UFoEze/
   qennzh0BV2GKJ5Oc8qXxXVpirnFAI2bk5pPDxWgha+Zi9H1ju8GmwTxWZ
   A==;
X-CSE-ConnectionGUID: 0iCgtbAEQbuVsXb8VeqmZg==
X-CSE-MsgGUID: r5MlY1BFROa3SOw2xlwvwQ==
X-IronPort-AV: E=Sophos;i="6.27,215,1787011200"; 
   d="scan'208";a="33971370"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:18:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:23374]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id c8eb6874-bd1d-4a7b-9dcd-48f77fea8dab; Sun, 15 Nov 2026 17:18:39 +0000 (UTC)
X-Farcaster-Flow-ID: c8eb6874-bd1d-4a7b-9dcd-48f77fea8dab
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:39 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:38 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zeev Zilberman
	<zeev@amazon.com>
Subject: [PATCH 0/3] PCI/PM: Keep hotplug ports that can't wake from D3hot out of D3
Date: Sun, 15 Nov 2026 19:18:28 +0200
Message-ID: <20261115171831.1498006-1-avivb@amazon.com>
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

Aviv Bakal (3):
  PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in pci_bridge_d3_possible()
  PCI: Avoid runtime D3 on Amazon PCIe switch ports
  PCI/PM: Keep hotplug ports out of D3 if they can't signal PME from
    D3hot

 drivers/pci/pci.c    | 16 +++++++++++++++-
 drivers/pci/quirks.c | 12 ++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)


base-commit: 23c62304dde29abe92013d85910d03a77dada35d
-- 
2.50.1

