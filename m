Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB93EBF0C;
	Thu, 12 Feb 2026 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770868723; cv=none; b=Zh7EDoX09bKrI9hsAnBaHoOMS4L+vKpD48WaZ3lhX1hLu6/2/t5ivi5QogDr9uOmZk6QahW6BuMFxL3Rp+LkCdp8nUDh5XW3wy37ypfdgoC84EHghJ1ibMwb8txKk4ReSsMi76ajEOuowUbutwK8UBVpMhKGxdXXZK/UYMYDN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770868723; c=relaxed/simple;
	bh=Uq+yET31YXPn+6iJgpPJzRy9Z36LV44Q2uKypHU5VQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YM+d/LaviCeTXHkYcfIfjjK5J4i+narybeXEERERpFpzMhkrb2h+gSM3bMnJ082R+UEZTGG9/FrQfxUyab47cw5+hn8c0vb71NWxQHsSoH4wEIvm98poUj98dIcaqf+tiBdi42ucqD311f9yFEwTeNPXz52rfMFU7VaUmaH1B74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgtDH+T0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgtDH+T0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31626C4CEF7;
	Thu, 12 Feb 2026 03:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770868723;
	bh=Uq+yET31YXPn+6iJgpPJzRy9Z36LV44Q2uKypHU5VQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OgtDH+T0WqqcN2q6mv52F8rIN4UlWUwYwVaZ86N70nO8br7E9KwxtjMvHaBTany0U
	 S8Lr1ToAgLcdKfROj0YG9tajRHvHYOtcq7zwIBaSFcVhreQekRBrbR+sYUbVtD3/DP
	 Rm4UVPCcd5ZBH8DSLnkM/LPhzqPQ9bot7O+aJf5WUJlCdok6Jh1VSlwUDTNoOG7hC0
	 QMigSn1pA1Wo6kFZFAZF4f7SXaktPoS5Q2l3GsvGuqUC+p/PElXgomhB+QzpwcMMMW
	 yonNuK/8D1a9k4LUkrjh2jD2777nn++TyTeHh8qRLf9wv6mqt3iJQVM4rjEW99qogB
	 Nin2lmgsufZKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B15F39EF966;
	Thu, 12 Feb 2026 03:58:39 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260210215453.GA91552@bhelgaas>
References: <20260210215453.GA91552@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260210215453.GA91552@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-changes
X-PR-Tracked-Commit-Id: dff645f564c38332502140f3ef643f659114c45f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
Message-Id: <177086871769.893578.4903234074979500019.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 03:58:37 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 10 Feb 2026 15:54:53 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c2b4a4c2bcb950f182eeeb33d94b565607608cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
