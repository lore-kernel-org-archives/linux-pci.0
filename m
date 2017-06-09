Return-Path: <SRS0=6Rku=5O=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=6Rku=5O=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1496998787-6371-6-git-send-email-deathsimple@vodafone.de>
References: <1496998787-6371-1-git-send-email-deathsimple@vodafone.de> <1496998787-6371-6-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Jun 2017 13:14:02 +0300
Message-ID: <CAHp75Vfq2WwMT1tGu8VWmd5ZfWc7HCjh6PxpsXtjY8a3eoXH-g@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] drm/amdgpu: move hw generation check into amdgpu_doorbell_init
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 9, 2017 at 11:59 AM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> This way we can savely call it on SI as well.

s/savely/safely

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a7d6804..99290af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -419,6 +419,15 @@ void amdgpu_pci_config_reset(struct amdgpu_device *a=
dev)
>   */
>  static int amdgpu_doorbell_init(struct amdgpu_device *adev)
>  {
> +       /* No doorbell on SI hardware generation */
> +       if (adev->asic_type < CHIP_BONAIRE) {
> +               adev->doorbell.base =3D 0;
> +               adev->doorbell.size =3D 0;
> +               adev->doorbell.num_doorbells =3D 0;
> +               adev->doorbell.ptr =3D NULL;
> +               return 0;
> +       }
> +
>         /* doorbell bar mapping */
>         adev->doorbell.base =3D pci_resource_start(adev->pdev, 2);
>         adev->doorbell.size =3D pci_resource_len(adev->pdev, 2);
> @@ -2136,9 +2145,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_ba=
se);
>         DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
>
> -       if (adev->asic_type >=3D CHIP_BONAIRE)
> -               /* doorbell bar mapping */
> -               amdgpu_doorbell_init(adev);
> +       /* doorbell bar mapping */
> +       amdgpu_doorbell_init(adev);
>
>         /* io port mapping */
>         for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
> @@ -2335,8 +2343,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         adev->rio_mem =3D NULL;
>         iounmap(adev->rmmio);
>         adev->rmmio =3D NULL;
> -       if (adev->asic_type >=3D CHIP_BONAIRE)
> -               amdgpu_doorbell_fini(adev);
> +       amdgpu_doorbell_fini(adev);
>         amdgpu_debugfs_regs_cleanup(adev);
>  }
>
> --
> 2.7.4
>



--=20
With Best Regards,
Andy Shevchenko
