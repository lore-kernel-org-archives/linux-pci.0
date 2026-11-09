Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246524;
	b=4bpF02fTi7a0Iqrx++epm16HJ3MPe1Mvo3j2eP+yeTdLtQ35JKWGov5NejX8JM2zjAAT
	 cZMxpFoW7rWy6v1bYo+l7YTOYYLyXfaTKLcpP+PLip+vdqjUEzwlzaE5l66Y6Z0hvdgP4
	 VoAbApXgZDXAu6b3GcQx2QgkHHK6Ufy5occZVBefQJ+5aLnegDJM6kQnxEACB1TKOaprm
	 9OBe/2jSlJpBafw2VlT6abMO3g4HRxpPNekeDtufeWhvElQCCnNrMtUcfWXXHiHnlkWFf
	 oIwLBLJaDHhh1tSsr/ajFVPXIhMHtmjCXeThkXpmhoVKGo1TpbSC4c2mSG+pD6TwCvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=upFR4SkgBoh4fWlRxpP3s3RvH08xGmmO6ga5U+SKogk=;
	b=jGhU4JWMXoLJgZbQe3OFd3mXDyoPwoko5F0pSiy+wIWcutPzG/xid1DQoIgVEfgcPr3V
	 jOqA+h1lDBYk6WpH3nox/yIxabMzaAdvfaNyqgZ4XR1j4cbUpuy+ziWScEuiOkeUOE/Ut
	 NX1F6UxoEWFyvp9DIw+lOpsREXdzqy4si/ZhYNaDjToiRVBJ3lFozi0Py3c8RS8pvBnv5
	 V/gc+wtN+im3CIFvZiPlxo6pt0weAoEvqlnB6oSOX7kdbTkNkpL08EpV4kBOciuyufa49
	 agxgrOGiO5odJsXAeAMnTHqn/q256DKx/r7NUcYnDEBV5gI3pE6/nhDzIavSyMa/vkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTQo0pCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7660A2601
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTQo0pCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178941F008A6;
	Mon,  9 Nov 2026 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246523;
	bh=upFR4SkgBoh4fWlRxpP3s3RvH08xGmmO6ga5U+SKogk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JTQo0pCzz1a8cxRtKhRfcrZKCORWdrmCZl5u4jHoI+6ZNHL0tjK1MwRpdCT7slTXU
	 KMY3V57xJcnUPgcMinozFLYdqxcgLDuiUdpBJtMYMz8cQlyvcv46b/CwnBQ5xZMYTz
	 SQJ9lA7EfubVNugKdPDnGB03Hu/JJKNP2EUNmVl03W+Lp8cgpgDTcLmpKwsDTbNSaD
	 Qq5Lv+nIj9b7frZuYK5LNxN3mto8pYFc/PJXjVKcRjd1W5PGfndKC3uy5Em+rLimQE
	 KcCbAN1nFltTLN9yPgzO0OMdnW8wKkd3GBSNsaW42eHoaZpkYted+TsvuLbuu56kj4
	 5DQx+lBWVHKEg==
Message-ID: <sashiko-outbox-205342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>
In-Reply-To: <20261109174009.735309-1-dmatlack@google.com>
References: <20261109174009.735309-1-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:48:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the code that starts and stops preserving a device into
> pci_liveupdate_alloc_dev_ser() and pci_liveupdate_free_dev_ser(), and
> split pci_liveupdate_preserve_device() into separate paths for devices
> that are already preserved and devices being preserved for the first
> time. Leave a single refcount increment shared by both paths.
>=20
> Since upstream bridges are preserved once for every preserved device
> below them, nr_devices is only incremented when a device's struct
> pci_dev_ser is allocated and only decremented when it is released, not
> on every preserve and unpreserve. Keeping that accounting in a pair of
> helpers makes the relationship explicit.
>=20
> A side-effect of the refactor to pci_liveupdate_preserve_device() is
> that preserving an already-preserved endpoint after it is frozen now
> fails with -EINVAL instead of -EBUSY, since the frozen check now happens
> first.
>=20
> Link: https://lore.kernel.org/linux-pci/20261106173427.GA1633106@bhelgaas/
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109174009.7353=
09-1-dmatlack@google.com?part=3D1

