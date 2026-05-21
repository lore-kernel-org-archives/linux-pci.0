Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7663101A9;
	Thu, 21 May 2026 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401379; cv=none; b=U1n7Ph93IhB/7p6zdk/uFGY3fPH9pB96GE0QuEUxvQX0OqH+5zyji38Z3cfz/6ieeE/OsW6MJgE/Gcqu/h1Qx/BB5/I5hAmQhq2j6V0n1zDPYGpy9wmdblPoeCJojIbLK2A+R7Dh4zAQgfmJwzpna+35urbfRB8SSsqk64M5Xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401379; c=relaxed/simple;
	bh=lxgcHGK3nn2wJTcz4n4pTfAEBTBixdm0hYOtgImBx6w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LbMqQfUFjnBZGnVIYpfNeJyf2u/5gRRd8tLGYkDkdi2b0ZW5Ok0EDKnM3OWBgwgCX+Hdk+82X0kuEhcxR/hyQ6LdA4Ikqj0lgocxKimsOAFvuKStePamPIqHgeDsFdw9sAl3OCH3v4qiOM8GJ+UiWqFE6dgxAV+EPgE28DuY/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZGtgSg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZGtgSg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF52D1F000E9;
	Thu, 21 May 2026 22:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779401378;
	bh=oeLQ5spo9frsMNsbwGxCU0y4+HtNjScz2zlfCaAxzuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PZGtgSg+N6F7qD0U+MUNw72f9sWwDyPgJcFsrQOCN+9727EN0meh8kSyPtU0VF58u
	 tk5+XGUkCH2aN0VgnxeMIpv71WM//O9jscgU4A3wSP74oir+Mqc7uC2tu4jGaOuOw2
	 /4zIX6XSKbL2mHyAjLGzPFDS4tW1sRXQuGeTzINL/9DepFyLk5DS+aUUExDexWFWXe
	 Ih125RpAi+6yUl0pT/28/gKVbsNy3B4Cr4zDfTWmrrYCRW21p/mRqMRd48L3VU5Nyb
	 9xrku455rK68gYVjrotP43SnJbv3KFOrqI58LL5bMhr25rZ81QtIzalcLiOKd9TlFN
	 zqMQgWfnzwG1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BBB3930E3C;
	Thu, 21 May 2026 22:09:49 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260521212038.GA186023@bhelgaas>
References: <20260521212038.GA186023@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260521212038.GA186023@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-2
X-PR-Tracked-Commit-Id: ed831e7ea1a860bdbab3eadeb95f7f73e9d212df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
Message-Id: <177940138848.532090.8241332850591707713.pr-tracker-bot@kernel.org>
Date: Thu, 21 May 2026 22:09:48 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Florian Eckert <fe@dev.tdt.de>, Chuanhua Lei <lchuanhua@maxlinear.com>, Hans Zhang <18255117159@163.com>, Jianjun Wang <jianjun.wang@mediatek.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Dom Cobley <popcornmix@gmail.com>, Phil Elwell <phil@raspberrypi.com>, Jim Quinlan <jim2101024@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 May 2026 16:20:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6779b50faa562e6cca1aa6a4649a4d764c6c7e28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
