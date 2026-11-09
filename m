Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235943;
	b=Rzs5xqWvA9hwLBmKcjXRZXma7BYw6+CSIwVOu2rj93PWIHson0+JsmzGs6G5RqIaY8Y7
	 nPqFSk2Unm1sbB9aouQf8ciajkSUCoobSkpwNcQkGrY8C6czkFxgXctVLJPbizI+/y60S
	 gt63NBB7HZzbmG8fEOQNQLwxwtfTHYC+RsG15zN9i1TdC/Bqr+VIryq0cZMg1HuhGSCtb
	 roKp3Qgv9YlmLRbVd3jsfTKERPlxbnWaaPNQr5opJqKUDZ+d+5YX7jjhGVDBpbP32gMrL
	 kw6k0gZKZEwsZ6Z+4lO5bhfk71vwVJnXpKUsVYj6re3J3aTQPHc1nReyGJX/IoWlS6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pANCHoT/JQku+E1Hs/hXJDCmp3PCvnbIYOHS3mMNmC4=;
	b=jnVRSXRswYXIIDVGYxYV5uLl+wpqxm7nyC0SeN9/TbvWC98Uu1UtWJp4KoLY3cL+TVaK
	 1L9Cvm5OFq+8wtlabMlBO9s34DsU+rgTFLeGZLfxwoVMFxeni8huv8NXVEAo8Amm6zQOj
	 4VT29f5la6t8m8o5C5xu5/OBWdv/nFWWnjPH99srcMP9dbnv6/+mshY7X40it913B36K0
	 Ab2iLLbMkmEYdLQhy2vRm0epeOXGdlja9z8hNT079BBu+XrctLKnzWFYqfdAPs+f82vjm
	 qggrh4kq4xHwwcy93GbeXLaN9Fw46gngHS0+NVprXpC7RMvF6TvvvjeGxKBdkhkeeiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vayzsb3x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967DC606A322
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vayzsb3x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A52D1F0089F;
	Mon,  9 Nov 2026 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235943;
	bh=pANCHoT/JQku+E1Hs/hXJDCmp3PCvnbIYOHS3mMNmC4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Vayzsb3xhTZhWEa8f5bFm+6Swfc+H1HAilp5AXCq9ybcBZ9RG+tb26bmti4wz8YJT
	 w8lWI+wGzaYT6LfPodHE2Q1bw5yn9o0CLfFrlt1m52K4ajb0BoWnqr44/usaUj8oHQ
	 jjN9/+21UCwXXXIkSP9nOdvM4lO55iCIXXt/y0/cuQu0V0cuqSc84hwCG37wzbXxRC
	 5qXNHM1Ois99XYwD3W8q85XiB5Efm7AGIkwP3eqkPdgxYoukw8m6Cyn9GuXjp2g+nV
	 E6dMtqhBBDSIal1dy+wMR6N4NKoqXf/JWzd2JLWdg3tSsHI9ZOrxbMEDz/oVIdzocA
	 AIQcYniIigCzw==
Message-ID: <sashiko-outbox-205135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: Fix NULL dereference when shrinking window
 without optional size
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109144553.2516-2-ilpo.jarvinen@linux.intel.com>
References: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
 <20261109144553.2516-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:52:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> adjust_bridge_window() assumes a bridge window it needs to shrink is on
> add_list. A window is only added to add_list when it has optional size
> or alignment. When resource distribution gives a window that is not on
> add_list less space than its required size, res_to_dev_res() returns NULL
> that is unconditionally dereferenced.
>=20
> Consider a hotplug Root Port with no spare pref space and a switch below
> it with two non-hotplug Downstream Ports. 02:00.0 has a 2M pref BAR below
> it and 02:01.0 a 1M one. Alignment leaves only 1M of pref space for
> 02:00.0, and hot-add (emulated using a remove+rescan cycle) crashes in
> the inlined adjust_bridge_window():
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   RIP: 0010:pci_bus_distribute_available_resources+0x19b/0x4b0
>   Call Trace:
>    <TASK>
>    pci_bus_distribute_available_resources+0x468/0x4b0
>    pci_bus_distribute_available_resources+0x468/0x4b0
>    pci_bridge_distribute_available_resources+0x7a/0x90
>    pci_assign_unassigned_bridge_resources+0x43/0xe0
>    pci_rescan_bus_bridge_resize+0x23/0x40
>    bus_rescan_store+0x63/0x80
>=20
> The required size must not be shrunk, so return early when the window
> has no optional size.
>=20
> Fixes: dc4b4d04e1ca ("PCI: Prevent shrinking bridge window from its requi=
red size")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109144553.2516=
-1-ilpo.jarvinen@linux.intel.com?part=3D1

