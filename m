Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848329;
	b=EzxWwaL3ZVKeypD+I4424+Oca6TLdUT+e8bn6bC1VeNAw/TDVFyCml71OoViiGpWkGn5
	 ZwlMdRceu006tGBfoVknEh7jH7FGXh/31HV9rZ4Dml7p4v+Ku7+VxMDEhFhkRoZ9TIvJv
	 Udj7dTa1By1iPv7oSww7d+oOVxFS5ukVENEZV1AZvbNEW2rvGulWMHf3A4yrJ+eau7LQy
	 aMVW6+Vl9BE41dcfWz95PPjN+Eo9/eJS0sNezt5mBUiKuzB2g5oIYh5vYn8gIMQtCoGk8
	 MPwBSH4loezGr1zBfy9L6VDCLOI9XMaVIv+Q8ZtuiPHh4RaJsGJi5mIVLP6cfiJmeEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ews1IsOntmplwjUxQR0FhDki/YYWz1j6sP1oPz6TD8Q=;
	b=K3D+m8Ol8YhASCZ7yk2Lef1vCQMCNWCXNk4zbKYf0rx3qhANPyCg5e/o+YlZXzwCewqp
	 fBwg+4sa/SNuvtEFgAKWfh/Gd2wpv6A6Gs06rSDHii5uxV98brUZp7B5ZyY6ELti+2iqq
	 x9Kye/Qm9IM5Vtwp7ovTu09gTtd3x/7Rd9xPgWhXHxOh22Zhwk8iZOx+ktscyOJ2LLFzP
	 dEc/c7RduHMBb5gahi8goRdEg1dNFPKmW9GdFSj1Urp2q/mY3kouv0Wr3XxYDlFxj/W9n
	 xDtjsfZlvM69eIYepTfJYKGZbNHBtM7zqs1yI6BMF7nibCDBEV5Pu9VBlAfpBZU041g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LAhw/W7k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C21606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAhw/W7k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CE21F000C4;
	Mon, 16 Nov 2026 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848329;
	bh=ews1IsOntmplwjUxQR0FhDki/YYWz1j6sP1oPz6TD8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LAhw/W7kN2YNR5RVBLpoNBEihjU/+AGOdckgq8fttj/OD72VStaHtZfnmCJE3COls
	 nrgYjp5IkwUW/eqUBOst1QD0Eja8eDu+f4sWIaEQHSwWjZ0VsbOB9XSBAfSb0C8sgH
	 vd7lEPvZqYJUtUVfcwP3Kt8zgLLLtYXix2aAuLcWuRHgE+2xxayjlEFfGQiEwdVhS6
	 uXkoS3v2NdZSNdRmouiZyTM71hVUkxCgo9Dobdazk6XRaY5IGq3AX4nR9RMCduLrsr
	 UiZLKIGP3d5aeh37vYR6jGUEW2kJb9+nLVZf1pSo49hGIA3xEi76oz4P0kMUAyfb+X
	 ux6lfrWSBd84Q==
Message-ID: <sashiko-outbox-217399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: Avoid runtime D3 on Amazon PCIe switch
 ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116165110.2773301-3-avivb@amazon.com>
References: <20261116165110.2773301-1-avivb@amazon.com>
 <20261116165110.2773301-3-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 16:58:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCIe switch ports on AWS instances (vendor 0x1d0f) advertise PME
> from D3hot but do not send it. Since commit d4c79b63d82d ("PCI: Allow
> D3 for native hotplug-capable Root Ports on non-x86 platforms") these
> ports runtime suspend to D3hot on non-x86 platforms, and hotplug events
> such as an ENI attach are lost.
>=20
> Mark them PCI_DEV_FLAGS_NO_D3, reusing quirk_no_ata_d3() renamed to
> quirk_no_d3().
>=20
> Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports=
 on non-x86 platforms")
> Cc: stable@vger.kernel.org # 7.3.x
> Co-developed-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116165110.2773=
301-1-avivb@amazon.com?part=3D2

