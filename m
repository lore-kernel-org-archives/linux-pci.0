Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494025;
	b=I92WUkXZSkqzU9gBoR7W6qiCAORSZhiWppQbtVDX6MgFd5pArPvh2ObuueXJTst5ML+W
	 T/OXBQUfy6dijcYBiNwPdCQwlnbMtdLmzVaptmc9RHmmAdgOTTpWvbtHIiphJQ6evs27S
	 HrM+zvjPOr/EEY1TY2MYqXuYcmFs1woRbTsEDzAA+HN3j70nkUzJJuPvBaDbwwoOV20H0
	 2F0xec5IcAWrrE7XZn2tvccGeG18Vqu2etR2XaNUf6K7+Is13BPFgijAqyKz+Dj/3IU6O
	 ff0QkNsFSCw08kC8MbwRymIAgLD4E4+MTAs1E7yOUbiBNrPU6QaRbn01pkVac4RcggA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Na/bxPhMJJatNkuNHIQdICorOo9HZ98b11hKUS/wbDE=;
	b=ZlO/IJshxm/IZvIKVgmQBXHbpUPLl7BWo4046cF8F599zP7Aws9m5ePzttGwFN3rw1lP
	 ElwJXS1kbDGSjJVjnhw8vsfznHR2u3155lDrKAMG69QHFIUJ8c6bLguCVZhpmSAKXjYeO
	 OscGpLfFC1pCZN6TwnZ16PdqvjgwPEIy+Wo+ZG2xmGY5oasaGJ2Og7zLXb2K7aZnIzKdG
	 t/28FMwUbVi5QgVhFirbd7ut9NRFsHBKN1RnYh0FxE8itkDACjnxDZpGPGvgYs+nsZhxw
	 +/4CDCYc8bfQUc7MNbhNlp9n477R68jyHQ0T+76NLCyHdPZO9LjWk070qdBi1Gr9+vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7uK8CSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41E606A327
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7uK8CSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86011F00A05;
	Thu, 12 Nov 2026 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494025;
	bh=Na/bxPhMJJatNkuNHIQdICorOo9HZ98b11hKUS/wbDE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=M7uK8CSSAdzrxwKFNGtyihGqw6v7hbIy7Np3hV8vyI2xhdWsx9AT09WmPoXac43C6
	 9b36iV1v2AS+dkO/K92UgkZ15zDkmQ8Ovi5ywKdU0LiUO/ye0s2XkOuddtlbVu8rGk
	 0uxP27GfcfqUF7lTy1F2WWRtP2ErDPv1kBv9wyH2H1fH2ZWY7sGT+On0yFUG4nc4c6
	 Rh5BuRgCq7jZxYSzMcAAi70P9ZIqS+H6mQepMl/i7Z7nN+TgxrZ4/ACHYnSSa9rm6F
	 1PEg+zYeuu44XXEOgYX5cp4zELV/lMuZQEmSDhj0l3g+FKk1m++G70HgfGr/jv8XFS
	 sztxdXdhUyubA==
Message-ID: <sashiko-outbox-211341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 03/20] vfio/pci: Avoid waiting for the bus lock
 when preparing D0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-4-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:33:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A D0 transition can wait behind a pci_bus_sem writer while holding locks
> needed by PCI error recovery. Recovery holds the bus read lock, leaving
> all three tasks waiting for each other.
>=20
> Use pci_try_set_power_state() for D0 preparation during function reset,
> hot reset, runtime suspend and SR-IOV enable. Preserve VFIO's saved PM
> state handling and unwind reset and SR-IOV requests if D0 preparation
> fails.
>=20
> Runtime suspend returns -EAGAIN on bus-lock contention. Keep its existing
> handling of other D0 errors to avoid leaving runtime PM in an error state.
>=20
> Apply this even when recovery is disabled, since global IRQ cleanup can
> wait for another device's D0 transition. Low-power transitions keep the
> existing helper. Subsequent patch handles config-space power requests.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D3

