Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446E3FD15E
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803382; cv=none; b=rKukLovr4SJk7q5U4ZrWrA0YW1euNdqbvemOpyhFYnHfQ36Mwm/jlZ14qlJJwC5Tl1+48aP+9+bO3Ua8YzNe2W/FiIAj4frrpNkknnBpfihvk6CQ5zv8TRnTPmKrB4DQIwGLaqMrGAkO4mBA794nY54qsNRk3GLfn5l2adtlx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803382; c=relaxed/simple;
	bh=FVqO2jqrzeW01zJgNeYZLtZkbAol82aPx19jcq3W8fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPYniJAkzAWPnt9XIo+NHTXeuHONPxyn+32McKRwF2I3EewqJGNqndh+axPWWW6JenoMJuYMKlBsfCpIlFV8SO+58ta/5dGPARdTxzl6/cXtUjmueX0M3H+2M56t+rpvxMoeHQdsd9mhZGK4JWwyuDWdNQW2SV+bjtL+wPbe8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZZh138Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZZh138Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A181F00A3C
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803380;
	bh=gb6ef52KaaJcGeDkHOxyjK3fb7Q7B4TvVc7N9XUjnxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZZZh138QAtBp69uzSDG2GTkj+PB6DWPAV4FttCJcCs+NEeu5E8AISkk6Ndzm8ioQl
	 ae9LPxV4fDeVa7Z4afEs2wI72tP/2mBWEF6YHKw1+fncdSTaNJR+7T44lGyTYmpawx
	 8Fl9/ItoVjXXKhw2/cvQxgkM1fB4qF4XlL7SghLm9YJMD0uXlkLMJOD577jXAo7ORG
	 bZMhQZFDt1MtfHLTn15ez1oYSBn1W3n5Q2YOSjdDijwXIEZ7fMlbKmHYFcb/URBAji
	 t1x6qHatJLVbJR4YqWE69Aggv8u1ddL6xC8NFD/TEcHXCI9LXRYtWc+xSgwaNzYpw6
	 TF89A3804Dlpw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a4113ab355so5335672e87.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 06:49:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8kz6Rog+p338uS8g21g+/akD40ss4YvD6n2dSxbEGpJOyDw+daI3ZQsPfTg8Lo1CuA1s0N/QfO2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YUCDK44LN6ANcFVK5B+mR3+I6gRHQnyIWk20Gd4pn7tkTYHp
	02G888SpVByPe4EVmkN/XMjBFeRyedvdo3Yf3wiJiBtjsekQu43Rmj2c2A75kPRYdwouwpOAP/2
	SJ6HYaISl7S50N6bDHmJy6JYYv+LLu3o=
X-Received: by 2002:a05:6512:31c4:b0:5a8:7317:5417 with SMTP id
 2adb3069b0e04-5aa32369f4amr5693898e87.9.1779803378428; Tue, 26 May 2026
 06:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427205024.254677-1-superm1@kernel.org> <20260427205024.254677-2-superm1@kernel.org>
In-Reply-To: <20260427205024.254677-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 15:49:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0imshJbuv-gCM8e=fR=hG7wDhPiyVaz-F1BWPpNUVkiyA@mail.gmail.com>
X-Gm-Features: AVHnY4JLvgbThW66Y0L8RqwXYEPtAtaxtvLc8MaN14sPh8aam0n4HcUhImrhjuU
Message-ID: <CAJZ5v0imshJbuv-gCM8e=fR=hG7wDhPiyVaz-F1BWPpNUVkiyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] PCI: Stop setting cached power state to "unknown"
 on unbind
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:50=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Lukas Wunner <lukas@wunner.de>
>
> When a PCI device is unbound from its driver, pci_device_remove() sets th=
e
> cached power state in pci_dev->current_state to PCI_UNKNOWN.  This was
> introduced by commit 2449e06a5696 ("PCI: reset pci device state to unknow=
n
> state for resume") to invalidate the cached power state in case the syste=
m
> is subsequently put to sleep.
>
> For bound devices, the cached power state is set to PCI_UNKNOWN in
> pci_pm_suspend_noirq(), immediately before entering system sleep.
>
> Extend to unbound devices for consistency.
>
> This obviates the need to change the cached power state on unbind, so sto=
p
> doing so.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/pci-driver.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d10ece0889f0f..2bfefd8db5260 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -512,13 +512,6 @@ static void pci_device_remove(struct device *dev)
>         /* Undo the runtime PM settings in local_pci_probe() */
>         pm_runtime_put_sync(dev);
>
> -       /*
> -        * If the device is still on, set the power state as "unknown",
> -        * since it might change by the next time we load the driver.
> -        */
> -       if (pci_dev->current_state =3D=3D PCI_D0)
> -               pci_dev->current_state =3D PCI_UNKNOWN;
> -
>         /*
>          * We would love to complain here if pci_dev->is_enabled is set, =
that
>          * the driver should have called pci_disable_device(), but the
> @@ -893,7 +886,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>
>         if (!pm) {
>                 pci_save_state(pci_dev);
> -               goto Fixup;
> +               goto set_unknown;
>         }
>
>         if (pm->suspend_noirq) {
> @@ -945,6 +938,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 goto Fixup;
>         }
>
> +set_unknown:
>         pci_pm_set_unknown_state(pci_dev);
>
>         /*
> --
> 2.53.0
>
