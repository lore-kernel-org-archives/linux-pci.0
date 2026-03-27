Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7F273803;
	Fri, 27 Mar 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643993; cv=none; b=b15dhEabdZSiriwu81Xlh51Ze9ojmLsk+aFOS6BkOksH4QpdiqLNxtji4itmX5gDY1MlXfbh6Qmo9GLE0eZ0Utu6YJt7QFWKT16HBTPVRMElk9OxbRkGkOMzSpboOdGOcWbwRHJX8uBDpLYHt/ZqGMz8XYsFlAKDw+qnQnVMtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643993; c=relaxed/simple;
	bh=/TGD0xZjPHyEgJu0uIV/kdH6fmP6xCkcwLgxrss4DP4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GH6BsrNHheOmYL0m6cqauwxQp4QbY6KVY3N+IRvDQY/YnNaUjTmUt4V0gjHYzUkLOsOJkysQt7AMG7YQwJ6y1YXD1zXoF/IB99Fq8N1CeKFaPQgM35NOStLKsDlf5Np4pDIRzCpBY98ySdcHwQrjCPGJreJkzofXFwZyvcLP8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjpjStuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjpjStuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789F0C2BC86;
	Fri, 27 Mar 2026 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774643993;
	bh=/TGD0xZjPHyEgJu0uIV/kdH6fmP6xCkcwLgxrss4DP4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fjpjStuW5X1ltymQ1npn6YvJYfdL2vLtpo2Si3giuN6Luz2nONQQ5nfkojNoaPnqZ
	 sv4k0hHsjibE0OQvBpJ5AXgJIdEkS8AlWDJjYilfNAS53/+EXboxEYVyjlzsABiZqC
	 GNIH2BvQH3jlP4TvyHUzFYH11AqO0LakJ57ypqj+Bmpr550u69oKZBFomqms1E4tTx
	 IqozHQNT3vGm2vi7GVh2oB25BRbSBkPXWDe/YPIJP7XK8V0gvb1mRXjDoG8NxJZcOS
	 bdNfRxUbBssr5Pmk8685t/dOrkTRG1pehm2+dHaY3npWt/hde4YekoRptx2bNqgTdl
	 GGMnHtR9sgk0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1183806928;
	Fri, 27 Mar 2026 20:39:40 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260327143601.GA1460168@bhelgaas>
References: <20260327143601.GA1460168@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260327143601.GA1460168@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.0-fixes-5
X-PR-Tracked-Commit-Id: 05f643d6f7e699198ccc47e634de3879a8ec26a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8af4fad545fa4df358c8e4d12f269e460717e514
Message-Id: <177464397910.3654421.9379105741760362525.pr-tracker-bot@kernel.org>
Date: Fri, 27 Mar 2026 20:39:39 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Maciej Grochowski <mx2pg@pm.me>, Felix Gu <ustc.gu@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Mar 2026 09:36:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.0-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8af4fad545fa4df358c8e4d12f269e460717e514

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
