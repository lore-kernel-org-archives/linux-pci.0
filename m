Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAD3E5A32
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433813; cv=none; b=u5YK96ssZSq4Ynk6iI8O82FEbsA8IRuAkeVQ5PUWc0R9L3EIFoosjcK2gTFl91Lv/8zWx0Qhx2PeAkkUNo/jsmbsz2w1tq5pJswlxU/ZSSvU0NGq0JnUF5wac0x5gBgxIdw7zregdqDb5aKDM8SOb5QzKWlm/nA8Bm+93Fvg+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433813; c=relaxed/simple;
	bh=XC0bmEWqHBXfTfVWNm21RU5X+3Mg91TpJAaeJ+G0Yo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnzc+hzbtwZkJyXDx0i4zN+eOnnMxjbQmqkzHS0Ay5zQkHZEQEdGQMPJ2efro2u4OGGUKpCggQYs5Tizt6zZZGPLdQYTeM2A6utVQhgfmrtSRZ5juLmb+nb+IeQbNOSOfnqyiCclSav+jybdHUm151RqZi6Lrhq9cVXHwbanXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Yog0Kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Yog0Kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9601F000E9;
	Tue,  7 Jul 2026 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433812;
	bh=pH0CDHWukcR46RZZUWqkyXlFn/yl/BJ6/GQ8q/mr2zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4Yog0KxUO+2/E52XhBLBfFHisDvqmTWmnEwFHofYhxTEmIZHB+O+Z6Y99NdJBihT
	 3sjin+erVc/I0z0cSwutvqDhApmm/TcTnzPJ6LzejjL11AmgX8uZlSPCm9IqSjzxz4
	 uo3l3hnMxLqlZCKGxbfc16NqbD6j+N1IpUI7P3A2OF3Wus9IQVHIw8H7Jd2QvTMOU9
	 Z7FL3qTxvbdJd2lB/qCLl/aCjQqd4qWTbNmbDiZOsxnvs6d19FqXFt7ew2nyyNjpd3
	 Jwjr3l2pnQESoycCdAL46ts0PrdOtDB5KkbznHgz+aVocdDQ1+qxFaCiKhUd8gcibi
	 z6pSpTnaEaEpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware
 error tracking out of vmcoreinfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
References: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:16:51 +0000
Message-Id: <20260707141651.ED9601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The official documentation for hardware recoverable error tracking =
was not updated to reflect the new configuration gate and conceptual locati=
on.

Pre-existing issues:
- [High] Calling ktime_get_real_seconds() from NMI context causes a permane=
nt seqcount deadlock on 32-bit platforms.
--

--- Patch [1]: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware e=
rror tracking out of vmcoreinfo ---
commit 1752de8824c67025df12b2ca7f3f5aa9d829d649
Author: Breno Leitao <leitao@debian.org>

RAS: hwerr_tracking: move recoverable hardware error tracking out of vmcore=
info

This patch moves recoverable hardware error tracking out of vmcoreinfo
and into a dedicated RAS tracking file. It introduces CONFIG_RAS_HWERR
to allow independent configuration and updates included paths for callers.

Link: https://lore.kernel.org/all/aYvi4Y_HNqk_u1-v@fedora/ [1]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15011f5752a99..eee6072dc28f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22536,6 +22536,13 @@ L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/ras/amd/fmpm.c
> =20
> +RAS RECOVERABLE HARDWARE ERROR TRACKING
> +M:	Breno Leitao <leitao@kernel.org>
> +L:	linux-edac@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/driver-api/hw-recoverable-errors.rst

[Severity: Low]
Does this patch miss updating the documentation?=20

The commit moves the configuration gate from CONFIG_VMCORE_INFO to a new
dedicated CONFIG_RAS_HWERR, and extracts the feature from vmcoreinfo.
However, Documentation/driver-api/hw-recoverable-errors.rst is not updated
in this patch to reflect the new Kconfig dependencies and conceptual
location.

[ ... ]

> diff --git a/drivers/ras/hwerr_tracking.c b/drivers/ras/hwerr_tracking.c
> new file mode 100644
> index 0000000000000..847c01fb24d55
> --- /dev/null
> +++ b/drivers/ras/hwerr_tracking.c
> @@ -0,0 +1,35 @@
[ ... ]
> +void hwerr_log_error_type(enum hwerr_error_type src)
> +{
> +	if (src < 0 || src >=3D HWERR_RECOV_MAX)
> +		return;
> +
> +	atomic_inc(&hwerr_data[src].count);
> +	WRITE_ONCE(hwerr_data[src].timestamp, ktime_get_real_seconds());

[Severity: High]
This is a pre-existing issue, but can calling ktime_get_real_seconds() from
an NMI context cause a permanent seqcount deadlock on 32-bit platforms?

If a hardware error triggers an NMI (such as x86 Machine Check or APEI
GHES), hwerr_log_error_type() is called to record the error. On 32-bit
architectures, reading the 64-bit time requires a seqcount retry loop:

kernel/time/timekeeping.c:ktime_get_real_seconds() {
    ...
    do {
        seq =3D read_seqcount_begin(&tk_core.seq);
        seconds =3D tk->xtime_sec;
    } while (read_seqcount_retry(&tk_core.seq, seq));
    ...
}

If the NMI interrupts a timekeeping update on the exact same CPU, the
sequence counter is odd, and the read side will spin indefinitely waiting
for it to become even. Since the interrupted writer is preempted on the same
CPU, it can never progress, resulting in a hard deadlock.

Would it be safer to use an NMI-safe API such as ktime_get_real_fast_ns()
to prevent a recoverable error from causing a system freeze?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-hwerr-ras-=
v1-1-4aea4a79d085@debian.org?part=3D1
