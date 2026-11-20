Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182955;
	b=vvfnlqA/BN4XjZM6y1G8hOGRtqlbkK+Aya0eJjQnDChRVL/GCuXrb7q7xUrH5cavZ/Yj
	 qmmB/D+hC2O4gVXcH/7p/ONlFe3Rmfs+XDGaf6WxkF1S3NNguAwswZnEucQzzcR4wQZZU
	 U5GMe4QIWOjLLymIG7jBcCKYPFZ0uBCb+57EBgvjr2k06qoG2oUc08gskcayHzNu7OYLo
	 5+eZBKAKDUu70OjLu9jdLRkwVXfmFNlBcOIAM3oAIrt3gEcSvHvlIcaFDBhfpJwj0Kvi5
	 tgr7SAUfrlU8sL/Q6Hi89vxoTZwj6IABuwDUkIGnEhwtdv5skfYbQvqIno4A6yVP9RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vRPbYWur9ifj7/xymnBvhlxP7OVgWK15b60a5+viqoY=;
	b=nYc9P6ETJF1eOvtd//11VRPjgptSRrZoCRewBunVgC2D5rs61BiNQFphTPp1IS/m5HV3
	 q7cEDIcLR5f15Ytc9aw4TJcn2oE/D6NRUAeA/kr/rf2cLvblk3Rx0iT6W71O5r2VbEzXT
	 0FipTh5cEFztyZO8f4Zy80UH0oFEVdTBgnrOttFLrgbdunHlx57CwPCGBetkVMi1EoyVZ
	 /C6jK1r97RrQbZqWAWAvz4FrwIDqgvuJs8DDHe2Ly2MCPmN2NzKW/3Us8tWdj4ByiibuQ
	 /YKghRBdU9lFZNNK+MVxDfFcq6POSJURWv/JX2xu/2BgUFtfAuzA+Bc5Qc2SRRiei3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SrDyYl3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A364606A332
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrDyYl3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96181F000F2;
	Fri, 20 Nov 2026 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182955;
	bh=vRPbYWur9ifj7/xymnBvhlxP7OVgWK15b60a5+viqoY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SrDyYl3/R+C0IHjvShOrrrBKn0NuM3Gx3kpuqg3WZe+iitXL7GqLujYP7rm+8E4z3
	 nzG0qQLvzy10Dvz/TtuHF7LGnY1qS0yWmTvNLSU9mZ/zOYIRzH6CJFFVwe+NhlGHXm
	 VmP2DlG16TjSubuXIGG5x8AWw4p8tHPShCv7TuENE9NBujyVAxGjteDe46LotRoegy
	 h9mJO1kt4PEsBfiz3KxOrIaSvBL4QFPgH+Tqn2BUVkA0hUnlqNGoo2b6m7QVwTcZi1
	 KGCblSVYSyHmYWZGHFuzg2Cvi7dBGaV/W7xUjisOTHvgSNUceYtuzft29gF1e4EXEI
	 Nj+jkU7dqAKbQ==
Message-ID: <sashiko-outbox-225300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/16] PCI: Hold pci_bus_sem across sizing and
 assignment entrypoints
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-7-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:55:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The bridge window sizing and resource assignment algorithm walks
> bus->devices and inserts resources of the found devices into the
> resource tree in many places. In addition, its internal datastructures
> hold references to devices and resources it encountered while walking.
>=20
> Most entrypoints to the algorithm do not hold pci_bus_sem, and
> pci_assign_unassigned_bus_resources() drops it before the assignment
> phase.
>=20
> pci_rescan_remove_lock is not held by all callers and cannot be taken
> by callers running under device_lock().
>=20
> Protect the walks by holding pci_bus_sem for read across the entire
> sizing and assignment operation right at the entrypoints.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D6

