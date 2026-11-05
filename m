Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894780;
	b=sVj77Lfn0vNVJoaL/Q/y+DK6EovdYCT6Fe26VVEc22uAhkPohIz0IXy7Cm4zgky2D92f
	 TI4g3ylcx7aRhCvQUcid04HLjNBnAhWs3q+Xc9xLdVY6fy8+wxw3ADZ5jKYIwpXBQIWq/
	 PwUif4KInBr1ykagI7Clevs2H804napUnacDW4YvvWPLw+pdsniPtrI570Q3q5vviB0Sm
	 8ZbxVR2pW86GSNfyKxhvOGbYokNFv7a4sSNNz5PFUzL3F3G9XuV22s8PiZGKRTEze+Cy6
	 Q59jI04FpEV5nsbqKb3+AblJYuXwENaEg56xAKRutV8czHVBP19McR1qzt/ww/ccfFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1OBuTbtxOzrSypFQt0h3xmCQ4ln8aIZkQlga43QybaA=;
	b=M19TPvip/pTtzNlF/yW7/AXCYpYZ/m6EtzvoSgt6bFB18HTSqPP/pmKYj49Zqx017BlM
	 fVTuYJn5bsjrabe2k+3tRSqUKmZHR38uxlC8/OdY++fd4HAVUeJhB5353l2gap2PoAigy
	 EuJqnoJzT7oYujZIrOChQZe3NgsrzY4YAXN2JGlfZIX7BQ9aRy9bUn4hI3DCgrQ+w7Cd2
	 eKLRuLtr3JfegvpD0mWOQjPMKcTfjPapAmci/m0eyBu9ZmLOqHI3zKvkFCUxYhKecmQy4
	 DNDmu0cduBStOosoZctDgm3PZem6jzpGpiNQAHLWQ3wIJsZSA7r2g1EMadXlydZNzDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkINU0OO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A760606A333
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkINU0OO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7441F00919;
	Thu,  5 Nov 2026 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894779;
	bh=1OBuTbtxOzrSypFQt0h3xmCQ4ln8aIZkQlga43QybaA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IkINU0OOU6GupibC5prP0qt/9vA0p52X6YPDXmFfiMuXZ/SY/yHEKM5DdISALP5sQ
	 IbW54N+4JSVyOEWQgVmKmH405e7H1oOmkftSLNyjSBEUosaFyS45/0PgfkYGoWm/fx
	 rEDfLjeVbJJmImpXnqtkXiFim/pV3OHmk7EkpWWFk9zLJCZSTmvcaQXK/PiFTGfZTK
	 khviBeq+TruUKHgfUhwJZkiZstS7iCs49kR3rW/98of0X3IZ2/q7iMIBovP5GcWr/R
	 tq3RkXJRyzs8OLqkw1pQH1BPnc+64U+Sp5Ki1VMWW1mWKVhO4541iqxAxMYj6jS2ok
	 auhG4GKBWoIAw==
Message-ID: <sashiko-outbox-199409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI/ASPM: Handle missing link state in sysfs reads
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UG91bGluLCBMb3Vpcw==?= <poulin.louis@student.oaklandcc.edu>, linux-pci@vger.kernel.org
In-Reply-To: <CAGQButuh2zJ9dvNc4ioqaSh32EGChc9Z3HORr9DwnNd90=zgCg@mail.gmail.com>
References: <CAGQButuh2zJ9dvNc4ioqaSh32EGChc9Z3HORr9DwnNd90=zgCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:06:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Louis H. Poulin II <poulin.louis@student.oaklandcc.edu>
>=20
> InputPlumber can hit a NULL pointer dereference at l0s_aspm_show()
> while reading PCIe sysfs attributes on an ASUS TUF GAMING X870-PLUS
> WIFI. The same fault was seen on downstream OGC kernels
> 7.2.9-ogc3.1.fc44 and 7.2.15-ogc1.1.fc45. The latter logged:
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   RIP: 0010:l0s_aspm_show+0x47/0x80
>     dev_attr_show+0x1f/0x50
>     sysfs_kf_seq_show+0xa8/0x110
>     seq_read_iter+0x132/0x4c0
>=20
> The faulting instruction reads at offset 0x30 with a NULL base
> register, consistent with accessing the ASPM state through a NULL
> [ ... ]
> ZhaoJinming previously proposed NULL checks for the ASPM and clock
> power-management sysfs callbacks.
>=20
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2607.3/04295.html
> Signed-off-by: Louis H. Poulin II <poulin.louis@student.oaklandcc.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CAGQButuh2zJ9dvNc4i=
oqaSh32EGChc9Z3HORr9DwnNd90=3DzgCg@mail.gmail.com?part=3D1

