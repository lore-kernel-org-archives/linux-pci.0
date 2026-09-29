Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EE53C3A9;
	Tue, 29 Sep 2026 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704191; cv=none; b=Smv55mHvlBNOoiWVgopLWiExl5i3cwxJ5JWVaOI0m/D2umFdS2t3SxMzLNn7q/deKDNpHiVidCTdHVJqJWvbQWDkdyKUrPiSkz5kxI0b8dD6j8pVfPppEhPT7sy+3LejjkO6bIhHPoS9ooUcfBzXYmKka+iJKy4GnnHjR7+5NcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704191; c=relaxed/simple;
	bh=P/k4f/eTi3CvrRllbfZMRkiksfAGIzP2q4PKRmVoEBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jM+9sdaDeq820/HcHaIwUZm5zU93ai2aJsY0V1K/gqkNrHi0uXjRAp8xd5gVGObpUHZAOoxZ1ckj6TnxKDzP9bYem3sb7ZR4/m/6SQd7TAKuvQfCb5BIKkLHpYQAoI+Jk/SOFjsWTySuJqRy7HwKIdsz2tOvQf98aGpGdSvbvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brXosUTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brXosUTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BE11F000FF;
	Tue, 29 Sep 2026 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704189;
	bh=VFLVaCJ04h8QR8kYowCEUJL19oIQH8ZG5ysEH+fwf/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brXosUTwIqs/WaZ/TmMJUlhK/rLh+f14jgg2YA9p6rk1MvtEExLiuQfHEPrq5e/+4
	 dJzlmVJCWnRwyXN+e9wlAmJGsOhqBvszviGCIChZjZCu1KuwKVr+mRBFbKGsLMp2w8
	 1vNQ1ti55kjLrMhhCjrH3P/Ysd51rmL6/RAZfT3nJEdFeQ+kE606KP2nwQRKY1m9ue
	 E3lHeZZtoNVpiG53hzNRNcRsxOluyDE3gzGlXTPGqQ0v+OtWAmAMVgXXnJS2bhtwS5
	 yvFxKHYuC5fRxSMtNwDSUf4I60IH8lKgoeGThw7dU2raqiN7uujN6uslpYqgYEmmg8
	 c6y4pyrSN9z6Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/16] vfio/pci: Buffer ROM reads before copying
 to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-4-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:49:49 +0000
Message-Id: <20260929174949.69BE11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfio/pci: soft lockup in vfio_pci_rom_read loops due to missing co=
nd_resched
--

commit 27d4f4cebe481807304449721e6097b02db9fc50
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Buffer ROM reads before copying to userspace

This commit moves ROM reads into a separate helper, buffering the requested
ROM data and unmapping the ROM before copying it to userspace. This helps
keep userspace faults outside the recovery gate.

> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci=
_rdwr.c
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
[ ... ]
> +static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
> +				 char __user *buf, size_t count, loff_t pos)
> +{
[ ... ]
> +	/*
> +	 * Certain devices (e.g. Intel X710) don't support qword
> +	 * access to the ROM bar. Otherwise PCI AER errors might be
> +	 * triggered.
> +	 *
> +	 * Disable qword access to the ROM bar universally, which
> +	 * worked reliably for years before qword access is enabled.
> +	 */
> +	while (done < length) {
> +		if (length - done >=3D 4 && IS_ALIGNED(pos + done, 4)) {
> +			u32 val =3D vfio_ioread32(io + pos + done);

[Severity: High]
Can this loop cause a soft lockup on large ROM reads?

If a userspace application or guest issues a large read on the ROM BAR (for
example, 16MB), this while loop in vfio_pci_rom_read() will perform millions
of synchronous MMIO reads without yielding.

Since each MMIO read can take significant time, this could stall the CPU co=
re
for seconds and trigger a soft lockup panic. Should this loop include a
cond_resched() to prevent an untrusted guest from causing a local Denial of
Service?

> +
> +			memcpy(data + done, &val, sizeof(val));
> +			done +=3D sizeof(val);
> +		} else if (length - done >=3D 2 && IS_ALIGNED(pos + done, 2)) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D3
