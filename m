Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521007;
	b=bn+AwoxlJlI817YuQBwei+01xQx8zqgc8z46whzoX6P3mZ9wW59Ar9uJPmA5PhyKND9l
	 VUS9hGAOF1jGoZy4K6NZQek6J4k0FsH8vAgO+C1Ib4XcbyQGrXe6EjQDC5sFhDMWI1r1S
	 VSxFTLu9LKH3/7Rtb1AZXzUelMb5bz5Yl8Ly13C9zNfNyk0wEw8Bbi0TYcvELJ/Olpkmo
	 ZrJ0pPYaf6to5byeph8xHy+YnmMoP83GYItR12SIwUWb1DA7IQhCmeI6rp80UmxQH6I0h
	 m9NVZihFC7v0ZrIu0k62GLTMFVOlAxVz6mD1OtYtKreBeIabmBdKzQBOhxtr5c6iBZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521007;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vrSCPrUzaNfK//FlxbUlE3+X/w8gwqYP7jEM0qlN9U4=;
	b=xFZ7TAVjEHjnzxfeek0LAW/MR7Um5ey5inkEqoWcEhE4cOJ1vkrZHV3NbVYb1F82PR5x
	 lDNm5uwJLJajWSvrebSqZFyVvhi9Odt4e0g122cst87jf0rIO4+AP+HD54Of7ubPQngR3
	 Ja3m3KVoKgilwMRDy8qaKVs2lPB36n8ubeU6SuPmPjr2NX7ZFMYHCJe3ALq9QYQtPOGTD
	 IczgiNXuAs6IOGptcOjC4YK4UeA/PCQbYjB3PSHM42AhPIESNYBTn9JnjsLU8HirbohLk
	 aYjbxtWKrfNs8VkBQVJv+QIS5dGPPG/oSLuGuU20NR7YTrYBJqAcR4bSmEt4U22ikLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6L2a6Ng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA55606A322
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6L2a6Ng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25CA1F000CA;
	Tue, 20 Oct 2026 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521007;
	bh=vrSCPrUzaNfK//FlxbUlE3+X/w8gwqYP7jEM0qlN9U4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6L2a6NgLPkUfDCh/8KLBhyU4l0mQXvhhAH+I43w7u0o/6/DrmjCSIb56C8fanIEP
	 HUoZvqimAjYjnWOg8MTPfQ2YsqpfyrF9j8Xnexb4q7fUZ0pDRzkZPbEI4mwhpxcW+B
	 VoonO6ywr9sOittdQnBOiT79WVovVXWP9bTvIsALB2PTqB+vng2sY2OCaqmDZJFGup
	 o3Sw/BOkoDO0qEj6UKRWaP8VVc+EfPZj/AMZhEM7MT0TKrz3F6JObVDQ/I8pgBntHU
	 CzEfpTYoiBvlSvMj5a5U/7S41tM1F/05LoYEAK33XpknBii8r5z6rvuv1BahKssf8q
	 ZE6jA9L5qRlDA==
Message-ID: <sashiko-outbox-179475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] PCI/EDR: Remove CONFIG_PCIE_EDR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020181924.3003553-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:30:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Error Disconnect Recover (EDR) is the ACPI half of the hybrid DPC model,
> where firmware owns DPC and notifies the OS of containment events.
>=20
> CONFIG_PCIE_EDR made EDR optional on top of CONFIG_PCIE_DPC.  This adds
> another knob to the decision to request DPC control in _OSC.  The OS
> requests DPC control only if it also supports EDR, so with
> CONFIG_PCIE_EDR=3Dn it never requests DPC control.  There is little reason
> to build DPC without EDR on ACPI systems.
>=20
> Remove the option and build edr.c whenever CONFIG_PCIE_DPC and
> CONFIG_ACPI are both enabled.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181924.3003=
553-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D3

