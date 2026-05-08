Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D839DBE4;
	Fri,  8 May 2026 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282543; cv=none; b=ZueT8PAHiUqrkxkXH6qLUE27UV3/WnccGLNxDo0Me+B1tsVrbflaaozl1vSnxBwYVznKNye4b41oTyj8glEMV3tpzUgee3GgQeu9WzCedWHPJ080nsApbXu0gKy9KKSUi3nTXzUXj6INmMx0wRwPBORSbAt2+B+mmHM9bw8wbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282543; c=relaxed/simple;
	bh=6d84cgm4DRArrgnud1ZGRucUe96Mg5TsvVVukCKOvDY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LqMaAcwX4bPDFGxGAr1mImzJgS9UscrxUKKT13Idh1vXVZme5EH/n6146hgQ3JSTaHQMIFYNI3nTFrBvzSDvrogdFLsm2t9guqYUs/zxdARFd/jn/TeLKYZiH3fEkufTZq7N20mKq7KNTnKa9jc/uIYLYu03wk3081g7N7WdAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9hpKE2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9hpKE2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D9BC2BCB4;
	Fri,  8 May 2026 23:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282543;
	bh=6d84cgm4DRArrgnud1ZGRucUe96Mg5TsvVVukCKOvDY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V9hpKE2Ledm4wBAeQiBcom/PBlS8hP/kgQHQFodgO0FLiTt+ph+lpJBbbSXhWfqRd
	 oU4nEbeSb/QmHbvIRkuWhP/IM20dEescOSxvM10BFllviyyMqYZPFB6slnpq2L3hRh
	 vNh9Gco9jZ1JHhyit0PlFlLanwnTtZccbdjkjPa8CbjUdECgBmAopxqbua9ejXKByx
	 HuC5ZYJyUskB3lUR/uMTfWTatmDuUQqKkG+2bjrf1sevXZ0NU9XPmsGv/IUqLhTsrB
	 yf6Cjq+2DKylO60wgOTqtlV5oWCh6bKu4vvsXuDEeUqPmbpeRzM1RhS0VnKn/odyuV
	 GV8D5w7uOFcEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9ED838119DB;
	Fri,  8 May 2026 23:21:32 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260508210428.GA19478@bhelgaas>
References: <20260508210428.GA19478@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260508210428.GA19478@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-1
X-PR-Tracked-Commit-Id: 9ef40a09c5de18f0d275a451f5c2a7fd4f07158b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 678ede852f918581fbc43c61f4c4737a3df99cac
Message-Id: <177828249129.892019.4662822956812707353.pr-tracker-bot@kernel.org>
Date: Fri, 08 May 2026 23:21:31 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, Samiullah Khawaja <skhawaja@google.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Hans Zhang <18255117159@163.com>, Hans Zhang <hans.zhang@cixtech.com>, Aksh Garg <a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 May 2026 16:04:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/678ede852f918581fbc43c61f4c4737a3df99cac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
