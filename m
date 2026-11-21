Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795233391;
	b=FR0Lh00FWPUSBX+am4Br6Foi8paOT9nTODC1b7FdyIZp2wMqjUl6rOnC57e5FSfz3Klu
	 zmAe+IAIQN7p8NxfWIwe58T7n9Dxi+afLXp2nFtS47+Eqezfxr9sWAZ3rj0vl4FKkS6a6
	 52hpVAZX42qDn3mjynY7NP5MH0MKgkCo16Wm4y6iFXAqi1yl3/CQyZsuJshW02EkZaq1S
	 WhIeyzYp0pYaN6j6+BPH4zR5RaENjwfVcBFDHKk4zhVXOLKyt5eNxLCcCna0+B3cX6L37
	 ukus55+hDH+LihnYwbJB/7ONlbSGwl3TGaMFCxdrkNQvQ1g0oi7U+O60qcCmNQt5Z7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795233391;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=OF/ithkTCQhz9xa/JHplw0o6MdEaPR7IC1Mrvqu8F2k=;
	b=J8k3whtt3ckufpUbVERyt3yBNMkCfaP5pJFIZVRb7pcYOUtwPiPr/avojKzcwAzdvnpb
	 3i+gd6GxncFaVpyE6//hYNncXLV32f8/Ay/dG1kEYOee2tkbPiN8k7cayqgiFC5WaAcnC
	 8QbLIIw6ayNSna3/L417ZdsdlZfgh/lPkULd9o0aNm3DYxPdHESwVExODzsUSG+cL4whh
	 PkZSCdgdDi5/t0f7llfkELu1F60INgvKNVG2LsoWakOh5rNAApMRgiEWjhM2fbDe7H4wx
	 4Sgs3+nK6IWSRWES9tN2oHZQvbThE+Ssz6TJR7lh2hz34SAOK4Oy06Qcw8YEui+18NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeMQQMiO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA560A260D;
	Sat, 21 Nov 2026 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeMQQMiO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0870E1F000C4;
	Sat, 21 Nov 2026 03:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795233391;
	bh=OF/ithkTCQhz9xa/JHplw0o6MdEaPR7IC1Mrvqu8F2k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UeMQQMiOK+5/hiPDpGAOllzlWhwR7BZEO1ErPVgjWwi9eziDE7dvsEvzgrCtrp3VX
	 LvPMYXpA1/5XjgHhdYlu8juMrmMMgPbNfzwOx3txWTYQdI4sswBdEdr7bfpRn27bzJ
	 iOh+FBS8N0au0YEnEDcmKpGT/YzVndLfGIXQvKiuhVBvKNqCowuurH+zXjDybgoXgQ
	 RFLBKXoRJKTPh4NoSA4daw74zoeNk+UP1o/zFkN+9G26sQSR2MJp83C/E8PY+u7Ft5
	 JjrTZoQkZslOL32KncAO84DLzT8D/o77aUxfFiNzcw0pD8+lUiy+NS8Ub6eISDcTek
	 ZLybWbWlIO1cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16AF380AAFE;
	Sat, 21 Nov 2026 03:56:30 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261121015731.GA966532@bhelgaas>
References: <20261121015731.GA966532@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261121015731.GA966532@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.4-fixes-1
X-PR-Tracked-Commit-Id: e735de71a2d9403fa1e2d134d1e9aa0a24f4eaff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa31d5f8b151b786b748c6bfc9a8c4f1855c8adc
Message-Id: <179523338947.911893.13065670322840145966.pr-tracker-bot@kernel.org>
Date: Sat, 21 Nov 2026 03:56:29 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Alexander Gruhlke <gruhlke@mailbox.org>, Sun Yuechi <sunyuechi@iscas.ac.cn>, Donghui Zhao <zhaodonghui@eswincomputing.com>, Senchuan Zhang <zhangsenchuan@eswincomputing.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 20 Nov 2026 19:57:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.4-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa31d5f8b151b786b748c6bfc9a8c4f1855c8adc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
