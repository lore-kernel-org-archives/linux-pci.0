Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D025B083;
	Mon, 24 Aug 2026 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581620; cv=none; b=mTkc3Xozlrs7huXl5E87E4Kz++1MsDdYkPkXWJOhAJzVoKDlM8aStYwnAFI0GIEDF9oZjSx0aoaoetOggJEAyOue1T21soSx6VzccPhrUlaZN4A/BoCkgGpJ6c25puV02MQ0EDNN9yeEi5+7IfHSdy+UgDoDnXkz8kWaXScOa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581620; c=relaxed/simple;
	bh=2insWGvkAec5b8iq7H3ZFxwhEsiyPqXfKq48KYi0uJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hfk0n7OSe4RQmlY0IBVOM7CFTpg/UNJ6ZTGKlTtLOMAT96WeYKyPHFfweu8Ddw6AGTO7RT9A40HlUvsbAtwkrjvxDL3tsYqcaH3MmIy0z0irQC4nOEVvMknw04Epy8/6NGyOTAp68FI80Owo1FS6wPq9PMVsFJcD1eqb5/zOEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bYSwXY+A; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bYSwXY+A"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hTCsP49Ksz4FTl;
	Mon, 24 Aug 2026 16:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787581609;
	bh=2insWGvkAec5b8iq7H3ZFxwhEsiyPqXfKq48KYi0uJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bYSwXY+AC7NpVUKwXqOHL+xT+l8veDKGaDEbPhffZqYGumweBu0JBfwGdWNAAYw+k
	 FsvqfGctpyzu4tbs2oCs87N05ShSgP8YE0I3I6JrG5Ta+2Gwjr10xr6I8JU3WQcDPE
	 TISV0UMIfFyaaMceq6UoDtJ/t9+WrHwOmdVbKcUhH7qBkfUZHPxOulAYz1RjXmifsV
	 ryX7x2fYwQL1ZwnK1Q91SqAkoO61pSV+89hfVTrVZbM4/nIMMLYuusijKHzTSQ/XjS
	 GEQaUTaGEJfg/8l7wjfhzzZm/kyow23DB7Cxo/huD9ZJbH7ksfe0r7Nc4gv5eDcYoY
	 pVw/yp0Ooo2mg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hTCsP3TBMz7wQB;
	Mon, 24 Aug 2026 16:26:49 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hTCsN6Ltxz8svG;
	Mon, 24 Aug 2026 16:26:48 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0F7B55FAEA;
	Mon, 24 Aug 2026 16:26:48 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7742d556-e878-4893-8b6d-d6039ddba544@leemhuis.info>
Date: Mon, 24 Aug 2026 16:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: Andreas Wild <andiwild@gmail.com>, Aoxtj <aoxiangtianji@axtjblog.cc>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260801201244.4421-1-andiwild@gmail.com>
 <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc>
 <20260808063103.10940-1-andiwild@gmail.com>
 <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc>
 <20260811064233.11315-1-andiwild@gmail.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260811064233.11315-1-andiwild@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178758160845.2946062.11356722925462353503@mxe9fb.netcup.net>
X-NC-CID: XTwglwB9BnhHi4/KgKtciDYg51/dYIqoPX0ZtGRHawf6Q5unbXk=

On 8/11/26 08:42, Andreas Wild wrote:
> On Mon, 11 Aug 2026, Aoxtj wrote:
> 
>> Diagnostic result: link is genuinely down, not recovering.
>>
>> [1.623701] diag: pre  ret=-110 DLLLA=0 sta=0x9023 ctl2=0x0023
>> [3.734697] diag: post DLLLA=0 after 1010ms sta=0x9823
>> [3.734702] diag: post ctl2=0x0021
> 
> So the link really isn't coming back at all rather than too late for the
> bus scan.
> [...]
> If you would like something to try, the change below skips lifting the
> restriction if HASD is set.  It applies to your tree (I checked it against
> v7.1.6 and on top of v3). Mainline would need a small adaptation, since
> that block no longer has the LNKCAP test.

Side note: what's the status of all this? From the outside things looks
stalled, but maybe there was progress and I just missed it.

Are we waiting for a reply from Aoxtj before moving on with the fix at
the start of the thread? And whatever the answer is: would it make sense
to move on with that independently to get the other regression (boot
time delay) resolved?

Ciao, Thorsten
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -115,6 +115,11 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>  	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
>  	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
> +		if (lnkctl2 & PCI_EXP_LNKCTL2_HASD) {
> +			pci_info(dev, "2.5GT/s restriction left, firmware set HASD\n");
> +			return ret;
> +		}
> +
>  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
>  		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
>  		if (ret)
> 
> Some things to consider:
> 
> I cannot verify the change myself - it compiles without warnings and that
> is all I can say.
> 
> HASD is specified as disabling *hardware autonomous* speed changes, so it
> does not strictly forbid a software-initiated retrain.  Interpreting it as
> "firmware meant this" is just my guess.
> 
> As I said before, I have no background in this code.  I came to it through
> one boot-time regression on my own machine, and that is the extent of it.
> 
> So please take it as "here is one thing that could help this particular
> case", not as a view on how the quirk ought to work.  Maciej and Bjorn are
> far better placed to judge whether the answer is this, or restoring the
> device ID match, or something else entirely.
> 
> One further thought for people who know the code better than I do:
> 
> Since retraining apparently cannot recover the link once it is wedged,
> would a secondary bus reset be the appropriate recovery in the error path?
> 
> Best regards,
> Andreas
> 

