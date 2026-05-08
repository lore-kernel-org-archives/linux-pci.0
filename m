Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6A36403B;
	Fri,  8 May 2026 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274270; cv=none; b=NVaM2fJmft7QOQdtLoYmfVY0gXrOe7uAtXp2UNxHgG71936VVxRhJFhGqy9NhpIBU9BvjqP5w47vkZIj/uYJagIRnA6zLjn9S2Hm8gnn90Dfccg1XyvZw7t62P4ZENo9tcaC//uagqHQh62eHneOnyEg41jpvvHQko8L8h2BExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274270; c=relaxed/simple;
	bh=azpOnJbK0Ml4D1VGSusOins3kG0pxRpD4X+uSZ7LwB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lJUSgVOua7R0I5YbMh5jk98W8Hi0gZhssLbb5A92SqiK028v+9JE15ew9Cv4tHpnIB7BhBgBqc70I2o8F2QV/YP/vt+OEUhVx8WMIxEJMQjER4SA1iHuiof2b7N0rCtZNkimAsMTR29rQvgClOJ+7Bp4wljad04ruG+NBldLg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejFxLuJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejFxLuJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B711EC2BCB0;
	Fri,  8 May 2026 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274269;
	bh=azpOnJbK0Ml4D1VGSusOins3kG0pxRpD4X+uSZ7LwB0=;
	h=Date:From:To:Cc:Subject:From;
	b=ejFxLuJGK0FzScYckOsaIgZB/Vbc4yAs/VV8LooZqtX9hR2vC7ueuLoVfhYvWkkuF
	 80HJ+QWdTcGpfkmK28uw5tF1v6B7GXNF421A3z3Ju2KfSPr4xhF4K+HmxMzRjhg+Fx
	 WXfjqmWrKhEvQXRScgZhd9UD586g5KC4V2zTSKDW27OLE+tDhbA241ksoNiZoHxGAj
	 q4+gcV/HiXP3/WGZGuxLOIWdDeSgvvn7nssjBOS1/lkUUUUkB0zrr6J6GTrn4l6DDV
	 GM+uMdd/SAzVf38E1XbnmmJof1zLxSuYSJTDJAg7+5W/AvAew/3lc84Ca/Ckgtsqan
	 fh8fEWJf7KbQg==
Date: Fri, 8 May 2026 16:04:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Samiullah Khawaja <skhawaja@google.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Hans Zhang <18255117159@163.com>,
	Hans Zhang <hans.zhang@cixtech.com>, Aksh Garg <a-garg7@ti.com>
Subject: [GIT PULL] PCI fixes for v7.1
Message-ID: <20260508210428.GA19478@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-1

for you to fetch changes up to 9ef40a09c5de18f0d275a451f5c2a7fd4f07158b:

  MAINTAINERS: Add Aksh Garg as PCIe CADENCE reviewer (2026-05-08 15:50:07 -0500)

----------------------------------------------------------------

- Don't fallback to bus reset after failed slot reset; a bus reset isn't
  safe if the .reset_slot() callback is implemented (Keith Busch)

- Update saved_config_space upon resource assignment to fix passthrough
  regressions when x86 pcibios_assign_resources() updates BARs (Lukas
  Wunner)

- Initialize a temporary pci_dev->dev in sysfs 'new_id' attribute to fix a
  lockdep regression after driver_override was moved from PCI to device
  core (Samiullah Khawaja)

- Update MAINTAINERS email addresses (Marek Vasut, Hans Zhang)

- Add MAINTAINERS reviewer for PCIe Cadence IP (Aksh Garg)

----------------------------------------------------------------
Aksh Garg (1):
      MAINTAINERS: Add Aksh Garg as PCIe CADENCE reviewer

Hans Zhang (1):
      MAINTAINERS: Update Hans Zhang email for PCIe CIX Sky1

Keith Busch (1):
      PCI: Don't fallback to bus reset after failed slot reset

Lukas Wunner (1):
      PCI: Update saved_config_space upon resource assignment

Marek Vasut (1):
      MAINTAINERS: Update Marek Vasut email for PCIe R-Car

Samiullah Khawaja (1):
      PCI: Initialize temporary device in new_id_store()

 MAINTAINERS              | 7 ++++---
 drivers/pci/pci-driver.c | 9 ++++++++-
 drivers/pci/pci.c        | 9 ++++-----
 drivers/pci/setup-res.c  | 2 ++
 4 files changed, 18 insertions(+), 9 deletions(-)
