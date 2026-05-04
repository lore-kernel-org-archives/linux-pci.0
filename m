Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E61A6813
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777862662; cv=none; b=WGvbjwr5j/4IP9U2lUBiNyCFD/sP6xm6QAAPI3uNwgOJnX3tH8cU7Vu02y6wa7Z4bMzGzeJunprft3E3a1nEdkoLT3UuhqmaKpbphAKT2t7pykWHnLq7YLWnS1uoL7/LVMTrpVwtZlA5YXO6tUaoFcYCB896nDJcM4GfWDEEgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777862662; c=relaxed/simple;
	bh=sB68pW06hUAe/bMcHU1XLpdRkQsqCGW3tOUdo6fTh0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O+V7EJznfNlyYVUFrCewRSCzAYkW8F1/hi+foQBKiDYoMQcE9pfNtcPdodDoBtbEt/rFxXrMm/CxpWgC+hglVCX7OQ+NNxSzIbKendVM86oa5CSt8PhloJAY9GL1ONL8NKRaTwy0JW5fAMC4X67yFs4dGuZVL+0raPeKTyIF9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuOKvoeE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuOKvoeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5256C2BCB4;
	Mon,  4 May 2026 02:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777862662;
	bh=sB68pW06hUAe/bMcHU1XLpdRkQsqCGW3tOUdo6fTh0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fuOKvoeEKOUinN/mEMUztVD6LC9FuP8w9IL6yf9yKnt3V0I6AkptMtnetxx/e8pR1
	 Z04SAf2EcUBOdr3Q1S6cABID2i6zdK/F9/NEywIkJu4PYR2MkA47vRIQjIx0xVLWBY
	 k9PK1TyGrnShtW5M29rFw6LYAjxH+C5omIAB5yj9TyGkr9UXvW7yQb4oABgANcgFUq
	 qL+0tWMcD/ffaJsBxcO/NhNk7skLs3qHU41+d9Lgzm/ZCvV+TP7xjKMOjoiaG9iUxe
	 4ZUwk9Lqo2KiulxY5XL/NXFvcbatXB7Xlc2xDA2Gj66h+FwLxaR8ZNm62Kpox8Szoq
	 rsbUB3D1zpIjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/proc: check user access return values in
 proc_bus_pci_{read,write}()
Reply-To: sashiko@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260504022231.15501-1-kartikey406@gmail.com>
References: <20260504022231.15501-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 02:44:21 +0000
Message-Id: <20260504024421.D5256C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Integer truncation in proc_bus_pci_write allows negative offsets t=
o bypass bounds checks, leading to out-of-bounds PCI accesses and soft lock=
ups.
- [Medium] Error handling discards partial transfers, violating POSIX seman=
tics and risking unintended side effects on retry.
--

commit e7bdf9d788abd98223b783ee67cefeac2bfdde52
Author: Deepanshu Kartikey <kartikey406@gmail.com>

PCI/proc: check user access return values in proc_bus_pci_{read,write}()

This commit replaces __get_user() and __put_user() with get_user() and
put_user() to check for user access faults during PCI config space reads
and writes. It removes the upfront access_ok() check and adds an error
path to release the runtime PM reference and return -EFAULT on failure.

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index ce36e35681e8..8e624d829840 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -53,15 +53,13 @@ static ssize_t proc_bus_pci_read(struct file *file, c=
har __user *buf,
>  		nbytes =3D size - pos;
>  	cnt =3D nbytes;
> =20
> -	if (!access_ok(buf, cnt))
> -		return -EINVAL;
> -
>  	pci_config_pm_runtime_get(dev);
> =20
>  	if ((pos & 1) && cnt) {
>  		unsigned char val;
>  		pci_user_read_config_byte(dev, pos, &val);
> -		__put_user(val, buf);
> +		if (put_user(val, buf))
> +			goto err;
>  		buf++;
>  		pos++;
>  		cnt--;
> @@ -70,7 +68,8 @@ static ssize_t proc_bus_pci_read(struct file *file, cha=
r __user *buf,
>  	if ((pos & 3) && cnt > 2) {
>  		unsigned short val;
>  		pci_user_read_config_word(dev, pos, &val);
> -		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
> +		if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
> +			goto err;

If a fault happens during this put_user() call, some bytes may have already
been successfully transferred by the previous call. Unconditionally jumping
to the err label and returning -EFAULT discards this partial progress and
fails to update *ppos.

Since configuration registers can be stateful, such as Write-1-to-Clear
bits, could userspace retrying the entire operation cause unintended side
effects?

If data has been successfully processed prior to a fault, should the functi=
on
update the file offset and return the number of bytes transferred instead?

[ ... ]
> @@ -106,6 +108,10 @@ static ssize_t proc_bus_pci_read(struct file *file, =
char __user *buf,
> =20
>  	*ppos =3D pos;
>  	return nbytes;
> +
> +err:
> +	pci_config_pm_runtime_put(dev);
> +	return -EFAULT;
>  }
> =20
>  static ssize_t proc_bus_pci_write(struct file *file, const char __user *=
buf,

This issue isn't introduced by the patch, but does this function truncate
*ppos? Looking at the full function:

static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
				  size_t nbytes, loff_t *ppos)
{
	...
	int pos =3D *ppos;
	...

If a large positive offset is passed, such as 2294967296, the assignment to
the 32-bit int pos would truncate it to a negative value.

This bypasses the if (pos >=3D size) check. When checking pos + nbytes > si=
ze,
pos is promoted to a 64-bit size_t and sign-extends to a huge value, making
the condition true. nbytes is then calculated as size - pos, resulting in a
massive positive integer for cnt.

[ ... ]
> @@ -154,7 +159,8 @@ static ssize_t proc_bus_pci_write(struct file *file, =
const char __user *buf,
> =20
>  	while (cnt >=3D 4) {
>  		__le32 val;
> -		__get_user(val, (__le32 __user *) buf);
> +		if (get_user(val, (__le32 __user *) buf))
> +			goto err;
>  		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
>  		buf +=3D 4;
>  		pos +=3D 4;
>  		cnt -=3D 4;

The while (cnt >=3D 4) loop would then execute hundreds of millions of time=
s,
passing a negative offset to the configuration accessor functions.

Since proc_bus_pci_write() lacks a cond_resched() call in this loop, could
this trigger a soft lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504022231.1550=
1-1-kartikey406@gmail.com?part=3D1
