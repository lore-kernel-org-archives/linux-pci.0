Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D836EA8B
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381242; cv=none; b=oIjFjU2Dwq3u/pBXcOl1O2GOA5AkEYq46Er4LsgqB9UI4126gYNr0eU5m5MFsIYUpH+zSKg23vTCUWOLvb59m9AEC4rTDp2hyG0wxIG4BgVDInYmoNL4E33vQJ+s8TsjIGU3vqstXtnIx9WROKULP2XkU6ly/x/GoYDiiRcOSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381242; c=relaxed/simple;
	bh=nPIyx0kQfCXgjaWzghgnkdiO1oKMBIM5wL0zRT5IBpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X1rKE2KPZtZOADWk57RaV1S3u/iAFFb7R92uo+gzwR8DW41Byr9rM2/3KlVCFEaOKdtEOguyYfAUZV+31NWGJrcWxzSilJTwIpCG7r1+STVesp/M1r0kqMB9dT+GfKnlKyeRFB5UQpocJtTYWckD0pyacA7yiV5OQn8E5sZkciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGd+wWSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGd+wWSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0461F000E9;
	Thu, 30 Jul 2026 03:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381240;
	bh=uqjlgv7FiZg3vjlr5y5ljm+uib/5noXw0QjTrdRTyHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gGd+wWSOkWooCsbEh5kj7W5q3LPUXUM/h7Jgx+dWqq6MdD/fgzAksiYE6QsGv0J+w
	 4h14vFuWTGrP5n9dvcRkin3PpcXONFMXazPUv3iKh6kuBlsI45TNgm178jH/KJbtDT
	 16cX7mffLf7JCEZH1BRg0KlGYRGjPHHEVGhvLw2ZgGs61FVXA2z3Ev0JwUHdfgvIHH
	 m3Xl15krzudFVGuWKdyqqag1TQ9x8gBij/X6hkvcVxn2oqo93q6oJlpjrJHyKTav/Y
	 YPrq5HJDaDDHMx+pXcejpQ0ohArFWo98XjuyYTYDzgqimQ7zQdhUtMj1UMH987ttQ0
	 vCwsr/prRYm2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] PCI: Align proc_bus_pci_read() with
 pci_read_config()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziming Du" <duziming2@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730032438.1643450-7-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
 <20260730032438.1643450-7-duziming2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:14:00 +0000
Message-Id: <20260730031400.8B0461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned pointer dereference via `__put_user` cast.
--

--- Patch [6]: [PATCH v2 6/6] PCI: Align proc_bus_pci_read() with pci_read_=
config() ---
commit 214117562117fd4692f3111d71550ff1bd6ab306
Author: Ziming Du <duziming2@huawei.com>

PCI: Align proc_bus_pci_read() with pci_read_config()

This commit aligns the implementation of proc_bus_pci_read() with
pci_read_config() to improve consistency. It renames variables and updates
the transfer loop conditions without intending functional changes.

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 71d1f34e13a7d..13ac92da4624b 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
[ ... ]
> @@ -46,66 +47,65 @@ static ssize_t proc_bus_pci_read(struct file *file, c=
har __user *buf,
[ ... ]
> -	while (cnt >=3D 4) {
> +	while (count > 3) {
>  		unsigned int val;
> -		pci_user_read_config_dword(dev, pos, &val);
> +		pci_user_read_config_dword(dev, off, &val);
>  		__put_user(cpu_to_le32(val), (__le32 __user *) buf);

[Severity: High]
This is a pre-existing issue, but could this cast and dereference trigger
an alignment exception on strict-alignment architectures?

If a normal user opens a PCI config file and calls read() with an aligned
file offset but an unaligned buffer address, the read chunks are aligned
based on the file offset, bypassing the earlier byte and word branches.
The execution would then reach this 32-bit __put_user cast with the
unaligned user buffer.

On architectures that do not emulate unaligned kernel-mode accesses like
older ARM or SPARC, this might result in a local denial of service via a
kernel oops or panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032438.1643=
450-1-duziming2@huawei.com?part=3D6
