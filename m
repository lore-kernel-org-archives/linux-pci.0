Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13938C406;
	Mon,  3 Aug 2026 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735609; cv=none; b=Nnwk6pZ8BzmwqmThXfQGD7Foca006B01J09QM5t7FzR9LhCcV67lQ12lt32qad0Dz5ZPFsyUKMDACIAfMXT9QUnKhN9/MZQX7XSBLQnmOLneiIfXgkxohDY7cPiS2lGqi7FTcS7VtJwk5rYxAdi5tU2HM5looYZMD1AagnWItic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735609; c=relaxed/simple;
	bh=Fg5GJQ6Zu59GQ27IKyj4NTNBwK1nB6pB73Wzr0Lc7k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbztFOWrndzXEVf1ObViv/TAM+EIaDhS+7Yi7p7olKxPssOOx01pkBNAu+ZBVUUHtoaZGwC2t+nXwWcUqIj1citSolKVMQudfC055/xtEGOX7AIfDUd2iPnMylU8A5swItS/z3OVk6brHiVNuaBQy0GpCobOhpIgibLuIDAeSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Cx+o9mRE; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Cx+o9mRE"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4hD5984pmfz8g1r;
	Mon,  3 Aug 2026 05:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1785735596;
	bh=Fg5GJQ6Zu59GQ27IKyj4NTNBwK1nB6pB73Wzr0Lc7k0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cx+o9mREDB7U1H2oc4yVCckjGUd+zGKg1czIIE8GMjjAPAQ1mUIozsMPtwXJMoeRm
	 mGRVy3KmgKiA2FjaAX4rYFhQ4U9QOBL/RVgc1BjRp8D5k2WVOfnOypZOSWDJK7J57C
	 5jXfpftdLkSmIAtV/GE1P22uejC1FmJZ4WlaB7nh2y1MkgfLUoqxOkPL5NY8no9Uxi
	 YqzZiscmXP8QTsnFpOUULu+fvUbyCcwepvwh+xHOBoYq+qi9E1Fhvx/btNAjAL7dKF
	 QIUw7TodpV7S7cOjhSo/o76RP5pa45f6awB3VGvSztW+RUltZRS5xLcXsMc7wu6Ypg
	 GR8BCJeHapNVw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4hD59846qDz8g1p;
	Mon,  3 Aug 2026 05:39:56 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hD5975h0hz8sgw;
	Mon,  3 Aug 2026 07:39:55 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 017AF5FC78;
	Mon,  3 Aug 2026 07:39:50 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4cf40370-47e8-4143-bebe-bfab78ac2fd4@leemhuis.info>
Date: Mon, 3 Aug 2026 07:39:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: Andreas Wild <andiwild@gmail.com>, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, macro@orcam.me.uk, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 edwardmalik95@icloud.com
References: <20260801201244.4421-1-andiwild@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260801201244.4421-1-andiwild@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178573559138.421207.13114101684528294719@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 017AF5FC78
X-NC-CID: vREIpUGzRwGL0pbZA7envThNcCOYS0xlc7kFeBPUjhIP4Gn4Ge0=

On 8/1/26 22:11, Andreas Wild wrote:
> From: "Maciej W. Rozycki" <macro@orcam.me.uk>
> 
> Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
> failed link retraining") the Target Speed quirk lifts a firmware-imposed
> 2.5GT/s restriction on any downstream port, without checking whether the
> link is up.  Where nothing is plugged in, the retraining that follows can
> never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
> quirk makes two of them -- the initial one and the restore on the error
> path -- adding a fixed 2 s to every boot.
> 
> On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
> slot, running v7.2-rc5:
> 
>  0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
>  1.541 pci 0000:00:1c.0: retraining failed
>  2.541 pci 0000:00:1c.2: [8086:7aba] type 01 class 0x060400

TWIMC, this patch fixes a regression Edward reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=221801

[side note: the report could be more specific, yes -- I wanted to ask
Edward to clarify a few things (like the actual slowdown) before
forwarding it, but it didn't came to that when I noticed this patch and
asked Edward to just check if it helped -- which is did.]

Ciao, Thorsten
> Where the Link Speed has already been clamped at 2.5GT/s and no link has
> been established there is nothing worth doing, which is what the kerneldoc
> for the quirk already describes: the restriction is to be lifted where
> firmware arranged it "and the port reports its link already being up".
> Bail out early in that case, before either the ASM2824 workaround or the
> removal of the restriction is considered.
> 
> Ports whose link is up are unaffected, and so is the ASM2824 workaround,
> which is reached with the Target Link Speed not clamped.
> 
> With this applied the quirk returns without touching the port: both
> messages are gone, enumeration proceeds from 0000:00:1c.0 to 0000:00:1c.2
> in 1 ms rather than 2 s, and the systemd "kernel" boot phase goes from
> 3.011 s to 1.036 s.
> 
> Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining")
> Cc: stable@vger.kernel.org
> Reported-by: Andreas Wild <andiwild@gmail.com>
> Closes: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
> Tested-by: Andreas Wild <andiwild@gmail.com>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Andreas Wild <andiwild@gmail.com>
> ---
> v3:
>  - Replaced with Maciej's much simpler approach: bail out of the quirk
>    entirely when the Target Link Speed is already clamped at 2.5GT/s and no
>    link has been established, rather than programming the speed and skipping
>    only the retraining.  One function, no new API, no bwctrl changes.
>  - Note this leaves the Target Link Speed clamped on such a port, where v2
>    left it at the Port's maximum.  A device hot-plugged there later trains at
>    2.5GT/s: pcie_wait_for_link_delay() only calls the quirk when
>    pcie_wait_for_link_status() fails, so a link that comes up cleanly at
>    2.5GT/s never re-runs it.  Flagging in case that matters; the clamp is
>    firmware's, so honouring it on an unoccupied Port seems defensible.
>  - v2: https://lore.kernel.org/lkml/20260801105441.6506-1-andiwild@gmail.com/
>  - v1: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
>  drivers/pci/quirks.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f..9e407c4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -108,7 +108,11 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
> -	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
> +	if (lnksta & PCI_EXP_LNKSTA_DLLLA) {
> +		;
> +	} else if (PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2) == PCIE_SPEED_2_5GT) {
> +		return ret;
> +	} else if (pcie_lbms_seen(dev, lnksta)) {
>  		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
>  		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
>  		if (ret)

