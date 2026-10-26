Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793038702;
	b=Hqun6zk8komLuslpji9u2wul7MyGtBBgd6B7s2Wx6D1cVnbH1PiB1lOhUbii5q0bMcG6
	 2IttrRj/KsXstFj7csIP50k6PkQA2bxjj/l3gMg+lKWRfX5QUDW2dr9TxdPv+Yp3Qf/2z
	 LU5V11+U0azMs7Ujj2ZHhYZZv8ljG+5q1cER8KKXxZo887AYmAeu1JL8NH4Uu1L2paMF3
	 SL1oinfZZZglct5MppQHWLHEy8LBVHSD8RpT1dSb5GralN2Ali8Y479GO2cxI0kY2AGOl
	 Tr2ttFSrZ6j1XpAg2QoE7Vkzwx4xBu+gffH5K2Buuk1lZAn2d7/c8aMO0PN8Gk0o8vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
	b=fN9Ts+GdHCgVNJpgskmJ+QOMKErlDUs+zetORTqdVF8g7qACH0MoIDiM3tfMncL/lQmm
	 nJ0ZRTHMdgLPPew4gzrowbWlYfQuh9NZadgza8GO1Iho3wRC62AYz4XOegMDvBpibqnTt
	 l9Mh5sQSCHCi34YstN7cPCfs+LfWqmhHA/thlKsBFfXAK/JCVgDyDIkNg6/5IMPuuLN31
	 XMIB2f5Ce0O1sLPK3MlEIwMJgBc8pzGSCM5rnb8QBaWXCSybjqsSJ9+6QQbKSmQV6Sa9d
	 QrlXQbspJh4kzXgMDTyCSXilcsedaKLA4g0QvWBUjwtP1kU3AqU1EgT9HqFQlhCec8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fYOX5pph;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B3606A31E
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 18:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fYOX5pph
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1438dbb05c1so180799c88.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 11:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793038701; cv=none;
        d=google.com; s=arc-20260327;
        b=JKvkB+2jdVaibRM2Vsgt5eJbyRFzltSw4LtsHCHq/qN2xzGNoWWuu1DZxFThJCbghv
         rUBzCeNlnFMiYrc9NYwheQuYX3fo4124qUB3qPcCt8/I5WLb62NQMoo5fguJwtp0MAIS
         QSwYMTq2kTKA8Sl6BvgD7OdutePCEC5D+7wlzIjsUjYlsGBUpmUh2uQgYwFT+6ky/84B
         jqIvpMaSKvYXt24IF6PtofX6m9mOTsuBeCUJkruTGEpPVJ2edPL2oBZZt+V8bHgiE/eA
         sjjKcPHyXrNBPh3pq0yGr01S5p/QbAN611GKdplhzwLw3p0VvZObSpjKgN48x2LsugDT
         JC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
        fh=ZJt8z809uxMgdm+sBP4cN6f5mYUTTfrPtaaf0F0kdhk=;
        b=LIVNyeTdji9zb0YZyCSHE+8RCbt4pca0fiffH9ZJ4x7jDdd/o6K0DEEcbcq1bb07c/
         l/mMr87s5jROXhUzFFuZ+FRBCAkF6P2/R45S3CsM4bdlmRSfhr8nuW6Duqyjr3/1JwbA
         GnAVOj1vqJYtn+kxDbWwYCDHe4kuYj6M05V59Tmfdm1ONFJjn3DO4+Vj9w+Ps3JkrU3q
         TPius6nT5AbSbun5IBHPo6g4lATAok+bm4ngHRSjGYqHtzoIL2zj0e32mAkMxKoicDuB
         CpymEaPVNPeJXgDZW9ybz+EARDIt0ubvPTIZQRhE5rYTBbyaaxwTQINYfjxJI2KqzblY
         DSwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038701; x=1793643501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
        b=fYOX5pphsGY/+i/Iy06yAJ16VPzT/i1wL+b30sH0lJqe8b5j0u4TWNje0SRlBJbpNd
         xVPxwEFG9gpIg7TXVB3JP/JIAyAYhYLwAH7rrfT9LYFSLkGi3RYylySiYPLv/ukn3+Ly
         JyseKMEDyDuVup5co5JLXOoLtQQU5jiH+mNAEf6A9yIusnp+kdQvXSAZP8VLEHU76Pow
         51SR089jLzIU4p3Jzib0uunNja3tletM5zojusi7gTZBYNg7T0rv6mVO2U2wp/P0/C8N
         6v2SiKCeY6alA0+WUBcAMtxszynbgR9tww5BjynoDnP1oyhIwpO1dCic4ze44VzEHFvv
         uBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038701; x=1793643501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
        b=h9V/dm+ggfZKr4/3hgmp7/1bkcJgmDwW2NLhU2yNRiES+RPeVlN6hxEp5an23o49zu
         tmmrVcRhaiSpZ+moG4jFmH+geo1Lq86spKhVARsPxWLxL0Pj6vhwG6QQXHZ5dy7uxDSi
         KzvXporlbLVYHlF07+sD7Aun3HCv/fCBcrYJuVjud0sVLGLWWq04rLW/r6lxu0/wOi/K
         5WfT5Wh+el4E1sbl3kNhz3ZpRvn6Qf6RmIwkJZcedV5BpNqEcn5+4PQwnYln34vwqqqU
         JJkThV/RnidL0I0q67gx7IY5KqxET/Q+jQG+wACtV/dTlFYx7vWomeSm7HZt1ddFqsXy
         0EeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHlTt9EH0xvm8VeSQq+TLdyokTdQ5Bod8b2/jzypg0ZE3ru7UDqNU6oYLu6na4JeDkWyeQv6x/zLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqtNfsBSxF6d/Ubp6UNdtgKja2k104u8OrsOvRfUkZh7hLw1Lv
	uykaxuo9y3UWnCOw+U05e09s8MR3CwlYNYTYHagcLAPajCK+eGSob0i9+VbvijimOk66YkQHAL8
	/NFCl4E+DNEx6SLZomnKLTR3CWR8SkZM=
X-Gm-Gg: AYBFou2pnmZEGbLVggfuAlO9GHOF7j20t2jbBrH+4EggT6JN2dxu3s7fgCJjuj2KK2e
	FaEc/JXOtz9w7QKpued1ibON8vgUCNSaw4/HU1bdNA/QV1LhB9VBYAzQzZae6cs+3hzZaY5WK35
	gxFyQp+u4bKWI23UKBGcv9jcAwTgkkZn4L0GgiZ45/U8kmtWYyVfoE9ME/SZfyVEyU2uqJdaePa
	r69VcI0JleoKRsd/8xSyl7Es3CLbEAdJG/rMr/98PaNZbjUsavAEu2gOs/msPUx5eAwK4qRTTe3
	u6jO046mFNd8LRLag6E5WcYieUZKjeFTkq+K01MEzP3iOcCE0jNqgo9WWXMwzwp3bCvxZTdUOK/
	gXan85Di74hbucsCSAzKNL2uZFZdDWOZeTl7n16N8wRA4jZ4mqQxPVV372OUYA3bLE3jVJ8VfVc
	M3C/0DMiBAAL/LawB6j0meodw=
X-Received: by 2002:a05:7022:5f07:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1993639e5f7mr16191284c88.1.1793038700920; Mon, 26 Oct 2026
 11:18:20 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com> <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:18:09 -0400
X-Gm-Features: AclHuK_gGXqjT0cI7KV7tvEEJQhRHXFUqhLnyaELH9XqFgMeuwm1bkZPQKcDe-s
Message-ID: <CADnq5_NLhN4TKH-afTtJdF2d-e0=1kysf=pWiUpXu+bLhJFEeQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] drm/amdgpu: Skip AC/DC notification while the GPU
 is runtime suspended
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
> Plugging or unplugging the charger raises an ACPI AC event. The handler
> sent the new power source to the SMU without a runtime PM reference, so
> with GMUX keeping the GPU off every SMU message spun on skipped register
> reads for seconds. A runtime resume racing with that left the SMU
> firmware unable to start on MacBookPro15,1 and the GPU in runtime PM
> error state. Record the power source only and let the resume apply it.
>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 808be6c42..b64f0b681 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -30,6 +30,7 @@
>  #include "amd_pcie.h"
>  #include "amdgpu_display.h"
>  #include "hwmgr.h"
> +#include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
>  #include "amdgpu_smu.h"
>
> @@ -498,20 +499,26 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_dev=
ice *adev,
>
>  void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>  {
> +       int active =3D 0;
> +
>         if (adev->pm.dpm_enabled) {
>                 mutex_lock(&adev->pm.mutex);
> +               active =3D adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX ?
> +                               pm_runtime_get_if_active(adev->dev) : 1;

There's no reason this needs to be GMUX only.  You can drop the
AMDGPU_RUNPM_GMUX check here.

Alex

> +
>                 if (power_supply_is_system_supplied() > 0)
>                         adev->pm.ac_power =3D true;
>                 else
>                         adev->pm.ac_power =3D false;
>
> -               if (adev->powerplay.pp_funcs &&
> -                   adev->powerplay.pp_funcs->notify_ac_dc)
> -                       amdgpu_dpm_notify_ac_dc(adev);
> -
> -               if (is_support_sw_smu(adev))
> -                       smu_set_ac_dc(adev->powerplay.pp_handle, true);
> +               if (active) {
> +                       if (adev->powerplay.pp_funcs &&
> +                           adev->powerplay.pp_funcs->notify_ac_dc)
> +                               amdgpu_dpm_notify_ac_dc(adev);
>
> +                       if (is_support_sw_smu(adev))
> +                               smu_set_ac_dc(adev->powerplay.pp_handle, =
true);
> +               }
>                 mutex_unlock(&adev->pm.mutex);
>         }
>  }
> --
> 2.55.0
>
