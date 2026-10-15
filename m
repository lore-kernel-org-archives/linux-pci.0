Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035A383326;
	Thu, 15 Oct 2026 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077413; cv=none; b=NE7Xrlkv/29sH/MQDbXdLp6jB+lydxCpwOglJR+TcN39qyU0Y47siIBk96cOI7FlCqa6lizv9H8wdAkbU0zGuR4OY+zUFToAuoURpuwbzwfnzJZ76ykblrhh1LxTIDDjWkUAb0jS164l2JwBL1Y6gI9rwEnrJng70btErsGlwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077413; c=relaxed/simple;
	bh=Jb3i2x3XPSYZVLFYoRvR6fBWO+g+98DxcrSxk1gCzz8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mr6Mh3RYJq7xlpZ3Q0gRM3nZVf37UYuXkUEnt1qZ6RUGxIklDeSGeR4KzOE1JcdG1jIDqgw+9t7YyauVRaEy/fkT2vIoZWvwQjaD+nQ8ij/Lfq7ETeEiJbUDHwuXfXuYCV5C40bj/U6vvXaR3kYjKSOyYWmkOCfu1yxR3Kwect8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnhN7rn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnhN7rn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A31F000C4;
	Thu, 15 Oct 2026 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077412;
	bh=czOd1zQNZUMw6GYUrJDnQ96E5UzYrct07og54e6yZVI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FnhN7rn2I9a3CYDafvP6ph9HvJGJLus1SL7dxzz9VKYPUJGPNeLGgEAVgkxo7IXpN
	 ncyBPoZQBK/FMqML0x6qDwqP7pQx08xtTSuniOpfxskxUtHFPltIoaPY5c2qIdUiG5
	 qFxB81eVLMz6xtEcNC7Q3tZ6r8tAbJ9oYOQQQ3DTicO3GmcRaCj59afGJKMbuayn1A
	 GMzBYTkUhDt85X44JI2UsWUztLpbOTxXegYsxEEhUvdTsdD8GSLVFM2Gv0rN241rX9
	 iFwQQ70fMZuKjr9r2bqnUoVBqc8OWW4y3mXmmdOf433kujdenSqi+dTmUk0C2mulg6
	 0Vb8k3sB0qtqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3A0392EB21;
	Thu, 15 Oct 2026 15:16:52 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261014201441.GA1661922@bhelgaas>
References: <20261014201441.GA1661922@bhelgaas>
X-PR-Tracked-List-Id: Upstream kernel work for Rockchip platforms <linux-rockchip.lists.infradead.org>
X-PR-Tracked-Message-Id: <20261014201441.GA1661922@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-5
X-PR-Tracked-Commit-Id: 4e9f69d08253471d92bcc46b363fbada06bd59c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e177c722b3dd9ad432195b5c2cbbfe58c909a821
Message-Id: <179207741094.3496071.13040126142711127127.pr-tracker-bot@kernel.org>
Date: Thu, 15 Oct 2026 15:16:50 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, Alex Deucher <alexander.deucher@amd.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, Jason Perlow <jperlow@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>, Diederik de Haas <diederik@cknow-tech.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 14 Oct 2026 15:14:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e177c722b3dd9ad432195b5c2cbbfe58c909a821

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
