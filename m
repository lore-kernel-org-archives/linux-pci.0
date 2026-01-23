Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AC2E36F1;
	Fri, 23 Jan 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203494; cv=none; b=XO99CHejviXMR/2uYOdxbfX1UjZIuI1Xl+Ar+31MONoNny6kppMoN0ZZwirt/oSCiD0ZWt0dU0GW+klJtVO/YAJMZQW9593aAKcTYH69BrZtN16q8h6AoyiF/51tIJJfKBPKe1cwkm3Ccnz0Ari8m5ZoDhT/CJ5k7ESbsqn9Iss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203494; c=relaxed/simple;
	bh=bTcICixCG9J8Xx59AGJSrW6Z5YeRjGsXXDad+0OGHy0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W5izGNNJJHRvLO5hjsojfC+tfwMJxqL+FLe+G3g6bWtJMBnWMxnW3RHjs7aJ57ifkylF7JEKBJfM0IYIVs2aKFWlyPYaJ6SCmfEB7Vfmed22osktvS5Jjh1jVY8gPXqeGjprGGgdNtwm23T+KQ/zMxhyQj/lANmHgOQU3U4E8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmFPnJBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmFPnJBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B508AC4CEF1;
	Fri, 23 Jan 2026 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203493;
	bh=bTcICixCG9J8Xx59AGJSrW6Z5YeRjGsXXDad+0OGHy0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FmFPnJBZSXw4ljXaTQTRTFioHY0s9cXAQoMA3pkRY4wroHuCWDA7XXRHyJR2hJdTg
	 IrEEHOpqcCQS0wn3CkKAfZlKfCsCQ0fomD++/ergZ/cKWoDF5mntq8f5mi99oNHd5b
	 eUtGbGhoN9W2ZigdwFjKLMoy4bvGJIWjVs0xnMIoGjfrfCO4EJ3TJQtE3jpaJ5rSeA
	 KY0Y34PvcPCsd2CXU0Iy09FDX5+fjVpfAseYX2NIyoXCNK7+NX5DX2135FrjjRcNcN
	 s8ePRaZigMjQhH2uWhxNGCbM87PJ3bM7d2n62De4apLPm3JCTG7lDUTD/tCwR9wVBe
	 USXOq47HCm7Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C89AF3808200;
	Fri, 23 Jan 2026 21:24:50 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260123180624.GA84249@bhelgaas>
References: <20260123180624.GA84249@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260123180624.GA84249@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-4
X-PR-Tracked-Commit-Id: 5528fd38f230c906fcebb202cc94fbb8ed8f122a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bde837031a3e0465b8c8413d45e45d7927b958a
Message-Id: <176920348935.2720183.9472346264087505944.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 21:24:49 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Jan 2026 12:06:24 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bde837031a3e0465b8c8413d45e45d7927b958a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
