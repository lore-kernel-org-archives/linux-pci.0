Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19A63B9;
	Thu,  2 Jul 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007912; cv=none; b=Fb6RvcBQqOtOkhhCXc+V7rQwyikEbpNHKrPsre4ARQ4/MhgaPzms6zYlVpwzzQbL47NKYhlRmFU8gEA9n0hOK3ZroFWlrWhCOrYBQ6IKRb47+l7l18xos87D4cKchiO9wynb4tF0alssl/dLA1krLAARJubpditRz+z+aYOI7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007912; c=relaxed/simple;
	bh=4GWxQeSeQ3FVPFwWmurWSfrNSGYafkI338Ksuom7YCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xh3Dh6jZpRa+wkR4Jvzz7TRW8AsYB5lXrCLhP9K3EenEClag8muV7X90DBmP99HclIu/LjqmH5rGToznNK9Vr93yMppfXKrBKn/uQV/3JaLhnviv25B6BXSFHX098PFOu0sjK8qta0c3LlJMWh4icWndek7hR7aJpEEqwKPRqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR/lwDvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR/lwDvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5FC1F000E9;
	Thu,  2 Jul 2026 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007911;
	bh=G1e7Ebgdly0AWGcesK5Bmyv5pIn6QOiASaDaQwBAU1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bR/lwDvCMp3HKrPYvzG3wWWcS0Ao87a6ufVCjIlWzZoWiesYqQqBkcaZTUNHFl4FM
	 C5mzQbFdPz0NI0Pszz5HprONm4IdtV1AhF1XSuRyDZfkErAoUarnGfBgWEEAvpR0M6
	 uzKBqylcwj9oCBD9jaWi6ZNNeRwfPSJxgcRNVffkY+lm/DOSs3jprD69Sra/Nv4NL1
	 x/wZDrU8/JrqoolTdd2O6p/yfWj6xM23iqzd0Rd+HuugWyLel6zZHyRnGA+t6Lnp0H
	 YE1sIoWJ3kJ3ydDh0XX5BxFR9fPqJyL7ZB4AUes/n56NxQrzIqXSyVbZW7KXRfigdg
	 1O8zlr6ifIJdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] lib/bitmap-str: get rid of
 cpumap_print_to_pagebuf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-cxl@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702154725.185376-12-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-12-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:58:30 +0000
Message-Id: <20260702155830.EE5FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `cpumap_print_to_pagebuf()` is deleted but still calle=
d in `drivers/firmware/psci/psci_checker.c`, causing a build failure for AR=
M configurations.
--

commit 905d23faa26c3dcaccb88eda3b8626258147c495
Author: Yury Norov <ynorov@nvidia.com>

lib/bitmap-str: get rid of cpumap_print_to_pagebuf()

This commit removes cpumap_print_to_pagebuf(), stating that all users of the
function have been switched to alternatives.

> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h

[ ... ]

> @@ -1315,24 +1314,6 @@ static __always_inline bool cpu_dying(unsigned int=
 cpu)
>  }
>  #endif /* NR_CPUS > BITS_PER_LONG */
> =20
> -/**
> - * cpumap_print_to_pagebuf  - copies the cpumask into the buffer either
> - *	as comma-separated list of cpus or hex values of cpumask
> - * @list: indicates whether the cpumap must be list
> - * @mask: the cpumask to copy
> - * @buf: the buffer to copy into
> - *
> - * Return: the length of the (null-terminated) @buf string, zero if
> - * nothing is copied.
> - */
> -static __always_inline ssize_t
> -cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
> -{

[Severity: Low]
Will this removal cause a build break for ARM configurations?

It appears there is still at least one remaining caller of this function
that was not migrated in drivers/firmware/psci/psci_checker.c:

drivers/firmware/psci/psci_checker.c:hotplug_tests() {
    ...
        ssize_t len =3D cpumap_print_to_pagebuf(true, page_buf,
                                              cpu_groups[i]);
    ...
}

Does this remaining callsite need to be updated to an alternative before
dropping the function?

> -	/* Opencode offset_in_page(buf) to not include linux/mm.h */
> -	return scnprintf(buf, PAGE_SIZE - ((unsigned long)buf & ~PAGE_MASK),
> -			 list ? "%*pbl\n" : "%*pb\n", cpumask_pr_args(mask));
> -}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D11
