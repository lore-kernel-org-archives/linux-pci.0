Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4F345722
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105854; cv=none; b=bG5ezppdMmFsHhh2TmRk2zn3ytqjLAbCJAVESKEt/FC/454nd1G5mpzWVFR7f+CIJYfJJB8QyOEKF3afPKOsl88/bjAv5lTNHe25NTT4GacHf26x2oHV8Se7iELUOc3W/ztboKafJDAGaJPnvvJdqH/Lskc2NlItzZFbSAEE9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105854; c=relaxed/simple;
	bh=TmssjQpy0gPeI3MvETkTe0akq0ZNsQvtV6a0dJ+okhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz3RkJ+BdVaRmf3LnKxDY5G6xAXf23EwUKQY7e3BcHX2D2pO/VYmVCVfd8z44TRJQ0Ffgjel1pNqrKdXosrouc/1GPrwR//nYalakj6Lebi61NiBOb4ALs/G7MszCPOBOom9m4MOTFE3qlppdnQrl0lWRqEc66Fd0UirJq4D9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9x4C6I1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9x4C6I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B49C19423
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 18:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769105853;
	bh=TmssjQpy0gPeI3MvETkTe0akq0ZNsQvtV6a0dJ+okhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I9x4C6I1tVd6MneyDRpEC5aNSbSXQxQXTallrhnZUDPGKw2Le8t5QgATR+9w9ri9B
	 E/aGkLfdAJ4gXQuC4YO1SH3SPgeYrECuSmyEA0lRkd98DBjYm2LqMvYgHx20T0ebOh
	 tRSe2k6Mx2ejq0rcXtqy1+Qegs41Cd/4uTsQIJ+hnRKjhure5ZNdrp1jxHeJgLsIja
	 SYVMkIK/Jl+A/B80TRlY+gFBDCuoGI/n+nIF0D42Fgd6/F200LzdDZZWTlsmbbOgp7
	 mLUpJrQVLW4QAiF3Gz90QW1SmUWa5gFt9dyafAj/gHNayT41uzXLTCNXo+8L49zsFM
	 oTpeSebRgubMw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c7a71ba20so442994b6e.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 10:17:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU39d2SyK4EIZcdGZk0aWd/HYohAd1kHJ+a/f4qLtEMOFMBTjyPIojk1y6LJd0HxgfWwYE/2JeQTeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLeNawAlAlA3dXJNnIvraEz0EKhXyrrC1q9qA4h1N5GjwQyDk
	qJ9KPNzCTN5C/qDG9r0hZY7bROWaSZcfjwDaZ5Sl0jos9nzNvEkmhYOH4g7FysC1o/T2xA7kuHb
	RPrsvEmbeRxxt4nHdmb8DQlOfhxkA0nI=
X-Received: by 2002:a05:6820:8188:b0:65c:2501:6c79 with SMTP id
 006d021491bc7-662cab9db87mr321159eaf.59.1769105852230; Thu, 22 Jan 2026
 10:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
In-Reply-To: <20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 19:17:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iBNOmMtqfqEbrYyuK2u+2J2+zZ-iQd1FvyCPjdvU2TJg@mail.gmail.com>
X-Gm-Features: AZwV_QjB3_rEGhESO5nhmyv1QvYjfK0Xx62wIlqHdgeo9nkRC28i7dwynrvApHE
Message-ID: <CAJZ5v0iBNOmMtqfqEbrYyuK2u+2J2+zZ-iQd1FvyCPjdvU2TJg@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/PM: Prevent runtime suspend until devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 6:49=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Previously, it was possible for a PCI device to be runtime-suspended befo=
re
> it was fully initialized. When that happened, the suspend process could
> save invalid device state, for example, before BAR assignment. Restoring
> the invalid state during resume may leave the device non-functional.
>
> Prevent runtime suspend for PCI devices until they are fully initialized =
by
> deferring pm_runtime_enable().
>
> More details on how exactly this may occur:
>
>   1. PCI device is created by pci_scan_slot() or similar
>
>   2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
>      prevents runtime suspend prevented via pm_runtime_forbid()
>
>   3. pci_device_add() adds the underlying 'struct device' via device_add(=
),
>      which means user space can allow runtime suspend, e.g.,
>
>        echo auto > /sys/bus/pci/devices/.../power/control
>
>   4. PCI device receives BAR configuration
>      (pci_assign_unassigned_bus_resources(), etc.)
>
>   5. pci_bus_add_device() applies final fixups, saves device state, and
>      tries to attach a driver
>
> The device may potentially be suspended between #3 and #5, so this is rac=
y
> with user space (udev or similar).
>
> Many PCI devices are enumerated at subsys_initcall time and so will not
> race with user space, but devices created later by hotplug or modular
> pwrctrl or host controller drivers are susceptible to this race.
>
> More runtime PM details at the first Link: below.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883b=
d2b4ef475155c7aa72b@changeid/
> Link: https://lore.kernel.org/all/0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@sa=
msung.com/
>
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883b=
d2b4ef475155c7aa72b@changeid/
> Cc: <stable@vger.kernel.org>
> ---
>
> Changes in v5:
>  * Put pm_runtime_set_active() back where it was, to ensure our parent
>    can't suspend before we're really ready. (See bug report in 2nd
>    "Link:")
>  * Add comments
>  * Update commit description with Bjorn's rewrite
>  * Add Marek's Tested-by
>
> Changes in v4:
>  * Move pm_runtime_set_active() too
>
> Changes in v3:
>  * Add Link to initial discussion
>  * Add Rafael's Reviewed-by
>  * Add lengthier footnotes about forbid vs allow vs sysfs
>
> Changes in v2:
>  * Update CC list
>  * Rework problem description
>  * Update solution: defer pm_runtime_enable(), instead of trying to
>    get()/put()
>
>  drivers/pci/bus.c | 7 +++++++
>  drivers/pci/pci.c | 5 ++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 4383a36fd6ca..90954f81962b 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>
> @@ -379,6 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 put_device(&pdev->dev);
>         }
>
> +       /*
> +        * Enable runtime PM (and potentially suspend) only after we've f=
ully
> +        * configured the PCI state.
> +        */

I would make it a bit more precise, something like "Enable runtime PM,
which potentially allows the device to suspend immediately, only after
the PCI state has been configured completely."

Also, it is not particularly what "we" means in kernel code comments,
so I generally avoid phrasing them this way.

> +       pm_runtime_enable(&dev->dev);
> +
>         if (!dn || of_device_is_available(dn))
>                 pci_dev_allow_binding(dev);
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..07b0d029aa51 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3196,8 +3196,11 @@ void pci_pm_init(struct pci_dev *dev)
>  poweron:
>         pci_pm_power_up_and_verify_state(dev);
>         pm_runtime_forbid(&dev->dev);
> +       /*
> +        * Mark ourselves active now, to prevent our parent from suspendi=
ng
> +        * while we finish configuring the PCI device.
> +        */

I would rephrase the comment this way:

"Runtime PM will be enabled for the device when it has been fully
configured, but since its parent and suppliers may suspend in the
meantime, prevent them from doing so by changing the device's runtime
PM status to "active"."

>         pm_runtime_set_active(&dev->dev);
> -       pm_runtime_enable(&dev->dev);
>  }
>
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> --
