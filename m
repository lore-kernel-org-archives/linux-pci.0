Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A773D73
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278208; cv=none; b=k7puTebYf8CkdeaPrOjsO0JFq0Wh280RouTXVu0/LH1htP7bgQ7vXBiXx2nqTRQ2HZVFjnycfe0i8/cV0/9aoBv0frvgDRTmI6SVev83MSyCrxokdt6qEvx/cfKDI9GNXH7wC7Bf1ZX1+rfc61iqf8jl0zU96nAB4wodppebj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278208; c=relaxed/simple;
	bh=Ruzk+cw8ZP8uop2GDhgzJFXe6CMwZfljoX8rZQdTTRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ACxLSc/xGwRDfeqlmm1HzoBYVVzAQY4Fcmwi1ZYP0TrezXywTWv/n96oLkF2cZRlNADDeWd0SHGc0GhQuAn2WLlf+PBRQVs1AEO7LlzUqeCHbR3FSnSwBoBApbfjZs5s7D//JFcAJHVvGVjtbz5aoyvhuUIeLeCll6BRIj1xxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSjpp2ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSjpp2ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC3F1F000E9;
	Fri, 21 Aug 2026 02:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787278206;
	bh=qdpaaLgt8W2/BQ4HUETUhLUnGpJbxvJp7Jj1U6z7WKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSjpp2iehor8ADIa68Gf3P2DpWvTPg8AOKziyOdMDC4XjCfziVoNJjG7FJ802Fvl/
	 Jyv4oR/fsthJAvNqfCE6qW9q1qxo4Vi6bVQHWz3TqEpUqdfa9HGcJr1R3qlGzpSV5x
	 1jb3ePSANKYE6ogpl0m2pP/ENCccUyYfSLk1f/qE+6g8SzlsCYdMkTu7FnxNpTwAnB
	 O6o1B4s180sQltvzt5ucoaLpfNpAIAMcXXL549azO1P1K9wm048n111y/zFcFxp0kx
	 kEkrsmjOZP9ll++4xFC1BrTkIEM0e/WF1ckPC5oehQRs8BluPUz+Ary3mVgAb4uIgf
	 nJUwIGrq+dvQA==
From: sashiko-bot@kernel.org
Subject: Re: PCI: Prevent device lock leak during bus reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhang Hongtao" <zhanghongtao35@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821021626.1874602-1-zhanghongtao35@huawei.com>
References: <20260821021626.1874602-1-zhanghongtao35@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:10:05 +0000
Message-Id: <20260821021006.3AC3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fixes =
pci_bus_reset while leaving identical lock leak and Use-After-Free races un=
mitigated in pci_try_reset_bus, pci_slot_reset, and pci_try_reset_slot.
--

--- Patch [1]: PCI: Prevent device lock leak during bus reset ---
commit 0d6c89d5cec5eebb33879246fbc7b446f026613a
Author: Zhang Hongtao <zhanghongtao35@huawei.com>

PCI: Prevent device lock leak during bus reset

This patch fixes a device lock leak in pci_bus_reset() caused by
concurrent device removal. It takes a topology snapshot under pci_bus_sem
to guarantee that all locked devices are unlocked during a secondary bus re=
set.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..25a1e44263c32 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5585,21 +5667,31 @@ static int pci_try_reset_slot(struct pci_slot *sl=
ot)
> =20
>  static int pci_bus_reset(struct pci_bus *bus, bool probe)
>  {
> +	struct pci_bus_lock_context context;
>  	int ret;
> =20
> +	down_read(&pci_bus_sem);
> +
>  	if (!bus->self || !pci_bus_resettable(bus))
> -		return -ENOTTY;
> +		ret =3D -ENOTTY;
> +	else if (probe)
> +		ret =3D 0;
> +	else
> +		ret =3D pci_bus_lock_snapshot_init(bus, &context);
> =20
> -	if (probe)
> -		return 0;
> +	up_read(&pci_bus_sem);
> +
> +	if (ret || probe)
> +		return ret;
> =20
> -	pci_bus_lock(bus);
> +	pci_bus_lock_snapshot(&context);
> =20
>  	might_sleep();
> =20
>  	ret =3D pci_bridge_secondary_bus_reset(bus->self);
> =20
> -	pci_bus_unlock(bus);
> +	pci_bus_unlock_snapshot(&context);
> +	pci_bus_lock_snapshot_release(&context);
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but regarding the RFC question in the commit
message about extending this fix:

The identical lock leaks and use-after-free races remain in the slot and
try-reset paths, as they rely on __pci_bus_lock(), __pci_bus_unlock(), and
__pci_bus_trylock().

For example, __pci_bus_trylock() iterates over bus->devices without=20
holding pci_bus_sem:

drivers/pci/pci.c:__pci_bus_trylock() {
    ...
    list_for_each_entry(dev, &bus->devices, bus_list) {
        if (slot && (!dev->slot || dev->slot !=3D slot))
            continue;
...
}

If a concurrent device removal executes list_del(&dev->bus_list) during
pci_try_reset_bus(), pci_slot_reset(), or pci_try_reset_slot(), the unlock
loop fails to find the device. This leaves the device permanently locked,
causing the same system hangs in driver bind/unbind paths.

Since these paths are reachable via PCIe AER recovery or hotplug events,
would it be safer to extend this snapshot mechanism to the slot and
try-reset paths to fully close this race condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821021626.1874=
602-1-zhanghongtao35@huawei.com?part=3D1
