Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807114;
	b=YJnXw6HSpH02EZFXjF4vYLO43IXakjBivfcy5ox20vAxitFpLDjaWhQw6PHN6sSMJQor
	 B6j9dhS9qs2/mgXjcbjstACtmVv5Fx4f3gAfIRSXSgxjHs46c0vtYU4L7knjFXqWOlVRm
	 F1bUSJqckQcQ1XNoRVZMhA2E6ak3In167GTKaB+gx/c77uxzKxv3+t/9ZGrbZMcYz1b/M
	 8N4eBi0l9CtreJc/vljO82vvSxCXMIjF8NnabrGsLLQsyJM42Z7oTh6Qbe8xCTJ7s7Q9u
	 S5QsA9E6tqNGHnIU2U8V60z8PXxIz3/RFD65KRl5zI4YEvGERNLYOOuyhGwINCUevmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807114;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=3hbiN5/uprvunvzos0dlVHJXelNrX5owbPIV377NlTg=;
	b=r+mykFBGHtwAo9P7xgFjzmTfGc1Hyea3gPRbHfaNOKf6Xl1vn/DatH65yhnU9BZ00toK
	 HgcCX20I+cW7ApIgnNkVX7Juz1o2B1RClGsIRVkHq1bBxxd+Hn5nJ0/QuZkJ7Ei7PL4LG
	 jJMJjCCHjdzPktsxl2GzOtywIyk5w3CLdPPB+iQOjTv265iXg9dZULbKbqAKzE97EOTAe
	 NxlHT3eUYmmTGdxM+umoGYhNO3dKsm3SszWuq0mQtjsFe/DlqjHMqtKwm6zwOFKvqIE6x
	 HQgC9uoIXDrx79IjU9YWhy05m532rptpXW37G8wUefFxafiHc7hVUjsjRmK7xHRxzsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX088MP8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF7606A31A;
	Sat, 24 Oct 2026 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX088MP8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96F61F01825;
	Sat, 24 Oct 2026 01:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792807113;
	bh=3hbiN5/uprvunvzos0dlVHJXelNrX5owbPIV377NlTg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aX088MP8KsmVUlMCY8YRTXQyHoiErz9Mw4AQtJQBQ0hOznit6yAtszv2gVEodnTl0
	 H+u3wo3RNYe+nPP9DomeoIhwxUgJ9KV956ZzMpshFct0RX2FiPACVvGqGefikkO9NT
	 6f/9Cn0lbUAs+9LDTsSFWBahVFi94uqduylnBkmg5GvcP8xQ2JIrNFWEu9TjhA9OyI
	 kxhdziAMZsQZ55e/NRAdeY1BGR0NBR+M/vG554QKh9yCUAnikd7b6+nbjhLOm9HYgW
	 3nzzPZwezqVyN8MxAyNe3lu7c230aj4C4HY1qEp1oPL4maACCODIIBxdDdKvDNTO0A
	 ESkC+OebvsQ2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE789391B177;
	Sat, 24 Oct 2026 01:58:33 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021224355.GA2571577@bhelgaas>
References: <20261021224355.GA2571577@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261021224355.GA2571577@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.4-changes
X-PR-Tracked-Commit-Id: f4319f548f7d8cb595ac1c91bfd459876399eeb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17bb0e2f6c8043f70a693a5f3797471cbed354c8
Message-Id: <179280711243.1400178.17950066981362111641.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 01:58:32 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 17:43:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.4-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17bb0e2f6c8043f70a693a5f3797471cbed354c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
