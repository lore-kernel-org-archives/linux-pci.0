Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259922B2D7;
	Mon,  3 Aug 2026 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782435; cv=none; b=AQ/cdGuy6SwHmXpLjGviEP+nkCp7J1E7oq3T+i85+raoRus+DQJBipk20tNkEHw8xrHU13B4zEcnTrOHG1gfIEw9rU7bkl2YhQJ2LOilYiHlxcOXLe6KrGP22YZIRh/HRa1a75oJjF/2QKMh91HQgsQaCRVVlKKjNYR6YGHrnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782435; c=relaxed/simple;
	bh=0gpOZWHP4F0HVpo5rQZkr+uVUP38Ex4nrU+SWhJex3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QGQcnGXwWHB7XY/HMmkxobVlZeKGxjCnYca/mt47FPxxvy+0fMNbZ04+HKrYIcKIpis+Y5zyxex1EW6bhf5fBSzDYZgX8YHs01PDLES7z+WdnjhoQvdLolASmTwyUlFd+R2VdvBrLunSfMibDcuM+9N3CadSIABTaTRH5l4Z+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyJmFWjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyJmFWjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA491F00A3A;
	Mon,  3 Aug 2026 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782433;
	bh=Z6fK3qH9IMOhF2jV5AdZp39gMOkB9CyNH5IS93iiNr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TyJmFWjr/6mmo+8ki1rAHBfDYhT6L/gYT3wuSLL1x4YiqBNK+ddOf9OPzgXebqMN9
	 /vUMCJoB7/Of6dixC6da5wBnRnqzxRh/O/dtRuibJVhZk9uNkFr0SlqwsUsinnwHAn
	 e9F/Kezp5fQSnI55z24syuRaW5wp7rollqKQLRHTuRKfpYg9CWDgUcYQSUnbReeBMr
	 v+ies3YwG55ni1tCey94jWmsOyOgi0guT3uhfauHxuFrnPAg8Uym92U4VzDt2Pi6xj
	 otHkbJPiS/GIQQ3r8hj8GPU5g4uzdtWhTDqswWcYhuIo44bMXALuxYzZV/tNcqFbpd
	 6B9R/uDHW4ZEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] PCI: endpoint: pci-epf-vntb: Expose packed MWs
 through configfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260803180439.1963864-12-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:40:32 +0000
Message-Id: <20260803184033.3AA491F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] vntb_epf_mw_set_trans() does not reject calls when packed_mws is e=
nabled, allowing legacy NTB clients to corrupt the shared BAR configuration.
- [Medium] Data race on `ntb->packed_mws` in configfs `show` methods can le=
ad to theoretical divide-by-zero.
- [Low] Using native division and modulo operators on a 64-bit integer will=
 cause a link-time error on 32-bit architectures.

Pre-existing issues:
- [High] The loop initializing optional BARs incorrectly starts at BAR_MW1 =
instead of BAR_MW2, leaving BAR_MW4 uninitialized when num_mws is 4.
--

--- Patch [11]: [PATCH 11/11] PCI: endpoint: pci-epf-vntb: Expose packed MW=
s through configfs ---
commit ff5e63e72a02a10c0fca1af20a09901153b50a18
Author: Koichiro Den <den@valinux.co.jp>
PCI: endpoint: pci-epf-vntb: Expose packed MWs through configfs

This patch adds support for exposing packed memory windows via configfs,
enabling up to 16 logical memory windows when packing is selected. It
utilizes mw1 as the aggregate BAR size and restricts other window sizes
and BAR attributes when packing is active.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -1295,6 +1295,7 @@ static ssize_t epf_ntb_##_name##_show(struct config=
_item *item,		\
>  	struct config_group *group =3D to_config_group(item);		\
>  	struct epf_ntb *ntb =3D to_epf_ntb(group);			\
>  	struct device *dev =3D &ntb->epf->dev;				\
> +	u32 packed_mws;							\
>  	int win_no, idx;						\
>  									\
>  	if (sscanf(#_name, "mw%d", &win_no) !=3D 1)			\
> @@ -1306,6 +1307,14 @@ static ssize_t epf_ntb_##_name##_show(struct confi=
g_item *item,		\
>  			win_no, ntb->num_mws);				\
>  		return -ERANGE;						\
>  	}								\
> +	packed_mws =3D ntb->packed_mws;					\
> +	if (packed_mws && idx > 0) {					\
> +		u64 size =3D ntb->mws_size[0];				\
> +									\
> +		if (size % packed_mws)					\
> +			return -EINVAL;					\
> +		return sprintf(page, "%llu\n", size / packed_mws);	\

[Severity: Medium]
Could the compiler re-fetch ntb->packed_mws from memory during the modulo
or division operations? If a concurrent configfs thread writes 0 to
packed_mws between the initial check and the division, might this result in
a divide-by-zero exception? Would using READ_ONCE() here be appropriate?

[Severity: Low]
Does using the native modulo and division operators on a 64-bit integer
(size) and a 32-bit integer (packed_mws) cause a link-time error on 32-bit
architectures due to missing symbols? Should this use div64_u64() or
do_div() instead? This same pattern also appears to be present in
epf_ntb_build_mw_layout().

> +	}								\
>  	idx =3D array_index_nospec(idx, ntb->num_mws);			\
>  	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
>  }

[ ... ]

> @@ -1400,6 +1417,44 @@ static ssize_t epf_ntb_num_mws_store(struct config=
_item *item,
>  	return len;
>  }
> =20
> +static ssize_t epf_ntb_packed_mws_store(struct config_item *item,
> +					const char *page, size_t len)
> +{
> +	struct config_group *group =3D to_config_group(item);
> +	struct epf_ntb *ntb =3D to_epf_ntb(group);
> +	u32 val;
> +	int ret;
> +	int i;
> +
> +	if (epf_ntb_epc_attached(ntb))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D kstrtou32(page, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > EPF_NTB_MAX_MW ||
> +	    (val && (val < 2 || !is_power_of_2(val))))
> +		return -EINVAL;
> +
> +	if (val && ntb->num_mws && val !=3D ntb->num_mws)
> +		return -EINVAL;
> +
> +	if (val) {
> +		for (i =3D 1; i < MAX_MW; i++)
> +			if (ntb->mws_size[i])
> +				return -EINVAL;
> +
> +		for (i =3D BAR_MW2; i <=3D BAR_MW4; i++)
> +			if (ntb->epf_ntb_bar[i] !=3D NO_BAR)
> +				return -EINVAL;
> +	}
> +
> +	ntb->packed_mws =3D val;
> +
> +	return len;
> +}

[Severity: High]
When packed_mws is enabled, multiple logical memory windows share a single
physical PCI BAR. Does vntb_epf_mw_set_trans() need a check to reject calls
if packed_mws is set? If a legacy NTB client driver calls
vntb_epf_mw_set_trans(), could it overwrite the shared epf_bar->size with a
smaller logical window size and reconfigure the physical BAR, breaking the
configuration for all shared windows?

[Severity: High]
This is a pre-existing issue, but there appears to be a logic error in
epf_ntb_init_epc_bar(). The automatic BAR assignment loop for optional
memory windows starts iterating from BAR_MW1 with i=3D1 instead of BAR_MW2:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_init_epc_bar() {
    ...
    for (bar =3D BAR_MW1, i =3D 1;
         i < num_mws && bar <=3D BAR_MW4; bar++, i++) {
        barno =3D epf_ntb_find_bar(ntb, epc_features, bar, barno);
    ...
}

Since BAR_MW1 was already assigned earlier in the function, this redundant
check consumes an iteration. When num_mws is 4, doesn't the loop terminate
when bar reaches BAR_MW3, leaving BAR_MW4 uninitialized and causing
automatic BAR assignment to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D11
