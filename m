Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2D3595D;
	Sat, 21 Feb 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636802; cv=none; b=pD6NBfYo7bAfIG/Id6SvBhJGQvJjboBM+4QdD73WZ8DesyOlZW1/bjKaCEzHz2qi2I7/AVu/5+7xfMmy7wL7ZlXsZH7rrifZkdtawMu6A+Uui9duE5M4ntVzpOs5iu8LFKPn/AWnM/27ArtDHkaz8wDaiUEWp5/pzBIIWAywScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636802; c=relaxed/simple;
	bh=lK4LwHWNL8IuRGcoQ3lHXkh6AMsKiLPDT40A4xy0h1g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BNBtIsLHJPHK8EkTFHXUaSDlf/U4X099ABWIX3+1xhLq+gJq2Sfaw5neI4wmox7Hoyup/473xxg0D4A263+XZEvKrfDnXYoSUVnRoCUPlJF+UBHiVJq6pl+5KgdIfB49Xg09PQt3FIgnAY39mAAwu/GtyapfC5JWMKJrW5t2kUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkqfNAUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkqfNAUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E29C116C6;
	Sat, 21 Feb 2026 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636802;
	bh=lK4LwHWNL8IuRGcoQ3lHXkh6AMsKiLPDT40A4xy0h1g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WkqfNAUR2a9XNTiyOdfalfcJTGTM7Mky5IWqOedn39IlI7MLORdYoy/IbOsqAcriH
	 q2CLfsPNN80moO7YFoa5xbiok1OSVGibmO4HVMuMewQgd4NPIYH5LDY5yUleKwseKs
	 7ShLNrZ1zPScYxP8Ah6E21uF+pXZ/eLoNV7E5+CtkUfK9L2VKmLlPqQnnhEUhoUAsl
	 uksonPmxBeXPlVy5zMf0W0B17k96GW0WM0bo59aRzAoS3/MoaPTaa0hfpe08/go49G
	 0pXjal9XHyditSjZ3AL6BTKftpGO6oTZhZJWKRvTug+7GEhR4vGRvAy34VTd4LAyjp
	 zIhawj6ZfiwWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DFC3808200;
	Sat, 21 Feb 2026 01:20:11 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260220190742.GA3538737@bhelgaas>
References: <20260220190742.GA3538737@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260220190742.GA3538737@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-1
X-PR-Tracked-Commit-Id: 8c746e22096579897d1f8f74dbb6b17a6862fb6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f6eb5a6d27b56ea44c2de9f9028d803aeccbfe8
Message-Id: <177163681034.969912.1606960824245892181.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 01:20:10 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>, RavitejaX Veesam <ravitejax.veesam@intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Feb 2026 13:07:42 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f6eb5a6d27b56ea44c2de9f9028d803aeccbfe8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
