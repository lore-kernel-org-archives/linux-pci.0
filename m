Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB03472526;
	Fri, 18 Sep 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759246; cv=none; b=N95Wv04g4wDciEQfMt/PV51yKMepN+YXqhopHXNg5iqt4r1yR8rHwngEqPEN7WkNC1UgIO1uhaTllLPfOUBRj1jbnZpN6InWvsK5zm6X7CRwHYr+z+wHs55zH2fLWQToUzGN+TJgeti20WzVWupuw3LK0In4B4/9jR2jzOADqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759246; c=relaxed/simple;
	bh=dtKVHM/mIstEf63dNyFkF+L1WOA+lqP+lACYczrMLc4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cfSwnWwPB04O6riFZn2O+oeEGICi7Bnnlf33MtZohPJcKcyLeoM6gdWz50VZwANNzfpR2ivwRfY9cZfHsYFbuA9d24UOnwbwECMgpNyHMK11xQSPpYK/FOyh9QYvfMJrBWSsRvHHlZ0cfskAq47q8NGtQ1b59zec0AfvGno6LMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCpQPqXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCpQPqXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75C41F000FF;
	Fri, 18 Sep 2026 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789759243;
	bh=f2VwI12ge9KwI/wZvGqjS8YHtTg0R2abZxMI+y24lGE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UCpQPqXNiuv7xtnG+i2YbbsL5aGt7REzy4US+akk/wCjsnSkeZSOloeZMhtVarl5Z
	 sFSLLvertsFa1ryXUL74OnymT8pNAT+2DNKh2Ag118yM5WeEEbpxxVMj0glL5sRiYq
	 3ypRfffWNVxxv5SPxg6z0KnNPz3JaqKWRE4X+XlJ/73bGgIzO3zboS8qkleISqHVFV
	 v7engqirm5wrZTZ6V6HN/LdbSjoCY0fkZ/kyVOpn6Vs4nAT7mFndZdD4xHTG9PpBEb
	 DXH/RKIVHPDQgIHvVAIWRPZmYv638Spp/pMtV87TbYIYY0heVmT8Yp2KZ8MwI6vQr2
	 qINKXCVJ9tmnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A4F38111DA;
	Fri, 18 Sep 2026 19:19:38 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260918191604.GA1177751@bhelgaas>
References: <20260918191604.GA1177751@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260918191604.GA1177751@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-1
X-PR-Tracked-Commit-Id: c9dc7d730319ad64b51570c5387f1fee7b07b510
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef31d04b6d8adfc971fc6b9ff76a1d6dc9aeefab
Message-Id: <178975917660.1108441.12498633725465235143.pr-tracker-bot@kernel.org>
Date: Fri, 18 Sep 2026 19:19:36 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, Leonardo Costa <leoreis.costa@gmail.com>, Franz Schnyder <fra.schnyder@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Sep 2026 14:16:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef31d04b6d8adfc971fc6b9ff76a1d6dc9aeefab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
