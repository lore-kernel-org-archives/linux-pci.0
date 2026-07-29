Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1B4195B5
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312790; cv=none; b=eLHs6yKl1n8hyimE5T+B6/dJcqLUzrNLg+1XhaU+20OdH+TBjCo3cHe8rkRvv4eet9OJupdAqx8WpdcnldxEX8EKXqGtv9+L60kFtZ0OM5sz9rgpWr3Fsm7hlyOb+twjtW5I0LDzs6pkDz5xIjzQueW0OAT8X2uz18dHFPcHR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312790; c=relaxed/simple;
	bh=i0iCTXyLfm0+1c/lXKV1zlTwAXbTbzeOPEUu1YpWEC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OLsof+8UDy+9xNXIIrqXZH8EH+VcTkAfLIl2xqQwa71KnOU0Sgi3biNpQ0WMyMHYLvi1VbD0Ep+ykLmDm82X4YfvSsG77sS6EUlMIEZGJDqkQF/Yo/VpzNtTkQpmiPcLadKngEeKuJQve+xe0VJoOywa73UTqX2BWxJoJZW+ol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTP5aJaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTP5aJaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AA71F000E9;
	Wed, 29 Jul 2026 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785312787;
	bh=EB7HbRINXTh5u1OAiTHbKJaCCWL80QdSIWsy7sgaV6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTP5aJaKEUfz6NQbBSzcPJCBz6wyHEuHHPiuHfKAB4pZtral2SDp/r7saiLVgiK6U
	 f4e/LhMhlpivOxMvjjvk/ITMV0ognBiIBMFemrtDs1nVQ2SD21u5h40PUMeJ5CQs98
	 0qAhwjpGqQXgDHkNI1Y/FzMrVIJ02NbHL0gco1X3Ge2f2DrBKS9+daG5w8ty+Gl1Mn
	 sn1k1WjxxmK2NTGBmICbEL6K5sAi66D3tl45oPu6d4J/i0+YmUKZApnYvgX6oCLpfu
	 PdZ9flQTfygNu8/M9vmCk4nxIwuxGiFn+cNYE7GvrLNqvW6bSmzXizRUO+ipCvS3gW
	 vCeAE3jo+jwyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/proc: Warn on writes to kernel-exclusive config
 space regions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729075413.1215821-1-kwilczynski@kernel.org>
References: <20260729075413.1215821-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:13:06 +0000
Message-Id: <20260729081307.11AA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer truncation of the 64-bit file offset to a 32-bit signed in=
t allows bypassing bounds checks and the new exclusive region check, leadin=
g to massive out-of-bounds memory writes.
--

--- Patch [1]: [PATCH] PCI/proc: Warn on writes to kernel-exclusive config =
space regions ---
commit ae079df2d52cc5cc8959cf281ed5e461ff2fcfd8
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/proc: Warn on writes to kernel-exclusive config space regions

This patch updates proc_bus_pci_write() to check if a user space write
targets a kernel-exclusive config space region. If so, it emits a warning
and taints the kernel, bringing the procfs interface to parity with the
sysfs interface.

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 71ad289fcb8e3..12200979d3a82 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
[ ... ]
> @@ -122,6 +124,12 @@ static ssize_t proc_bus_pci_write(struct file *file,=
 const char __user *buf,
>  	if (ret)
>  		return ret;
> =20
> +	if (resource_is_exclusive(&dev->driver_exclusive_resource, pos, nbytes)=
) {
> +		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config of=
fset %x",
> +			      current->comm, pos);
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does truncating the 64-bit file offset to=
 a
32-bit signed integer earlier in proc_bus_pci_write() allow bypassing this
new exclusive region check?

A large positive 64-bit file offset provided via pwrite64() gets truncated =
to
a negative value:

drivers/pci/proc.c:proc_bus_pci_write() {
    ...
	int pos =3D *ppos;
    ...
}

Because resource_is_exclusive() takes a u64 address, the negative pos will
sign-extend into a massive 64-bit value that won't match any exclusive
region, bypassing this detection entirely.

Additionally, this truncation also bypasses the subsequent bounds checks:

	if (pos >=3D size)
		return 0;
	if (nbytes >=3D size)
		nbytes =3D size;
	if (pos + nbytes > size)
		nbytes =3D size - pos;

The signed comparison if (pos >=3D size) evaluates to false for a negative
pos. Because nbytes is unsigned, the length clipping if (pos + nbytes > siz=
e)
evaluates using unsigned arithmetic and becomes true for a negative pos. Th=
is
erroneously increases nbytes up to massive out-of-bounds lengths, potential=
ly
leading to large writes outside the PCI configuration space.

>  	if (pos >=3D size)
>  		return 0;
>  	if (nbytes >=3D size)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729075413.1215=
821-1-kwilczynski@kernel.org?part=3D1
