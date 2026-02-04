Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDA39E199;
	Wed,  4 Feb 2026 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247525; cv=none; b=Ksr952uhjtFqScsuBIPUseVDuXHYpO14Ecqwsnx89sYYf2jVIDftYht/EmetA5IwCdg0ACbg+LFrN2/GWyqs3xa+qZMzp351k8zPw3x6dfhmUykGoCh0W4MezhTIyqvsk94GeoHYuoeI7TaHVjsigzedtprVytTB2XaNYUVOqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247525; c=relaxed/simple;
	bh=5M0iWlchF+GcuC9DA8aw+uAtTs0J0wOvMlTCj9M2p4M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LLSsdx576/tOzNGFcBW9Bx+mystP7zY8xa4zKJTEw7zhocaLRRTGHVYeHiaf+BYIN8QRl9c7Pm6hmDClhWxS6fp/wSgGWovCVHYHDnbjKp/GqvoOWFa7Y80d3aQSOPp2xHrKPHIMANxAa/GD+NU2dBUwSnY7x95fTXlexOuSy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZVBnA3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZVBnA3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CCCC4CEF7;
	Wed,  4 Feb 2026 23:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770247525;
	bh=5M0iWlchF+GcuC9DA8aw+uAtTs0J0wOvMlTCj9M2p4M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qZVBnA3AMpDRgdFRy4k/GW4f1bBV7f84bwGz4Guxit1+2kHux3zcSPwoYISsr+hKl
	 T3V6FkNNvKG0RySiLqD6ZgsWKcETDDavOda5YKb1lwc/gB6y+DPZLuqraVBZM1UwQp
	 HdzC9DDB1odRGuMaWepF3qv+ACbjliyWVsEjAa8T9b8Jn91ZKBEZoWmeT5sHNu8Uxu
	 zXJXbVFwNgoOTQIYOk7LfyvL6T2Z/u4neSJa3zXggyv5e+k7RQG/1Vu5hNRXyJ9ve8
	 c80+Yeyimigg4es1viTdqx8u3yQIJgfWdJGsubIla8rxAzwx3yE5ZwFRvll7vN6nxr
	 ZVoClzg8bAz0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C248F3808200;
	Wed,  4 Feb 2026 23:25:24 +0000 (UTC)
Subject: Re: [GIT PULL] PCIe Link Encryption fixes for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <6983bd3a3a3ae_68d310016@dwillia2-mobl4.notmuch>
References: <6983bd3a3a3ae_68d310016@dwillia2-mobl4.notmuch>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <6983bd3a3a3ae_68d310016@dwillia2-mobl4.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-fixes-for-6.19
X-PR-Tracked-Commit-Id: c2012263047689e495e81c96d7d5b0586299578d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
Message-Id: <177024752327.90305.3178751056344607605.pr-tracker-bot@kernel.org>
Date: Wed, 04 Feb 2026 23:25:23 +0000
To: dan.j.williams@intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 4 Feb 2026 13:42:18 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-fixes-for-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f14faaf3a1fb3b9e4cf2e56269711fb85fba9458

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
