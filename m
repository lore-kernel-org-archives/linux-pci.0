Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A155423783;
	Mon, 21 Sep 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986824; cv=none; b=uo2DFKIMX+0q0VNxnOaOQxHp1GNX2ZAaeW1F4BA6cDzaRlgBUR6TjLZh6AbkAWb7fRrO+QsQ1Nnv21cl/CyCZ3Wq8q5cwGrKPhzAIJGlIE/TzvBIA3DMFMOY/s08E5ZhQda/GJYlq9y3zNENDsg1pxmGfGzZEtS5WBG0ZiysqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986824; c=relaxed/simple;
	bh=LV+2tYCakXqoZe2XmT5/XlVU9oDmqMoQ4He7N+Nuloo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2Q+GfC3mTCX8wwJgqIwcT0Bymb5btYjynoGQXuZU9Nw3Z64591SmiCKoJ1C0R/6Ypqe9S90I6UTg9AKFGjcm/G3kIqIoAAb/5Ki1TWyV1huE2SXeGINnd3rADnt8ECJByS3rap+1rgClWslTPyjPVQS3kNXj1hfG4J4Ittt9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=a/2p1nEr; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="a/2p1nEr"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hpKMS253Yz8MkP;
	Mon, 21 Sep 2026 12:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789986820;
	bh=LV+2tYCakXqoZe2XmT5/XlVU9oDmqMoQ4He7N+Nuloo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a/2p1nErlbmFMLJNFNXEeNC0l5pSuu/FT+zb1XLK+YOqfd3p+loP3w9nvhgMLDxPg
	 NBeL13cy5SQAn1UOpzWotIaEY7/dARW1dHvF67s0r8eE0i2si/GGFNxfaMiYjCizAD
	 PkqOkEivYa+oI23qLZ8lAoIC0mc8YM9T6CpkUSNm7rWEqSEjdb+LVVOEnN48Uqy7f4
	 IBPNkoZ8CoZG5lb/1IYSehlKnq0Bun49S/hLz/rAU1USw7TabkJEc/dexQT0O43VQI
	 ei95ftI/SvGpA3c4rrrPRdSulEB1QbfoNK+UPk3GiKbKHcNXVWds0SzjpFKXymlW5P
	 1iTbZRWWmzflQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hpKMS1Mxtz8LKg;
	Mon, 21 Sep 2026 12:33:40 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hpKMR3bqTz8sb7;
	Mon, 21 Sep 2026 12:33:39 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id A7D775FC31;
	Mon, 21 Sep 2026 12:33:34 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info>
Date: Mon, 21 Sep 2026 12:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andreas Wild <andiwild@gmail.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, M M <restafvalendergelijke@outlook.com>,
 regressions@lists.linux.dev, blaat windows <blaaaat@hotmail.com>
References: <20260917233355.GA1115024@bhelgaas>
 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178998681509.217018.8059272518562419775@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: A7D775FC31
X-NC-CID: FUpWLpRNalb8yuhbPZz+iPk/MR3311IHVxmP+iUcn5PvMG0xI6U=

On 9/18/26 12:39, Maciej W. Rozycki wrote:
> On Fri, 18 Sep 2026, Thorsten Leemhuis wrote:
>
>>> But IIUC Aoxtj still sees issues with 72780f796468 ("PCI: Always lift
>>> 2.5GT/s restriction in PCIe failed link retraining") even with this
>>> patch
>>> (https://lore.kernel.org/all/331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc)
>>>
>>> And M M / Mich (BCC'd) also reports an issue that (IIUC) is not fixed by
>>> this patch (https://bugzilla.kernel.org/show_bug.cgi?id=221919#c3)
>>>
>>> So evidently there are still issues but maybe this patch fixes part of
>>> them?
>>>> Yeah, Maciej ten days expressed that we to look into this. Anyway, I
>> suggest someone that is affected by that problem starts a new thread
>> (please CC all those that are affected by it and the regression list)
>> with summarizing the current state + this patch, as this thread got a
>> bit confusing... (please drop a link to that thread here afterwards)
> 
>  It remains on my radar, no worries.  [...]

FWIW, another report from "blaat windows" (now CCed) can be found
out-of-thread here:

https://lore.kernel.org/all/AS2PR10MB7429335B6C8F4C7FA3F88638B5852@AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM/

Quoting that below.
"""
>>>> Another reproducible case of the active-link failure described in this thread.
>>>> 
>>>> Hardware:
>>>> Intel 4th-gen/9-series platform
>>>> Intel 82571EB quad-port NIC
>>>> Microsemi/PMC/IDT PES12N3A PCIe switch
>>>> Root port 00:1c.4, LnkCap 5GT/s x4
>>>> Working negotiated link: 2.5GT/s x4
>>>> 
>>>> Kernel results:
>>>> 7.2-rc1 fail
>>>> 7.1-rc7 succes
>>>> 
>>>> On failing kernels, the PES12N3A hierarchy does not enumerate and all four downstream 82571EB ports disappear.
>>>> 
>>>> I traced this to pcie_failed_link_retrain() and specifically the new generic clamp-removal code introduced by 72780f7964684939d7d2f69c348876213b184484 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining").
>>>> 
>>>> I tested 7.3.0-rc3+ with only this block commented out:
>>>> 
>>>>     pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>>>>     if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
>>>>             pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
>>>>             ret = pcie_set_target_speed(dev, speed_cap, false);
>>>>             if (ret)
>>>>                     goto err;
>>>>     }
>>>> 
>>>> With that block disabled, 7.3.0-rc3+ boots normally, having all four NIC ports enumerate:
>>>> 
>>>> 07:00.0 82571EB
>>>> 07:00.1 82571EB
>>>> 08:00.0 82571EB
>>>> 08:00.1 82571EB
>>>> 
>>>> The important result is that the initial 2.5GT/s recovery is fine. Leaving the link at 2.5GT/s works. It is the subsequent:
>>>> 
>>>>     pcie_set_target_speed(dev, speed_cap, false);
>>>> 
>>>> which breaks this PES12N3A/82571EB link.
>>>> 
>>>> So this appears to be the same active-link failure mode, but with a PES12N3A switch rather than a direct 82571EB connection.
>>>> 
>>>> This was tested against vanilla 7.3.0-rc3+ with only the above local change.
>>>> 
>>>> I can provide full dmesg/lspci output and test a proposed fix if useful.
"""

Ciao, Thorsten
