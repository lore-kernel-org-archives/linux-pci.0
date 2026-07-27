Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA742BC44;
	Mon, 27 Jul 2026 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185445; cv=none; b=PEtBe8tPLNsPu/8qkEET7FrqMndMzll1FjEPG00V6wuolve3eMpE9A5K49dqnuSQ9Blih0b0CNARo2go3cVQDOPtlhvvyJjNqIbvW1kQhRuGyDFrLAvIJgLhrFOdGclsSmITBDsJjn15fKjaBus7VFAfPBmMWjpV4Uyp12hkUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185445; c=relaxed/simple;
	bh=RCPd6GbnvyfVjdV/dISyAzcVUZMw1aCy6FqlREEzx5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eo2S/lhzoIZU+6sdHXTYfQqYRH37NOMNmIA9ZNe/sucBW0g2D9xVcj6XdRw0E43vmKorbzr9Gey75Gdk8lqhxMdI2hGbcjjcP3JbUlEiEq376x3HhsbpgSMa32ONj+bF0SEBFptjei6mqNK0yaGqRrenGg46nhE89U8BnSKDQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHKw0dFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHKw0dFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109341F00A3A;
	Mon, 27 Jul 2026 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785185444;
	bh=VfAXffogEnldNo6DXQntixj26Xbp+v5BW/iDaaI/n4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NHKw0dFGtiRNiNjBoRw0wTfhK9hEMGutXuizhWjmfiHMDo2f/coZyYBNPZogrTVw/
	 8WKLkfaJxgoBK8JI4ETI80v3sLVmDpkbfgiOxiEnr7TB5DY/toReR9JsHcXE+loDCJ
	 6/3hbLh6r3HEyUHx4+p1glMBE75Yjs/mKKkAkwjT1D6MtLPAKGctZU60+lPDfk4ieu
	 TGi2iFvAseB8ik/u1ItRfXtVXvCXobBGDKrvUhevhXpVX7L+zxFa2w6seVjKAvslvp
	 tgw7t8/W+iOHdwe8gW62126QUZnCN18lOdzR4xbpijL0Z67QqJAofIggkAb+OtyZk/
	 cHz0INslr1PNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93937380664D;
	Mon, 27 Jul 2026 20:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs
 for
 PLDR
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178518540913.1412337.16971564531930709335.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 20:50:09 +0000
References: <20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 luiz.dentz@gmail.com, bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com, alex@shazbot.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jul 2026 10:51:02 +0530 you wrote:
> Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_reset
> to allow userspace to trigger PLDR (Product Level Device Reset).
> Reading the attribute displays supported reset types. Writing
> integer 0 triggers PLDR. Any other input is rejected with
> -EINVAL and a warning log.
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> [...]

Here is the summary with links:
  - [v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7ef68421906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


