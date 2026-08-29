Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688339A4A0
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787964977; cv=none; b=EuXMne+ehEw93BT687UN6UTWJ7Io/YXoyP2c1U5Wy6QCiNKSD4jn6wM2rEbtZHqRMpoXjGE9xFZWV62WCB+7HdsWTUytvDrfHSY00RcpTl4P4zTn4lD2y+Npyzklydzl6kAmWrViB3ptnBs3jKcJKPwNDST9c5UtvFMH7s1969w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787964977; c=relaxed/simple;
	bh=39lZHmwO8KzLVcIniocHlRN6Ngx7dlwoB76RGFEsl5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nvRcijT/ZvwfkyxrLrBrLC1g3+Vh41vQA16nw3GCFOrTzmo7Xh26NmpMUXJ2NZpq+FbuRfZBLH5lzG5Mma50p91Z8vQpwFIE5/bwGIiGmeoBRmewtHPV7QJYLQNhleiwQ+DAEA+CqL4dQJMNXBlV1cb4yCOJxT3gu8ZI96OJ+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbfT9Klo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbfT9Klo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BCD1F000E9;
	Sat, 29 Aug 2026 00:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787964975;
	bh=5ZELWZswzARZwbs18Bls1g0FVjY724JU1yv8u8/nUqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbfT9KloKcNgR5wMQsDKsK3vIrN25sKx+Gu8RQz21uzSnVFdFiKXxFNTvheRaVwtK
	 D7rKXJoO6M+YZvuJfNPaD1ufotPmTlYtbwCWlA+2ZbWnY+7Q84lk2nVQLkZUzfWba3
	 oNDTQuGbsaOjFycRvJZGCtLuu7jwPYrQNYeHzA6582AX76+wIfjX0/ViMSdsBOktfB
	 oY1BMWyEp2katAkm/e1DcnvQhAJBiy6S5Avmld066RZ0RnXq+LiqnEPOyZz9C7Dpvv
	 7uvP10fg9GlvmH8N9FB13rzalf/3gEXulCuetXInPQimKdZvMhCot6uLL4vBqDA99+
	 Wsz2MWMh6iSbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Reserve prefetchable window headroom for
 Resizable BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geramy Loveless" <gloveless@jqluv.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <10fb16fb-2069-4d89-b473-1006ae5abfbc@jqluv.com>
References: <10fb16fb-2069-4d89-b473-1006ae5abfbc@jqluv.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 00:56:14 +0000
Message-Id: <20260829005615.55BCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `resource_size_roundup_pow2` function invokes undefined behavi=
or on 32-bit systems by shifting a 32-bit integer by 32 or more.
- [High] Concurrent execution of `pci_pack_low_reserve` during PCIe hotplug=
 or asynchronous probing causes data races on the static budget array, lead=
ing to memory corruption.
- [Medium] The `pci_pack_low_reserve` function permanently leaks budget sta=
te and stores stale root bus pointers across device unbinds/hot-removals.
--

commit 3d18f0cac0d66de7c502abb13e0bec070d238ae4
Author: Geramy Loveless <gloveless@jqluv.com>

PCI: Reserve prefetchable window headroom for Resizable BARs

This commit reserves prefetchable window headroom during bridge sizing
for the maximum size of downstream Resizable BARs, allowing a driver
to grow a Resizable BAR later. It also demotes small prefetchable BARs
to the non-prefetchable window when sharing with a massive prefetchable BAR.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..1094f618bb1ff 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> +/* Demote only if the host's 32-bit aperture has room (tracked per host)=
. */
> +static bool pci_pack_low_reserve(struct pci_dev *dev, resource_size_t by=
tes)
> +{
> +	static struct { struct pci_bus *root; u64 used; } budget[32];
> +	static int nbudget;
> +	struct pci_bus *root =3D dev->bus;
> +	struct resource *r;
> +	u64 aperture =3D 0, *usedp =3D NULL;
> +	int i;
> +
[ ... ]
> +	for (i =3D 0; i < nbudget; i++) {
> +		if (budget[i].root =3D=3D root) {

[Severity: Medium]
If a root bus is hot-removed, could its memory address be reallocated to a
new root bus, causing false matches here and inheriting the exhausted
budget from the stale pointer?

> +			usedp =3D &budget[i].used;
> +			break;
> +		}
> +	}
> +	if (!usedp) {
> +		if (nbudget >=3D (int)ARRAY_SIZE(budget))
> +			return false;
> +		budget[nbudget].root =3D root;
> +		budget[nbudget].used =3D 0;
> +		usedp =3D &budget[nbudget].used;
> +		nbudget++;

[Severity: High]
Could concurrent execution of pci_pack_low_reserve() during PCIe hotplug or
asynchronous probing cause data races here?

There are no synchronization primitives protecting the static budget array
and nbudget counter. If two concurrent threads attempt to insert a new root
bus when nbudget reaches the array size limit, could both bypass the bounds
check in a Time-of-Check to Time-of-Use (TOCTOU) race and cause an
out-of-bounds write, corrupting the kernel BSS section?

> +	}
> +	if (*usedp + bytes > aperture / 2)
> +		return false;
> +	*usedp +=3D bytes;

[Severity: Medium]
Since there is no teardown or release hook to decrement the usage when a
device is removed, does this continuously accumulate the budget usage?

If a device is repeatedly hot-unplugged and re-plugged, or if a software bus
rescan is triggered via sysfs, does this permanently leak the tracked budget
until a reboot?

> +	return true;
> +}
[ ... ]
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c12..d8b8cb35b8bb6 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
[ ... ]
> +/* roundup_pow_of_two() is unsigned long and truncates 64-bit sizes on 3=
2-bit. */
> +static resource_size_t resource_size_roundup_pow2(resource_size_t n)
> +{
> +	if (n && (n & (n - 1)))
> +		n =3D (resource_size_t)1 << fls64(n);

[Severity: High]
Does this shift operation in resource_size_roundup_pow2() invoke undefined
behavior on 32-bit systems?

If the requested bridge window size n is greater than 2GB (e.g. a 2GB BAR
plus an additional smaller BAR) on a system where resource_size_t is 32-bit,
fls64(n) will return 32. Since 1 is cast to a 32-bit type (resource_size_t),
shifting it by 32 or more results in undefined behavior in C.

> +	return n;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/10fb16fb-2069-4d89-=
b473-1006ae5abfbc@jqluv.com?part=3D1
