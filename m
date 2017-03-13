Return-Path: <SRS0=wqlW=2W=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=wqlW=2W=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489408896-25039-5-git-send-email-deathsimple@vodafone.de>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de> <1489408896-25039-5-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Mar 2017 18:51:08 +0200
Message-ID: <CAHp75VcSD+edusfZF8KWvCqoywPwJXdO_=9-RZdDpMF5dKtocQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: helgaas@kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 2:41 PM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Try to resize BAR0 to let CPU access all of VRAM.

> +void amdgpu_resize_bar0(struct amdgpu_device *adev)
> +{
> +       u32 size =3D max(ilog2(adev->mc.real_vram_size - 1) + 1, 20) - 20=
;
> +       int r;
> +
> +       r =3D pci_resize_resource(adev->pdev, 0, size);

> +

Redundant.

> +       if (r =3D=3D -ENOTSUPP) {
> +               /* The hardware don't support the extension. */
> +               return;

> +

Ditto.

> +       } else if (r =3D=3D -ENOSPC) {

Useless use of else. And thus of curly braces.

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

Comment why it's used here.
--=20
With Best Regards,
Andy Shevchenko
