Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F579494828
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527423; cv=none; b=nDPbwJ7eR6m/O9Lj0e962BJQwQXpdegXpUroghY+lARGb6tSn6au5+cN4Slj6J117aiXAffDkQlMMKtuxMrBlScL4U+weokb/bhktn1/pe3YTrSWBfVvkyMgdnvSmLIt4MWcSsEQsTdCJV8MjuSy0J6S2xmI/AxzgyNH8om7yNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527423; c=relaxed/simple;
	bh=dNAxG5RJpae8U6isDe+cGScB/P1cfsuTlvTizvNXPLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p34NYKdegzdkcmUu3TJTGW9pnllChrQzxwkfX2ZZigHssyOsgFvslv36NeAfIWl+9rLEWD7+3cStcqO5HrOZCsFS/rrI9cFf3YEE3MSOhi6DQjUn4Q9YP9J2FH/ROuyts402TPOE/SsL8tagzMl+TH77AMF7QTDXK/8UmWuFPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxThJ91Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxThJ91Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9731F00ADE
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527418;
	bh=uzlabd0Ht729u0PHQ5e0HoltWkVGvcok12nebPy3mcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZxThJ91QUNLYppsFFwHX3lssAndLcVBXZQYVZ/lYhnp1veDL4SLu/9AgkKb6asLKn
	 uZ7njNtejOZa9hVzAofczEBApnyxicUYITl/ofg3ipc55FyKGEJ1+zae9ivP5g9UHc
	 eE3j2TShV5RBt2vKJaOWV4Fs9wAyMP/AH4lvIi4FWJUfL2EQQBH/UFUFTYuxDEN/k2
	 A0ea+grGz659SzeyFT2hZLXFS2ppOlpnqZnXogVTLT02XlYKt53SxEz+2Or/bnnMP3
	 tJHWXQwejiR7CThfyQbuDfp9YsW3BD1BCaW2gVGjo+CdtCA8dvY0YsHnd91+q/8gB+
	 5E3zuL43TlM6A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b4ab4b4179so895534e87.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:10:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByMW7o0cYI5Ch30lVw8T/jc4iR86VYgwnZVxGw0TCAlBiANP2ouK/hei0n80bV0/Ic5H8P0p+ZxAUg=@vger.kernel.org
X-Gm-Message-State: AFuF++n63L5qYq5nbuahGgwDigThT0nZdHuA89UuSTaPaevwIc1zTBD6
	Q/A5Fu0JYd/Z35f+53tl0xwosrUr6DvOo2AL6juv9pYYFpaAHXJA7MZ7VMJx8JpjHkLznSme8DN
	XEGB1AvZr1JlSpHTD29Ymh+eZIRgWSSk=
X-Received: by 2002:a05:6512:a356:b0:5b6:19fe:a5a9 with SMTP id
 2adb3069b0e04-5b619fea602mr1069728e87.26.1788527416701; Fri, 04 Sep 2026
 06:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831205533.2325747-1-mario.limonciello@amd.com> <20260831205533.2325747-3-mario.limonciello@amd.com>
In-Reply-To: <20260831205533.2325747-3-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:09:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgvyRrgVa2fiGMLmT0Uc7gygik8bdSoRhgS3fboQpi8g@mail.gmail.com>
X-Gm-Features: AcwNN1UyzTWrLiZwgmKBA-GlTE12abqgFXdai1dQeipUIJWUfjAUqUXi0_m-QpE
Message-ID: <CAJZ5v0hgvyRrgVa2fiGMLmT0Uc7gygik8bdSoRhgS3fboQpi8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/PM: Run bridge power up actions as part of
 restore phase
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 10:56=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
>
> pci_pm_resume_noirq() calls pci_pm_bridge_power_up_actions() when a
> bridge is coming back from D3cold and bus PM was not skipped, so that
> the mandatory post-power-on link training delays are observed before
> any downstream device is accessed.
>
> The last patch in this series makes the hibernate poweroff_noirq path
> put bridges with downstream devices into D3 (including D3cold),
> mirroring what the S3 suspend path already does.  For that to be safe,
> the hibernate image restore path has to bring those bridges back up the
> same way suspend resume does; otherwise a downstream device may be
> accessed before its parent bridge's link is retrained.

Note though that pci_pm_restore_noirq() runs after the boot kernel has
initialized the PCI bus, so all of the links should be retrained by
that time.

It then carries out a "freeze" transition before passing control to
the image kernel, so "restore" doesn't really get devices in
"pristine" states.

Moreover, BIOS code runs before "poweroff_noirq" and the boot kernel
and it also messes up with devices in general.

Is there a specific issue that is avoided by this change?

> Add the same bridge power up actions to pci_pm_restore_noirq(), gated on
> the same conditions as the resume path (bus PM not skipped and the
> previous state being D3cold), so that hibernate restore and suspend
> resume behave identically for bridges.
>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e3d352c7b31d4..d15b3eb55ec53 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1297,10 +1297,15 @@ static int pci_pm_restore_noirq(struct device *de=
v)
>  {
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> +       pci_power_t prev_state =3D pci_dev->current_state;
> +       bool skip_bus_pm =3D pci_dev->skip_bus_pm;
>
>         pci_pm_default_resume_early(pci_dev);
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>
> +       if (!skip_bus_pm && prev_state =3D=3D PCI_D3cold)
> +               pci_pm_bridge_power_up_actions(pci_dev);
> +
>         if (pci_has_legacy_pm_support(pci_dev))
>                 return 0;
>
> --
> 2.43.0
>
