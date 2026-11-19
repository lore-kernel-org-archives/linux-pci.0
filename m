Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071544;
	b=Jjy15gwTaMntKjeBhGgvKWAOi8CsEb6a8A0T9/q/1/8JmCoPmh2i3UxaHXrnihDcCNcC
	 4Dvwe0k1c8B8uUVy+4p1nhzwUL57c7qAsC8o1c0J17fljrbaL7BjuPJClt/POA+37Z8Df
	 PLNRKO3N8f7sAa/7NdBSt18xR5L2iFyLp6V6XHMmv1yfi1B9o2niX86h4kGwgkW01s0pw
	 ET7XxiPkAvq5dlraUd6kmKEb3f2gftTp854uZ18Q7t3y5LuClGQhXWA8DzArjomny3XPl
	 GHO7veXd2dy9oEqAOl34gA0GctqkZSPc2p9l6KeY98oEyv2hSkuCQ9meeOtJ9y9OjMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071544;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+pvbgnIm1CJA5ULWF722PRe4yjTIxfG6rRBmrlUhpU8=;
	b=Jf6J8cCOssSe+WrkzSlFk4JpBCWh7/JSlc6VWVPFYJgOTrC3G0jcNAP1826tIkiokpja
	 /fQ2vuFMh6RPH1gnJzu1DO/EMrhhRyA9VJvr8O4MmlbgBJHsdCedf2NjaHMuTNgmS9EmT
	 OZH0/G/9K93J+tJYfA7ANqI3FlHOingjYdoQbC+YZjwyFinyEDzROkPV1jbkHQ+qROf+N
	 Cl1BsEQ9lpG9cboSmfpTfGocgDnuyr8dVtQPu4r7jo0H9OuIkrXQT1PSBifgwGecjlEIW
	 FA9F3Mhn6T7aPok+l1maNbVaYO06R8dEfi9z4NsjawU09Zz86ypdpUP1KeH82bqPyoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUWiquaR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EF606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUWiquaR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E6E1F000C4;
	Thu, 19 Nov 2026 06:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795071543;
	bh=+pvbgnIm1CJA5ULWF722PRe4yjTIxfG6rRBmrlUhpU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUWiquaRif1l6Q5W6pR7fNA68ed0+foRjx2TliWM8hROWBqpcvsqoZ+CqwDP7QdrM
	 t81EARAKTEYuT8PKy2ksCI8IKLqUhnPTNAS+1DgHB0Hs5fSlcnjHrwlGPNPfmtHidh
	 TMpBBX3FUyxbyJZgSzurLq5yHTnsj4ehRD771v28RmCJOtWkVmywUDxx+Lw5Mm1LgV
	 DDvkb5Ct3/TnXqIi4KKD5dEQSXZ4wYjj+9OSN/EAJ819ctsmsK4Hw3vxgehHZlxB4Y
	 n/8YfN7toOEYCWOibCspDvC2b+ZmGUbPzXVNn0stAuExJcAH6xWxJzUqeAqZoa9KmE
	 8a7otvQeICt4A==
Message-ID: <sashiko-outbox-222536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/IDE: Destroy host bridge IDAs on release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaolei Wang" <wangxiaolei01@kaihong.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119065429.1824738-1-wangxiaolei01@kaihong.com>
References: <20261119065429.1824738-1-wangxiaolei01@kaihong.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 06:59:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_ide_init_host_bridge() initializes two IDAs embedded in the host
> bridge and reserves stream ID 255 in ide_stream_ids_ida, which allocates
> an 128-byte IDA chunk.  pci_release_host_bridge_dev(), however, only frees
> the resource lists and kfree()s the bridge, leaving both IDAs undestroyed.
> The chunk becomes unreferenced once the bridge is gone.
>=20
> This is observed at boot with CONFIG_DEBUG_KMEMLEAK:
>=20
>   unreferenced object 0xffff000100d4df00 (size 128):
>   comm "kworker/u16:3", pid 52, jiffies 4294892598
>   backtrace (crc 6f8346e1):
>     kmemleak_alloc+0x34/0x40
>     __kmalloc_cache_noprof+0x3c0/0x56c
>     ida_alloc_range+0x42c/0x554
>     pci_ide_init_host_bridge+0x130/0x170
> [ ... ]
> pci_release_host_bridge_dev() just before kfree(), symmetric with
> pci_ide_destroy() which handles struct pci_dev.
>=20
> Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
> Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119065429.1824=
738-1-wangxiaolei01@kaihong.com?part=3D1

