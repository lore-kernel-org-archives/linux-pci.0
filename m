Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965423;
	b=g9FPKgLtrVGEetHYHruD/TjfpnsxkMkg1luasEQCROnxdok8bpxQ4frbSMJE6fYXuerP
	 bVvKpLJo17UG3u+7HPCIpxpVdR8WK36H/HxZYkbG0EwTWwcPDLOn+MPabVYdhLiRkkUnn
	 TyM9phMzf4kvSuEnZZls9+WFhuzREd6FucQNs/7eR10KlmMF2efdm7RTbEx6k5ZaMbBPq
	 1Da/3/4Pk80CfejREyAH6JOVVEz/Rs8HPFRBW7TiVHgwlLZfSBtL0MO2ShEqvqRn6YjwZ
	 kmJ48gFYizVXPbl7wRAhMbgbtN/8GnOl3UoS3wsmNmeqPAaoPyiNtV+NGumgc+7ytMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965423;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0sY6whUUX2vqc7mDj/L4VgEe2WX0ix3Orvb8NCUGY9c=;
	b=qsoDqc9erCtld8viy8k4LbplqXdGDP0caRfFPPFQK+ZTY63OFc3kgNfciOTei2AwoceH
	 FKPQ9eG72jgdwtDJjiiJ8vIkwTh0ax08UNPaclY1G+gwdFca12Xyjqc568ZytSN7KOJg/
	 aMX2RXq0ocUzYjuBLnrA5q+6D4jO54R/6UthJOD4YqLD4mqPCQFQJD/sFHwlNDJkckZoT
	 KBI222OVzJF8aAv5Yc7pyOHVl/h5UNozZYouNpkKjsBL3rXvePHl3vUvwUQo0tigKYFsq
	 sCOUoYXMUYKmEHL1MjO/iGEKJoQZBevi70+TqZhJmopdIUdE0BTUObBeVsns3eUECYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mijxhO+f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE99606D811;
	Fri,  6 Nov 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mijxhO+f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EA61F008A1;
	Fri,  6 Nov 2026 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965423;
	bh=0sY6whUUX2vqc7mDj/L4VgEe2WX0ix3Orvb8NCUGY9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mijxhO+fH2Z2sPeXAZM78WoGpkduVSLR3o1JKhLiOtU7OtuyXEsqmUpIF5+TBoUnb
	 I8XoqrNtZp78fIUX4+UNrZ3RQXOuvEZRHRmvD79mWXH3kCooPJT9U/HMzXELDKjyNU
	 1y47a9P93YNIdx50l82AFASvnGA9wgBIRaGBwO2DlYPB4CI39N1pbv/U9ghfEa5RSO
	 2g1R4wqil54Va9JXUpqc2ISgByRBDSpH98Yue4YXcSrJeYAdkpSpcVDSxpaai9X9wU
	 tHhPBpdn2VzYOyUgLXJG+olv3BFOGOVintQtb+1VUkCqMcsds05NS5uljfSL0xv81N
	 clGaCE0RzAMOg==
Message-ID: <sashiko-outbox-201340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/17] cdx: Propagate DMA configuration errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-7-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-7-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> CDX reports successful DMA configuration when firmware setup defers or
> default-domain acquisition fails. Driver probing can then proceed without
> the required DMA setup or IOMMU ownership.
>=20
> Return the configuration result so driver core stops or defers probing
> instead of allowing a driver to use a rejected domain.
>=20
> Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D7

