Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E533345740;
	Fri, 12 Jun 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296973; cv=none; b=EcUnzhpUmSlSmIb+BXoPX5fjXLHfgCqmoPoFrsTlhD3eXd9IASTjt7cYN3asoN5iDXrq4DRs41t7h51WUGGlzOszwT9e6LX6xyI6tctEUGBs6l9wV4lkjgPpnQG6aHRV5nhtyKJ1atAxG6Ip2NssWv0TIRpLSR9gNAXPoon3px8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296973; c=relaxed/simple;
	bh=CPQIOUc0AqVMinhpn/pEot5TncjwJvsnulrRjpF8Q3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SZ2yngrsHHpGAJl3gDm/r0zEXSNtNXhDcD+6USw8vygQ9vll0EG2WUPzXe89WMC334ltDhz0tX3UnwpuWpJH4PfR16mJLMZ8zcSkBLKBHspBc5282IGAgqy+XzBmLQ6933czMmXCwWjq6pNA1I/jH7vITEZJWEM6atTBQ65Yn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKUrOlgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKUrOlgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AA01F000E9;
	Fri, 12 Jun 2026 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781296972;
	bh=g1eJb+rA2icS5P2zoHHm6jlzwC06cFKbHnVzD88weqI=;
	h=Date:From:To:Cc:Subject;
	b=LKUrOlgRxYt5YUVe5aQ8KaXIwWN7HaT/tM+F7rgi9wBto1FebG1CETUH3gDrXTLXn
	 OTO6eqaEAgEZ8oD/s35uJtOIjZrTx0tmiTI2JlkXpDyc1SciGC1xQTCUaTsEDtcgQA
	 19JioRpJGRyVZVcuiON5Qmo3KNCoU8mK3qLOCOtwFtcPli0ZoohHOCPwTrPGsG2p9/
	 TDURf1hJUF5jNQGeb1/ggMyTT+gJ0q/GBkwuypVBlIj7MnkTSa+Viea5UndeLSWr4X
	 YrBalTYB28L7pju+cPDYZCnk1vY+FII8IigO8x/1TIkxRACY40Rzqdzg4FN4ruWXPt
	 2A1sFiHW/Uh6Q==
Date: Fri, 12 Jun 2026 15:42:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [GIT PULL] PCI fixes for v7.1
Message-ID: <20260612204250.GA637200@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-3

for you to fetch changes up to d898796a8e7ed8528c775f33da056e9978c4c248:

  MAINTAINERS: Add Frank Li as PCI endpoint reviewer (2026-06-12 15:15:38 -0500)

----------------------------------------------------------------

- Add Frank Li as PCI endpoint reviewer (Frank Li)

----------------------------------------------------------------
Frank Li (1):
      MAINTAINERS: Add Frank Li as PCI endpoint reviewer

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)
