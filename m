Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CF3B6367;
	Sun,  4 Oct 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128415; cv=none; b=g00u0Db3Pf9jtkQrG4uvfayT3uwFxOc+VmcGN4I9P9klck1alqiPcyQEv2ITHW5Q98b3qvqtqP23m6bhvdjzHdWjViMqEE3h+qDKJooFYsKjqS7BTAgIEWVK8JgAo1dX6mu15U79J7pYtBhT7xQPypHzG5pWm03sNYC2qps/PIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128415; c=relaxed/simple;
	bh=lei9XIb4M52i6TBsv4VscPx1kB1vzfi2NNHv46kjUpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZPk7jpjOBhKA1abx+1n7SRaMxouCmDHhbhrMV2Pe5T0bF6eC6vZutIJ3M1kxsC1Xg+xSk7RPs4UjkzQwJ3vAx28EwY5+0BNFmIF53dYL6Aca4JyrO3bABuKG1RIgc0KpdrXeAMV75Eo2QE55DuO261FbApwu3uXmLkwUrfhcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KRK3Aa8s; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KRK3Aa8s"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4hyRKf2tLPz8g5c;
	Sun,  4 Oct 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791127814;
	bh=lei9XIb4M52i6TBsv4VscPx1kB1vzfi2NNHv46kjUpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRK3Aa8sRYbCbCq1G1XvwlHbNsBbfAmvSK/1YXrBPWGCoBG9JitEnWCXcKYSm9SN1
	 lmeUIULdxyMWENfMpfKildMGAWRFt5ywzdVSzPXos/8qs2CDvrxmzqJfqCNGADuYuO
	 1klsc5Xs6sHKger7S8q6wArDck5YKHV0ncftPQErmu/BZ+vofehyRhSEJMTKdcKzDT
	 DNaN0H7jOZNgb6xRif1mkCO7tCQmG7fXuoWuXR/xMkAKjMWFqsn02hSETv/Q9xJJCG
	 gcAo0P7FjvET9xwtrrNvO3bi5lWprYreIqZJDG4KoZpKpgf6CC5hYjbAk+yCsQEkQ1
	 LHI67EPIbKV2w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4hyRK82NCQz8fFB;
	Sun,  4 Oct 2026 15:29:48 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hyRK72G8Rz8svb;
	Sun,  4 Oct 2026 17:29:46 +0200 (CEST)
Received: from [10.200.136.123] (unknown [213.235.133.113])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7E7485F9B7;
	Sun,  4 Oct 2026 17:29:41 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 213.235.133.113) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[10.200.136.123]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <22e0563e-afcd-44f5-9d87-f0b2a637038e@leemhuis.info>
Date: Sun, 4 Oct 2026 17:29:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI: failed link retraining quirk costs 1 s per empty AMD
 Promontory 21 port
To: Tomasz Bojanowski <tomasz@bojanowski.me>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andreas Wild <andiwild@gmail.com>, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260923191357.7410-1-tomasz@bojanowski.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260923191357.7410-1-tomasz@bojanowski.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179112778259.802426.18123040059643894221@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 7E7485F9B7
X-NC-CID: Q44MKV0GqKUBMV2sqV18DJ4/uqgfKdP/CLwerjGyDH1lO/S8ENY=

On 9/23/26 21:13, Tomasz Bojanowski wrote:
> 
> On an AMD AM5 desktop the pcie_failed_link_retrain() quirk fires on
> two empty downstream ports of the chipset switch and adds 2 s to every
> boot.  This seems to be a different case from the one addressed by
> "PCI: Skip Target Speed quirk on clamped ports with no link" [1]: here
> the Target Link Speed is not clamped, so that patch does not return
> early and the LBMS branch is taken instead.

Hmm, nobody replied afaics (or did I miss something), so it seems nobody
has an idea what's wrong here. So I guess you need to perform a git
bisection.

Ciao, Thorsten
> Hardware: MSI MAG B850M MORTAR WIFI (MS-7E61), BIOS 1.A68 09/07/2026,
> AMD Promontory 21 switch, downstream ports [1022:43f5].  Nothing is
> connected behind 06:00.0 or 06:08.0.
> 
> Seen on Fedora kernels 7.2.5, 7.2.6 and 7.2.7 (33 boots, every time).
> The same two messages were already present on openSUSE 7.1.x kernels
> on this machine in July, so this is not new in 7.2.
> 
>   [    0.248171] pci 0000:06:00.0: broken device, retraining non-functional downstream link at 2.5GT/s
>   [    1.248035] pci 0000:06:00.0: retraining failed
>   [    1.248972] pci 0000:06:08.0: broken device, retraining non-functional downstream link at 2.5GT/s
>   [    2.248036] pci 0000:06:08.0: retraining failed
> 
> Port state after boot (06:08.0 is the same except Width x2 in LnkCap):
> 
>   LnkCap:  Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <32us
>   LnkSta:  Speed 2.5GT/s, Width x1
>            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>   SltCap:  AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>   LnkCtl2: Target Link Speed: 16GT/s
> 
> Since the message is printed, DLLLA was clear and pcie_lbms_seen() was
> true when the quirk ran from pci_device_add(), before bwctrl is bound,
> so the LBMS bit itself must have been set on a port with nothing behind
> it.  The kerneldoc above the quirk expects both bits to be clear on an
> unconnected port, which this chipset does not seem to honour.
> BWMgmt- after boot is expected, as bwctrl clears LBMS when it binds.
> 
> Each port then waits PCIE_LINK_RETRAIN_TIMEOUT_MS before the error path
> restores the original 16GT/s target.  With this chipset used on many
> AM5 boards, other systems may well lose 1 s per empty chipset port too.
> 
> Let me know if any other information would be useful.
> 
> [1] https://lore.kernel.org/all/20260801201244.4421-1-andiwild@gmail.com/
> 
> Thanks,
> Tomasz Bojanowski

