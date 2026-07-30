Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0336A36A
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381221; cv=none; b=LzhkO6NZDOPIGW9mY+5b8iBHUj47TIRVTCDaEetdCOG9/Fu5OxA8mTEujJefB2oiPP/nqyHVK/sEPYKXUwLzmzJunr8YtLCYhL7DodQ7qFz7Dlw8+5UB1fKzB5NQ7JOpSL9z4DtxxdGK1NgAVYwdEoVGxK55rDA9luZrihG9TMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381221; c=relaxed/simple;
	bh=DEQvOvUo6vjc0Wtf2v/eQaN2qU32JVQY8RY9CITvkXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AR/4EzLC42XTdT/URM6huhgGKHTsp/4jpQojVpH0mP2dDEngVSVcpx5D0PKBgQy4R4PB5QfBP3xLaFqmPlwWbikl6GbBUE6yMDx4HbcvBw5b/nNSEpiOOdhtyL8vLkwt7b9eF0ufvc1jomYtWT8sYrtTcmNsQCvUs6iYnJYeyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXecPdjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXecPdjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D11F000E9;
	Thu, 30 Jul 2026 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381219;
	bh=kZfcglSDl3EKeFobXwvHBQUroPjMFI2KqbzyYoPp86c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXecPdjL5wyARU65t3tntTlU18YPz2utGeDdzWnkJ272YmxvwEftTHUCujlb4iont
	 VYeSmsoGUx4FFQ1Tse5LnLOrKDP5AHaNDYMdr+ckiS895wIjHKA3uVN9Hx/VS8OV31
	 TVPHlVZLDQqWcMfyLfVCEg/yrLICAvWdR/iQKDN28Uia7jTWx+XW6ZlzYThDRMDkWY
	 bJ9M+V9DCgGC9g3t9aRKzT/LK5wjEVh+PtRgscoPmoJWxrxGcv7OZz+gOo/M50kEO9
	 7wEMiTRvUBzLn55fwjTILdzgkJDP37bQ3mYg2i3sBNE1d4N0yHlxr6EEkpN7dcPvHZ
	 ZjiJQewWLsoBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] PCI/proc: Serialize config inode size updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziming Du" <duziming2@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730032438.1643450-3-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
 <20260730032438.1643450-3-duziming2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:13:39 +0000
Message-Id: <20260730031339.AE6D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return values of `__get_user()` and `__put_user()` are silentl=
y ignored, risking hardware configuration corruption and silent failures on=
 page faults.
--

--- Patch [2]: [PATCH v2 2/6] PCI/proc: Serialize config inode size updates=
 ---
commit 3aca0ed476ea2dd3079bd4be2a68be7793fdde7b
Author: Ziming Du <duziming2@huawei.com>

PCI/proc: Serialize config inode size updates

proc_bus_pci_write() calls i_size_write() without serializing concurrent
writers. On 32-bit SMP systems, concurrent updates can corrupt
i_size_seqcount and make later i_size_read() calls spin indefinitely.
This patch protects the inode size update with the inode lock.

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index cad749924dd89..ec2338c1e667e 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -181,7 +181,9 @@ static ssize_t proc_bus_pci_write(struct file *file, =
const char __user *buf,
>  	pci_config_pm_runtime_put(dev);
> =20
>  	*ppos =3D pos;
> +	inode_lock(ino);
>  	i_size_write(ino, dev->cfg_size);

[Severity: High]
This isn't a bug introduced by this patch, but looking at
proc_bus_pci_write() earlier in this function, the return value of
__get_user() is silently ignored:

drivers/pci/proc.c:proc_bus_pci_write() {
	...
	if ((off & 1) && size) {
		unsigned char val;
		__get_user(val, buf);
		pci_user_write_config_byte(dev, off, val);
	...
}

Does this code fail to handle page faults correctly?

If a process calls write() with a buffer that fails memory access,
__get_user() sets the target variable to zero and returns -EFAULT.
Because this return value is ignored, the kernel proceeds to write these
uninitialized zeroes directly into the PCI device's configuration space.

Can this cause hardware misconfiguration, system lockups, or kernel panics?

Similarly, in proc_bus_pci_read(), the return value of __put_user() is
discarded:

drivers/pci/proc.c:proc_bus_pci_read() {
	...
		unsigned char val;
		pci_user_read_config_byte(dev, pos, &val);
		__put_user(val, buf);
	...
}

Could this lead to silent failures where data is not successfully copied to
userspace despite returning success, leaving the user program to consume
uninitialized memory?

Is it possible to check the return values of __get_user() and __put_user()
in these functions and return -EFAULT if they fail?

> +	inode_unlock(ino);
>  	return nbytes;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032438.1643=
450-1-duziming2@huawei.com?part=3D2
