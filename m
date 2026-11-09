Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221988;
	b=5WlRy3zKF0Myt2uzkx2GEAa0iQ5TCwMivMyL3V5dZ1FYumuvkZQQ68BQyMEDrmiTYLOy
	 LhiKeIrUj+g8c5VfMfCL9DX54Yqyo1Fj1VMISMFmotLJkiL5hBjufSoEibtIibyFefkHV
	 8i1f83t1qugzG3xG3eKAMTPMtdYJG6rHDuEp/OmOTnCnrnKGFNkdH3/36c/0pc36evMdP
	 wo+7DzTkgS3FoYm2Ku5e7ESHXDoomWuuez1MnOpJHH/a/2NXIWkG5jDbvzhmY6VkmF/R/
	 CW1Zy9HTXrP43PJDiWItft295p0mct3o6SbhIS7WNRDVV5hIs3lwKbgdptuTO8LwyfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g3PMu7zdhzOAGVBjCcicmGFr/XWyLfFOmEp/3AVxC6w=;
	b=EKNzy5N2hYZzYHmZr+/XAKj8eDo4zO0aF+qIBsev5c1yCrLtY0wgkj5Tt+5gnmsAunup
	 XRF1TJau4eWAPpIR/1Bwv2Upxl8gTF0ykQ+7ZLvAMua2KiZyAAMeYwm9unW/zJuLRcYX4
	 LhdBFOasE99ZEWhg78B4+AGO0YMWM0jGV4rQFZx+wFWxXut4sxTj0c9umGjhSnDqM5Kpk
	 S+7eaqwLjnIccwTSg/+BhIQgL9JSK31ZoxC/dNPdUncI1QFOhW8E854DnC3mIzkgkT3HA
	 IxP+8g/aDZhhQ/lkFwynMR5LtLhEYUmSIHTx96u2OQ/P7dAEI4tMyRhu5+TE+QAvNHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czhckDHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA759606A32A
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czhckDHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C8E1F008A3;
	Mon,  9 Nov 2026 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221987;
	bh=g3PMu7zdhzOAGVBjCcicmGFr/XWyLfFOmEp/3AVxC6w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=czhckDHUq08wNrUgUKcHHvbkhQk46yDNN2UWQ4dJVqUBs59RetFRLQfTkpE54oRq9
	 QOvwDhF/ixH9BOMt3GirCF+lwPPU4jUOlHyfOrzIa1RCwsWrfK9SqgWcFPgxwo9P5h
	 DjROK0Hu3DYT9MAu7ZMZUUMUtc4PgtbVZb2/E6EfRnTyLS0B9cxsaRzrstwvBNJ1R/
	 nKGIpVPL+bHkhiBPkiuSxdURIG3RBLJMo6+bPQstUqY8w+vXXcFjKEjzyHMOYnXz7f
	 TdIBRGVoKS3VV7O4RRd0tuRtZs3huSGVptGWlIpub4RTyI7tL9m4bYZuR2eJwQ8Abm
	 XyjyyCK8AnA0g==
Message-ID: <sashiko-outbox-204856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Reject negative resource alignment order
Reply-To: sashiko-reviews@lists.linux.dev
To: shao.mingyin@zte.com.cn, linux-pci@vger.kernel.org
In-Reply-To: <20261109185515838mOfBTIYMU1_4vygdxd-Gg@zte.com.cn>
References: <20261109185515838mOfBTIYMU1_4vygdxd-Gg@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:59:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>=20
> pci_specified_resource_alignment() parses the pci=3Dresource_alignment=3D
> boot parameter and rejects only orders above 63.  A negative order, such
> as "pci=3Dresource_alignment=3D-5@...", passes that check and later reach=
es
> "align =3D 1ULL << align_order" with a negative shift count, which is
> undefined behavior; on x86 the 64-bit shift count is masked to six bits,
> silently producing a 2^59-byte alignment that mis-aligns (or fails to
> align) the affected IOV resources.
>=20
> align_order is a bit order, so parse it with %u.  vsscanf() does not
> accept a sign for %u, so a negative order no longer converts: the
> parameter is reported as invalid and no alignment is applied.  Orders
> above 63 are still rejected and fall back to the page-size alignment.
>=20
> Fixes: 6534aac198b5 ("PCI: Bounds-check command-line resource alignment r=
equests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109185515838mO=
fBTIYMU1_4vygdxd-Gg@zte.com.cn?part=3D1

