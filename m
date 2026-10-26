Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793039159;
	b=bSNOBTQkK4hoTW/a6BMuSwX6X56kg2/A+jncN8W/An2hOBss4CB4lEYqu83DkxwiEeJJ
	 hPEiO73/K4D/yRXRTlHUPqVJ/QB3Hs580SjplZuS/hBtcVkgBJxZ3+P11hW0VuHnyFJ3t
	 UJaD21wRJbA+ULWIp3QQPXoOOzHsCClbVC3hS7sfzkhWwn1hIwT/42MFDrn2jBsLi5rtT
	 5dXxL9VWoitgK9zJYcustmfsPzaoaj5E2nBcvoIXNeBwIpRzHs5SMMOcfi/cMPq4Qi8Ng
	 /iCeiusZyxhhM/NRHd0I0uOtU8sUjJuzXKzhKuFfqAHEabeSByIg6t35G9LowzZ6kaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Os8SsBDuhx8e1cUJ1s7YkJjosd5+qwq5mJVznKB4gFU=;
	b=cpK+MjJmzDdziJC1D+oJwJvcGHQZeFJPjADGX8KWWvNe+SZFIF5GmayvZLQiDLiS++QT
	 mEkIjmb8mdPfR/uNoR1gtRA/py3ASs1No7EAsDQJjiEp1So6ParYkfdtOEBD5q3hOyrfj
	 C582PUduLv/6Lm8YDYt9nMS0SxqReJfdUEzDKr/Rz4O+2pKxhU0Q6FEqwDhrOxbEh6RuN
	 QehnCAZ8ANFdNVtUy/R2dZcB/MW89tO5J50kskIvxjjxsJdo8TpL6Ojip9eoPkkfcKTF+
	 nshBrt2RyxV/kIMg+dpucKKLO1BXcEK0qD2ybSLBvd7nqCPW6ojLr1gPXTLTmv0NJfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lbwuRd+E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D699606A31E
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 18:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D699606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lbwuRd+E
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-34c522572bfso424437eec.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 11:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793039158; cv=none;
        d=google.com; s=arc-20260327;
        b=iX0vabvBkhOhn+i/mCMupr68vfwmhvncl3IS4FSL5w1hQ0Op4dryDnUzfbr0yUjmBi
         NT+GQbUjk2Eyh5C85JYwaCEVweZqW9iH/xA4I77xmcv64L/bauYg/6nGfCJsfxG+xa/c
         9tiJfyu93tbJAH68SCYUFpuW1DTPW4rGG+v5E+Vr4bk//IPpXMnpnPV7Qr/8dO1++vKb
         ZrhNzvKKlJSaKHhdjjp5OS5Nkcsl7A+NTFQaBnpeRSDMWhq59cMMGiHLQbNKe4IMOAIB
         IxdPgc+09KJu4NSZYoyEFLwOKkvmeGkkJ0zgPEUDpkQh04UVI8ZCK/7zfSIuNsnuZmEe
         eHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Os8SsBDuhx8e1cUJ1s7YkJjosd5+qwq5mJVznKB4gFU=;
        fh=4AY5Ytd6TIkUhtcaXs7cqqNv10T5VDwhjY14C/rIPsk=;
        b=J6he07N2BU2oEw4N7JUpga7mhNo9u65ZT4wStsrZ2bVxRikDuLN1nW4pV9YcvuSy8q
         KssRYm+r4Mz5v+aeuPLJOtSx7YyHaidzzmq0CE6/b1RfuBlmEbHyDpCnmy+0bna1ra7r
         TgFH50cZUlm8iqzj+Bs/vfc55e/uVgIsP1GGxv0A9KuKHz4pSh5BKAdecY7hVcJuGM9C
         pViV5JGAH+N3jcO9nenzA4fSGuB1e92GIIxr1irCaL9+Nin4gaupB5wJEBXtxiQ0ZsB8
         8z9xkTaoKpS/Pq2LFNtq6G0fDBkwZvX7VzmFf8aENkJDZRb8hgTmEbbDC6WHs7BWMPsN
         q80Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793039158; x=1793643958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Os8SsBDuhx8e1cUJ1s7YkJjosd5+qwq5mJVznKB4gFU=;
        b=lbwuRd+E6IGbpx/R//bHxBaxtTULqnLTEPOgtj435togavFrY7DCao9Jpf3oyDVxKs
         MWsaSaYk63yGIG6j0VdJu0kxsnNN4Dc/AaXIclthMFkzIiaMMkJys0fiym+KULMW9ZLP
         u6sTd9Hi8W9+KgPwgnfE4vns13wMC83wHX+XTYlLK5NHtQK4Dv3BRfQAAz6M4kWg7dl4
         N5BRqH9iTNUNz8KvsN5ogrYNYzeupCISH5cMfqCJmBmRRN4xFT15SOUTUVQC03TgU/ZA
         WsU5OxwXQlZqgPrSMVxeUFYmGw+Kew8yFQfCQYFTAQbnOytGQeRGW8ssvLoGRkIozqvh
         2fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039158; x=1793643958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Os8SsBDuhx8e1cUJ1s7YkJjosd5+qwq5mJVznKB4gFU=;
        b=ClRU9MI2zVOD3qyNwkEZi6sic2+PRG7/pvirTS6491sugJsWxogbhXFVayLnrelAPQ
         O4lpvGYC2RRU9qFfWe4AsX1NtW4nV8l0l/OpDnyQHn6kgCcOs4hClkXMTkC4klXunHId
         u0Rurp/akK55FQ+aCarZXGxAXDmihYHq8MUKTJ/wCdxxgcMisB2Mn2pQdJQ2C2gEiol9
         MdaYHG4hQ8ERpZEM93lMSBc+JsGAdh76JbsqM7GNRq+KNZmQEUawCoXfjuRJ5+oLbyyQ
         +uR8St6fs6xkFFdHgVd5sQ9DgeVCIkPChu8wxY3jMGqWQTVd9j04tXtXvI4rXf1jHTYK
         TIKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsv9atrlqpRb/N+yg0WRIzTB8SfRCb8ARKGiSxtfSOOwOSJie7vR16d89aH98/g1tzf1HXdecefHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJI5DghfVw0VKAwyVks7chR6DUtmy1H8X6l23koqxKi0/RUKY5
	ifDEo+KH7KZFuYVbuNTzfsGYhh9Tx/1QcjC6lauXDcVaCvXd5CIcAW+n+MREZm23uuIl2Cp2Fus
	E8vIhK/7kVb2A708kxD/wUen2rEBvZK8=
X-Gm-Gg: AYBFou2txgSDe6IFoRXSwuGWtQw66LqIhE2V8RmxevB31ixm++p0sRTgbAoDSCcJWDZ
	706kb4xuOfhtlF/tyOynTLYw0/NhVflm1VN6z6JqUr7woliEqvJQHPdR2QgAYjRoKI28FHK4zeI
	gxfIFpekaxKqEDUt2EPM59s3NKtJp8wG+2n+P/ZK7S6h6/VzmHMVQv3cdkUSGYZ5yMUq30nEW20
	zQn+krAup1Pq6+4RByUznHviURWmSGAttlLb8a6gjwDIkQuV3F+svITZDBJtJ67KyUB73QLcQwE
	2XMZagKB4/i/d6MNYPrtyZebltEBWPZL7SuAfesQ6D3QJN3HT6hfUToHC5aVibmoXCLvj1UQVaM
	wH8ts96O01xtrcdj/peIEhOIv8FiqZdpt56C4NmigfzhJUoOgy7T7VTmXcc5NBPIeLbHT3eDdzp
	Kxm0YUbOY1v7z4TVaKKuyP7W0=
X-Received: by 2002:a05:7023:a46:b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1991b9e5d7bmr16987682c88.0.1793039158092; Mon, 26 Oct 2026
 11:25:58 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com> <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:25:46 -0400
X-Gm-Features: AclHuK9L_P-9DUQQyVR1q5n6RC6VuTR2frqkgDd6R4nvp8sd0RT2y__G1BnjdtI
Message-ID: <CADnq5_PRG_O7jy9P+mf7AQLerpfz6up=BejRSPMgYDh9xigm=A@mail.gmail.com>
Subject: Re: [PATCH 11/13] drm/amd/display: Refuse DP AUX while GMUX keeps the
 GPU off
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

On Sun, Oct 25, 2026 at 12:11=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> From: Andre Eikmeyer <dev@deq.rocks>
>
> fwupd reads /dev/drm_dp_aux* while the GPU is runtime suspended. The AUX
> device holds no runtime PM reference, so the transfer touched registers o=
f
> the powered off GPU and caused a CPU CATTER.
>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7261317d4..b099bf520 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -24,6 +24,7 @@
>   *
>   */
>
> +#include <linux/pm_runtime.h>
>  #include <linux/vmalloc.h>
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/display/drm_dp_mst_helper.h>
> @@ -111,6 +112,20 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct d=
rm_dp_aux *aux,
>         if (WARN_ON(msg->size > 16))
>                 return -E2BIG;
>
> +       ddc =3D TO_DM_AUX(aux)->ddc_service;
> +       adev =3D ddc->ctx->driver_context;
> +
> +       /*
> +        * User space reaches this through the drm_dp_aux_dev character d=
evice
> +        * without a runtime PM reference. Refuse the transfer while GMUX=
 keeps
> +        * the GPU powered off, a register access then hangs the PEG link=
.
> +        */
> +       pm_runtime_get_noresume(adev->dev);
> +       if (READ_ONCE(adev->gmux_off)) {

Nothing about this needs to be GMUX specific.

Alex

> +               pm_runtime_put_noidle(adev->dev);
> +               return -EBUSY;
> +       }
> +
>         payload.address =3D msg->address;
>         payload.data =3D msg->buffer;
>         payload.length =3D msg->size;
> @@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct =
drm_dp_aux *aux,
>         result =3D dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, =
&payload,
>                                       &operation_result);
>
> +       pm_runtime_put_autosuspend(adev->dev);
> +
>         /*
>          * w/a on certain intel platform where hpd is unexpected to pull =
low during
>          * 1st sideband message transaction by return AUX_RET_ERROR_HPD_D=
ISCON
>          * aux transaction is succuess in such case, therefore bypass the=
 error
>          */
> -       ddc =3D TO_DM_AUX(aux)->ddc_service;
> -       adev =3D ddc->ctx->driver_context;
>         if (adev->dm.aux_hpd_discon_quirk) {
>                 if (msg->address =3D=3D DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
>                         operation_result =3D=3D AUX_RET_ERROR_HPD_DISCON)=
 {
> --
> 2.55.0
>
