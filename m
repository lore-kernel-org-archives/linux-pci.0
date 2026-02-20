Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9163570C8;
	Fri, 20 Feb 2026 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614464; cv=none; b=VjAsGjsqDcrm5b1RHRAG5VKWmnjS7Ge5XErtFodYKWrEnbOAuzvhfP+flJjQPSjlolYCWb7KsSM3u5n/uc5Mm0HC+WBICuwoqZjUH5H0IoJogXsQYYvZ1tM8ZMciFFc0jGVcLZlsubJKLC+EoZjIM7xw+yWyRHaTK2PrgvKj1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614464; c=relaxed/simple;
	bh=HLWPoKms4xfYKoADbyP5HaiB1LOFc9NdoTUGYjK+2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D9ksRj26V3OR3KVb2QKBT1EN+E4Xg3Balh1I9ZukL/ITXW2BwGOve426kONweQZn/s6YwWOW9vJmMJI3HkxbJ5LAvexY06/k6Q0n5fAMsYc9i+V43ylV5N6fntSonqTHDjL9fKQjYxYLuhTCE66IKkEiNFpAGrDXCIJWT92rCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLC6pQ/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLC6pQ/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D3C116C6;
	Fri, 20 Feb 2026 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771614463;
	bh=HLWPoKms4xfYKoADbyP5HaiB1LOFc9NdoTUGYjK+2JA=;
	h=Date:From:To:Cc:Subject:From;
	b=BLC6pQ/wpqEURTqrd/AbLG+dwugCzXMnp7rnls5lOf4LAr6A10ZFs0/VgPNi3+Um1
	 slLh5TcymPfkCE9NkBfE4XLWpeuvG0sPKz8/ltrZa6RxteoRpPLV/CfSrYin5ZkOdD
	 OefWAXUI0+Ds6vPC7dtorrhkHrQH8s79z9mOyNpIDp2fP0lit1pygfAbNfFkaUD4E3
	 nORQd3+qkaV+o2+Zn5l0rRWvTRM0r1mDoIqJNNME7SofLYdYwxKEIjStEwLvN6HQgz
	 aHIEN8Z1fR0JSQ0zYLszDr3Rh97dtPeD8PjbaqY2JPqkwhueB2o74tqDsqFKNc17x/
	 R8fqJRC93HX6g==
Date: Fri, 20 Feb 2026 13:07:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	RavitejaX Veesam <ravitejax.veesam@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: [GIT PULL] PCI fixes for v7.0
Message-ID: <20260220190742.GA3538737@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 1c2b4a4c2bcb950f182eeeb33d94b565607608cf:

  Merge tag 'pci-v7.0-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2026-02-11 17:20:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-1

for you to fetch changes up to 8c746e22096579897d1f8f74dbb6b17a6862fb6d:

  PCI: dwc: ep: Always clear IB maps on BAR update (2026-02-19 15:34:19 -0600)

----------------------------------------------------------------

- Fix bridge window selection bug that prevented resource assignment
  (Kai-Heng Feng)

- Fix bridge window sizing, which failed to assign resources for windows
  containing only optional resources (ROMs, SR-IOV BARs, etc) (Ilpo
  Järvinen)

- Select CONFIGFS_FS when PCI_EPF_TEST is enabled to avoid a link error
  (Arnd Bergmann)

- Fix recently merged Endpoint inbound submapping feature (Koichiro Den)

----------------------------------------------------------------
Arnd Bergmann (1):
      PCI: endpoint: pci-epf-test: Select configfs

Ilpo Järvinen (1):
      PCI: Account fully optional bridge windows correctly

Kai-Heng Feng (1):
      PCI: Validate window resource type in pbus_select_window_for_type()

Koichiro Den (2):
      PCI: dwc: ep: Return after clearing BAR-match inbound mapping
      PCI: dwc: ep: Always clear IB maps on BAR update

 drivers/pci/controller/dwc/pcie-designware-ep.c | 15 +++++++--
 drivers/pci/endpoint/functions/Kconfig          |  1 +
 drivers/pci/setup-bus.c                         | 42 +++++++++++++++----------
 3 files changed, 39 insertions(+), 19 deletions(-)
