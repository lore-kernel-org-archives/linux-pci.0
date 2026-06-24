Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB217DFE7;
	Wed, 24 Jun 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339481; cv=none; b=qRPPsgw+8q5lBTqMan2kwwqBlZldt8z9gTZpzo1v/14pitKgTCJjeHec3Ic2lzBbVUusdYOk40b0YoQDot8s8Ccs879EWKu6hj6JGHdgo2t/BtCzCwAQfT/mN0fu6HAAqkbUG2DwXEi+9/RJpvcMiUz0nejyd04zMdsSIY+tarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339481; c=relaxed/simple;
	bh=Y1NzfsUjqPb5TF6n2nFyui9px2pZSY3qzNNqPePTZGk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mO5uYrxJhlyCRfPjM7+AY0ImJPWqIUq3AniUjJqb4+qZq0Cso1+tsiQCg661BeFePFLnvN4de6Vk2eWs1UH1AoZ9wDCz/XRHpLPy2rtALtbV5XQqJVMZDhtfXufKRKq/MCxYVA1OgC6NCd+1bMw7Qv2OFHzMhDOo757qav8CY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQJo+eF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQJo+eF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9101F000E9;
	Wed, 24 Jun 2026 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339479;
	bh=zMVlceZqxf1McFFb1CT0zGDpY80P+xrNvaEjfh2AyC0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZQJo+eF13GvkvbOT8IovV4MKh2uoCCz0OnG2e4I0L68bMaNIFaqy3rRa7wDcLrtzq
	 6zl2vPrWSf9zlnZiSk2WrzmmOyQyagaLK98wWU0PUwu0fcflj9DxT7V0nTcrkMEEcx
	 LIVBPDLaK1zj20AyEbz6vHHoN8jSZlAHd2DllvFynGzfhFF8AmLlrddB0dDVg2LmXC
	 IChgmIov9KFca99TRZvksEtAuOmKcurNrl89pv3JZkxiAo/Yt3QTgmRQXYPXupInTX
	 yhu+ZqPJ2QEFO4IOhX3ElHRRfIN7uAiizo34aBHPeSsZKKSBKWJTgaukj1fod6wxkC
	 O4eskca2tsvKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569453AA6A7A;
	Wed, 24 Jun 2026 22:17:49 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260624110021.GA996382@bhelgaas>
References: <20260624110021.GA996382@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260624110021.GA996382@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.2-changes
X-PR-Tracked-Commit-Id: 2c2fb7a8aa10e9ca7f2a49d426469ec89e3b267a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26ae421f7f49f8a6a32d15b1d21a782b46a1bad5
Message-Id: <178233946796.3002918.13907858493146543276.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jun 2026 22:17:47 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jun 2026 06:00:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.2-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26ae421f7f49f8a6a32d15b1d21a782b46a1bad5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
