Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06C3BED1F;
	Fri, 14 Aug 2026 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716828; cv=none; b=RFsf3fH7ZaG16GROW8cb2KLot3NLBSsiasgMre9eoIq5fuCnl3Q04BteM9QESIdPoSx6EyoiOsli+cr3D3Iyb3zSHEqJZumu0TzNVw3pOb6c7R8XW+SqaFi+lZhxw7L0FuS9kE9ps9wCACUL4FqYvx8JCdyKh/6a2CK6ygj23Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716828; c=relaxed/simple;
	bh=c80rJCuf1FetCMePt4iaLPuMlo7RRkkw6AJCrdDNZQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOKVqHMI2iaxfDBDN3ts+iTmvtQZR+/xEdKS1s/1Id8wwrQXl2HuvJXUqDBPw19zPDgfuEFpH7Rsr4pHT3OmsqovTwCB67ZGDXPR3BZRMXvnum0Ze4vu7db+pfQz69Df64SRVwYUEFQH0NLFqbq3iVdFOxfkD/WJ/iWFYnEIyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F61F000E9;
	Fri, 14 Aug 2026 14:13:21 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/7] PCI: rzg3s-host: Add PCIe hotplug support
Date: Fri, 14 Aug 2026 17:13:05 +0300
Message-ID: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds hotplug support for the rzg3s-host driver. This is a
continuation of the series John posted initially at [1]. Along with it,
prerequisites fixes and cleanup patches were added.

Series applies on top of [2].

Thank you,
Claudiu

Changes in v2:
- added patches 1-6
- re-worked patch 7 to use struct pci_host_bridge::reset_root_port() API

[1] https://lore.kernel.org/all/20260630141720.3938514-1-john.madieu.xa@bp.renesas.com/
[2] https://lore.kernel.org/all/20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Claudiu Beznea (6):
  PCI: rzg3s-host: Follow hardware manual clock/reset initialization
    order
  PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume
    phase
  PCI: rzg3s-host: Drop nop instructions
  PCI: rzg3s-host: Move host configuration code together
  PCI: rzg3s-host: Move suspend/resume code into dedicated functions
  PCI: rzg3s-host: Move IRQ domain setup code

John Madieu (1):
  PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

 drivers/pci/controller/pcie-rzg3s-host.c | 946 ++++++++++++++++-------
 1 file changed, 658 insertions(+), 288 deletions(-)

-- 
2.43.0

