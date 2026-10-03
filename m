Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617B41BA72;
	Sat,  3 Oct 2026 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791028190; cv=none; b=Y9UF8ouZvMgRA11Fk3qf8RIMydyWPX1016Pf85QJ+EyZsDyItgClmzgvAKx5dnCzTe7FNoX5LX3XScK8tD3wKKV2e3+A2q0minns18Ic0mSZZUCSw8cub5F1S46sfiqymg6dwHOhupgQXTqDLgnT9up7H3Fdk3j+ZZz0mKv90Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791028190; c=relaxed/simple;
	bh=K/G8ayveIiAT01+peYXECvWucw5Iy8kHfX0MaHhTUsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA6yM2zD3GzlAjLuHU0H62U3fdUw71G3NWlsV3P//MGr2TwdUqcpWJMAu3yoLTwx9ofsdyGpAd9CQ6Qe9rvLpVh3cM4u4OCaAddBLD/O5dEUiH2W9hk/1KZBgSj4aVaUhEZFdp+elAA1K3AWD9FrpM+fp3yB3EaQTrMURWhIWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvhyPzEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvhyPzEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35FA1F0089B;
	Sat,  3 Oct 2026 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791028184;
	bh=NFEUgraGfv40XUkXEHfZfQA0c2MYZcfko4AG3Lj7pMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LvhyPzELt+Z6fcF0fP5f4JBVuz0/mB035tAd1C0CaSGDzNbv/5V/4LCvSbovxKkpF
	 Cu/AgcYYXmJDyfaZ/2SIuhhOdlBniq6rytpgSDGpcS9rq75jC7pAyAZvJlhZ59lfuD
	 pqprQmXFCpaW7Svku7SF3OC4KCx8/sey+msUb7EXs+DXLp3c/exjqTfOS35ebOZ4zt
	 x+eiwjnM64KyWEXVk8WLTN4zn4WrqdIV17rRL+MEmItZV6YdaTvSmyosUxFZ5CBH2P
	 wj50+AEraf5PI9IqeJhLs7JC+AmndxhyG9D5XsDRMoQSR15DN1K4TBQZlZvLy8+BFF
	 S3PPxx1cLbOXg==
Date: Sat, 3 Oct 2026 13:49:38 +0200
From: Thorsten Blum <blum@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <asDr0tWYBNC296EQ@kernel.org>
References: <20260916100206.92853-2-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916100206.92853-2-blum@kernel.org>

On Wed, Sep 16, 2026 at 12:02:07PM +0200, Thorsten Blum wrote:
> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
> 
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
> 
> On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> 00:1c.3, also documented by the model list in commit abb2bafd295f
> ("x86/quirks: Add early quirk to reset Apple AirPort card").
> 
> Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> is silently skipped on these machines.
> 
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.
> 
> Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
> Link: https://zoringroup.com/forum/5/7170/ [2]
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes in v2:
> - Add iMac13,x background information and supporting links (Lukas)
> - v1: https://lore.kernel.org/r/20260807094601.263450-2-thorsten.blum@linux.dev/
> ---
>  arch/x86/kernel/early-quirks.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Gentle ping. Is there anything you'd like to be changed here, or could
someone please pick this up? Thanks.
