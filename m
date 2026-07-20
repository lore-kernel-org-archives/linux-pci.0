Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93143F4AE
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565614; cv=none; b=h7b99lXXHKbrECrEYYWQPFZ/JJHgExA5TYD5qXJ1d3CZX8g0Vf37ik0GBIR+YQtvS43X4WZkT2VKOd74PGR7FlhRcDP1zaUFllyl4YW89dWkV9Y7HNBjiiwEptJqlCroTAGq5/bbndwRvtiuUD6bnMzLfaNCJt+xy+jK7R70ALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565614; c=relaxed/simple;
	bh=jX2MIj2XWbYUM2Wd8ms9NBmBYrFU09BPXCHp40Yh2tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MiTKiOIvDPu0dqp4+EXoM3FkRwJ9c3tBAotrm5SwTdhGs46o3D+kWgWLJ7EM5r342BlXBi0TxY7MsmWg6ZIcWW9A49QDYUTQ27cvBQH2zeLsxRDgO0EZ0/OuTWJ1yJHy8zz4PPLjMZ7L5zOM7zIVmma1/5EiYncuVyaBqp0tGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2ZNoAZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2ZNoAZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E86C1F000E9;
	Mon, 20 Jul 2026 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784565606;
	bh=PMKN5w9AytSsx7sHQLy1Yf23NKCKzHCc/IzfFpjSWGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n2ZNoAZd3+1YELvnz0sWRDMKisFWCCOEdDLG9tMxVHeznym4Jbv8E6QgE/4k9Gp+z
	 3iuAeaXTKgt/2SAVXec+kEOEF3Vv0/9Huie4Ag6HGaTH9BgXI2pjtxEYGFRmMT9UJV
	 JAY52vMvqL2H0M8u7i72Ufpc+F38KK+ORhAIGL2DpzT8DmHGoGSalJYI2flNUs20Wu
	 7SXthqalio2SFW8zvlsdEDVzQsfwmb5gpAx3l+tQ6Lb8XfnMeNlrBRNw7rKbedSgFz
	 y/zu9bHQYRRpF+SDb1LhF30q0DbQWq5AHegBANhK2JY1sdxq28oVgqIb13z8szGS3P
	 ftN54ORJk+7VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: Do not add hotplug reservation multiple times
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720162416.5771-1-ilpo.jarvinen@linux.intel.com>
References: <20260720162416.5771-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:40:06 +0000
Message-Id: <20260720164006.8E86C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes nested hotplug reservation accumulation for memory=
 windows in `calculate_memsize()`, but misses the identical buggy logic in =
`calculate_iosize()`, leading to I/O space exhaustion.
--

--- Patch [1]: [PATCH 1/1] PCI: Do not add hotplug reservation multiple tim=
es ---
commit 3c4b4a62adcb92793a7c17214021e8b637be1016
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Do not add hotplug reservation multiple times

In nested topologies, hotplug reservations gets added multiple times
into the bridge window higher up in the hierarchy. Adding reservation
for intermediate level bridges does not seem very useful because the
hotplug is going to add device at a leaf.

Link: https://lore.kernel.org/linux-pci/f23946f2-06ac-4607-8f2c-3ffbc52b627=
a@redhat.com/

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c9956..e8c94aa1d3c12 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1021,7 +1021,7 @@ static resource_size_t calculate_memsize(resource_s=
ize_t size,
>  					 resource_size_t children_add_size,
>  					 resource_size_t align)
>  {
> -	size =3D max(size, min_size) + children_add_size;
> +	size =3D max(size + children_add_size, min_size);
>  	return ALIGN(size, align);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does calculate_iosize() need=
 a
similar fix to avoid I/O space exhaustion in nested topologies?

Just above calculate_memsize(), calculate_iosize() retains the identical
logic for I/O windows:

drivers/pci/setup-bus.c:calculate_iosize() {
    ...
    size =3D max(size, add_size) + children_add_size;
    return ALIGN(max(size, old_size), align);
}

When allocating I/O windows for nested hotplug bridges, pbus_size_io() pass=
es
both the accumulated children I/O sizes (children_add_size) and the hotplug
reservation (add_size) to calculate_iosize().

Because the logic is exactly the same as the unpatched calculate_memsize(),
this appears to still unconditionally add an extra 4KB (due to bridge window
alignment) at each nested bridge level. Can this linearly inflate the requi=
red
space and quickly exhaust the limited 64KB I/O address space on systems with
deeply nested hotplug PCIe bridges (like Thunderbolt docks)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720162416.5771=
-1-ilpo.jarvinen@linux.intel.com?part=3D1
