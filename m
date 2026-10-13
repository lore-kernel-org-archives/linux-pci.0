Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E06513566;
	Tue, 13 Oct 2026 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929079; cv=none; b=HVPqxRYrRqQutNoHeLscvusn1WCG+nh8kEnemCH8R/dTFJk20iVViVSgwLmSCNPjX6LNMmdXW1NJSOY/8GckXV6SPi8Yj9epKVhZlTZ+IbhNmKQc9z0kZaiTMG797qRmPTU3YQKxOz/HZKWVyuy6stGl6cJ4GpjeVHb0kG3lTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929079; c=relaxed/simple;
	bh=nZHBSV3VyOMEAL0LuI6eUfdtDrQ6m3YE77+WsUryVQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPHiW3Xe2qEoUG9CJfNAFL8pyxTojQvQ11I1Z8voekfrMbuBnW9a8FPeLGX2rwhDuNldHmbQxe6/5mLpvES4o3GJzXjq0MCTz47GSCI6GcmcYt/rfTeeBkWeK1Tkdqy/jVjBjgbV+UWHgfwRvT/vIlUGH8aP6VLejLAHOW/8QUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJeU4Kf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJeU4Kf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6350D1F000FF;
	Tue, 13 Oct 2026 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929078;
	bh=q7R6tLaKMrnhiYMCpQEIBY4+ztBWPJj02oLmWr3zD2o=;
	h=From:To:Cc:Subject:Date;
	b=nJeU4Kf7A2ZSxV4/oIrv/+m4qhi2DPQWNhkyFHU+DESOAf5yJulmXe7xvyDk0w6nk
	 ZOPE/RCgVdYnlCZcbsCNmMnWSV9s0BGx4r1UjkkmZ2e8b7YfxL2almnq8fnLZrbNL0
	 Ap66yNHiGLfCHF4pqqYTIrRYUGWV60zpMJjBvQ3tKf2mSNFYYh1MN8KdQx7bp/uTsP
	 us5r4B2/OKrQ/BpEj5C2azn9LDyzFzjTwSadnescPhT1LPiH4gkSV1ApLX8BHmNlOa
	 k9uKOw4o48oOCTDVpXLsAl+snuqBO006lYP42s8MykuOlmLhddCxxNolvcQdbK6oBm
	 7Ty2Yik2PBAwg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rosen Penev <rosenp@gmail.com>,
	Rani Hod <rani.hod@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 0/2] PCI: iproc-bcma: Use EROM instead of devicetree
Date: Tue, 13 Oct 2026 17:04:19 -0500
Message-ID: <20261013220421.1588051-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a combination of these two patches:

  [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
  https://lore.kernel.org/all/20260807160526.379-1-strst.gs@gmail.com

  [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
  https://lore.kernel.org/all/20260912043626.437-1-strst.gs@gmail.com

I think it's a little simpler because it keeps the use of devm and it
doesn't require two pcie-iproc-bcma.c patches.  I didn't sign off on the
pcie-iproc-bcma.c patch because it's Semih's work except for the minor devm
adaptation.  And the commit log probably needs some work, but I don't know
enough to describe the platform/bcma driver issues.



Bjorn Helgaas (2):
  PCI: Expose devm_pci_alloc_host_bridge_release()
  PCI: iproc: Use the EROM outbound window on BCMA

 drivers/pci/controller/pcie-iproc-bcma.c | 40 ++++++++++++++++++++++--
 drivers/pci/pci.h                        |  1 +
 drivers/pci/probe.c                      |  2 +-
 3 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.53.0

