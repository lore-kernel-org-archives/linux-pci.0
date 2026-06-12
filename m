Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B29357D0B;
	Fri, 12 Jun 2026 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297573; cv=none; b=EbIPcfZA5A+JIOyUpnbwp5XET3TzSazt+o6Mi7Sf2iCUVKHQ0qpE05/xnmOqlnsiGPmfxwDJbJCzDiUWGfF2FDK9V5FUhqwnzfPIPuyk3k5yLvCfsE3uCN3Q7f06otOjwzwJ99sE/f7Hwqmc+0jWardoUzjvUAsavBaGc65vXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297573; c=relaxed/simple;
	bh=UNdX3Y4wCs779/QiHaOxXr2JuqmPS+BxnvWe9Dsl+xU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hx4kEePHlePoesKhni/p9tfPfXClyBQAKasNz36lzrEX5O3/sWAm8hIxDnfgEjK5V1JD130o0sI/Jtur70N/SxhI3GuVu8qYXnjH3iC2+uVWfFDMooKmPQ1u2nld/jJNmSyLZVsKrX6QQWArIco35UbHYlopT+EKH3m4JasEWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZoFvCUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZoFvCUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F88A1F000E9;
	Fri, 12 Jun 2026 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781297572;
	bh=iFF4Y0nDnDpOEVN0ZiFZIhY1rSA1OZZ/6DlHUhdkKoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=SZoFvCUGj/96ADmJmPJ1XxW+CgVDVIhatm9ADKQChYHDEsYdoZ4YQjF3l6AEX6ID8
	 a5lLF0LtdSFUsXt8SyOK7qhUnUXf4CDnMiEUBWHq2w0mosEz6PiP9Ok8BzQSHxp/O4
	 +XpfrjypmOfOzU0vXtZursM0NEwONKWGlbc8Pb+2qMOI1ehnetV2MPoBpvHHavXOM1
	 YA7vY1XPEmqi9tMt1MpnXvjMHJ2jE6II81zXLMQOFP5iJzWV2QkSqcpYmwK9F9ntvJ
	 GliLpH81b+2UGpL7ZJHfWJIUAUdAHk4QMTc1GHICK4BHq19SutN82P8PG0cafRRYDG
	 Mew7laUGADDdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D639E4DB3;
	Fri, 12 Jun 2026 20:52:50 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612204250.GA637200@bhelgaas>
References: <20260612204250.GA637200@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612204250.GA637200@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-3
X-PR-Tracked-Commit-Id: d898796a8e7ed8528c775f33da056e9978c4c248
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a2974b5145cdf2f4db134be1a2157e9ca4a1cf0
Message-Id: <178129756870.1243625.16864204082241102710.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jun 2026 20:52:48 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 15:42:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a2974b5145cdf2f4db134be1a2157e9ca4a1cf0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
