Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.38.247.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347434;
	b=k99LdfuRxM4DQL+W2AcwDp9VxIhbpu93Rk8CSKWQ/+R8RSdwVR6P6rJEXG2LtuuwRn4M
	 ejayO97UQ9YbeBN0eyQzB9kXsUuCscfuQ1vVk4gdsgc7KOAIBNt59qieXlWiL46LJq1cJ
	 F+iFzt7riK/JDSTTEuuQ0R/E2VM2fS0mFGK2hQCzoSaHHkCKhLCTDyptvv2ab/51SCIiU
	 f8dBiTMW9qcFJ5i4gqXhayLHlXncnh5Tj1ZHKU1VCLYIgsGalnjgXxXFTcwI3AqQm7stB
	 wCn/luCzOxFvxr4/LYOP0Qd+tX5oCxQDdDukRUbgeVJCAZVMh3yg6QLEcR/Y+5iHcBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347434;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=27glQ701BXXOZ3tvcgViKU0UyTiCkefglF1mL3SW7VI=;
	b=gmsIwwD4sEn+lu4yMTLWLl2vZjq3y0GLveOPFABD57dvM3KM87qzB36GnDi4aoqjLBdx
	 8YBVlNxVdmw8p5neFFX7f+bJRS4lCtmmPOxaOriC0CUGnX3UPDZMnTWZZJzKyhgXYDtmK
	 d11uqjSqwXx6iPZ7v420Sm8jN2kwuw9kH+wElNBUAYdphz2omf0lirT1Ms+s+adumT0/P
	 pemP3EhOVW2Xs4NEs7Yg6IIdDMLjiRMIxyfC7YTbvPfTgtFWMZYHAYWmpw/1KE4KH43PQ
	 UM5PU6y/zIRjD1+xYnSYdCdV7R2zjwzXPEyHZt4NYpwx/1ScOBUHPkFoXhSm9s00/gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	arc=none smtp.remote-ip=46.38.247.119
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3370606A31E;
	Fri, 30 Oct 2026 08:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3370606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jGDB61h9Fz8hrJ;
	Fri, 30 Oct 2026 09:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793347406;
	bh=LCrTFa7rbBF1FSzAjhtS8uZts2i3nZ9PKlQn0INEoNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XTJ2BORLrV1kjCP/VO49ctAFItX2aHxSoW2w7zu4gF2k8Sx/g3QaK0GnFdHM9PxtZ
	 TpKa8yAPaLJqkh6+073Q4juzBl+n40oCtfcCJy3lw10QPSpxLEc+kxe3K5Tul2enm3
	 XMJbCn9LeRyH4n8R71u/Cknn2NL9tSe2Op04wXr4cFX3DuaDQFYxJQLKmgtl6wrQZg
	 qe3H7n+FMpLi7p/LHNeq9dif+TwcEXgTFisZ4YBEgOi9YQ9mTe+gKurWXikztLs3xc
	 LMeVp6frRb3L6H3VoOqFn2x/6PH5c7HQkFn/dlT2GmXK7RxczpDlSshp66OuX/cZcp
	 VYTj1X9dKrvuA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jGD9Y752Mz50nC;
	Fri, 30 Oct 2026 09:02:57 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jGD9X6cRVz8svZ;
	Fri, 30 Oct 2026 09:02:56 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id B60025F98C;
	Fri, 30 Oct 2026 09:02:49 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <8debe9f6-4ad2-4b02-83c2-3884a2394858@leemhuis.info>
Date: Fri, 30 Oct 2026 09:02:47 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: Fix Renesas uPD720201 hang after the RCB Link
 Control write
To: Stefan Roese <stefan.roese@mailbox.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20261002091029.2225203-1-stefan.roese@mailbox.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261002091029.2225203-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179334737019.873731.16074367389338197624@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B60025F98C
X-NC-CID: 3r+oDmltqckJl+CUtaSea57BPK4M0u966VhmgDQv0HRhvbJa64c=

On 10/2/26 11:10, Stefan Roese wrote:
> Since commit 1a6845aaa6de ("PCI: Initialize RCB from
> pci_configure_device()"), which went into v6.18.14 as dbe723b480e4, a
> Renesas uPD720201 xHCI (1912:0014) behind the CPM Root Port of an AMD
> Versal SoC hangs the system on every boot. The first access to the xHCI
> BAR after the firmware download runs into PCIe completion timeouts.

Is this regression fix still in the "to review" list of anyone, or did
it fell through the cracks? Or was this solved meanwhile and I just
missed it?

Ciao, Thorsten
> The chip comes out of reset with LnkCtl 0x0003 (ASPM L0s and L1
> enabled), although the Root Port supports no ASPM. pcie_aspm_cap_init()
> returns early for such a link and never clears these bits, which leaves
> the link in a state that PCIe r7.0, sec 5.4.1.4, calls undefined. This
> went unnoticed so far because the chip clears ASPM Control itself during
> the firmware download by xhci-pci-renesas. Once the host has written
> Link Control, even with the unchanged value, the chip no longer does
> so. pci_configure_rcb() does exactly such a write for every endpoint.
> 
> Patch 1 fixes the ASPM state: on a link without common ASPM support,
> clear ASPM Control where a device has it set, and update the saved
> state.
> 
> Patch 2 is Bjorn's set-only RCB change. It also avoids the Link Control
> write on this board, which matters with pcie_aspm=off or
> CONFIG_PCIEASPM=n, where patch 1 never runs.
> 
> Testing on the Versal board, v6.18.40 (AMD linux-xlnx) with the patches
> backported, 3 cold boots each:
> 
> - patch 1 alone: good, "clearing ASPM Control" for the xHCI
> - patches 1 and 2: good
> - patch 2 alone, pcie_aspm=off: good, the chip clears ASPM Control
>   itself again
> - patch 1 alone, pcie_aspm=off: bad, completion timeouts
> 
> On pci/next the series builds without warnings (W=1, arm64 and x86_64
> defconfig). I could not boot test it on pci/next, as this board does
> not run a mainline kernel.
> 
> Changes in v2:
> - Make the aspm.c change patch 1 and the actual fix (Bjorn)
> - Update the saved state after clearing ASPM Control (sashiko)
> - Reword the clearing message to "link has no common ASPM support"
> - Cite PCIe r7.0, sec 5.4.1.4, in patch 1 (Bjorn)
> - Replace "write RCB only when it changes" with set-only RCB, now
>   with Fixes: and stable because of the pcie_aspm=off and
>   CONFIG_PCIEASPM=n cases (Bjorn)
> 
> Similar reports with this chip and ASPM, possibly related:
> - Qualcomm RB3Gen2 needs pcie_aspm=off: https://lkml.iu.edu/2603.3/02364.html
> - RPi CM5 "HC died": https://github.com/raspberrypi/linux/issues/6849
> 
> v1: https://lore.kernel.org/r/20260930144650.3701516-1-stefan.roese@mailbox.org
> 
> #regzbot introduced: 1a6845aaa6de
> 
> Stefan Roese (2):
>   PCI/ASPM: Clear ASPM Control on links without common ASPM support
>   PCI: Set RCB only when the Root Port has it set
> 
>  drivers/pci/pcie/aspm.c | 23 +++++++++++++++++++++--
>  drivers/pci/probe.c     |  7 +++----
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 

