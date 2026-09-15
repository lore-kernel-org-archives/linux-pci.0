Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272CE3B9D9D
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480269; cv=none; b=t+L7AjQDuQKlgwCd2+VDD9ujaCWR9fBrxBIjQ/+R2nhDr6hk832rZRZXwQ46TdvQICcf5g4k60Hav5LFoKh5eis5L8SPinHokh2u/vT5WW0vRDkhgkC+7H+CXm5s2tuo/r4BJV91Smm5Ebpt/gCkMpYtrPvqjZYE+Zy6cCvD5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480269; c=relaxed/simple;
	bh=yMBphWdTCIPuWfqOpsbMpbNW/NAeRhoedZCbXkbt1I8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t8sLS+RSaPqLYzqMIy+aPgMG6Cafcnf6312xqHIljsmkFpsEmDSh+6R1ao+icyIo5sg+ImNZWxOavTmUlr2dr72QLLGDhbkSXfLirdkYL/KJ5FA6IA3S4CnFXYDfYO1EaRdbiKeBxWXsv+dOMW+z3wQt0DgYC5p0+xy9oMIqSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLBPSkxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLBPSkxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504561F000FF;
	Tue, 15 Sep 2026 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789480267;
	bh=aKurW0dj2pTtHgP+1BjvT3NxfRqVtJzBwX7pQ9ZDYR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLBPSkxmUHFmTBEwZ14LFdB535ORgYUQlevXnxITvpuOg/0DqqmaWe5w3q5G2Rp5B
	 lcfUWohGUY2lKnVzUmhh7rrwlwnsVgykBiE3nT9Grn3B/MQ9LL3NZrVLwaAMoEubdn
	 1+j0vQtDrhWdlVZ9sCir9EDtL9ZH8weU/MSMFqXA9ZxKfzXYbnxiOcmse9ZTX27RL7
	 9XTauJNzWfj+zA6FDCmKYk3Mc4uqUwBrmxhiYWi95s3LLHXPMhwX+K4wYJvqASq9dC
	 uFvvatJqNAatfrLRryabYHfo0wKg997IsRe6/ORe0GZk3s97xRYaX7SEcHPMxmYDJw
	 yrTeMNUAty+VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix order of device disablement on reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <4c908eaab127d82ecfdc1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de>
References: <4c908eaab127d82ecfdc1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:51:06 +0000
Message-Id: <20260915135107.504561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: bottom-up save and disable fails if parent bridge is in D3hot
- [Low] pci: stale documentation for save_and_disable_locked traversal
--

commit 0c082dfc1a7a6d8233dea3dd350ae1d9557bf0fb
Author: Lukas Wunner <lukas@wunner.de>
PCI: Fix order of device disablement on reset

This commit reverses the device disablement traversal order in
pci_bus_save_and_disable_locked() and pci_slot_save_and_disable_locked() to
recurse before disabling. This bottom-up approach is intended to avoid AER
splats caused by disabling access to the Switch Upstream Port before stoppi=
ng
access to MMIO space on subordinate devices.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..ce9f74d659206 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5508,9 +5508,9 @@ static void pci_bus_save_and_disable_locked(struct =
pci_bus *bus)
>  	struct pci_dev *dev;
> =20
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		pci_dev_save_and_disable(dev);
>  		if (dev->subordinate)
>  			pci_bus_save_and_disable_locked(dev->subordinate);
> +		pci_dev_save_and_disable(dev);

[Severity: High]
Does this bottom-up reordering cause a regression if the parent bridge is i=
n a
low-power state?

If the reset is triggered via the sysfs reset_subordinate attribute while t=
he
parent bridge (e.g., Switch Upstream Port) is in a state like D3hot (via
runtime PM), the parent bridge is not woken up by the sysfs handler.

By calling pci_dev_save_and_disable() for the child first, the code will
attempt to access the child's Configuration Space before the parent bridge
is woken up:

pci_dev_save_and_disable() {
    ...
    pci_set_power_state(dev, PCI_D0);

    if (!pci_dev_config_accessible(dev, "save state"))
        return;

    pci_save_state(dev);
    ...
}

Since the parent bridge is still suspended, its secondary bus is inaccessib=
le.
Could this cause the child's Configuration Space accesses to silently fail,
resulting in the child's saved state being corrupted?

If the state is corrupted, when pci_bus_restore_locked() later restores it,
will it permanently break the downstream devices until a cold reboot?

The original top-down traversal worked because it woke up the parent bridge
first, making the secondary bus accessible for the child's Configuration Sp=
ace
accesses.

[Severity: Low]
Is the comment block above this function now inaccurate? It states:

/*
 * Save and disable devices from the top of the tree down while holding
 * the @dev mutex lock for the entire tree.
 */

Should this be updated to reflect the new bottom-up traversal?

>  	}
>  }
> =20
> @@ -5543,9 +5543,9 @@ static void pci_slot_save_and_disable_locked(struct=
 pci_slot *slot)
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot !=3D slot)
>  			continue;
> -		pci_dev_save_and_disable(dev);
>  		if (dev->subordinate)
>  			pci_bus_save_and_disable_locked(dev->subordinate);
> +		pci_dev_save_and_disable(dev);

[Severity: High]
Does the same problematic bottom-up reordering apply here for slot resets,
potentially corrupting the child's saved state if the parent bridge is
suspended?

[Severity: Low]
Does the documentation block for pci_slot_save_and_disable_locked() also ne=
ed
to be updated to reflect the new bottom-up traversal?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4c908eaab127d82ecfd=
c1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de?part=3D1
