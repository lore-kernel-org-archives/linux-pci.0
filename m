Return-Path: <SRS0=FWh+=4R=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=FWh+=4R=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de> <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 May 2017 15:00:24 +0300
Message-ID: <CAHp75VdyC8oqLYRZHk3e4rvw+=9SW7LNn7vT9_VoisNuN5p91A@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] drm/amdgpu: resize VRAM BAR for CPU access v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Platform Driver <platform-driver-x86@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 9, 2017 at 7:49 PM, Christian K=C3=B6nig <deathsimple@vodafone.=
de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Try to resize BAR0 to let CPU access all of VRAM.

> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -372,13 +372,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *a=
dev)
>                 }
>                 adev->mc.vram_width =3D numchan * chansize;
>         }
> -       /* Could aper size report 0 ? */
> -       adev->mc.aper_base =3D pci_resource_start(adev->pdev, 0);
> -       adev->mc.aper_size =3D pci_resource_len(adev->pdev, 0);
>         /* size in MB on si */
>         adev->mc.mc_vram_size =3D RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 10=
24ULL;
>         adev->mc.real_vram_size =3D RREG32(mmCONFIG_MEMSIZE) * 1024ULL * =
1024ULL;
>

> +       if (!(adev->flags & AMD_IS_APU))
> +               amdgpu_resize_bar0(adev);
> +       adev->mc.aper_base =3D pci_resource_start(adev->pdev, 0);
> +       adev->mc.aper_size =3D pci_resource_len(adev->pdev, 0);
> +

Looks to me like a candidate to be a helper. (3x occurrences)

--=20
With Best Regards,
Andy Shevchenko
