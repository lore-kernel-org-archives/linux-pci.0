Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9081FC7;
	Thu, 21 May 2026 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398441; cv=none; b=eFE1N2GyylRIpe25b0EbKJ0UD6J6Rf56D4saN05W6Se0bo9S60+eCCdIehtxTNZeU3cvoxRCJLquC9hD2mQEUPlKhAKiVJbx6y5U/ba7CffMjTH1lP8WsYWzQ2yA0z793OklZchlKDRTL3idjIqJfx1cI8dJKBOL8rqLSCgSaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398441; c=relaxed/simple;
	bh=UANmvG2FRmiFNQnGr78SzzAxpZRHuBjFTXMX+ZZKu0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=divZqz7te7eBW1/50WrgAsw87XegFwNuCELPDSllVqKHx/PM03GfLGmxmJFlY+FNigIB5eIiv+ui/vIQZrn2gF+hMI7PfrRUy7bg4f2Zxy7YJzy9s7CwfHX8o2vovyXzrnMXXsZTMOB3ktgpdLA8DINoqulWNzifTk41fct/y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARpPjW+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARpPjW+g"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E21941F000E9;
	Thu, 21 May 2026 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779398440;
	bh=E8es7eKdBSk+6as20dmN2CeIVO8nOP/PPbib2fb2n+A=;
	h=Date:From:To:Cc:Subject;
	b=ARpPjW+gP10f402uEoQB9q/bVwwaUbwSOyMWb9kL/tb6/nN/2GhueTzWAu8v40CV0
	 MvWx+kkevAe/HzlheOo1f61BWThogWlwH8+hiiXSy5QkI1sErglPyJAwjFw4ZgaO8+
	 +vytwPesYi1zoMUSpBLZcsdCSuIEotYm5gddGB6fJiIhdTj4BfewSMiGhmhGSaBcpU
	 UG1JGDNCmVvMKiMyq2I4cJa7wUJtEJrb6eKR61W9HhaacoOxwIEsCnq7mTnu1bKMED
	 VZABY0jq1nEG3J4qn2l130K8uHL5pQFsMz1qXc+fgBLWA7HgPx6Y2SnAgNSedxyNgV
	 mjFR3f0oduX9Q==
Date: Thu, 21 May 2026 16:20:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Florian Eckert <fe@dev.tdt.de>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Hans Zhang <18255117159@163.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org
Subject: [GIT PULL] PCI fixes for v7.1
Message-ID: <20260521212038.GA186023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-2

for you to fetch changes up to ed831e7ea1a860bdbab3eadeb95f7f73e9d212df:

  PCI: brcmstb: Assign pcie->gen from of_pci_get_max_link_speed() (2026-05-15 13:09:52 -0500)

----------------------------------------------------------------

- Remove obsolete PCIe maintainer addresses (Florian Eckert, Hans Zhang)

- Restore a brcmstb link speed assignment that was inadvertently removed,
  reducing bcm2712 performance (Florian Fainelli)

----------------------------------------------------------------
Florian Eckert (1):
      MAINTAINERS: Remove Chuanhua Lei as PCIe intel-gw maintainer

Florian Fainelli (1):
      PCI: brcmstb: Assign pcie->gen from of_pci_get_max_link_speed()

Hans Zhang (1):
      MAINTAINERS: Remove Jianjun Wang as PCIe mediatek maintainer

 MAINTAINERS                           | 4 +---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)
