Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728975;
	b=49a2H1ZE1fo4k7UUmwsxiZHNs01+lcpTHp0Ec4lWQNzf4eKbSREvPJd4/bSAyd670qw6
	 f4Dn780gogTI5drqU8I4m+HVH+w2X6UmOebikLpF4azhESGlGPy+BHju4n5F2s8RTahYH
	 QW9MCeojWOuOt2GDrM7NRLqDRN/6ZYRSVIsjDDGCk5hJAP3xkaojPdPLAVBMltvvMFQZd
	 63aRZDmaBY/bchTzdxJxJQyO51khmzQn5x+olaUlWEJAmtxDLnI5q9Gj9z7TudvsiDCad
	 uIdZohI8huiczglJ31WORVbOO+EfGny2BgNs8rOK3QKr9URJz878n/AEVCBE7MzLQkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dq6BEMG+ulAo9ixXA6mMWztGorLGTznQolobeotc46o=;
	b=INMRYRUuB8lZvMrG6njZFmYK7VMNUT9FNoBrfsFiOkSJAQnpjLUZl7+c/iRwa+jpricn
	 mLviHua2YMgmHQpRpoalArP5jG2S0y3VTP3K8YMbj0HLBVJ67hB/z5DenDtNn/u/xqHaU
	 J9oMjuIgQxemeazcnLHFPOr8IGqwz5gG5EruGL0DsYqmCFZy8qnpqGs0y6ufwzj9RyDTP
	 uPTgQ2+4WI4R9Z09n1nnOMoBYrW8F/h//68SpEa6ccKqRmMoerDluNpoqtTxjjx7660qw
	 DCoN9oLY9xjEiJfkYSvqQudbXaWOBocFtjE4H4lPnxc63z/S0whQW02KPIk9f4Qep2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7VptM+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C1606A31B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7VptM+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B5C1F00A17;
	Tue,  3 Nov 2026 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728974;
	bh=Dq6BEMG+ulAo9ixXA6mMWztGorLGTznQolobeotc46o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f7VptM+EOsCRSPONNAdCn01Sr5Il+6OFJw4CuP15pxaBIz/ikSHqXF7YA3A7hjAcx
	 q0cIQR56Zs7WSg/6VGNsTHJBHMC0UgEwDeplV0CCwMN1i1b+qZNRkFAeOvioLH3PNk
	 upYCvxfCTN8utsN2Q9RACt610DpLopyF9tnv4a/xErcgu5lxXGhqyKxS6Orh9qzUZW
	 wWEDCrE5ohqL805588vPIko+1ISdKJNsHucUcvJkffiBPxqNPXzRV9aCOPggvyK/ll
	 6yKlFqYAw0wgIxyi9nBv4hne6y1yA/4bjxPJktZcxrTVUJ4lsGCm+YgxkjSFMJ8PFA
	 ljoY1JcogEr1g==
Message-ID: <sashiko-outbox-195799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: switchtec: Add Gen6 switches to NTB DMA alias
 quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261103175208.481170-3-logang@deltatee.com>
References: <20261103175208.481170-1-logang@deltatee.com>
 <20261103175208.481170-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:02:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the Gen6 PFXs, PSXs, PFX and PSX switch device IDs (48XG6, 64XG6,
> 144XG6 and 160XG6) to the quirk_switchtec_ntb_dma_alias PCI fixup
> table, matching the switchtec driver's PCI ID table. Without them, DMA
> transactions from these switches' NTB function are not given the
> correct requester ID alias, which can misdirect them under an IOMMU.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261103170033.471034-1-logang@delta=
tee.com?part=3D2
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103175208.4811=
70-1-logang@deltatee.com?part=3D2

