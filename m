Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290165;
	b=rmtHz/d+1v78BqhH5z3E92+mu+Gsl1Jt/Oxj11mkfmVDRncSmywR592pu2c61envbWM4
	 kmXVbpFTBw4E9WCSvfvKcHNYBWtEFznpvR+2mwE2YDtwmjI5UiQs0jDLwWXru+lMNsOtK
	 FcimPlcOFW1esALedjjmhAEHsr0rl93xqbK1tSb3THS1gwFEARVBJRvvfOJwHHG+9+BvZ
	 VBB7d0yOwSW/puklML9KGVGSWhgIiP3Wthkyn1yp0SJuomf9eKmXIoLny6ZHLoD1hfSLx
	 yLshXDI8b+CsDA5jBQaUrvKJbVrNn8BwmYDoY1K3XsOKL4sPkUNxwFZzRSFOWzCh1Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290165;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=InU34aQHl2Y1/PYvcti4YCFewZ5eYohHaIfKHTk063g=;
	b=FdDO6EXIiuSctvOsRocrg5UpA1JdD/hoX5MeesV50kbkWmX5MgjOxaHT9kyNt6tC2gem
	 0jDkPrpvs2YzNGLftLe/Oou5D7mt09m311x8Bb6nU8ICFLM7gPxbiaHGvTSyeHS6ZCO1M
	 nzI8Z11RIR+Zer2JLn3xjxpftvDyaPtjtNoHv/xy2MeYaHRmI7v8kdNK8ojA7DsjejVMQ
	 KxNuQcAW7cE3AeQUWCrQlWXSEJCEBE7+oc7WPYoK9TfsH9FcjF1+oge5MBfNEc2gy/hUc
	 iQSpmFnPNMUXXRE3G1bjmNZMHQWgHw5u7r926u77SKnQwpQoLwk44AqZfmu7QHU7K1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Va39L7/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A152606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Va39L7/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB77E1F0089F;
	Tue, 10 Nov 2026 05:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290164;
	bh=InU34aQHl2Y1/PYvcti4YCFewZ5eYohHaIfKHTk063g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Va39L7/I8Er7CPaFTRbCU0gDU8WJFnvz/NfcgY9NvLAB6xUiaMXoU+mp4ehIvV/Gu
	 5xXeaM9NxSqYGnqWneBhpwNWl1iuMfuqRcssSraMSacxFeiCaLF1ce/Ea8xRHWhmtM
	 MQpIk5AyE3C2/c53Yd2TFfsDXRG0JbxGp025mkw8pZeU+se5hVqHEbAVIu0IDMsxM5
	 RbgkwVbnaikf1Lvqzdv/fq7iNOMPrTgeJFN5BYS+mJhUrtITs7BIJzSi0Sdip4lzX+
	 YRRDJZnB2nBBu5dtT70umikn8yeUy9Fl59Kg+4yYez9eUt1EJYzOw7v76JX2mCMo9A
	 SjQ4txQUXnL/A==
Message-ID: <sashiko-outbox-206355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Clear the bridge's subordinate pointer when child
 bus registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110053410.2469-1-lirongqing@baidu.com>
References: <20261110053410.2469-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:56:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: missing Fixes trailer for pci_alloc_child_bus() error
  cleanup
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] PCI: double put of bridge->dev in
  pci_register_host_bridge() [1]
--

commit 145a85e5894672f4949013776fe03b0bdc6734a5
Author: Li RongQing <lirongqing@baidu.com>

> PCI: Clear the bridge's subordinate pointer when child bus registration f=
ails
>
> pci_alloc_child_bus() stores the new bus in bridge->subordinate before
> device_register(&child->dev). If registration fails,
> put_device(&child->dev) runs release_pcibus_dev() and frees the bus, but
> bridge->subordinate still points at it.
>
> The caller returns without scanning the new bus, yet the rest of the resc=
an
> or removal path still follows dev->subordinate:
> pci_assign_unassigned_bridge_resources() and pci_stop_bus_device() walk
> bus->devices of the freed bus.
>
> Clear the pointer before dropping the reference.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

[Severity: Low]
Since 1f2768b6a3ee ("PCI: Fix reference leak in pci_alloc_child_bus()")
added the put_device(&child->dev) call that frees child on registration
failure without clearing bridge->subordinate, should this include:

  Fixes: 1f2768b6a3ee ("PCI: Fix reference leak in pci_alloc_child_bus()")

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 222ad696a1581..efa85ae052106 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1271,6 +1271,8 @@ static struct pci_bus *pci_alloc_child_bus(struct p=
ci_bus *parent,
>  	pci_set_bus_msi_domain(child);
>  	ret =3D device_register(&child->dev);
>  	if (WARN_ON(ret < 0)) {
> +		if (bridge)
> +			bridge->subordinate =3D NULL;
>  		put_device(&child->dev);
>  		return NULL;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but does
pci_register_host_bridge() [1] drop bridge->dev twice when
device_register(&bus->dev) fails?

pci_register_host_bridge() takes a second reference to bridge->dev via
bus->bridge =3D get_device(&bridge->dev).  When device_register(&bus->dev)
fails, the error path jumps to unregister, which calls
put_device(&bridge->dev) and then put_device(&bus->dev):

drivers/pci/probe.c:pci_register_host_bridge() {
	...
	bus->bridge =3D get_device(&bridge->dev);
	...
	err =3D device_register(&bus->dev);
	bus_registered =3D true;
	if (err)
		goto unregister;
	...
unregister:
	put_device(&bridge->dev);
	device_del(&bridge->dev);
free:
	...
	if (bus_registered)
		put_device(&bus->dev);
}

Because put_device(&bus->dev) invokes release_pcibus_dev(), which calls
put_device(pci_bus->bridge), both references to bridge->dev are dropped
and the host bridge is freed before returning to the caller.  When a
caller such as pci_create_root_bus() then calls put_device(&bridge->dev)
on its own error path, it triggers a use-after-free and double put.

[1] https://sashiko.dev/#/bug/linux-274884f5-d0c4-48cf-95bc-82c1e0b3753d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110053410.2469=
-1-lirongqing@baidu.com?part=3D1
