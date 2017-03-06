Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1488800428-2854-5-git-send-email-deathsimple@vodafone.de>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de> <1488800428-2854-5-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 Mar 2017 14:06:45 +0200
Message-ID: <CAHp75Ve8WyfNjrRq2jw_puqBUOAfWMBgVFdo--tdvQ4ta5tjzQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: resize VRAM BAR for CPU access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 6, 2017 at 1:40 PM, Christian K=C3=B6nig <deathsimple@vodafone.=
de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Try to resize BAR0 to let CPU access all of VRAM.

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -616,6 +616,35 @@ void amdgpu_gtt_location(struct amdgpu_device *adev,=
 struct amdgpu_mc *mc)

> +void amdgpu_resize_bar0(struct amdgpu_device *adev)
> +{
> +       u32 size =3D max(ilog2(adev->mc.real_vram_size - 1) + 1, 20) - 20=
;

Too complicated.

unsigned long =3D fls_long(real_vram_size | BIT(20));

And the result is not a size, right? It's a logarithm from size.

> +       int r;
> +
> +       r =3D pci_resize_resource(adev->pdev, 0, size);

> +

Redundant line.

> +       if (r =3D=3D -ENOTSUPP) {
> +               /* The hardware don't support the extension. */
> +               return;
> +
> +       } else if (r =3D=3D -ENOSPC) {
> +               DRM_INFO("Not enoigh PCI address space for a large BAR.")=
;
> +       } else if (r) {
> +               DRM_ERROR("Problem resizing BAR0 (%d).", r);
> +       }
> +
> +       /* Reinit the doorbell mapping, it is most likely moved as well *=
/
> +       amdgpu_doorbell_fini(adev);

> +       BUG_ON(amdgpu_doorbell_init(adev));

No way to recover?!

> +}
> +

--=20
With Best Regards,
Andy Shevchenko
