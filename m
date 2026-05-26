Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DD3BB122
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804092; cv=none; b=RGIvg6aXhnWLWbTQydfbrC2cTBPHiHRorQ87H7/zAQVNlcllVcdaRQX5VCJk0U0nNoHcJ43ciOxoMjTufIgr2oqX4Eu1yC0ywnSaYMJfr0T64IbqmbQmxun0TPmt71GIA6empKDkL0GsW/UgDXTn2IIYyrOfdabA4kjIU26d8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804092; c=relaxed/simple;
	bh=zT4hsvjh9s7Rl/uJ7DSOJf+hMz42se469gCDoMNFndY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX+1lyWfvm6x52Bem0A5ytrUpol83x5fyXiW9ymqyHzKeUAMhlTTd3OMH76LO7xcqSHbFitzJjHZC6eGHND786ECI3sJzMjiYQPwONrtq8MyVknBNuhkrdSpFAVzbr7xbuOMrizgbBdWDDinx7kiJqjjNmOHpXXkYN8N2V4S95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2xETLmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2xETLmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59FC1F00A3A
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804090;
	bh=89D0eYm+0F9/XRE0pzMVFbzHry7rvSDRyI3oosyqExE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A2xETLmMI1mZgI4V24suk/oETIhIlqhWyxJdn5O31IpZbBsJ7g16HoLkuESwnSfcl
	 RJYEENZV9FEF7XPg+yFJ4fp8/Oo6HFKS6fo2gYMPbwmfSoOB1f3ZjBk9bB+BLI4UhI
	 4BrXWbAKrBNMCcrGYP4PLUWRDkhd3su6KtEF9AUK7jiE52QQsNoGZz2yS2Kn+mvCjo
	 D0kQUU1p0h7SUVjGoDPWzgj+APnqLYkO4QqViIWrr6bKF2lzuQRsL5Y6U13KxDmHp9
	 kD2MCjthcF3zyWTltrjS7n0AclNAuajV3UgdcEt2+sbv+MtHDfym4viJuJpD3FQEDf
	 i/NO/PsHvq3HA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa2691db86so10242637e87.3
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 07:01:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/LQ5NVaVWTn7btXXR1pLKHYrXQyq6u/ZcMlH6erqTY9u+U81TyndPxwulwXiR3Y09Y/pT+fmtN/6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3POMszncHMDq60qvakbTPGIo8SOuwf+AeGM7lmW7eDCFoE5UI
	RITXAJAnREtx+5Oba4kyAPoB94yPHKxRu2XmafJX1XJvsp+9b9qu1hukCA2kRTme9Kc64DgVIqT
	ClQXdenjQHokFpraGVl1xO0/kOMrHPCw=
X-Received: by 2002:a05:6512:144f:20b0:5a8:8920:6345 with SMTP id
 2adb3069b0e04-5aa323bbc13mr4115016e87.38.1779804089130; Tue, 26 May 2026
 07:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427205024.254677-1-superm1@kernel.org> <20260427205024.254677-3-superm1@kernel.org>
In-Reply-To: <20260427205024.254677-3-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 16:01:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j_hx8fe_MbuKz3R0F0SihNSSMm=MfPV8ev8Xiqo4qYgQ@mail.gmail.com>
X-Gm-Features: AVHnY4L1Kbdt4xoUziiUxkwkOE4wFmTfA3KViM8fFVgoL9hiWLA3VFzQEhNh2RY
Message-ID: <CAJZ5v0j_hx8fe_MbuKz3R0F0SihNSSMm=MfPV8ev8Xiqo4qYgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI/PM: Disable device wakeups when halting or
 powering off system
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:50=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> PCI devices can be configured as wakeup sources from low power states.
> However, when the system is powering off such wakeups are not expected
> and may lead to spurious behavior.
>
> ACPI r6.5, section 16.1.5 notes:
>
>     "Hardware does allow a transition to S0 due to power button press
>      or a Remote Start."
>
> This implies that wakeups from PCI devices should not be relied upon
> in these states.

Does it?  And what about the Remote Start part?  Wake-on-LAN etc?

> To align with this expectation and avoid unintended
> wakeups, disable device wakeup capability during these transitions.
>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2bfefd8db5260..a43ee7bbfb3f5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1166,6 +1166,9 @@ static int pci_pm_poweroff(struct device *dev)
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
>
> +       if (device_may_wakeup(dev) && system_state =3D=3D SYSTEM_POWER_OF=
F)
> +               device_set_wakeup_enable(dev, false);

1. device_wakeup_disable() can be used here.

2. Do you really want to unregister the wakeup source class device here?

If you need to roll back the poweroff transition, user space will see
this change.

3. What if the device is a NIC that needs to be set up for WoL?

> +
>         if (pci_has_legacy_pm_support(pci_dev))
>                 return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>
> --
