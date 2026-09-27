Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6F3F926F;
	Sun, 27 Sep 2026 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538560; cv=none; b=Pa5sM//vt6Zc08X9HOH7IKtR754ymn1YCwbjBlLHJ1tOaP2Kq14DI7DWSfEvh68DJJbi2xnLXwGiP/0a6Z6xrY9tdIXXEHTZ2xYqB8JRHNknTDQGxTnofP0FoUySkLkxwzpbHbh5zZ+pPrCSD5BZ/yJcp1C6lHCPS7YeziRaxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538560; c=relaxed/simple;
	bh=iWCmURMLuDpQkHHgL5/qAvECS3kjwSbk59FrytsEm7I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cfPRE6ghcEOB5hpzbJFARFs33k8/MqyvJgr46Fg0edQXlwQh/jvEfqgq63jlSG1+fKuLUO1RJVIrRrgwHfUtkCd7G95Co9EWfurL0RhoWBxhwgPaGt0bwEyB1x8mgbi0FDwNGq+ney9tnBGdYTOodKD3W9wC8vPV8TiJfUe8Z+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkyBIvk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkyBIvk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F067F1F00893;
	Sun, 27 Sep 2026 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790538559;
	bh=JgjVMJzoTDXZLljiCvxHnmepUJtCbTxKOtjiawS7R+Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YkyBIvk5rAxDIFg/orhsgpZ15jQFwTeqwhsviFVK2X4uG5SCtb/KCB8HcfibbUr9a
	 AfMHX7yRImJh81bKegtoiCA5Edp4nESH5TslRUBFnHoCcFq5bUUQBdz/GAvTeCDNv6
	 sFYopgqkNcPRghXhmYwbVl0T1raJOJNln7vnul08nxNAP5AP/IB+Zf2w48jDFuX+11
	 r/Y7DmhR830FkHE7cFlPN83PKf32vNYDX88aEwIJn3Hzjtl+E+rer9En/Xnft889AE
	 ijI7yPH63jDwNuMU3waxoe6lluY2grH2DHVfJEcpmYRf0tl7w3paI+w4S8/DYiB9ua
	 LcuoAzLNnri1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A41380AA5F;
	Sun, 27 Sep 2026 19:48:05 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260926165811.GA2146023@bhelgaas>
References: <20260926165811.GA2146023@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260926165811.GA2146023@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-2
X-PR-Tracked-Commit-Id: 4fde448225123442c5796f54b7a4400e2d3cbaf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fddfc3ec31799a932bb92f1b8a84cb3d1f963be9
Message-Id: <179053848466.2777566.15245149270723962711.pr-tracker-bot@kernel.org>
Date: Sun, 27 Sep 2026 19:48:04 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Mikael Etienne <mikael1022bzh@gmail.com>, Arthur Husband <artmoty@gmail.com>, Alvin Lim <alvinwylim@gmail.com>, Niklas Cassel <cassel@kernel.org>, Roland Waltersson <roland.waltersson@netinsight.net>, x86@kernel.org, Angel J <iamanaws@httpd.dev>, Herve Codina <herve.codina@bootlin.com>, Andrea della Porta <andrea.porta@suse.com>, Liz Fong-Jones <lizf@honeycomb.io>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Sep 2026 11:58:11 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fddfc3ec31799a932bb92f1b8a84cb3d1f963be9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
