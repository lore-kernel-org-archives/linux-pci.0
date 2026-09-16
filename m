Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9514D596A
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592740; cv=none; b=V93oMW+A9dzZ9sXW9lesATfmLAnGUZCjbXU4DrZTitI02QOhkPB+VLeQ7mtV0f/kjx9yWOfGWA5vXnegUjDVYMfvthl8FYL7p9Nr/DgetYpR7Qo3SJOE4LtBduIrKYvpes5W3XGVNOFgRHd+iNt8rMIK0euAQCxmjiBjK9APpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592740; c=relaxed/simple;
	bh=Yx1SQsqMcuUysHGylaNCSkf3B6mN4S8+x3anb2JZ37s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rr5O+fqGRZuNGNUtiOLw3tV0b2KUmzTVyiWV9vOC92ge8fzuHyIXebVYLqszHqfGFdi/hTPTqswDECPR0JcRECxtZbN9Y6BCRiNKaHXRkROTYdCyrHGiazIC+GsMubxdxx9cA1FFR8EI2z4e6QHihVMAfU1eiHIrhECqfyppKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E77GZE+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E77GZE+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1111F00899;
	Wed, 16 Sep 2026 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592722;
	bh=p+JxVL6GQkDKLal49E3di2DhyLDqhPhdSCjY3nMq4tE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E77GZE+xZjT6qC3hbOaV06RpebRyuSrDz40kC75DnIDvyynh8se9FuBHWAUNJZQaP
	 T/26wozaSX1DwTjr/8fic3xMARslwxFsmixY8C0WS+BdU3BR44OdY9WaWq0E/6K3eL
	 84ndtXyHMYS/nvCNcTdTJcW/TncMOC1vAG0vM4UIgj3Nckw+ryZ2AMhxKw5lxFQjuo
	 FlbyMIjbcqllhF5LHis74v7mawW/a6QJRaMiu9K1hvuPr0YRgcwuyfGkU23axAaojd
	 CEMLsYC2/P8J9n2iTWgHeCHfTLmIi2tmjYySK2tBRKQUdHTMnKpSRkNwvDiR9ihSBJ
	 MaYD83XgmWNNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: Align hibernate poweroff flow with suspend
 flow for bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916205340.2466679-3-mario.limonciello@amd.com>
References: <20260916205340.2466679-1-mario.limonciello@amd.com>
 <20260916205340.2466679-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:05:21 +0000
Message-Id: <20260916210522.3A1111F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: missing secondary bus wait in restore_noirq on hibernation ab=
ort
--

commit 2ba69e2c07c28dfe82ab9450d201b37b5e9b14d7
Author: Mario Limonciello (AMD) <superm1@kernel.org>

    PCI: Align hibernate poweroff flow with suspend flow for bridges
   =20
    During S3 suspend, pci_pm_suspend_noirq() puts PCIe bridges with
    downstream devices into a low-power state (D3hot or D3cold) when the
    platform allows it.  The hibernate poweroff_noirq path never did this:
    it only called pci_prepare_to_sleep() for devices with no subordinate,
    so bridges with active children were left in D0.
   =20
    On many designs the platform firmware leaves bridges alone when the
    system enters S4. This prevents being able to meet various energy
    certification criteria for different parts of the world, particularly
    in designs with a dGPU.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 8334214f8c1ed..8d293ca66a0d9 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c

[ ... ]

> @@ -1272,16 +1275,26 @@ static int pci_pm_poweroff_noirq(struct device *d=
ev)
>  	}
> =20
>  	if (pm->poweroff_noirq) {
> +		pci_power_t prev =3D pci_dev->current_state;
>  		int error;
> =20
>  		error =3D pm->poweroff_noirq(dev);
>  		suspend_report_result(dev, pm->poweroff_noirq, error);
>  		if (error)
>  			return error;
> +
> +		if (!pci_dev->state_saved && pci_dev->current_state !=3D PCI_D0
> +		    && pci_dev->current_state !=3D PCI_UNKNOWN) {
> +			pci_WARN_ONCE(pci_dev, pci_dev->current_state !=3D prev,
> +				      "PCI PM: State of device not saved by %pS\n",
> +				      pm->poweroff_noirq);
> +			goto Fixup;
> +		}
>  	}
> =20
> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
> -		pci_prepare_to_sleep(pci_dev);
> +	skip_bus_pm =3D pci_pm_suspend_noirq_common(pci_dev);

[Severity: High]
Since this change puts PCIe bridges into low-power states (D3hot/D3cold) ju=
st
like S3 suspend, does the recovery path for an aborted poweroff also need
updating?

If hibernation aborts after this point, the system recovers by calling
dpm_resume_end(PMSG_RESTORE), which invokes pci_pm_restore_noirq() for all
devices.

While pci_pm_resume_noirq() properly checks if a bridge was previously in
D3cold and calls pci_pm_bridge_power_up_actions(), pci_pm_restore_noirq() l=
acks
this check:

drivers/pci/pci-driver.c:pci_pm_restore_noirq() {
	...
	pci_pm_default_resume_early(pci_dev);
	pci_fixup_device(pci_fixup_resume_early, pci_dev);

	if (pci_has_legacy_pm_support(pci_dev))
		return 0;
	...
}

Without a secondary bus wait, downstream devices accessed during their
subsequent restore_noirq callbacks might hit an untrained link, potentially
resulting in Master Aborts and device state corruption.

> +	if (skip_bus_pm)
> +		goto Fixup;
> =20
>  	/*
>  	 * The reason for doing this here is the same as for the analogous code

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205340.2466=
679-1-mario.limonciello@amd.com?part=3D2
