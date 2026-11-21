Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226253;
	b=UM6loEZLilKpL2iA97AlM7INvyvhKF5WGepfkRrhsCQul0VlK9XLR2lu4Olu57t7OosS
	 eXdathbw0PkOwBEfD6iwQPhwADFsqHMJ+NiGao71v3fhmKK6TrEkN8ht9jUQzyfNPZusR
	 gyfNeNId0Evqbk1IXn4YMsqM2mNY4gOqNLK9skn8ad3PXqh2laTEoo/NRYS1JJYylD8wQ
	 cSP5Qeq2CZp2yVpEDBWp5GhD2lP3DXBSX0N/vKfDGJsfPkwn+78bsQgiHufy6OXC9k5bk
	 G6MiKxTBBENpOMU3A/D3Ez2YOQupNSyj4EBlMzlyFK3FaSgKoqh3lTmiZDAXXs1WWJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226253;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=6bykOydDu0O4FHmMNk7Jp7BVGe4iDBIyIZTVK6rs5L0=;
	b=l5MNL0x//y0S1v1ghhBapd8oH2X3FZKxajnuSwwCq6UDON4DRoSH5fJumhLxjBX/lE0o
	 XVCCKsLbDJTpOVLg+B+zRBwDvfNhm2zYgKoDoYCvXtyB1k7TdgZkouP5BI1YF8+JKc3yC
	 cl0i+AZesMfqla69keRlDSmPmcBFPw0x1/36qOUDZrYVaoZsLCxsirDik07GGQEbgBLdm
	 nKwOlB9S3vz1LjRXJNJh3sZoNw2Azv4u3n/+CusFGGsulhRFfZuVrvpcWtV1osqD8glsm
	 j3fMnvaWE5sb5l7VqNea8SD+w2qw6ehNVsDI2ds0ZmBWAMKIeQh6eytk8Swd7zkIukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfgtMgZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693D606A68A;
	Sat, 21 Nov 2026 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfgtMgZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A55A1F000CA;
	Sat, 21 Nov 2026 01:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795226252;
	bh=6bykOydDu0O4FHmMNk7Jp7BVGe4iDBIyIZTVK6rs5L0=;
	h=Date:From:To:Cc:Subject;
	b=CfgtMgZTMRM5c5MZuOPlTETHQliulLNDDljo+czhpyiNl5BVsWbYeWm+3bItB8t21
	 rs4EPTtrQ2SV03C3RV4ZELQrOC1GTuxZu7t6IwxXzaTj9C16qN8IHZvtn6wzh43gmv
	 2sWiZvwlpPTmJiyS7qo9Zr4qm8WimRmndiM1/Y6U6ybKWTNKRlQ6xIrvCYbhliymOW
	 XHbo5sULZaQ5v0fO1+4sJDpxmbe0GGJW0zDCRGEft3Ji16npN51/i0k8Elfc3eSpqc
	 LcRwVH8hyfyUJ0I771ct5QIsuoVDHTMEow1kUwJcafXYehfpP7iiW88t/k0x2Xm7Ne
	 +NxTxYVRCE/6w==
Date: Fri, 20 Nov 2026 19:57:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alexander Gruhlke <gruhlke@mailbox.org>,
	Sun Yuechi <sunyuechi@iscas.ac.cn>,
	Donghui Zhao <zhaodonghui@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [GIT PULL] PCI fixes for v7.4
Message-ID: <20261121015731.GA966532@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.4-fixes-1

for you to fetch changes up to e735de71a2d9403fa1e2d134d1e9aa0a24f4eaff:

  MAINTAINERS: Add Donghui Zhao as ESWIN PCIe maintainer (2026-11-18 09:54:31 -0600)

----------------------------------------------------------------

  - Ignore Immediate Readiness on Samsung PM9D3a NVMe which falsely
    advertises it; removal of unrelated delays in v7.2 caused post-FLR
    state restoration to fail, resulting in VFIO and nvme regressions
    (Sun Yuechi)

  - Add Donghui Zhao as ESWIN PCIe maintainer (Donghui Zhao)

----------------------------------------------------------------
Donghui Zhao (1):
      MAINTAINERS: Add Donghui Zhao as ESWIN PCIe maintainer

Sun Yuechi (1):
      PCI: Ignore Immediate Readiness on Samsung PM9D3a NVMe

 MAINTAINERS          | 2 +-
 drivers/pci/quirks.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
