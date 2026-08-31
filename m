Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1ED3B3C05
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214807; cv=none; b=MY+GbBHty36oWML8EWchnSj1c2pfAI/5z1Bu3U8itHwgjirEi4RFS4R32XVzQnG2gLPVGdEzZLr5fmtmE7zA3bGkghBUphoOq1C/aL0jc7XAKTVWANF3Snql24O2/NCJf+azy3a9Lg114MhepIo1s0M5kjr2JknBPPHK9EJ0ZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214807; c=relaxed/simple;
	bh=gJEi1rFUP4xOjMfWlc8itLVzxHhH6m/T+bZkAUil81k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uDh2hhufNPMgL7SWh3LGZQLqpyS4vOF2+NHujnrxUjKl7ffdHD6XkG/Hu1q2q8eeJdYf3G/xbGTKmEpsqYAxTCMGaBSqujepqfbZNZdD6sRwOF3tYXiSNArcbEji3dv1uq+lh3xHpoyW/JGD1HOdJr1R23Dcb8z95EVYrAhWxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYcRmhly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYcRmhly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01051F000E9;
	Mon, 31 Aug 2026 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214806;
	bh=lNUwUe/RLVZyFzLMbMluBXER04FMwiHE3RLFzMyQcjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYcRmhlyDEBRN16KcmpiLXcxexltp1WPRyXBu0tVcDuKFkHHSUKW2pBcTzrTsvxgg
	 3C3RP1qs44gLd1kNFXd8JYVn7ythKO+rgtYeeghnGG2w1XGzdC+l9T+4Z00IxQH8ou
	 48oYOzX9VEUMne7f+sEEBekdO9ftuOqlw7G5bDii2XESdpomd2NjbcvVs0s6HX3qAO
	 RyOkYrDDVX7gxV8ZePCQtYXWWlupmWtNVDD2YM2FWhvPtD+BZ2Yl5LIvaSdCDUDTQz
	 6gDplqfhOZ0ko+oCErOVZKKZh5SEcZBHT9gSQLFAo4ntOVJm6PIPhDbYqs1E/sW27+
	 ESjnlqYLqYcBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] PCI: Put PCIe bridges with downstream devices
 into D3 at hibernate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831205533.2325747-4-mario.limonciello@amd.com>
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
 <20260831205533.2325747-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:20:05 +0000
Message-Id: <20260831222005.E01051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hibernation restore skips mandatory PCIe bridge link retraining de=
lays due to snapshot state mismatch, leading to fatal PCIe errors when down=
stream devices are accessed.
--

commit daecc28d1bb864ce78fb9c9df2c8ecd53a30fb12
Author: Mario Limonciello (AMD) <superm1@kernel.org>

PCI: Put PCIe bridges with downstream devices into D3 at hibernate

This commit aligns the hibernation path with the S3 suspend path by making
pci_pm_poweroff_noirq() use pci_pm_suspend_noirq_common(). This allows PCIe
bridges with downstream devices to enter low-power states like D3cold during
hibernation.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d15b3eb55ec53..a6fb731378d9c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c

[ ... ]

> @@ -1278,8 +1281,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  			return error;
>  	}
> =20
> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
> -		pci_prepare_to_sleep(pci_dev);
> +	pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
> +	if (skip_bus_pm)
> +		goto Fixup;

[Severity: High]
Does this cause mandatory PCIe bridge link retraining delays to be skipped =
on
resume from hibernation?

During hibernation, pci_pm_freeze_noirq() sets the device state to PCI_UNKN=
OWN
via pci_pm_set_unknown_state() just before the memory snapshot is taken. The
snapshot therefore records the state as PCI_UNKNOWN.

Later in the hibernation process, pci_pm_suspend_noirq_common() powers the
bridge down to D3cold.

On system resume, the boot kernel loads the memory snapshot, reverting the
in-memory state back to PCI_UNKNOWN.

When pci_pm_restore_noirq() executes, it skips the bridge power up actions
because the restored state doesn't match PCI_D3cold:

    if (!skip_bus_pm && prev_state =3D=3D PCI_D3cold)
        pci_pm_bridge_power_up_actions(pci_dev);

Can this state mismatch lead to downstream device accesses failing with fat=
al
PCIe errors on resume?

> =20
>  	/*
>  	 * The reason for doing this here is the same as for the analogous code

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831205533.2325=
747-1-mario.limonciello@amd.com?part=3D3
