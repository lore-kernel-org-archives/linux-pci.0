Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2399547051;
	Thu, 17 Sep 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688039; cv=none; b=ULW1RA/zAVNNiVNoiKTkeqQuzRV74IjCGiLfvg4wm1zlvn3JIJ6189HiSMja+4Qv95Cp3wJbMBdEfqIpTm87OhNmNw4FYMN1+xzpYPQKcLNbjMo9W3u2oVAElURn7Dqmc53nTd0TBV9drGz/AaLUsfDRXeKryO/5j6ssI3A4XBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688039; c=relaxed/simple;
	bh=bFSeoq1VnhSsG42lkzkAaTURyMhFWjFEK8DGwudPxt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j+GHamOPIEcbIWIxWRS7rzutb/rs/b4IQNT38vkcJbDkWe1NenQ5Y4tN/6wGBbbHlSqj8six3Q/vv7/WjdwD+hoDVIx9Z/Hiapm0i7myHsMKOgq8USdBtrBuW0gCn6iPJM2mJQKM9wIb4beqQ9myCvwMovmPpglONgiT0xX66mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ8dWvoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ8dWvoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8131F000FF;
	Thu, 17 Sep 2026 23:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789688037;
	bh=o6NjHuKSvx6W9m1xdLJtdEGbC26vx0xPDV45IDAYDA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lQ8dWvoVPA0tRMMJFvia8Fq2Xw1DkzZn0nLpAm04KsK7EPoZMr2iuJrtAgHfLXL+m
	 wvQP1/YiLhaVCVaPJpzzZ3s2UucU0tBHQg7PjP2UqDGwzW+XsgSMt1VR4ohEPxPOID
	 Z4HIkDyx8dHHxCzDSCO0uoFNYGf2wlfOqWIvRWdVgeiXyARQ8VQX+BJTElUbiP/r/s
	 g86cdxDyq+03r+hWf0bXrRgGxRAMKPeheA0wbzL0DtSYLPyj1ZXcSGYHGiXHcIjttg
	 XDTM1g+Qxyls9PPMVPl/rwStqzoCCUDWfHK6UiXMlNNdL6rJATu45IUIVKTW68INAW
	 T7betGVWWoOaA==
Date: Thu, 17 Sep 2026 18:33:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Wild <andiwild@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, macro@orcam.me.uk,
	linux-kernel@vger.kernel.org,
	M M <restafvalendergelijke@outlook.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
Message-ID: <20260917233355.GA1115024@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801201244.4421-1-andiwild@gmail.com>

[+cc M M, Thorsten]

On Sat, Aug 01, 2026 at 10:11:48PM +0200, Andreas Wild wrote:
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
> 
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

I provisionally applied this on pci/misc.  It seems to address at
least part of a v7.2 regression, so it probably should go on
pci/for-linus for v7.3.

But I'd like to have it in -next for a bit before asking Linus to pull
it.

I added:

  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221801

based on Edward's testing at
https://bugzilla.kernel.org/show_bug.cgi?id=221801#c13.  Edward, I
bcc'd you because I haven't seen a public email response, but if you
want your Tested-by to appear in the git commit, just respond to this
email thread.

But IIUC Aoxtj still sees issues with 72780f796468 ("PCI: Always lift
2.5GT/s restriction in PCIe failed link retraining") even with this
patch
(https://lore.kernel.org/all/331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc)

And M M / Mich (BCC'd) also reports an issue that (IIUC) is not fixed by
this patch (https://bugzilla.kernel.org/show_bug.cgi?id=221919#c3)

So evidently there are still issues but maybe this patch fixes part of
them?

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
> -- 
> 2.55.0
> 
