Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1488800428-2854-4-git-send-email-deathsimple@vodafone.de>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de> <1488800428-2854-4-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 Mar 2017 14:00:03 +0200
Message-ID: <CAHp75VeUTWC0p6PpRu+nw6Vqwnm2Q4-nTYh59T1efBReDou+Og@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: fix printing the doorbell BAR info
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
> The address is 64bit, not 32bit.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index bf31aaf..a470869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -385,7 +385,7 @@ static int amdgpu_doorbell_init(struct amdgpu_device =
*adev)
>         if (adev->doorbell.ptr =3D=3D NULL) {
>                 return -ENOMEM;
>         }


> -       DRM_INFO("doorbell mmio base: 0x%08X\n", (uint32_t)adev->doorbell=
.base);
> +       DRM_INFO("doorbell mmio base: 0x%llX\n", (uint64_t)adev->doorbell=
.base);
>         DRM_INFO("doorbell mmio size: %u\n", (unsigned)adev->doorbell.siz=
e);

It seems I sent patch to remove those at all, but if you wish to leave
them, please convert to %pap and remove explicit casting.

--=20
With Best Regards,
Andy Shevchenko
