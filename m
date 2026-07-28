Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8A478E3D;
	Tue, 28 Jul 2026 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280777; cv=none; b=mvJg6Wk/XW+JPntLFPNVBs36y+ZYW6LDZmB3xzG7JYL+cje4LmpwepNCRBiazZI9k9raJMqgSSUKyhyvJ78a9arOA/TqpGzBQonJxeOJ1DQhlQ68xy7Y38FniEx4zPQSzAS0qwAkX06UgfISOqQIVKxcXPbhLnG5OFyun6hEVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280777; c=relaxed/simple;
	bh=/1Z465AFeRC4q71LBhRZUnjtTwJshzyAXAv59HkAx+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCaqyAdjk2DSBpIBxoypzc+Vfei7kwyriUcj8VltZtmkG4gLwnkqGDHV6k5B/StDcwTea06LOvcdN06I7rHkavQLw0g+O8pTcE3NpkFzCxYrbRrFyf2HDhAxd5MACwCBoi5faZntBmWU+5oHDnlmTe8tMfWwANISt117FZJgEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRoK7sw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRoK7sw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05CF1F000E9;
	Tue, 28 Jul 2026 23:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785280774;
	bh=ilsqNG0PCpIJ2XGyyjHetkq2bHI/GbgFTHMfifpPFA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TRoK7sw3YixAND4XE0H6DWWfud7KE7Dn5Fe4BvVg8GpYu574zB3V3jGUF0k/+wx3E
	 hOMG0ey8a9c2OgzRc3zwE44SoKSsWuxmvZw/3RXDgpSi0j6nLs2uKmn62So7NNqYJt
	 X/cSFbyeg91EeZX2vbzODyba43jgPutuobnjdOJa6MBXK9b1aG/q/8yzVl0YqysGK8
	 WsgkufqCfnf/Q8He/ETR18+lcDdvljCbidnnaeLXS/IC6P9t06teantQkQCC6CYuWq
	 9SDVbcMP8Ka4KwV6SlparLhXdlB7CfTkSikx1yZYQUxcMMvROQdY/KJO0xiyKo8HxX
	 vwV1Ol62sE41g==
Date: Wed, 29 Jul 2026 08:19:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH 0/4] PCI: Fix procfs PCI config access issues
Message-ID: <20260728231714.GA2293930@rocinante>
References: <20260414024544.2975605-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414024544.2975605-1-duziming2@huawei.com>

Hello,

> As suggested by Bjorn, this series aligns the implementation of procfs with
> the sysfs counterpart and fixes procfs PCI configuration access issues.
> 
> The first two patches refactor proc_bus_pci_{write,read}() to align
> with pci_write_config() and pci_read_config() respectively:
>   - Rename variables (pos->off, cnt->count/size) for consistency
>   - Remove rebundant bounds check
> 
> The last two patches fix potential overflow issues:
>   - Prevent overflow when offset exceeds reasonable range
>   - Fix implicit 64-bit to 32-bit truncation in read path
> 
> Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/
> 
> Ziming Du (4):
>   PCI: Align proc_bus_pci_write() with pci_write_config()
>   PCI: Align proc_bus_pci_read() with pci_read_config()
>   PCI: Prevent overflow in proc_bus_pci_write()
>   PCI: Prevent overflow in proc_bus_pci_read()
> 
>  drivers/pci/proc.c | 115 ++++++++++++++++++++++-----------------------
>  1 file changed, 57 insertions(+), 58 deletions(-)

These changes here are worth doing, so I wonder if you have some time to
pick this up?  If not, then I am happy to pick this up and send a v2?

Thank you!

	Krzysztof
