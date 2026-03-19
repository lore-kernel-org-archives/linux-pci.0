Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7424035D5;
	Thu, 19 Mar 2026 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963047; cv=none; b=qLD92Cw1/IJNAN5gn4FUTfzPwcARvgS4+CFQ3IhUY3Musnob3uGTVGsv3GqWhCic+nxspSAX2g9JVdk4Q9YpJl3nLhmpJhwDchvNoe/ImtyMBASpBXELbyQr7q/7GHs5V47ljlpd06JM7yTTZbpZ/MBAMf0j3BnEoerGRp/yQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963047; c=relaxed/simple;
	bh=dLOwqsZANL6VR7j2N8d1LZMKxzMOZrCV+0BMSAHfsSE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qTtKwy7ctq4+iPnExSIXIlmK9yvWfXS5B5j4V/clyL3Pe/ycMGsOm2327V/dJFKp2EVsd8KZkBfJaJLK05ANUTBUoJybeBzEjIE1zu6Lt4Q9Co6HSz1SJp0khJJ9weN4RTl1dTeqddLkoG18pZzvXaOoNMt0pvLRH7iRQRiSD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfdxE5lD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfdxE5lD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2932C19424;
	Thu, 19 Mar 2026 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773963046;
	bh=dLOwqsZANL6VR7j2N8d1LZMKxzMOZrCV+0BMSAHfsSE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MfdxE5lD/DNsyIcPiQwuvK7cD0eGKWx7HpBDCGXD1pUlT2VWLJquKd8gLv5nN0RzB
	 xzoT5a57YLXNEsJpNZqy9WBFxCKvYM24eHJF5mLJDMccWaguAHJ6i2IH9upZA8bEOy
	 mi25g3QQrR+GTUfcv9Ld63gIhnifKkRUhnHOBiTlagKcP1OC7woYXwA/QrwqNyt/No
	 okW14Uu9gAxTH4hVOBtFdYOjgWEwJUyBYrKBk3UlAkTxrJ6xLLEy0aG1EYe44AO6gy
	 V0xmx0WVa3rPdHFkvM5tpGrOVYeyvyw85KxLksvz3iTjsM5W0SGtleHLrPZ7i1IFyz
	 DKrxUKUVZl9dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F8539302F6;
	Thu, 19 Mar 2026 23:30:38 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260319210740.GA528280@bhelgaas>
References: <20260319210740.GA528280@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260319210740.GA528280@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-4
X-PR-Tracked-Commit-Id: 21647677ba9af2cb6bc460e17d9f29a7132c40c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b70771216558bffb329c2e69b2fd5fd71133e55
Message-Id: <177396303747.1847629.2934275890626052976.pr-tracker-bot@kernel.org>
Date: Thu, 19 Mar 2026 23:30:37 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Koichiro Den <den@valinux.co.jp>, Christian Bruel <christian.bruel@foss.st.com>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Mar 2026 16:07:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b70771216558bffb329c2e69b2fd5fd71133e55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
