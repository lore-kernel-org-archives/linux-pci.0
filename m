Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ECB20D4FC;
	Sat, 17 Oct 2026 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201401; cv=none; b=KYKspkPOED+PxWkxbOix3CM5xCUkc2E3vrvzbQs/uMVbw7w7gAT3+C9yH2DzSjIHZ2ZNqLDSZ2dgsY0CyCjo0KteHGweNRIIz6zCxKd+i6lx/MnM/B8aF7fsMdtLKUH/1Tw36+r1x4vSzF7lA5CnR40VSnyvIWUNcesk4uqloYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201401; c=relaxed/simple;
	bh=J1L7KtSn0TMbabENTl/zysBd6rVfMzsjatEuVpBu+CY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fI4U14m4icX0BBK/K1F//9UQGhMh841fQ489TVw32BCPVdvVcLjYBu4qeQf9MWCKlQGUJ5r6omf5Rxl20Cz7vOARJAi03NiGCSOPgirtxBzPpsTP48u/UeEcEcpDXYRYTZJ6NxdvMejnlhfJU2p1Ac2tvT0SMN1rvrNsaHd2qKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVP0cKQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVP0cKQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF411F000C4;
	Sat, 17 Oct 2026 01:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201400;
	bh=pgCkbiIYX2OvgWHrcDnPPAJO7N9AtdhuI7nyy8WvXEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bVP0cKQwInkTVH6hVdBOBtsklPj0f8a54ROGiyYdZSlqWWkXrXbWk1Un+NJbkgfkh
	 vtcE/bHNtIWWEgAbZjiak2ulkFXZnIPRfbSwRczHTq1lVdEBe73d9gBGeZmuqpZvt7
	 caP9s49d8gcrszai3UMafiAx2ByVdcPPdEv2M3zPhSlN8W0GYSz1rCJt2QWwHm0ZUZ
	 zQq4tExYQ2bLWcHptkfuTI4/qBGseQ6VmFFXC+mP0ZYpsRUmhc9zAtqGmQwRK87N7P
	 fjVpyXm50rWyg/cIEOf3WhqyT+tfqdp9WX8hw/Qg0UnJIJ5NPtUCoB3UQaufb+FixM
	 zCxGigXQOG5UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F17BE380CED9;
	Sat, 17 Oct 2026 01:43:19 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016181351.GA1880783@bhelgaas>
References: <20261016181351.GA1880783@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016181351.GA1880783@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-6
X-PR-Tracked-Commit-Id: e8df1d194c39b7a5159d570798941851f70a8668
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4766082b791b515953d87f7a24c2ea857e6c10b0
Message-Id: <179220139859.1053691.3963601609719530806.pr-tracker-bot@kernel.org>
Date: Sat, 17 Oct 2026 01:43:18 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Alexander Gruhlke <gruhlke@mailbox.org>, Lukas Wunner <lukas@wunner.de>, Hui Wang <hui.wang@canonical.com>, Vitaly Chikunov <vt@altlinux.org>, Linux-Fan <info@masysma.net>, Raphael Norwitz <rnorwitz@nvidia.com>, Suresh Gumpula <suresh.gumpula@nutanix.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Alex Williamson <alex@shazbot.org>, Kanchan Joshi <joshi.k@samsung.com>, Daejun Park <daejun7.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Oct 2026 13:13:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4766082b791b515953d87f7a24c2ea857e6c10b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
