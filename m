Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518072;
	b=G4AFM4Q7/2qBUqOqUaR7rkgP5TkbuuF9VV1ULiog2DfqkaI4L98s2JUw3u1+M1F9XjZq
	 nqfsWIk5gKMBt4uKYiKqR8UW3pilV0Tk1jkilPvAXVRlDdu7OX8Zoc2iEdQKlZOEp4wEb
	 y6xCI0unys3EJWnd1gffhuh+CX/oHk79x/8bSxGdHRRBrJfsRZ7Gwn7aJaYZtkKbcEuq1
	 HQvcjAlg3sGkRnfvWwQnVAZ63aLJvbQbw42rViLWlq4bUKywtI2LeeiWc2IRVlJV+zBAe
	 Uzs5pHjlcj3WnZaqfIYPgyo5bBMYBnPCVcgLSe195hpag6tBF/jPnpIdDUlbNZ31wyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518072;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4IFx3LZsh0QKtiMdrwYHgGlzGlhP3r07WXzIVRhp8gs=;
	b=C3g7cspI23E5JWPAObhsXMOxv8qBagNofmNG0HLkgVfrmp/CGgis436IKE3vjdwyyLqD
	 GRdIoycMzmah3bzY0MmyUxQ6Bi+TX0IMP5NHz0sHkTFPBHNWAQBtrnzwNC6FV158ts8jP
	 LrN6cRt6XH9Pz3RIG6KO61khSe6Z0fjtKvar5QW4gZ1kuuJEX/ZiHYP5NvYTUVmgL3gdc
	 0ihab/42phEBA4nLz+5tKSfhhiKT5SMHPved/WbJtkaIkU1tKBzHWEwEI2k1qRODbIZ8D
	 SK4RmOWnHS7lASjj5JhTVf4LAGxDw78L3MNcu1W3Dxl3jhaIcXo8DXtag/0sysX5ZCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4875606A32F;
	Tue, 20 Oct 2026 17:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D76C1F000CB;
	Tue, 20 Oct 2026 17:41:11 +0000 (UTC)
Message-ID: <sashiko-outbox-179431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261020173736.81755-3-pavel.e.popov@intel.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <20261020173736.81755-3-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:40:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> VMware guests, passthrough devices appear directly on virtual root
> buses without host bridge devices. In Hyper-V guests, each passthrough
> device appears in a PCI domain of its own without a host bridge
> device. Consequently, P2PDMA checks evaluate endpoint Device IDs
> against the host bridge whitelist, causing P2PDMA requests to fail
> regardless of host support.
>=20
> This affects discrete devices such as GPUs, NICs and NVMe drives.
>=20
> Add an explicit list of the Intel Xeon server generations from
> Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
> CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> restrictions. AMD Zen and newer are already covered by
> cpu_supports_p2pdma(), so only Intel entries are needed.
>=20
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020173736.8175=
5-1-pavel.e.popov@intel.com?part=3D2

