Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD560390229
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133106; cv=none; b=SY0F5g4Ns9LijFCxcjh+yFXJsrBBPj6yrfVZJY+3FQg8KsnbpbW9wWGTlsQMnKDVyAnx1LU6ZFYN7vEnRvvXe4jdg4dhBoxRyB/ZrHKLCsBDpIpkK8D1Bz6A/c27qnPuCpdWrQsMBrImlNPTR5/rDBJxugUFuCJmepYkar9Jl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133106; c=relaxed/simple;
	bh=deN0GC2SDjpo00D+j8kF3BaRV5F6uBlPHfj7/kmXDcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrFprLiekUO3kAbi22Mq/Jip49K3oCbUrho/SksJqR5AArWeYcrF8G2qvXiRc80AswlxnnClASBr8bok9WQDiQ87x0yXhXd2Tbonc4raYtq8vMdWAkccszJw/tvb+pxSj+Nd18AgruK75eXFURWhFbZfIheRv2/NXe9cKdkH8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB9Rv2AZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB9Rv2AZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3040C2BCF5
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779133106;
	bh=deN0GC2SDjpo00D+j8kF3BaRV5F6uBlPHfj7/kmXDcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UB9Rv2AZ5SnoNl39Hix4kXS0GjvIk6J3LK0WZBhSiqsADHCXEdYnt5DwDSZkx63qV
	 /BNvoRsouWOnIkZFj93ixlVBPENCNFW4AwoEYyd4X1IN5YN543vzOUwNrvBJnVqffH
	 LJxWRpdBvx3k0sBeDG2Yug8U/JaNXQtQwr8IZA7dgFMC+ukH9ZKvxKgzrY2NTidzJC
	 yeY3xp7gOvpLudNfK7w8oSo69FRe4sqg6H1zfMUHSOPPbZl5rEaC8zHori7uXhWDf3
	 AZG0nDMKD0MRxs1nyz4A+DD9I3i8bskF87AyGMNjlYwsTucq6yqGQFpmr4BmHl0pqt
	 zHzVpkwW7IuCQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso34193001fa.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:38:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/td6oPVHb3NoJmesiFbs0MzhMRn+X8Gp7n26V+Gjv/Epprmkm
	tcw0M6vru+Kq1xmQJkg7lDbnyk0Gy/Ux03lNqe2HQQBrpYVk6uXxpclC0bZkjMD9WGLjNv8Rw1Z
	EDrp+qhDL3N8jiK8Yeej1UTfztaoA4lA=
X-Received: by 2002:a05:6512:1243:b0:5a7:4699:d851 with SMTP id
 2adb3069b0e04-5aa0e73f5f4mr5128555e87.7.1779133104721; Mon, 18 May 2026
 12:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518191220.636213-1-bhelgaas@google.com> <20260518191220.636213-3-bhelgaas@google.com>
In-Reply-To: <20260518191220.636213-3-bhelgaas@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 May 2026 21:38:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iU=0SHXK9RngiYCwz5XZ0mJ+L5iy-FSWhytNgJbCam0A@mail.gmail.com>
X-Gm-Features: AVHnY4K5iH8pv-2trv6c4mXKXOKu2MrZZ0Gsqfr7J1WN1EN8U3ufFO0zvztWvWI
Message-ID: <CAJZ5v0iU=0SHXK9RngiYCwz5XZ0mJ+L5iy-FSWhytNgJbCam0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Marco Nenciarini <mnencia@kcore.it>, 
	Michal Winiarski <michal.winiarski@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Eric Chanudet <echanude@redhat.com>, Jean Guyader <jean.guyader@gmail.com>, 
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:12=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> From: Bjorn Helgaas <helgaas@kernel.org>
>
> For a device that advertises No_Soft_Reset =3D=3D 0, a transition from D3=
hot to
> D0uninitialized is a soft reset, and the resulting internal device state =
is
> undefined.
>
> Per PCIe r7.0, sec 2.3.1, a transition from D3hot to D0uninitialized
> mandates a minimum 10 ms delay before accessing the device. Following thi=
s
> delay, the device is permitted to respond to initial configuration reques=
ts
> with a Request Retry Status (RRS) completion status if it needs more time
> to initialize.
>
> Call pci_dev_wait() after pci_power_up() performs a D3hot->D0uninitialize=
d
> transition to ensure the device is ready to accept config accesses, as is
> done after the similar transition in pci_pm_reset().
>
> If the device is already ready, this is essentially a no-op except for on=
e
> additional config read.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5a9af0bb2c71..8228d2782f95 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1300,7 +1300,18 @@ int pci_power_up(struct pci_dev *dev)
>         bool need_restore;
>         pci_power_t state;
>         u16 pmcsr;
> +       int ret;
>
> +       /*
> +        * When setting power state to D0, platform_pci_set_power_state()
> +        * ensures main power is on.  If it puts the device in D0, it als=
o
> +        * completes any required delays after the transition; if it leav=
es
> +        * the device in D1, D2, or D3hot, we use the PM Capability to
> +        * transition to D0.
> +        *
> +        * In all cases, the device is either Configuration-Ready or
> +        * inaccessible upon return.
> +        */
>         platform_pci_set_power_state(dev, PCI_D0);
>
>         if (!dev->pm_cap) {
> @@ -1341,10 +1352,19 @@ int pci_power_up(struct pci_dev *dev)
>         pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
>
>         /* Mandatory transition delays; see PCI PM 1.2. */
> -       if (state =3D=3D PCI_D3hot)
> +       if (state =3D=3D PCI_D3hot) {
>                 pci_dev_d3_sleep(dev);
> -       else if (state =3D=3D PCI_D2)
> +               if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {

Hmm.  The pmcsr value here is from before the pci_write_config_word(),
so AFAICS it should be updated after the write.

This means an additional config space access and I wonder if it can be
added to pci_dev_wait()?

> +                       ret =3D pci_dev_wait(dev, "power up D3hot->D0unin=
itialized",
> +                                          PCIE_RESET_READY_POLL_MS);
> +                       if (ret) {
> +                               dev->current_state =3D PCI_D3cold;
> +                               return -EIO;
> +                       }
> +               }
> +       } else if (state =3D=3D PCI_D2) {
>                 udelay(PCI_PM_D2_DELAY);
> +       }
>
>  end:
>         dev->current_state =3D PCI_D0;
> --
