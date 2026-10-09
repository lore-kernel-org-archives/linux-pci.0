Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381B2F549F;
	Fri,  9 Oct 2026 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588750; cv=none; b=pXYiNM5hfq6a1xWreHknJpyWP90rB7RvquFRavDXD/fuyORq2nQPAk91m6IZrRaAjsr02GRMKrFXaabpZEY5j77UHsy0+c1SdzPnwEYySDljuest5YyTiUDRwbwHIIpehhyXNLsewZUu1rEtl+dUAbxppwSAgmoJtlHqgBdxqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588750; c=relaxed/simple;
	bh=KzIm4FdFxuXHgsJU3+JXTFAlYZe2ev6FzXHPuqUH9G4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lAFWFy6ZBlwANs+pYvklQdykHRBLvwC0C129vJPG4WX4MQKocmRyALgR5IoG5pBQc9f8LfkulsiH4cEKftf0nSf0N0+/4bySoLtqUalbJJb8OuztfLnuKp0mujL+I4kCTCILfd9OfA12BduOKO4w7oB/QiEhgiurctXpxuJ6rXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkbbsnDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkbbsnDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE81F000FF;
	Fri,  9 Oct 2026 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791588749;
	bh=XsAAW/EodyzMUQNgpqDd1gVryRXCL0iBRw+vyKGYF0s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nkbbsnDhHbcUgWZxIPr4zlCDEyiIgwFB2oGgjt+OVD8YOCXu6BTTOrunpugbwVcv/
	 md5wDlzXDz7oboIjx2Aq/b+fxAGAqBswhSulNnMUSWbfY3WTDJSSbeZOlt3sBBd6oH
	 2Lygkj3nrqT0K0M0gqPBmxKU/t5JzZ/NTGTlC7I9ba90zFLQAKvwntHuLOEMW6Kf1B
	 V1KjVbuGNdEgyWR4gc/RR+wVriN4c4nsC2Z4XyDb/RPdtSKBAro4oadq0QQn11RuvJ
	 TiOfXGdpJgIlBFeaegVak/6b4npZ/dPZYtqE7Amp2/XZAmeShdeat5DV5LW5w+Gdqh
	 OcFc1GSNJbhWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4C139263A7;
	Fri,  9 Oct 2026 23:32:29 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261009161832.GA980777@bhelgaas>
References: <20261009161832.GA980777@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261009161832.GA980777@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-4
X-PR-Tracked-Commit-Id: 79c168e2aa957ed0054c93db17caba653b95e377
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
Message-Id: <179158874784.1049084.5856116017471433775.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 23:32:27 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, Alex Deucher <alexander.deucher@amd.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, Jason Perlow <jperlow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Oct 2026 11:18:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
