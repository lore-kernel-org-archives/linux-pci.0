Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6C2DB7BF;
	Sat, 30 May 2026 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101964; cv=none; b=EbrQxqUHlgX+PVreew3Ba7fZ6VV5gwJRLiLujbZAx629bxfV7exNbh4bWZI3NVDIp/5BtsurSJip+SyuqPblEowomxkCJmmOdBXm3rYam7JdetcA1orfS0EQhN3UlFaos9lQHUyBOyoBwBtPRRI7g2HApZKXPEZl+lY7QPEDeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101964; c=relaxed/simple;
	bh=K0+J+UcsLatDZgMrzII2EndHog2w4aS02JUTm38DK/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQ7oJiPUI/zKM3sf56numfew1j/5aCIUkL2QNebKM+4Zn3R/T4eYVkGfcAPlVMr2rENu6Hh0WVi3c5pfRA5iPA5Qwqz5mUt41dLu0eyCC2cC3Ty4YT2K8fXqTl6tlVrMGlP5m5FCRKm9HrWznjQhdlhQe14k9nO0GPX1bpqCPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRAtuKuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRAtuKuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F6D1F00893;
	Sat, 30 May 2026 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101961;
	bh=tgcInZqyhkkP4msOEISdWXRIsJwIfldxBc7ekr2WWpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRAtuKuEXgLh/hjMC8cC8ApyruWRCX+1Xaa2KU0mjtakH9Fc6EJ7z6djMhhKbT1id
	 hYgRP6SmITSVyy7tgVUaO0XX0vsLDrqJv5/CZKdtzjL8UsoNnmz6Ze6+Fp5lSzgulg
	 f2x4HI7FfZfjSLSlcBgGWTe92YmJv/P8a5D5krnS9gYZsXh0bT08Vj2RrM1MpHzlPr
	 epkRIVdaEHWOpnMzQ9EO+BV97V39EFjbd26woMtDBwdXFm/882cz4N144+QnMzVLJU
	 /fjjq2BpVN8BCU5/DR6tgnXPpbnFy8DX8IdbR2T7M+nXEGvtZJuxWj5W3pC5Ybjala
	 rv+YiqJ6zq1yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] moduleparam: Drop legacy kernel_param_ops
 .get_str field and dispatch logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, kvm@vger.kernel.org, linux-modules@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, linux-media@vger.kernel.org
In-Reply-To: <20260521133326.2465264-11-kees@kernel.org>
References: <20260521133326.2465264-11-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:46:01 +0000
Message-Id: <20260530004601.82F6D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional call to `arr->ops->get()` without a NULL check can c=
ause a kernel panic if the array parameter element lacks a `.get` callback.
--

commit a252ae87a187a5b644d160fded352c545493a611
Author: Kees Cook <kees@kernel.org>

moduleparam: Drop legacy kernel_param_ops .get_str field and dispatch logic

All struct kernel_param_ops .get callbacks have been migrated to using
struct seq_buf. Drop the migration scaffolding.

> diff --git a/kernel/params.c b/kernel/params.c
> index 25f0c8d5d19f3..6b410189297b1 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
[ ... ]
> @@ -470,23 +469,9 @@ static int param_array_get(struct seq_buf *s, const =
struct kernel_param *kp)
>  		p.arg =3D arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> =20
> -		if (arr->ops->get) {
> -			ret =3D arr->ops->get(s, &p);
> -			if (ret < 0)
> -				goto out;
> -		} else {
[ ... ]
> -		}
> +		ret =3D arr->ops->get(s, &p);

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditional call=
 to
arr->ops->get() need a NULL check to avoid a kernel panic?

If a module defines a write-only array parameter where the element's
kernel_param_ops struct lacks a .get callback, and assigns it write-only sy=
sfs
permissions, root can still attempt to read the file. When this happens, sy=
sfs
invokes param_attr_show().

For normal parameters, param_attr_show() has a safety check that rejects the
read if ops->get is NULL. However, for array parameters, ops resolves to
param_array_ops which has a valid .get callback, bypassing the safeguard.

Could this result in a NULL pointer dereference when arr->ops->get(s, &p) is
executed? Before this patch, the code fell back to calling .get_str(), which
would also be NULL for a write-only type, resulting in the same kernel pani=
c.

> +		if (ret < 0)
> +			return ret;
> =20
>  		/* Nothing got written (e.g. overflow) =E2=80=94 stop. */
>  		if (s->len =3D=3D before)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521133315.work=
.845-kees@kernel.org?part=3D11
