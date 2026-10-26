Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793039129;
	b=vTLnT5HAuxImBZeFqiTZ9Ts4mM87qvGcGvzlci9ebmPqTiDaqpvaqdKgxiUurE4B6xOb
	 9tcOtfMI+hndSAueKIl18PdUIaBd6EBpHW55RBM/95g2cBkwcbBOs41pIV/NZcQheUnx4
	 d9itLt7akkNt7zlxLQB9BvTWUukQ0vGvT5hcjngkOIZavyTnHE3St0YfBRzp10zlo1J53
	 BbDawU+uvAXr7JHVuJhssoi9+/9ziFM87X651tTRwZdgpmN3UgMtCymr0p6QxEBETyXVD
	 AswF1o77pkFoIm6015Nkjr28O/yR1gdR2qHnLn5XLrDEP0kNJgTwLpch08SFShRZNqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Do/93Ec+a4uH5EBQqfEmx8Kskebovc78z6QXsKmL6Zw=;
	b=ywOEoEryZz4ze/eLHbq8nFU4RUWvIKohIqYofVO+Pn6DyN3/Lo96GzvkpX1k7nfAE0iR
	 2tw9sDAsIj64/baqXYBfhaLxHspTZCUug61Qh6NcMdW6kKSJOTzuvwcvZGDldH3qJ9zCR
	 978m/VNIUVV/b+8eFMtEaGp7ifsAo9JRPRwV4SoL1pRXaq1d3PPhB7YjKnUkupPll7UTq
	 yzOOpCf6JZFS5N2Qrnf5jVSUyf3z6zT388dFCcEb4QKKjpgJVYzb1yrlONE25KDILKfTE
	 fV7xKsIQ84Ii0BvclQ5eqO6e+uVzAa2Tlqg58USPNUvQKDjLuyfCmrbdDOK9P6aWevw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psje4x7z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83B606A33C
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 18:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E83B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=psje4x7z
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550dd02c9cso326930eec.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 11:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793039127; cv=none;
        d=google.com; s=arc-20260327;
        b=Y08UEu5gV5Xm7fOxo0CMQ34InemRIgAGsDNxDgLY6s/2AXDWtPv/ESsiGGaCvXWVXj
         rQdUIE3h7qagA25yKD+6dC5y5T7nKyhf8e8e4BwjyRjfta/PQfye3v0Z7K64/XCQhA3N
         XjPA+4jLsKB+0rJq/gEcQZahf5mAbW4CwcyKNjkvFaiYdZ/wG2eJIR97QzNJ37OpGBM2
         MlTNHFpIJE7hezmsR+ELKSlYkPgdUMt5F/tCPIJw090h3glVv8T5nRbc/pdFCL/WRJSe
         73Q8PHTZcA7BCS5Aqr2orSCGAEfqYjNkkKoCBi/M2yYpin9OhFH1UZL/KoETyMjcMOWn
         mMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Do/93Ec+a4uH5EBQqfEmx8Kskebovc78z6QXsKmL6Zw=;
        fh=6grzwNjNX4kHbSLbWLPOH1CfnnMGeTsVvxZYhTOCaKk=;
        b=fCqRz9rx2CIqdrdeCc606jqsQTIPdTaVAelJ7G8OAsmdTLJ2GFCjfnI+zkNtAEOnvT
         QitNInX8NTh/vwpNJd6EoFKqUpqKwx+u7xZJvfYumnfPmFUcDwbkuo/2bvnv2XiwwujV
         WHP06FQRLNPQkVDiCI7MypAWmbGISOZLOMtH5yDCmcC/EC9vhzvnyepuJ2jKfVhEbrjh
         ZRXUzuy102xBNVEbEg4A4MqUzDGReNZ3HM1j9iVpRRVA6xgVNde2w4mQJgWoLGbH0uvN
         f8W4v25seGBxGpxVdjw5IWSd5EdCv89ogXDmOAIM2Bt6k3GYtJJgQDJ62SrnYOvz7Fic
         AlsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793039127; x=1793643927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Do/93Ec+a4uH5EBQqfEmx8Kskebovc78z6QXsKmL6Zw=;
        b=psje4x7z1e4XGk6iRkqCgnwuVkNqyA5hL1Vp7pOb17/wITHwbAh0iYhBFF6mbhBM24
         xvmdiZrEk7sxlbtJGRrL1dDwskbybjtm5434K6pwAuao7iFW0fn7EYfBaW2jZrbWpbR6
         Kia39LOXBzpqlFZPdzAjJqwGYH0ePgO4sp83wQLX2dfMVkVgOoFzN4dRoLSC3BqTi2hG
         6Tpq8SbAjt+m4i2nllfijPXNXSM/UKkWJPZ3h+MsofLN8OHoYscFnm1bPA3vhxPndd4m
         9r4JKrstZNe2KzxJzptH//U3GfUJ4Hzpr3kyNTkkp4w8iMvy8jHjJ4zTlNpymwAGWsdb
         sUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039127; x=1793643927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Do/93Ec+a4uH5EBQqfEmx8Kskebovc78z6QXsKmL6Zw=;
        b=CQKlXUvr2ienSix917xwjiAGUKpQutyRIwki+WBlB4NetDDWsykrxH5hOX44vBpCGM
         CwqhchWPB1VcjJ2JSy9iV574RV62GmLgo5tqLUz4qNYue7q4vfIixg3XLXdPGPrq3UXj
         uNWrg9RKAfaXZ+1QPgCJ0NjJydm6DwV7A9dAwwktLa4DXgDEkhX5CdluzvLVSTPns/aF
         N/bLolGYRrWI7uBaX6gME7SFiEcATuC2gfHfbao/CV8rAtQodnZURiqpX5agqTkuYmvS
         PW17e8vVietFzdmUyWvnSiGlxcPR5kFY/6u1ORjNRmpGUsOZti6RAjHWyLyj6N9I/eLm
         CsAg==
X-Forwarded-Encrypted: i=1; AKwUvBwGYRPmVK3tzdkurW9ero78QxAX5sJrjrxJZt296ZvZ+Dk/A0waOBm4bHp0TYlJiDxQtGWhp9GB4Nc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF4qT4XTSE32tAJGyUU4SX0WxTsubdHdLgDVi6AjJxdT5LhuwD
	sg+NxdI2cpbZQqgn87QE7IJ0724kG8iova0ZfVULvq5dk3vn5ontYE9Oa4s+ZJZ+aXM6S9Fmsu+
	nPuyxjhdRM9LtgyeXPoiVDQxqujT1MRo=
X-Gm-Gg: AYBFou3K1ns9SEbKfou3+7Ru3S5vNSsmHjoXIW4kKAW7iKoLE9j/PK248FfXl0caKdk
	vW5UA/KFP48nBnLJe/kqxMr90bLOQwMMyhPwy0t87/C00uSWZUX9jW1jWJ4c/PG/ueV8FaALewW
	+2gMQN6dRUlsLz7fWqolEL/JzGdPSB5Hwk5H3eIcClcNNg30AyQJvQRbLsxK3LOxS5i5GJewnwg
	oS4uffNyNwEt8YI8s+grWPUR2wYVXzK+m8JR0hnpLvwD8D7tggVYJarDr/n669N+AFYx5vjL2NM
	xGnbGP+D7Cp6B3b9Aynpuz2qHDb5rdOcEdahKifgBp1W7HnvB9MHj5yWjcpGelh5keKqQSQe+/N
	hc2DufizsXQc6ryEcayfRtg5B4ym8XdwkUv7RbO0L4V7qNxiNYvm6BrA7PdoDi8h+U+gp/tY7TC
	HJD7QGHv7dO+qj7XVcxJ8sahY=
X-Received: by 2002:a05:7022:7f05:b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-199345c5ecamr17915804c88.1.1793039127302; Mon, 26 Oct 2026
 11:25:27 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com> <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:25:15 -0400
X-Gm-Features: AclHuK-iVje5ZZPGXAxueHXGbehXRgBbIH4abpn4VFZrQQC5igwZxtMQm-2wnbg
Message-ID: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Kenneth Feng <kenneth.feng@amd.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 12:26=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> From: Andre Eikmeyer <dev@deq.rocks>
>
> As mentioned previous any access to the GPU when the GMUX has
> shut off the rails results in a CPU CATTER, skip and report
> any register access after the GPU was runtime suspended for GMUX power-of=
f.
>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
>  4 files changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 6fd607587..ac8dfc3ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -881,6 +881,8 @@ struct amdgpu_device {
>         /* enable runtime pm on the device */
>         bool                            in_runpm;
>         bool                            has_pr3;
> +       /* GMUX has cut power, any register access would hang the PEG lin=
k */
> +       bool                            gmux_off;

You can drop this.  Nothing about this is GMUX specific.

>
>         bool                            ucode_sysfs_en;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c1f196242..8185934b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -946,6 +946,11 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_devi=
ce *adev)
>         if (adev->no_hw_access)
>                 return true;
>
> +       if (unlikely(READ_ONCE(adev->gmux_off))) {
> +               WARN_RATELIMIT(1, "%s: register access while powered off =
by GMUX\n",
> +                                       dev_name(adev->dev));
> +               return true;
> +       }
>  #ifdef CONFIG_LOCKDEP
>         /*
>          * This is a bit complicated to understand, so worth a comment. W=
hat we assert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 5ad7b6dd8..135798c76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2932,6 +2932,9 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
>                 amdgpu_device_baco_enter(adev);
>         }
>
> +       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
> +               WRITE_ONCE(adev->gmux_off, true);
> +
>         dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
>
>         return 0;
> @@ -2960,6 +2963,8 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)
>         if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
>                 return -EINVAL;
>
> +       WRITE_ONCE(adev->gmux_off, false);
> +
>         /* Avoids registers access if device is physically gone */
>         if (!pci_device_is_present(adev->pdev))
>                 adev->no_hw_access =3D true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.c
> index 7468855c1..bb5dbeb7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -594,6 +594,9 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device =
*adev, u32 reg_addr)
>         void __iomem *pcie_data_offset;
>         u32 r;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -677,6 +680,12 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_devi=
ce *adev, u32 reg_addr)
>         void __iomem *pcie_data_offset;
>         u64 r;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;

Duplicate check here.

Alex

> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -706,6 +715,9 @@ u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_d=
evice *adev, u64 reg_addr)
>         void __iomem *pcie_data_offset;
>         u64 r;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>         if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offs=
et))
> @@ -762,6 +774,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device=
 *adev, u32 reg_addr,
>         void __iomem *pcie_index_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -784,6 +799,9 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_de=
vice *adev, u64 reg_addr,
>         void __iomem *pcie_index_hi_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>         if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offs=
et))
> @@ -832,6 +850,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devi=
ce *adev, u32 reg_addr,
>         void __iomem *pcie_index_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -861,6 +882,9 @@ void amdgpu_device_indirect_wreg64_ext(struct amdgpu_=
device *adev, u64 reg_addr,
>         void __iomem *pcie_index_hi_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>         if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offs=
et))
> --
> 2.55.0
>
