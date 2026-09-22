Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53689387363;
	Tue, 22 Sep 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088400; cv=none; b=sWSfY98+zmIvzHAVtYA2wUnhlgxZYXYLlLsv8Jb21wEr/X9yXOP/ARgDVO+sr38GGOALAhTCEFX7fEAtpDYwbEaWyIh3CswxpUNbvXtbCgv13ggni14iA4S5+/ABBH42ffvaanMAlBimLXzanvbwnzzufeGTDYPS6Rl0uMtoslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088400; c=relaxed/simple;
	bh=4xreLxQ1I340fogvtrKewsFN4s6TZwujc09Jws6cjCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZad5nKBi2ENxkzJt5j14UVfbrOnRnEPxi7Jwk/N6ndvQtM3hpClOYdOA/UWlfjDgqUNrN7iQixh7y/WHXFf8SGY0DzrFufHWY5cxJK1a1yYqhHLsf3cW4vhtr2CKxLFDy+Tm7+H5bBaV/n7tosUtVqMaG+zdfwzUHaR5+5XsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/VYW5qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/VYW5qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53081F00893;
	Tue, 22 Sep 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088398;
	bh=pQWvfVhlkb1UP/GbghYQupF2WXF8RruUNCemknW2ZEY=;
	h=From:To:Cc:Subject:Date;
	b=A/VYW5qpfE2iV4K7ECNBuF46X9KAP1T6ERDY4JVV3Hn6bmxyC7uGfIA27ccuTSIB3
	 1CtlOG3f9l7Nmd2VAN7NP3ALhmvTzWtrZEhwiQBX3eX10aVKRur6OBafyASSRT4NbK
	 ss6cs/yUVhsMu8j/WWmI9gQnJd5IK+6ztL1ZikQOylavh4apquK1mG8tbZ7mMY6rPj
	 e1GaFX5VPNNbCus80doZ4rh85zbDZb81lKLwCTWzo1s/jznobXTRvlp2WineYp0oQf
	 57f7GppftxuBnULVtkSp2UWybBdORg5/ITqtRjHaS8o/DxevzCRc8lEJVCehvcWD5L
	 B9Dy4013Em0qQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
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
Subject: [PATCH v4 0/8] PCI: rzg3s-host: Add PCIe hotplug support
Date: Tue, 22 Sep 2026 17:46:20 +0300
Message-ID: <20260922144629.586997-1-claudiu.beznea@kernel.org>
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

Changes in v4:
- simplified comments in patch 2/8
- kept only DL_UpDown changes in patch 7/8
- added patch 8/8 for the .reset_root_port() support

Changes in v3:
- added patches 1-6
- re-worked patch 7 to use struct pci_host_bridge::reset_root_port() API

[1] https://lore.kernel.org/all/20260630141720.3938514-1-john.madieu.xa@bp.renesas.com/
[2] https://lore.kernel.org/all/20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Claudiu Beznea (7):
  PCI: rzg3s-host: Follow hardware manual clock/reset initialization
    order
  PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume
    phase
  PCI: rzg3s-host: Drop nop instructions
  PCI: rzg3s-host: Move host configuration code together
  PCI: rzg3s-host: Move suspend/resume code into dedicated functions
  PCI: rzg3s-host: Move IRQ domain setup code
  PCI: rzg3s-host: Add bridge::reset_root_port()

John Madieu (1):
  PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

 drivers/pci/controller/pcie-rzg3s-host.c | 815 ++++++++++++++---------
 1 file changed, 508 insertions(+), 307 deletions(-)

-- 
2.43.0

