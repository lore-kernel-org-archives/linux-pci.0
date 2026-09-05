Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221D2E7BD6;
	Sat,  5 Sep 2026 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612135; cv=none; b=AHTKBM6cqnQ2MkIWQ4y/u0JNpRhqfDjn4bJJsQeeM+NH3LLXDqmUt/Mdx6XEaWsJjX3NRrHFTH2AwuXk6SFJhVykWX8LTwZXDrqBUoJyrrcdM1cZU3RTZxhwtLii0yXnS+OQS566L6NDuw+TBaAn9AsVRj7Gg5b1YXLZYkzTWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612135; c=relaxed/simple;
	bh=6g4N7ZWYpHeM2bDF+cbgZum7pz0WkkYOOWN7e1zATJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jIN2TzSQ9304wR29TiYP4bEza5VgbCxZItTsX3426gi2Y1HWH46HzLlznwENXgvAIo0BB863s3/Z5ieFdMyjB8t13UG7BD6dg/VT7aVEaoeDZ1AY+AxrfVRj4L/G5Uek9lTCJ+pabBUKz6mI2LjAjq5aavsijdTiyFdTE9koOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI0bl9jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI0bl9jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010D81F00A3D;
	Sat,  5 Sep 2026 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788612134;
	bh=tO5OseRptbV49LjJbJjeU0zXCobceuFU31HSM8yp0F0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nI0bl9jgobSbcDs5SR3BhT3f/PdlJnHqC2Din6WHVCSip1Xqn3EDgW0NNNB3CB8B2
	 P/o+FwYp8TAsdaLi4OTZbuVHOPIrNXvUBB7vb50hRm2EGCqb2cV6Gw6VfpyQyknatu
	 JMSUTPFrvFbuvVoPywoet7ACXQ4yrX66jdyGbgUnYx7jaR/mxXjiMVDnSuIoUzZeLd
	 qe2JC3tQWi7/+G0I0WE9JPoNTTY17LQmU1igHAKosdIeG3ONuZajMFliPz3i9Fox/n
	 73VYiNx9e8zOnax8L5YYSdg7h3Ji53UvdU7+3B5lCD3QkVXsV9FO8vcSorjnMEYMFS
	 iHYM1VSdTf4ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] media: dvb-core: remove defective and unsafe ULE
 debug block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com, linux-pci@vger.kernel.org, media-ci@linuxtv.org, linux-input@vger.kernel.org
In-Reply-To: <20260905123450.5620-3-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
 <20260905123450.5620-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:42:13 +0000
Message-Id: <20260905124214.010D81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch claims to completely purge the unmaintained DVB_ULE_=
DEBUG code block due to severe lockless race conditions and buffer overflow=
 vulnerabilities. Instead, it only renames the macro to `CONFIG_DVB_ULE_DEB=
UG`. This effectively connects the previously dormant code to the Kconfig b=
uild system, enabling the compilation of the vulnerable code and exposing t=
he kernel to the exact vulnerabilities the patch claimed to mitigate.
--

commit dbd3a4787c312d697a3d80cb3e2c0e2207187d0b
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

media: dvb-core: remove defective and unsafe ULE debug block

Completely purge the unmaintained DVB_ULE_DEBUG code block from dvb_net.c
due to severe lockless race conditions and buffer overflow vulnerabilities
on global network state variables.

>     media: dvb-core: remove defective and unsafe ULE debug block
>    =20
>     Completely purge the unmaintained DVB_ULE_DEBUG code block from
>     dvb_net.c due to severe lockless race conditions and buffer overflow
>     vulnerabilities on global network state variables.

[Severity: Critical]
Does this patch actually purge the code block as stated in the commit
message? It appears the patch merely renames the macro to match the Kconfig
build system, which actively enables compiling the exact vulnerable code it
claims to mitigate.

> diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dv=
b_net.c
> index a2159b2bc1766..3b503695e3b64 100644
> --- a/drivers/media/dvb-core/dvb_net.c
> +++ b/drivers/media/dvb-core/dvb_net.c
[ ... ]
> @@ -320,7 +320,7 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule=
_handle *h)
>  {
>  	/* We are about to process a new TS cell. */
> =20
> -#ifdef DVB_ULE_DEBUG
> +#ifdef CONFIG_DVB_ULE_DEBUG
>  	if (ule_where >=3D &ule_hist[100*TS_SZ])
>  		ule_where =3D ule_hist;
>  	memcpy(ule_where, h->ts, TS_SZ);

[Severity: Critical]
If compiled with CONFIG_DVB_ULE_DEBUG=3Dy, will multiple concurrent threads
processing TS streams via dvb_net_ule_new_ts_cell() race on the ule_where
pointer?=20

Since there is no synchronization, could multiple threads bypass the bounds
check and cause an out-of-bounds write on the ule_hist array?

[ ... ]
> @@ -659,7 +659,7 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_=
handle *h,
>  			h->ts_remain > 2 ?
>  				*(unsigned short *)h->from_where : 0);
> =20
> -	#ifdef DVB_ULE_DEBUG
> +	#ifdef CONFIG_DVB_ULE_DEBUG
>  		hexdump(iov[0].iov_base, iov[0].iov_len);
>  		hexdump(iov[1].iov_base, iov[1].iov_len);
>  		hexdump(iov[2].iov_base, iov[2].iov_len);

[Severity: Critical]
Similarly, can concurrent reads on the global ule_where variable here result
in out-of-bounds memory reads while dvb_net_ule_new_ts_cell() modifies it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905123450.5620=
-1-breno3011alves@gmail.com?part=3D3
