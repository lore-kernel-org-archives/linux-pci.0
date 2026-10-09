Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20145D905
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578168; cv=none; b=HTJrC8/6gNEjpxwXHK1X7AoXd/X80HOxgB2mKxUf6Ev3QUbpdR5biLIQmnujn6oI3WZq/olALpT1AIlo/du/U7aeuOJ0+zpY4U28RkDqv5LyTGAn2IzuCywPL0+xtnu/Zdjqu+paj4es2cOYQegeEocU8EAIggtnDkp2e0/W2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578168; c=relaxed/simple;
	bh=4OjNd/CDf7B6zjmz68OHEpXtsQesU1en+oVNHuLSJPA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sIERGr0+5RiSg8j6H+NLISvkevGVMktQZ2+IR2F6Le8ecopCRX2XeUsEzApCLnnZTHl4osgQ0O+tIty8oA60WiuLOkXopMsSQdEq5IkBfrNQQ1+D47KzAVDjHO8AwVXncu3tSQHwoaD/jT56cTgkw4g6M6OcAXSAAkRID+f0KiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No7Nc9jn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No7Nc9jn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE671F000FF;
	Fri,  9 Oct 2026 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791578167;
	bh=7/yG1JxYZ+lQ8qG3WmhImnuiPmcli+17gdnvoECJyQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=No7Nc9jnlNuNCyDv+khz/bLGP8YZCCQi2smLQbfch7ooFdjs8rSKLNh5igt1FfB3o
	 Zic8ObAp/65hcKNH+MfXMVHByQNkvVr54Sy/dgI55lM+e83yV1/q6Wx1K/FeisD2up
	 SXWwSIcH7bT76qCbVfowXzgab92PDn0lJaXDnSaQgZg1TJZ1IeVOUO81Sy0YjwJuyC
	 ZstTve6e9acrtdi3s/majCBm7JqvdRJdWiR5rnRM5tGgD1go8+q5/NRHl6xQN6WExO
	 bCRTRlKfgTJW9NLSii8AEL9kXNpfXP1CLHT41nfQ6AnVifj6zgvXCvbqHJmavvGxCo
	 FFJoRJNcQsoLg==
Message-ID: <sashiko-outbox-166041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI: dwc: Power the controller down when
 hibernating
Reply-To: sashiko-reviews@lists.linux.dev
To: "Birk Skyum" <birk.skyum@pm.me>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <179157746908.73485.2343672865542690797@pm.me>
References: <179157746908.73485.2343672865542690797@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 20:36:06 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: hibernation S4 WOL and thaw broken by short-circuited D3cold =
check
--

commit fefc3f1865b9c97f0642e5cbcd08bb6b0f27167f
Author: Birk Skyum <birk.skyum@pm.me>

PCI: dwc: Power the controller down when hibernating

This commit modifies dw_pcie_suspend_noirq() to power down the controller
during hibernation by checking pm_suspend_in_progress(). This ensures that a
hibernation image resumed after a power cycle does not crash when the kernel
reads uninitialized DBI registers.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 77aa79ef0ccf8..458e4c6e798b0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
[ ... ]
> @@ -1231,7 +1232,14 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (!dw_pcie_link_up(pci))
>  		goto stop_link;
> =20
> -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
> +	/*
> +	 * Leaving the controller powered is only safe if it keeps its state
> +	 * until resume. A hibernation image is resumed after a power cycle, by
> +	 * a kernel that may not have brought this controller up, so only a
> +	 * suspend may leave it powered.
> +	 */
> +	if (pm_suspend_in_progress() &&
> +	    !pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
>  		return 0;

[Severity: High]
Does this short-circuiting && operator cause issues during hibernation?

During hibernation phases (poweroff_noirq and freeze_noirq),
pm_suspend_in_progress() returns false. This causes the && operator to
short-circuit, skipping the call to pci_host_common_d3cold_possible().

Because of this, pme_capable remains at its default uninitialized value of
false. Later in dw_pcie_suspend_noirq(), pci->pp.skip_pwrctrl_off is assign=
ed
the value of pme_capable:

stop_link:
	...
	pci->pp.skip_pwrctrl_off =3D pme_capable;
	dw_pcie_stop_link(pci);

Since pme_capable is unconditionally false, pci_pwrctrl_power_off_devices()
will force cutting auxiliary power.=20

This completely breaks S4 Wake-on-LAN and wipes endpoint hardware state dur=
ing
the freeze phase, violating the core PM contract that thaw operates on pres=
erved
hardware state. Endpoints lacking D3cold support will crash or fail to resu=
me
during the thaw phase.

> =20
>  	if (pci->pp.ops->pme_turn_off) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179157746908.73485.=
2343672865542690797@pm.me?part=3D1
