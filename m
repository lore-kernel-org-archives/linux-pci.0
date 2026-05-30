Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEC2D8393;
	Sat, 30 May 2026 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101964; cv=none; b=Br+u17Tma/rBkNtF31RIWZ23LFUfvtYx+FcoLl4B9NpIOY5q3VPza7VG+TrAz76T6vAtZWmcHqbssN3cJYjIHUB2TuN4umCpsSHUatIuiF5E0pDKivH4a1uYE7RDk6ku/n8lMDHyBtWAt5J+0sClPACrl9GJmPiPk9e+mtN7coM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101964; c=relaxed/simple;
	bh=T6StIc+S7LmpMRyXVlAjVPZFElYigxub0A+lfzhMZoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fMg7x9KCoGibLAlZeutALX1ez4r2oM6wtlpcde8c0UzhSx9BiPauarT8et0ihtfdkkjXfttut/Xsbx0CvaiqXy7+BBkiYZlYNzcX33e0B+AgxhLobL1fVKskq5hY8pnihF7IYSY6GP6SpVS6FEYQqto5n8tjBjENNZwyZ+xwI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaxTetCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaxTetCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430391F00899;
	Sat, 30 May 2026 00:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101961;
	bh=s1vN3UitLlzLcD29lzcFPKhjjvtfv2O+YVSzGjb5VXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GaxTetCIIOcASlpnP929drAaCahncV9klHyxTiHKs9Yvaz5pWpQr5OYu8cPgTKrXA
	 0VP5bwQPqb7hBCNMOzxm4gEPBHJPb3+uXYNwe6wf/pxNCuAfhg/dgubCqCmv5dyQ9q
	 p90bwwsbeAbMkEwSa9j4nrqct4VIs2bpWi9uIRbSweQlvJveRDUWgONybB7gurGl/u
	 6Wsq5bfv4oeYkXhWnzy3VajGK0TsMuGrvu/C+VLNNzKr4QoL9F0qQ3NPun2VkfveTj
	 w5X9LNJB4/3O+VV3bPANnHX6Cwx4L0FhwiMnQyjaPNU3GyLdMtqyeoLJVT9+JKDzbm
	 k3BLXtNLN9aSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] params: Convert generic kernel_param_ops .get
 helpers to seq_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521133326.2465264-8-kees@kernel.org>
References: <20260521133326.2465264-8-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:59 +0000
Message-Id: <20260530004600.430391F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Information Leak / Uninitialized Memory Disclosure in param_array_=
get()
--

commit 4bb10449d07e3a1b177001d61d53053c25dd4767
Author: Kees Cook <kees@kernel.org>

params: Convert generic kernel_param_ops .get helpers to seq_buf

This commit converts the generic kernel parameter .get helpers in
kernel/params.c to use the seq_buf signature instead of char pointers. It
allows param_array_get to write element output directly into the parent
seq_buf when supported, updating various dependent callers to match the new
signature.

> diff --git a/kernel/params.c b/kernel/params.c
> index 4eda2d23ddf28..25f0c8d5d19f3 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
[ ... ]
> @@ -453,36 +457,46 @@ static int param_array_set(const char *val, const s=
truct kernel_param *kp)
[ ... ]
> -static int param_array_get(char *buffer, const struct kernel_param *kp)
> +static int param_array_get(struct seq_buf *s, const struct kernel_param =
*kp)
>  {
[ ... ]
> -	for (i =3D off =3D 0; i < (arr->num ? *arr->num : arr->max); i++) {
> +	for (i =3D 0; i < (arr->num ? *arr->num : arr->max); i++) {
> +		size_t before =3D s->len;
> =20
>  		p.arg =3D arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret =3D arr->ops->get_str(elem_buf, &p);
> -		if (ret < 0)
> -			goto out;
> -		ret =3D min(ret, (int)(PAGE_SIZE - 1 - off));
> -		if (!ret)
> +
> +		if (arr->ops->get) {
> +			ret =3D arr->ops->get(s, &p);
> +			if (ret < 0)
> +				goto out;
> +		} else {
[ ... ]
> +			ret =3D arr->ops->get_str(elem_buf, &p);
> +			if (ret < 0)
> +				goto out;
> +			seq_buf_putmem(s, elem_buf, ret);
> +		}
> +
> +		/* Nothing got written (e.g. overflow) =E2=80=94 stop. */
> +		if (s->len =3D=3D before)
>  			break;

[Severity: High]
When a seq_buf overflows, it calls seq_buf_set_overflow() which sets
s->len =3D s->size. Because of this, does s->len actually equal before
when an overflow occurs?

If s->len becomes s->size, the condition s->len =3D=3D before will evaluate
to false, causing the loop to continue for one more iteration rather than
breaking. On the next iteration, before will be s->size, the write will
fail again, and the loop will finally break.

Because the overflow mechanism sets the length to the buffer size without
actually writing data into the remaining space, could this leak uninitializ=
ed
kernel heap memory to userspace when sysfs returns the buffer?

> +
> +		/* Replace the previous element's trailing newline with a comma. */
> -		if (i)
> -			buffer[off - 1] =3D ',';
> -		memcpy(buffer + off, elem_buf, ret);
> -		off +=3D ret;
> -		if (off =3D=3D PAGE_SIZE - 1)
> -			break;
> +		if (i && s->buffer[before - 1] =3D=3D '\n')
> +			s->buffer[before - 1] =3D ',';
>  	}
> -	buffer[off] =3D '\0';
> -	ret =3D off;
> +	ret =3D 0;
>  out:
>  	kfree(elem_buf);
>  return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521133315.work=
.845-kees@kernel.org?part=3D8
