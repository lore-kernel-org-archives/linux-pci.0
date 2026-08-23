Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21E3AC0F6;
	Sun, 23 Aug 2026 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787518259; cv=none; b=FPA9Dh/J9xNLGyY1N8YNkCPa+G9H7E03+h+i24NlyBduMK8s7uqB3mVkCFWoQHO7TK6x7jgw3iEn30HumvpWEk7chukKrW0qjCaB8Zikr81ffX5nusHu6vIoMtRtwDtozOtd/1MW5/gnRH6TA6NNgf1f0EpEGlCPurx+p9Imgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787518259; c=relaxed/simple;
	bh=+vmgj7h1Ee7tqPR/0b2Bkvy7pCwVdbVtl37ye6OGrSs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fLXQ/TFjSuzswxhW79r2tqAIM12uFNG1XVCCwX8PpIr6Xz3NT2pTPDlNtWnOQEI6tH0ebksZiF2+ZECwwKWdewEMZVc5CvKG/27X/BnT2cuOuK/JheSSGcCn666bNLd4RYyB60DDGGy3cCiJv0I2yyqrNCOUJSrcdnRzgbNk0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C218keO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C218keO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060E81F000E9;
	Sun, 23 Aug 2026 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787518255;
	bh=/AxVLRo0OtEFhZWH3tuWX/VdsQ2cbx1Ca/QgfVAwBKg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=C218keO0Z940xg+ktgcInN8/EI20d3kKLJO7xuyXVIG34bqq+bbhMRbtz2lHRqvAK
	 drwb8IEkKy58mGjyjtu3ELrVZIWCL8yndWpqQ9T7Ybi4Bf1ofdsInSsbOG3/393R2C
	 +Bck8YCfXrJDQ/CMlMTJtJqEi7eaJuKKiJdMvyeB0tLlCaTaZtIyI9NSwyhgLCa3bQ
	 iqcj7WAOiK6zaTLN2yFVhCv5pGSsp5JxmVIwEmiyfNGDWn94FMUJL+zySSQN61Se6y
	 bERXxehepiJ/CHXTBDkqlkaP1bUPmUaRSdKSwnYXf80Ysvxbht2No61CXh7fWWo/kv
	 Lm0TsnJ7Ljr/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A9D380AA78;
	Sun, 23 Aug 2026 20:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260823193353.GA1246025@bhelgaas>
References: <20260823193353.GA1246025@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260823193353.GA1246025@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-changes
X-PR-Tracked-Commit-Id: 9324becc398a1f9e67c91a3d652a7c56e5afc7f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 570f7e331f5febb30f1384817463c7e42b65ca7d
Message-Id: <178751820296.2147879.1397825262421221065.pr-tracker-bot@kernel.org>
Date: Sun, 23 Aug 2026 20:50:02 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Aug 2026 14:33:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/570f7e331f5febb30f1384817463c7e42b65ca7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
