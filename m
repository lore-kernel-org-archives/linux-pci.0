Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69F3E9F9D;
	Fri,  2 Oct 2026 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975494; cv=none; b=bF8MLDbxFLwmLy464U3tko+13fTuvllArXZU0u5N71dbAyUdEqAn08Iw89fX3HZ4A5b9T8mI3j6IcQy8yxW1iMka9/pPChDv4avZ6UQ5915t2fu6h5ouDkJFEINrm7HPM37zEWwLfI+P4QhQ/PZYm7HH4PErRjAesr1izjaYTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975494; c=relaxed/simple;
	bh=olzEn0A2cJnlZZNIYJdjITSahAiZ1hgOfweHqmYIWJE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O7z0YPw0YqZlj7HBP6H72AEOpTKUvuWElCANzFiouIakjicZvpOh2rKWEC2vCWD+VDHF3455YL/6UZN6qeSv6ScZg8JzffMeci+b66DKN4X5RcmJLHFse97kGyrVHvt8ONGwhFABps0GeP2rlJvUG3vZ5JFA4VtmRwSIzwSIrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYN0Qzc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYN0Qzc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF151F000FF;
	Fri,  2 Oct 2026 21:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975490;
	bh=nNk+2hm423xFAmSTiwSTTBnkhkgUVazLlu2BS3u14Yg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=mYN0Qzc99XDU+vWHjGymevljtQoGuqR3Ysyl7C64qQADmOgW9a3TDmNZ2L4Cx4lml
	 XP/g4qreswKq5yiXHSL/+1yFi1v/jHkLf4Km+yc044AQCLrG2zozEZXoizWa9UrSZL
	 /FF06prfj9up9bX4KUN2MeAzqG7jE9XMhirM/7OwEgGW1ZGDDiZftpjeOjTIfx333Y
	 YjaTDDOelpLRfWQErERzg5ngu5ZOoK2FlnI5PV5iIrctjvba374jqrrmpA9HSID0YV
	 e6gI3XXURRq4k/TRuBy34eQCMzmG3RFr7W/XT1ntmM84YX9FWwDFZHlmVN2AgHWP6s
	 trU7X8CxB2EHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F152A3811A72;
	Fri,  2 Oct 2026 21:11:29 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261002163433.GA117980@bhelgaas>
References: <20261002163433.GA117980@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261002163433.GA117980@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-3
X-PR-Tracked-Commit-Id: 40cce45b921f7930886bcba43069edc579725457
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2dbe503fd806082acb0ca79a9d6641822988c2c
Message-Id: <179097548852.3587474.17592955744086014053.pr-tracker-bot@kernel.org>
Date: Fri, 02 Oct 2026 21:11:28 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Nikola Prica <nikola.prica@amd.com>, Gerd Bayer <gbayer@linux.ibm.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Alexander Schmidt <alexs@linux.ibm.com>, Jay Cornwall <Jay.Cornwall@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Oct 2026 11:34:33 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2dbe503fd806082acb0ca79a9d6641822988c2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
