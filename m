Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 9 Mar 2016 15:40:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nouveau: use new vga_switcheroo power domain.
Message-ID: <20160309144047.GB26158@wunner.de>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
 <1457504045-12738-2-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457504045-12738-2-git-send-email-airlied@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dave,

On Wed, Mar 09, 2016 at 04:14:05PM +1000, Dave Airlie wrote:
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
>  		runtime = true;
>  	vga_switcheroo_register_client(dev->pdev, &nouveau_switcheroo_ops, runtime);
>  
> -	if (runtime && nouveau_is_v1_dsm() && !nouveau_is_optimus())
> -		vga_switcheroo_init_domain_pm_ops(drm->dev->dev, &drm->vga_pm_domain);
> +	if (runtime) {
> +		if (nouveau_is_v1_dsm() && !nouveau_is_optimus())

The " && !nouveau_is_optimus()" can be dropped because a machine cannot
have both. Note the "else" in nouveau_dsm_detect():

        if (has_optimus == 1) { ...
                nouveau_dsm_priv.optimus_detected = true;
        } else if (vga_count == 2 && has_dsm && guid_valid) { ...
                nouveau_dsm_priv.dsm_detected = true;
        }

> +			vga_switcheroo_init_domain_pm_ops(drm->dev->dev, &drm->vga_pm_domain);
> +		else if (nouveau_is_optimus())
> +			vga_switcheroo_init_parent_pr3_ops(drm->dev->dev, &drm->vga_pm_domain);

You're calling this unconditionally for all Optimus machines yet
I assume pre Windows 10 machines lack the PR3 hooks.

Best regards,

Lukas

> +	}
>  }
>  
>  void
> @@ -117,7 +121,7 @@ nouveau_vga_fini(struct nouveau_drm *drm)
>  		runtime = true;
>  
>  	vga_switcheroo_unregister_client(dev->pdev);
> -	if (runtime && nouveau_is_v1_dsm() && !nouveau_is_optimus())
> +	if (runtime && (nouveau_is_v1_dsm() || nouveau_is_optimus()))
>  		vga_switcheroo_fini_domain_pm_ops(drm->dev->dev);
>  	vga_client_register(dev->pdev, NULL, NULL, NULL);
>  }
> -- 
> 2.5.0
