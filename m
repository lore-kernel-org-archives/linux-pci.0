Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A134751D
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447593; cv=none; b=TMuh1YqkcAh8N8ckbD25GH6P7slvK6mKQb+DqdTypLGmBB10JcKgqHrt3IFVY2r02IoD0nXirp1YVo121SnOyqhq1bOez2+nnTKuBjUKGY4IGo8VbQc0I6OuzJJnyIhkxBRfV/i5ibted9S8UALpyVJKp9bC8V7QyQREkFarkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447593; c=relaxed/simple;
	bh=oQde5zE4oF8XHfRrVSDCm604TzeXwdKc0Oi7Jedt6/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGVF+5UloW9hyZajzMPlptt1xE1r0o/7eCQ6N40iTX6NlJqjr5nC5eMkt/MAgTDKBWJhiDyhaD6CElygjRfFdQjFyjsaVXoRL1Suokm2mu2OF2fpav7519qsniGEj/1rzR3exlhvhEBRTWNmHftnZHBmnRZlCMHUC4j5/+dw1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kb76pK91; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kb76pK91"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4g583Z74ptz3y6Z;
	Wed, 29 Apr 2026 09:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1777447547;
	bh=oQde5zE4oF8XHfRrVSDCm604TzeXwdKc0Oi7Jedt6/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kb76pK91Auzn5syjdNDGpF6zxXD3bjETDBPyMsGIAYPemV8k0V4EC1/rpz7iVbDTW
	 81IxZFKi266+SmBaa1mIpuOp9NdE1JB86OIrbotLfgyUq6zEtEK6mmZ2qF5+CF+yd8
	 xcSwkQGOVhZ9uM/3ZnVvjJeYtMvl4jDny5yabRGiVv9qt3L7y77VWqRVzZGXM+FRRi
	 JMbsaEvrmEiJkMDPXY5OA/pAh4ruKErnnc9rFw9QF57qkhnp9DDuUjA/5rCMdUueTL
	 6LpEC+hOn4v2tQeniPSzM/kDNdFi7KN+ok4b4eVewcGRfByaHwCpRu/exRlM5twKwJ
	 GrE7wxdcrNHXw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4g583Z6C2wz3y4w;
	Wed, 29 Apr 2026 09:25:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4g583W4bVPz8tdJ;
	Wed, 29 Apr 2026 09:25:43 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BEF6A633D0;
	Wed, 29 Apr 2026 09:25:42 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <40051e46-11a8-414a-aa8a-ecb37846a649@leemhuis.info>
Date: Wed, 29 Apr 2026 09:25:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Update saved_config_space upon resource assignment
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Bernd Schumacher <bernd@bschu.de>, "Alexandre N." <an.tech@mailo.com>,
 Salvatore Bonaccorso <carnil@debian.org>, 1131025@bugs.debian.org,
 Uwe Kleine-Koenig <ukleinek@debian.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org
References: 
 <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: 
 <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177744754331.2437893.7300139824891796474@mxe9fb.netcup.net>
X-NC-CID: 4H1AzZDm7MNaS380OBd68xyjr7zkXvMklCezlslU6cqGG3sGses=

Top-posting, to make this easy to process:

Bjorn, sorry for bothering you, but I wondered: is below patch still in
your review queue? It fixes a regression that made it to a longterm
series that two people reported.

Ciao, Thorsten

On 4/15/26 17:56, Lukas Wunner wrote:
> Bernd reports passthrough failure of a Digital Devices Cine S2 V6 DVB
> adapter plugged into an ASRock X570S PG Riptide board with BIOS version
> P5.41 (09/07/2023):
> 
>   ddbridge 0000:05:00.0: detected Digital Devices Cine S2 V6 DVB adapter
>   ddbridge 0000:05:00.0: cannot read registers
>   ddbridge 0000:05:00.0: fail
> 
> BIOS assigns an incorrect BAR to the DVB adapter which doesn't fit into
> the upstream bridge window.  The kernel corrects the BAR assignment:
> 
>   pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window
>   pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned
> 
> Correction of the BAR assignment happens in an x86-specific fs_initcall,
> pcibios_assign_resources(), after device enumeration in a subsys_initcall.
> This order was introduced at the behest of Linus in 2004:
> 
>     https://git.kernel.org/tglx/history/c/a06a30144bbc
> 
> No other architecture performs such a late BAR correction.
> 
> Bernd bisected the issue to commit a2f1e22390ac ("PCI/ERR: Ensure error
> recoverability at all times"), but it only occurs in the absence of commit
> 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing").
> This combination exists in stable kernel v6.12.70, but not in mainline,
> hence Bernd cannot reproduce the issue with mainline.
> 
> Since a2f1e22390ac, config space is saved on enumeration, prior to BAR
> correction.  Upon passthrough, the corrected BAR is overwritten with the
> incorrect saved value by:
> 
>   vfio_pci_core_register_device()
>     vfio_pci_set_power_state()
>       pci_restore_state()
> 
> But only if the device's current_state is PCI_UNKNOWN, as it was prior to
> commit 4d4c10f763d7.  Since the commit, it is PCI_D0, which changes the
> behavior of vfio_pci_set_power_state() to no longer restore the state
> without saving it first.
> 
> Alexandre is reporting the same issue as Bernd, but in his case, mainline
> is affected as well.  The difference is that on Alexandre's system, the
> host kernel binds a driver to the device which is unbound prior to
> passthrough, whereas on Bernd's system no driver gets bound by the host
> kernel.
> 
> Unbinding sets current_state to PCI_UNKNOWN in pci_device_remove(), so
> when vfio-pci is subsequently bound to the device, pci_restore_state() is
> once again called without invoking pci_save_state() first.
> 
> To robustly fix the issue, always update saved_config_space upon resource
> assignment.
> 
> Reported-by: Bernd Schumacher <bernd@bschu.de>
> Tested-by: Bernd Schumacher <bernd@bschu.de>
> Closes: https://lore.kernel.org/r/acfZrlP0Ua_5D3U4@eldamar.lan/
> Reported-by: Alexandre N. <an.tech@mailo.com>
> Tested-by: Alexandre N. <an.tech@mailo.com>
> Closes: https://lore.kernel.org/r/dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com/
> Fixes: a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.12+
> ---
>  drivers/pci/setup-res.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index e5fcadf..1769ba9 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -102,6 +102,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
>  	}
>  
>  	pci_write_config_dword(dev, reg, new);
> +	dev->saved_config_space[reg / 4] = new;
>  	pci_read_config_dword(dev, reg, &check);
>  
>  	if ((new ^ check) & mask) {
> @@ -112,6 +113,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
>  	if (res->flags & IORESOURCE_MEM_64) {
>  		new = region.start >> 16 >> 16;
>  		pci_write_config_dword(dev, reg + 4, new);
> +		dev->saved_config_space[(reg + 4) / 4] = new;
>  		pci_read_config_dword(dev, reg + 4, &check);
>  		if (check != new) {
>  			pci_err(dev, "%s: error updating (high %#010x != %#010x)\n",

