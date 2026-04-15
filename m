Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEB38AC66;
	Wed, 15 Apr 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290505; cv=none; b=l9EQWERaFL3hGspXwprL38PxRxZSLSBhpX3unw6yyI8kQ18kFsDkSy3IAT79LoWvXgqFYVlkiR1W81+3pN7+qeEKT9kZkjMwF1lGYD8G12sJLic49dCjSb/+64Y4rzzfw2BaLz6HM24WCe5jxTTzo01kyO5xLgU+T55490FXzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290505; c=relaxed/simple;
	bh=tmWqWLK7zmJ1PUuKGG0oCDHQD9wwzhoyjZnystU4neM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N+sTSAxRuEtkalMRC7i1N2d/IVMFHdVmZJuohz3MTf0khjqFsK9igWWg1z9XKU4SYVbXhBpg9qHcof0IUkE4ka+vVsJK3kc0dOs/GyW/zG6c5x82UO0uwRZjSV+5m3l0DROGr97MncSAhob7qbw3AaVXvPzZtJBeyjqnhKrYl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeRsEH9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeRsEH9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD4CC19424;
	Wed, 15 Apr 2026 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290505;
	bh=tmWqWLK7zmJ1PUuKGG0oCDHQD9wwzhoyjZnystU4neM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BeRsEH9kuLryfj7HBYuJtZTh7K6vAhgF57M1tNxmzfdH4LXAtxhmDMiHRN8vqwZEg
	 JvBl/H49lLoc+uEk3IzNAD5zgga6tkWu31t99P8bc5kM1Rzh+AOiG5IbtwtLzZRS+a
	 Kz4Ag8TQa07BOeSosgQpQEzWJFYwBFe1J0S26vxQiNAN7RZO0fTHrl/q7wYfE1Aht7
	 JVUOSBVMjr5jQA6tExFKdesmXWqGxqh3PCuRd49tk626tCmGYazn1UCkkg16iixq2l
	 CytmCEije8ZJWcRD1BGC1+kMXvYrUn8kI0L0/QlfK/mGZ+OQeKTURHwSmTKrDziSyP
	 idy4Qsxw87oKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF6F1380A964;
	Wed, 15 Apr 2026 22:01:15 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260415212935.GA90297@bhelgaas>
References: <20260415212935.GA90297@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260415212935.GA90297@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-changes
X-PR-Tracked-Commit-Id: 4224e91fea5695a89843b4c38283016616946307
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40286d6379aacfcc053253ef78dc78b09addffda
Message-Id: <177629047464.2457809.9080291067682452935.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:01:14 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 Apr 2026 16:29:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40286d6379aacfcc053253ef78dc78b09addffda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
