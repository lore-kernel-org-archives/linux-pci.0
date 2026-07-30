Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6B29405
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381394; cv=none; b=T3ss4Y9n+XpVqJc0lNQzjHe5m7Is0/th9gdYmnpQ1J3it02YHMCMXbFeYgU7Bh+7pvkRvW0jmqvdBOeU9S7XqR73m5fOZAGW8aww1bqGJYUFVPNyFW6yJunHuG5Z1xNU81jTiXYXEP077o7WwkscxvcyuCr6CExg+lc6vqIKViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381394; c=relaxed/simple;
	bh=k0g1RD6BH6WAcVBIVfOI6A7Jpg7oSZXJQdoQPHdKbBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ah2E350Y0go2NqrEkMBoQlWPE197nK5N3SE/71y7CdAS3DoZWFzYB2btZ1HkGbikUJWNnxYh4dFfeha9waqEFs8veJpPIw5gPFArEpTzQCfI7OGRwB2/tpSmM10wSc8/lG96Ld5zlW+ys9FlCIx0qUPnZJX099LEtgADyq+PPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEJD/SGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEJD/SGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42451F000E9;
	Thu, 30 Jul 2026 03:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381392;
	bh=6+SFfiSOAj8ZcJ57f73ZdLnsbGpEyvHWAaZBoza8+lE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kEJD/SGYBL06iO9dIELeCOLSSEWm+uEvVFvyGUN5JcxEKg5VxbNEMgHs2WjPsZYJH
	 TunBpXD8dAIT99EU/A6sA55rt0SYipXjgiK+Pys9VRy6U8cTCmCIqBG+4X9HsrvL6P
	 89gER3Fcgq/8XBCAq2JhYFX2Lve63N5+A9MlB2mHPW6Hw83GBFXeZ+qFMN9rZ+BggW
	 HOuDzYT1hCCyQUy2UOKG40McnRtUKy+b71ybooPUHFZqCDha3oaxTqA6Gv8oLw5SpW
	 69D3XgF4KU4vdlgPgXK2suua9v0eyOFoC+AIrkvP+q4lXJD2hKz2INelzen+QFOkRo
	 rMHFomtNoPJ+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] PCI: Align proc_bus_pci_write() with
 pci_write_config()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziming Du" <duziming2@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730032438.1643450-6-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
 <20260730032438.1643450-6-duziming2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:16:32 +0000
Message-Id: <20260730031632.B42451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error handling for `__get_user()` causes silent hardware c=
onfiguration corruption.
- [High] Unaligned user pointer dereferences cause alignment faults and sil=
ent failures on strict architectures.
--

--- Patch [5]: [PATCH v2 5/6] PCI: Align proc_bus_pci_write() with pci_writ=
e_config() ---
commit 9ab25f02e0980d093d99dfa257a71fcb18afa9ca
Author: Ziming Du <duziming2@huawei.com>

PCI: Align proc_bus_pci_write() with pci_write_config()

This commit aligns proc_bus_pci_write() with pci_write_config() to improve
consistency across the PCI subsystem. It updates variable names, simplifies
bounds checking, and modifies transfer loop conditions.

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 3f041765da978..71d1f34e13a7d 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
[ ... ]
> @@ -114,80 +114,79 @@ static ssize_t proc_bus_pci_write(struct file *file=
, const char __user *buf,
[ ... ]
> -	if ((pos & 3) && cnt > 2) {
> +	if ((off & 3) && size > 2) {
>  		__le16 val;
>  		__get_user(val, (__le16 __user *) buf);

[Severity: High]
This isn't a bug introduced by this patch, but can this cast to a multi-byte
type result in an unaligned user pointer dereference?

If a user calls pwrite() with a buffer whose alignment phase doesn't match
the file offset (e.g., a page-aligned buffer with offset=3D1), synchronizing
the buf and off increments guarantees that when off reaches a 16-bit or
32-bit boundary, buf will be unaligned.

On architectures with strict alignment requirements, could this trigger
alignment faults in kernel space, causing __get_user() to abort and return
-EFAULT?

> -		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
> +		pci_user_write_config_word(dev, off, le16_to_cpu(val));
>  		buf +=3D 2;
> -		pos +=3D 2;
> -		cnt -=3D 2;
> +		off +=3D 2;
> +		size -=3D 2;
>  	}
> =20
> -	while (cnt >=3D 4) {
> +	while (size > 3) {
>  		__le32 val;
>  		__get_user(val, (__le32 __user *) buf);
> -		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));

[Severity: High]
This is a pre-existing issue, but does this code ignore the return value of
__get_user() before executing the hardware write?

If a user passes a buffer that spans into unmapped memory, __get_user()
will encounter a page fault, return -EFAULT, and set the output value to
zero. Because proc_bus_pci_write() completely ignores this return value,
could it proceed to silently write these zeros to critical PCI configuration
space registers (like BARs or the Command register) and potentially lock up
the bus or crash the system?

> +		pci_user_write_config_dword(dev, off, le32_to_cpu(val));
>  		buf +=3D 4;
> -		pos +=3D 4;
> -		cnt -=3D 4;
> +		off +=3D 4;
> +		size -=3D 4;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032438.1643=
450-1-duziming2@huawei.com?part=3D5
