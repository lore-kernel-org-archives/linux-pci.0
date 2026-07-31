Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7D47A862;
	Fri, 31 Jul 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523146; cv=none; b=HyMTK4xbA1u+sH4VwQKmebTo3LKaWo8w/B5IiC9hbuWCio4hEh5adISmewbcsDfJndjBoLn2Fc9BCWaObzSNzYRGg3hzC7gHYCmisuQVeXGjYYF9ggAEQlF/wtO+zMnivL8GP7kk/3ts7RK/ufhtRUn4rg7dxeCX8bTM2C+74mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523146; c=relaxed/simple;
	bh=2b/02i8Hy1ioym0D6Hcv+kwkkUfke4HmrF6fFV+6+fs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Vpgn1pcPT39Zt8DLOLVFBiOc6pgSmTvcGwON7sG+PbcWkhsSauGztdR2v+qDjFWzB5ewZp3mA2t44BWrjA2fgTyzK0Ut5xCjs0QAz2U7UwYy63acl64tylZeNcd7jQroYOsNmJNlYQ4CFiSDVu1rZQc7Sw1qgki6qi3WQq1+Jtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivmVarBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivmVarBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6251F00AC4;
	Fri, 31 Jul 2026 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523145;
	bh=rHdG2/VHL7YNBQDWL0QLuZKcFUpzSr+ANVDztyKKSvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ivmVarBkI0n7Xt3GdpuSZlCKbshkMqgIcv4IXkMKIlgEaAirzLgnU4bZOHP35doFz
	 Gc7PsRhKkQ0TD8l23ATSLE/VDsSEY+p3fVLsxRkd5DBXzpCHjcxYflJdORxYR7VTYO
	 IwCDNq1/GHznhX0IIyMB85iHLVw3hj/llXdIq1K6iVie74ITxNjJBKdL0/lEkh6TDW
	 08R+Lmq+wKTlAi/AZCVi01MF0Ubdccx2Z3PJ3Psv06QaNLW+N90NVSZhLNz9UpeOHn
	 zHJD6keAn5y21MSfhQWQcFHwcasDq11Pi0+G5rV1xygvveU87mxGnlV9ReI6jtiJ5z
	 S3JEY7UVhy03Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398B39263B9;
	Fri, 31 Jul 2026 18:38:29 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260731153950.GA1568891@bhelgaas>
References: <20260731153950.GA1568891@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260731153950.GA1568891@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.2-fixes-1
X-PR-Tracked-Commit-Id: 7678e81498e20e78d7d5f64e552cd153117c1d66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 596254ecc5b7502915feaa737f62b636b77d669a
Message-Id: <178552310824.857209.14496025580678077715.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jul 2026 18:38:28 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, Leonardo Costa <leoreis.costa@gmail.com>, Frank Li <Frank.Li@nxp.com>, Soeren Moch <smoch@web.de>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Mitran Karthikeyan <kmitran@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jul 2026 10:39:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.2-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/596254ecc5b7502915feaa737f62b636b77d669a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
