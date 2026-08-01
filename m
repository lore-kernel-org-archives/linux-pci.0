Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F93385BE
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577155; cv=none; b=HpUNRjpOMYtcYIp7rWRQpFWtoSIg6LU1t/WFzF64E/B+SQURAPUX1qx0fI1Fh1NTqEslBOol6a7aOMnEkhTAanefkEWYOvf0ZvgPWL3+nmvkpDcsLL+MkYlhMKVx+sQ0l4RVSPfwvbE+pkJQTmon141+6/dr0fikAJu9OHT/ynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577155; c=relaxed/simple;
	bh=OYH0rz3h5/ECqFBz3kfR5FIeevZEJ0Vrl+UjyUx0UyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G61H4aWqDOmqiCcNtriInY4TjglUUeLq7yZVPepb56yhWlR7/8wNnRELut3RM/YYt6DqMQhTWBxroXE5PmIn5R4RqX0VYwOnSatiWjMvaFBia6C8th/4eL53HjX7O123pe47fipLuNUSqc154+tw1up+vmC/4ATnqsnlxy1OCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/xTI6T3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/xTI6T3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D55B1F00AC4;
	Sat,  1 Aug 2026 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785577153;
	bh=VRBud5hP4QVh11GhR0ykxT+lvyDy9kxb0Y6qf4QgBnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h/xTI6T3e2k2pLICnFziM9LnKgMbZJnyb1GI73YTjTk1T/JqyFRQwESOfmPB6xjpF
	 7mP//qAJxrqb65TKMFmxT0fcIxZMXZ9NlxLOurfYtLljK3PaJNOG4liCdS6y7TKeM4
	 dW6JYtSqE8/Er7e1Q1pSbYkzBV21IX7logqxQHe2/HNKZHOHv5mFlsUO0a0hPo8Eke
	 jPyrn7OAYTWrXbyg70OKO9+u2Z0/y2TWC3UjTI1EhZ5D0tm3f0WfOFATji5bQHoL8e
	 K7ejxhhWaY4abXaEWuNTBeVUbpxKMu3tw2JeMh9PK0B5G/vgJQW+hGHsVr/XMoGa0q
	 gWRJxEP/GqQkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Avoid link retraining on empty ports when lifting
 speed restriction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Wild" <andiwild@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260801092152.5643-1-andiwild@gmail.com>
References: <20260801092152.5643-1-andiwild@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 09:39:12 +0000
Message-Id: <20260801093913.7D55B1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Deriving Target Link Speed directly from LNKCAP ignores LNKCAP2 an=
d software constraints.
- [High] Lockless modification of Target Link Speed races with bandwidth co=
ntrollers and misses LTSSM state synchronization.
- [Medium] Unhandled error from pcie_capability_read_dword() causes writing=
 a Reserved value to Target Link Speed.
- [Medium] Reusing the `ret` variable can cause a false positive success re=
turn if the link drops concurrently.
--

--- Patch [1]: [PATCH] PCI: Avoid link retraining on empty ports when lifti=
ng speed restriction ---
commit 8c8f91b0ee4d3449b1bc98ead3ff414abb7453a9
Author: Andreas Wild <andiwild@gmail.com>

PCI: Avoid link retraining on empty ports when lifting speed restriction

This commit speeds up boot times by skipping link retraining on unconnected
downstream ports when lifting a 2.5GT/s firmware restriction. It directly
programs the Target Link Speed instead of initiating retraining if the Data
Link Layer Link Active is clear.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..d0c8b09712faf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -97,6 +97,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	u16 lnksta, lnkctl2, oldlnkctl2;
>  	enum pci_bus_speed speed_cap;
>  	int ret =3D -ENOTTY;
> +	u32 lnkcap;
> =20
>  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)

[ ... ]

> @@ -115,9 +116,25 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  			goto err;
>  	}
> =20
> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT) {
>  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> +
> +		/*
> +		 * With no link partner the retraining can never complete and
> +		 * every attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  Program
> +		 * the Target Link Speed directly and skip the retraining; the
> +		 * link will train at that speed once a device shows up.
> +		 */
> +		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
> +			pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);

[Severity: Medium]
Could this result in writing a reserved value to Target Link Speed?

If pcie_capability_read_dword() encounters a transient bus error, it returns
an error code and leaves lnkcap as 0. Because the return value isn't checke=
d,
lnkcap & PCI_EXP_LNKCAP_SLS would evaluate to 0000b (Reserved), which is th=
en
written to the PCI_EXP_LNKCTL2_TLS field.

> +			pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL2,
> +							   PCI_EXP_LNKCTL2_TLS,
> +							   lnkcap & PCI_EXP_LNKCAP_SLS);

[Severity: High]
Does this bypass software speed constraints and PCIe 3.0+ requirements?

By deriving the Target Link Speed directly from LNKCAP, the code ignores
PCI_EXP_LNKCAP2, which is mandatory for determining supported speeds on new=
er
devices.=20

The PCI core already evaluates and caches the correct maximum speed in
dev->supported_speeds, which is retrieved earlier in this function as
speed_cap.

[Severity: High]
Is it safe to modify the Target Link Speed without subsystem locking or
hardware retraining synchronization?

By calling pcie_capability_clear_and_set_word() directly, this bypasses
pcie_set_target_speed(). This skips acquiring pcie_bwctrl_setspeed_rwsem
and data->set_speed_mutex, potentially racing with thermal governors.

Furthermore, missing the pcie_retrain_link() call means that if a device is
hot-plugged concurrently, the hardware LTSSM might not recognize the updated
Target Link Speed.

> +			return ret;

[Severity: Medium]
Does returning ret here introduce a race condition if the link drops
concurrently?

If the initial pcie_lbms_seen() workaround block earlier in this function
successfully retrains the link, ret is set to 0.

If the link is unstable and drops immediately after, this second block reads
DLLLA =3D=3D 0. This early return will then execute with ret =3D=3D 0, fals=
ely
signaling success when the link has actually dropped.

> +		}
> +
>  		ret =3D pcie_set_target_speed(dev, speed_cap, false);
>  		if (ret)
>  			goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801092152.5643=
-1-andiwild@gmail.com?part=3D1
