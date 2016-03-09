Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34006 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547AbcCINUj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2016 08:20:39 -0500
MIME-Version: 1.0
In-Reply-To: <1457504045-12738-2-git-send-email-airlied@gmail.com>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
	<1457504045-12738-2-git-send-email-airlied@gmail.com>
Date: Wed, 9 Mar 2016 14:20:36 +0100
Message-ID: <CAJZ5v0g6J0Lew=JxoTA35-JL4-wexWmNh=d_nTg_Ld=iA+RifA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nouveau: use new vga_switcheroo power domain.
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 9, 2016 at 7:14 AM, Dave Airlie <airlied@gmail.com> wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> This fixes GPU auto powerdown on the Lenovo W541,
> since we advertise Windows 2013 to the ACPI layer.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_vga.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
> index af89c36..b987427f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -101,8 +101,12 @@ nouveau_vga_init(struct nouveau_drm *drm)
>                 runtime = true;
>         vga_switcheroo_register_client(dev->pdev, &nouveau_switcheroo_ops, runtime);
>
> -       if (runtime && nouveau_is_v1_dsm() && !nouveau_is_optimus())
> -               vga_switcheroo_init_domain_pm_ops(drm->dev->dev, &drm->vga_pm_domain);
> +       if (runtime) {
> +               if (nouveau_is_v1_dsm() && !nouveau_is_optimus())
> +                       vga_switcheroo_init_domain_pm_ops(drm->dev->dev, &drm->vga_pm_domain);
> +               else if (nouveau_is_optimus())
> +                       vga_switcheroo_init_parent_pr3_ops(drm->dev->dev, &drm->vga_pm_domain);
> +       }
>  }
>
>  void
> @@ -117,7 +121,7 @@ nouveau_vga_fini(struct nouveau_drm *drm)
>                 runtime = true;
>
>         vga_switcheroo_unregister_client(dev->pdev);
> -       if (runtime && nouveau_is_v1_dsm() && !nouveau_is_optimus())
> +       if (runtime && (nouveau_is_v1_dsm() || nouveau_is_optimus()))
>                 vga_switcheroo_fini_domain_pm_ops(drm->dev->dev);
>         vga_client_register(dev->pdev, NULL, NULL, NULL);
>  }
> --

Looks reasonable to me.

Thanks,
Rafael
